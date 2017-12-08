import logging
import os
import shutil
from contextlib import suppress
from copy import deepcopy
from functools import wraps
from pathlib import Path
from tempfile import TemporaryDirectory
from typing import List

import numpy as np
from pyha.common.complex_fixed_point import default_complex_sfix
from pyha.common.context_managers import RegisterBehaviour
from pyha.common.core import default_sfix
from pyha.common.fixed_point import Sfix
from pyha.common.util import get_iterable
from pyha.conversion.python_types_vhdl import init_vhdl_type
from pyha.simulation.vhdl_simulation import VHDLSimulation

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class NoModelError(Exception):
    pass


class InputTypesError(Exception):
    pass


def flush_pipeline(func):
    """ For inputs: adds 'x.get_delay()' dummy samples, to flush out pipeline values
    For outputs: removes the first 'x.get_delay()' samples, as these are initial pipeline values """

    @wraps(func)
    def flush_pipeline_wrap(self, *args, **kwargs):
        delay = 0
        with suppress(AttributeError):  # no get_delay()
            delay = self.model.DELAY
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

        try:
            if isinstance(ret[0], tuple):
                ret = [list(x) for x in zip(*ret)]  # transpose
        except:
            pass
        return ret

    return transposer_wrap


def type_conversions(func):
    @wraps(func)
    def type_enforcement_wrap(self, *args, **kwargs):
        # force input types
        if self.input_types is not None:
            args = [[to_type(x) for x in data] for data, to_type in zip(args, self.input_types)]
        else:
            args = list(args)
            for i, arg in enumerate(args):
                if isinstance(arg[0], float):
                    logger.info(
                        f'Converting float inputs to Sfix(left={default_sfix.left}, right={default_sfix.right})')
                    t = default_sfix
                    args[i] = [t(x) for x in arg]
                elif isinstance(arg[0], (complex, np.complex64)):
                    # assert 0
                    t = default_complex_sfix
                    logger.info(f'Converting complex inputs to ComplexSfix(left={t.left}, right={t.right})')
                    args[i] = [t(x) for x in arg]

        ret = func(self, *args, **kwargs)

        # convert outputs to python types (ex. Sfix -> float)
        if self.simulation_type in ['MODEL', 'PYHA']:
            ret = [init_vhdl_type('-', x, x)._pyha_to_python_value() for x in ret]
        return np.array(ret)

    return type_enforcement_wrap


class Simulation:
    hw_instances = {}

    def __init__(self, simulation_type, model=None, input_types: List[object] = None, dir_path=None):

        # if is CI, use temp dir
        dir_path = None if 'TRAVIS' in os.environ else dir_path

        self.dir_path = dir_path
        if self.dir_path is None:
            self.keep_me_alive = TemporaryDirectory()
            self.dir_path = self.keep_me_alive.name
        else:
            self.dir_path = str(Path(self.dir_path).expanduser())
            if not Path(self.dir_path).exists():
                os.makedirs(self.dir_path)

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

        if not hasattr(self.model, 'main') and self.simulation_type in ['PYHA', 'RTL', 'GATE']:
            raise NoModelError('Your model has no "main" function')

        self.main_as_model = not hasattr(self.model, 'model_main') and self.simulation_type is 'MODEL'

        # save ht HW model for conversion
        if self.simulation_type == 'PYHA':
            Simulation.hw_instances[model.__class__.__name__] = model

    def prepare_hw_simulation(self):
        # grab the already simulated model!
        self.model = Simulation.hw_instances[self.model.__class__.__name__]
        self.sim = VHDLSimulation(Path(self.dir_path), self.model, self.simulation_type)
        return self.sim.main()

    @type_conversions
    @in_out_transpose
    @flush_pipeline
    def hw_simulation(self, *args):
        self.model._pyha_floats_to_fixed()
        # convert_float_to_fixed(self.model)
        # convert datamodel to Fixed...
        if self.simulation_type == 'PYHA':
            ret = self.run_hw_model(args)
        elif self.simulation_type in ['RTL', 'GATE']:
            ret = self.cocosim.run(*args)
        else:
            assert 0

        self.pure_output = ret
        return ret

    def run_hw_model(self, args):
        # reset registers, in order to match COCOTB RTL simulation behaviour
        self.model.__dict__.update(deepcopy(self.model._pyha_initial_self).__dict__)
        ret = []
        for x in args:
            ret.append(deepcopy(self.model.main(*x)))  # deepcopy required or 'subsub' modules break
            self.model._pyha_update_self()
        return ret

    @type_conversions
    @in_out_transpose
    def as_model(self, *args):
        ret = self.run_hw_model(args)
        self.pure_output = ret
        return ret

    def main(self, *args) -> np.array:
        logger.info(f'Running {self.simulation_type} simulation!')

        if len(args) == 0 or args is (None,):
            raise InputTypesError(
                'Your model has 0 inputs (main() arguments), this is not supported at the moment -> add dummy input')

        # fixme: remove this during type refactoring
        #  test that there are no Sfix arguments
        for x in args:
            if type(x) is list:
                if type(x[0]) is Sfix:
                    raise InputTypesError(
                        'You are passing Sfix values to your model, pass float instead (will be converted to sfix automatically)!')

        if self.simulation_type in ('RTL', 'GATE') and self.cocosim is None:
            self.cocosim = self.prepare_hw_simulation()

        if self.simulation_type == 'MODEL':

            if self.main_as_model:
                logger.info(
                    'No "model_main()" found -> using "main" as model, turning off register delays and fixed point effects')
                with RegisterBehaviour.force_disable():
                    with Sfix._float_mode:
                        r = self.as_model(*args)
            else:
                r = self.model.model_main(*args)

            if r == []:
                return np.array(r)

            if isinstance(r, tuple):
                if isinstance(r[0], (list, np.ndarray)):
                    # assume that no transpose needed ( model returns correct way )
                    return np.array(r)
                return np.transpose(r)

            if isinstance(r, list) and isinstance(r[0], tuple):
                return np.transpose(r)
            return np.array(r)
        else:
            return self.hw_simulation(*args)


