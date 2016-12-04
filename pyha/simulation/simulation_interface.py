from contextlib import suppress
from copy import deepcopy
from functools import wraps
from pathlib import Path
from tempfile import TemporaryDirectory
from typing import List

import numpy as np

from pyha.common.sfix import Sfix
from pyha.conversion.conversion import Conversion
from pyha.simulation.cocotb import CocotbAuto


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

        with suppress(TypeError): # was one dimensional list
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
                else:
                    ret.append(x)
            return ret

        ret = output_types(ret)
        return np.array(ret)

    return type_enforcement_wrap


class Simulation:
    """ Returned stuff is always Numpy array? """
    hw_instances = {}

    def __init__(self, simulation_type, model=None, input_types: List[object] = None):
        self.tmpdir = TemporaryDirectory()  # use self. to keep dir alive
        self.input_types = input_types
        self.model = model
        self.simulation_type = simulation_type

        # direct output from dut call will be written here( without type conversions, pipeline fixes..)
        self.pure_output = []

        if self.model is None:
            raise NoModelError('Trying to run simulation but "model" is None')

        if not hasattr(self.model, 'main') and simulation_type in (SIM_HW_MODEL, SIM_RTL, SIM_GATE):
            raise NoModelError('Your model has no "main" function')

        if not hasattr(self.model, 'model_main') and simulation_type is SIM_MODEL:
            raise NoModelError('Trying to run "SIM_MODEL" simulation but your model has no "model_main" function!')

        # save ht HW model for conversion
        if simulation_type == SIM_HW_MODEL:
            Simulation.hw_instances[model.__class__.__name__] = model

        self.cocosim = None

    def prepare_hw_simulation(self):
        # grab the already simulated model!
        self.model = Simulation.hw_instances[self.model.__class__.__name__]
        conv = Conversion(self.model)
        return CocotbAuto(Path(self.tmpdir.name), conv)

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
