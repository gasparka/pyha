import logging
import os
from contextlib import suppress
from copy import deepcopy
from functools import wraps
from pathlib import Path
from tempfile import TemporaryDirectory
from typing import List

import numpy as np

from pyha.common.sfix import Sfix, ComplexSfix
from pyha.simulation.sim_provider import SimProvider


class NoModelError(Exception):
    pass


class InputTypesError(Exception):
    pass


SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE = ['MODEL', 'HW_MODEL', 'RTL', 'GATE']


def flush_pipeline(func):
    """ For inputs: adds 'x.get_delay()' dummy samples, to flush out pipeline values
    For outputs: removes the first 'x.get_delay()' samples, as these are initial pipelien values"""

    @wraps(func)
    def flush_pipeline_wrap(self, *args, **kwargs):
        delay = 0
        with suppress(AttributeError):  # no get_delay()
            delay = self.model.get_delay()
        if delay == 0:
            return func(self, *args, **kwargs)

        args = list(args)

        for i in range(delay):
            args.append(args[0])

        ret = func(self, *args, **kwargs)
        ret = ret[delay:]
        return ret

    return flush_pipeline_wrap


def in_out_transpose(func):
    """ Transpose input before call and output after call """

    @wraps(func)
    def transposer_wrap(self, *args, **kwargs):
        # numpy cannot be used as it loses type info (converts everything to float)
        args = [x for x in zip(*args)]  # transpose

        ret = func(self, *args, **kwargs)

        with suppress(TypeError):  # was one dimensional list
            ret = [list(x) for x in zip(*ret)]  # transpose
        return ret

    return transposer_wrap


def type_conversions(func):
    @wraps(func)
    def type_enforcement_wrap(self, *args, **kwargs):
        # force input types
        if self.input_types is not None:
            args = [[to_type(x) for x in data] for data, to_type in zip(args, self.input_types)]

        ret = func(self, *args, **kwargs)

        def output_types(li):
            ret = []
            for x in li:
                if type(x) in [list, tuple]:
                    ret.append(output_types(x))
                elif type(x) == Sfix:
                    ret.append(float(x))
                elif type(x) == ComplexSfix:
                    ret.append(float(x.real)+float(x.imag)*1j)
                else:
                    ret.append(x)
            return ret

        ret = output_types(ret)
        return np.array(ret)

    return type_enforcement_wrap


class Simulation:
    """ Returned stuff is always Numpy array? """
    hw_instances = {}

    def __init__(self, simulation_type, model=None, input_types: List[object] = None, dir_path=None):
        self.logger = logging.getLogger(__name__)
        # self.tmpdir = TemporaryDirectory().name
        self.dir_path = dir_path
        if self.dir_path is None:
            self.keep_me_alive = TemporaryDirectory()
            self.dir_path = self.keep_me_alive.name

        self.input_types = []
        self.model = None
        self.sim = None
        self.cocosim = None
        self.simulation_type = simulation_type

        # direct output from dut call will be written here( without type conversions, pipeline fixes..)
        self.pure_output = []
        # if model is not None:
        self.init(model, input_types)

    def init(self, model=None, input_types: List[object] = None):
        self.model = model
        self.input_types = input_types
        if self.model is None:
            raise NoModelError('Trying to run simulation but "model" is None')

        if not hasattr(self.model, 'main') and self.simulation_type in (SIM_HW_MODEL, SIM_RTL, SIM_GATE):
            raise NoModelError('Your model has no "main" function')

        if not hasattr(self.model, 'model_main') and self.simulation_type is SIM_MODEL:
            raise NoModelError('Trying to run "SIM_MODEL" simulation but your model has no "model_main" function!')

        # save ht HW model for conversion
        if self.simulation_type == SIM_HW_MODEL:
            Simulation.hw_instances[model.__class__.__name__] = model

    def prepare_hw_simulation(self):
        # grab the already simulated model!
        self.model = Simulation.hw_instances[self.model.__class__.__name__]
        self.sim = SimProvider(Path(self.dir_path), self.model, self.simulation_type)
        return self.sim.main()
        # conv = Conversion(self.model)
        # quartus = None
        # if self.simulation_type is SIM_GATE:
        #     make_quartus_project(Path(self.tmpdir.name), conv)
        # return CocotbAuto(Path(self.tmpdir.name), conv)

    @type_conversions
    @in_out_transpose
    @flush_pipeline
    def hw_simulation(self, *args):
        if self.simulation_type == SIM_HW_MODEL:
            # reset registers, in order to match COCOTB RTL simulation behaviour
            self.model.next = deepcopy(self.model.__initial_self__)
            ret = [self.model.main(*x) for x in args]
        elif self.simulation_type in [SIM_RTL, SIM_GATE]:
            ret = self.cocosim.run(*args)
        else:
            assert 0

        self.pure_output = ret
        return ret

    def main(self, *args) -> np.array:
        self.logger.info('Running {} simulation!'.format(self.simulation_type))
        # test if user provided legal 'input_types'
        if self.simulation_type is not SIM_MODEL or self.input_types is not None:  # it is legal to not pass input_types if SIM_MODEL
            if self.input_types is None or (len(args) != len(self.input_types)):
                raise InputTypesError('Your "Simulation(input_types=X)" does not match arguements to "main" function!')

        # test that there are no Sfix arguments
        for x in args:
            if type(x) is list:
                if type(x[0]) is Sfix:
                    raise InputTypesError(
                        'You are passing Sfix values to your model, pass float instead (will be converted to sfix automatically)!')

        if self.simulation_type in (SIM_RTL, SIM_GATE) and self.cocosim is None:
            self.cocosim = self.prepare_hw_simulation()

        if self.simulation_type == SIM_MODEL:
            return np.transpose(self.model.model_main(*args))
        else:
            return self.hw_simulation(*args)


def assert_sim_match(model, types, expected, *x, simulations=None, rtol=1e-05, atol=1e-9, dir_path=None):
    if simulations is None:
        simulations = [SIM_MODEL, SIM_HW_MODEL, SIM_RTL]
    # force simulation rules, for example SIM_RTL cannot be run without SIM_HW_MODEL, that needs to be ran first.
    assert simulations in [[SIM_MODEL],
                           [SIM_MODEL, SIM_HW_MODEL],
                           [SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                           [SIM_HW_MODEL],
                           [SIM_HW_MODEL, SIM_RTL],
                           [SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                           [SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                           [SIM_HW_MODEL, SIM_GATE]]

    # for travis build, skip all the tests involving quartus
    if SIM_GATE in simulations:
        with suppress(KeyError):
            if int(os.environ['PYHA_SKIP_QUARTUS_SIMS']):
                simulations.remove(SIM_GATE)
                logging.getLogger(__name__).warning(
                    'Not running SIM_GATE tests because environment variable "PYHA_SKIP_QUARTUS_SIMS" is True!!!')


    for sim_type in simulations:
        dut = Simulation(sim_type, model=model, input_types=types, dir_path=dir_path)
        hw_y = dut.main(*x)
        try:
            np.testing.assert_allclose(expected, hw_y, rtol, atol=atol)
        except AssertionError as e:
            l = logging.getLogger(__name__)
            l.error('##############################################################')
            l.error('##############################################################')
            l.error('\t\t"{}" failed'.format(sim_type))
            l.error('##############################################################')
            l.error('##############################################################')
            raise
        #     print('\n\nSim "{}" failed:'.format(sim_type))
        #     print(e.args[0])