##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################
# utility functions


def simulate(model, *x, simulations=None, conversion_path=None, input_types=None):
    """
    Run simulations on model.

    :param model: Instance of top level class (the 'main' function will be called)
    :param x: Inputs to the 'main' function.
    :param simulations: Simulations to run:
    - SIM_MODEL: runs model ('model_main')
    - SIM_HW_MODEL: runs Python simulation of ('main'), simulating hardware effects
    - SIM_RTL: converts to VHDL and runs RTL simulation via GHDL and Cocotb
    - SIM_GATE: runs sources trough Quartus and simulates the generated netlist
    .. note:: If None(default), runs all simulations. SIM_HW_MODEL must be run if SIM_RTL or SIM_GATE are going to run.
    :param conversion_path: Where the conversion sources are written, if None uses temporary directory.
    """
    simulations = enforce_simulation_rules(simulations)
    return {
    sim_type: Simulation(sim_type, model=model, dir_path=conversion_path, input_types=input_types).main(*x).tolist()
    for sim_type in simulations}


def assert_equals(simulation_results, expected=None, rtol=1e-04, atol=(2 ** -17) * 4, skip_first_n=0):
    assert sims_close(simulation_results, expected, rtol, atol, skip_first_n)


def sims_close(simulation_results, expected=None, rtol=1e-04, atol=(2 ** -17) * 4, skip_first_n=0):
    """
    Assert that simulation results (for exampel SIM_MODEL and SIM_HW_MODEL) are equal(defined by rtol and atol).

    :param simulation_results: Output of 'simulate' function
    :param expected: 'Golden output' to compare against. If none uses the output of 'SIM_MODEL' or 'SIM_HW_MODEL'.
    :param rtol: Simulations must match 'expected' to:
        rtol=1e-1 ~ 1 digit after comma
        rtol=1e-2 ~ 2 digits after comma ...

    :param atol: Tune this when numbers close to 0 are failing assertions.
    """
    # l = logging.getLogger('assert_equals()')
    if expected is None:
        if 'MODEL' in simulation_results.keys():
            expected = simulation_results['MODEL']
        else:
            expected = simulation_results['PYHA']

    def array_to_list(array):
        # https://github.com/numpy/numpy/issues/8052
        if isinstance(array, np.ndarray):
            if isinstance(array[0], complex):
                array = array.astype(complex)
            elif isinstance(array[0], np.floating):
                array = array.astype(float)

            return array_to_list(array.tolist())
        elif isinstance(array, list):
            return [array_to_list(item) for item in array]
        elif isinstance(array, tuple):
            return tuple(array_to_list(item) for item in array)
        else:
            return array

    expected = array_to_list(expected)[skip_first_n:]

    expected = init_vhdl_type('root', expected, expected)
    result = True
    for sim_name, sim_data in simulation_results.items():
        sim_data = get_iterable(sim_data)
        sim_data = sim_data[skip_first_n:][:len(expected.elems)]
        sim_data = init_vhdl_type(sim_name, sim_data, sim_data)
        eq = sim_data._pyha_is_equal(expected, sim_name, rtol, atol)
        if eq:
            pass
            logger.info(f'{sim_name} OK!')
        else:
            logger.info(f'{sim_name} FAILED!')
            result = False

    return result


def enforce_simulation_rules(simulations):
    logger = logging.getLogger(__name__)
    if simulations is None:
        simulations = ['MODEL', 'PYHA', 'RTL', 'GATE']
    # force simulation rules, for example SIM_RTL cannot be run without SIM_HW_MODEL, that needs to be ran first.
    assert simulations in [['MODEL'],
                           ['MODEL', 'PYHA'],
                           ['MODEL', 'PYHA', 'RTL'],
                           ['MODEL', 'PYHA', 'GATE'],
                           ['PYHA'],
                           ['PYHA', 'RTL'],
                           ['MODEL', 'PYHA', 'RTL', 'GATE'],
                           ['PYHA', 'RTL', 'GATE'],
                           ['PYHA', 'GATE']]

    if 'RTL' in simulations:
        have_ghdl = True
        try:
            Path(shutil.which('ghdl'))
        except:
            have_ghdl = False

        if 'PYHA_SKIP_RTL' in os.environ:
            logger.warning('SKIPPING **RTL** simulations -> "PYHA_SKIP_RTL" environment variable is set')
            simulations.remove('RTL')
        elif not have_ghdl:
            logger.warning('SKIPPING **RTL** simulations -> no GHDL found')
            simulations.remove('RTL')

    if 'GATE' in simulations:
        have_quartus = True
        try:
            Path(shutil.which('quartus_map'))
        except:
            have_quartus = False

        if 'PYHA_SKIP_GATE' in os.environ:
            logger.warning('SKIPPING **GATE** simulations -> "PYHA_SKIP_GATE" environment variable is set')
            simulations.remove('GATE')
        elif not have_quartus:
            logger.warning('SKIPPING **GATE** simulations -> no Quartus found')
            simulations.remove('GATE')

    return simulations
