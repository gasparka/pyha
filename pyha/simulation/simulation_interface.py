import logging
import os
from cmath import isclose
from contextlib import suppress
from copy import deepcopy
from enum import Enum
from functools import wraps
from pathlib import Path
from tempfile import TemporaryDirectory
from typing import List

import numpy as np

from pyha.common.context_managers import RegisterBehaviour
from pyha.common.hwsim import HW, default_sfix, default_complex_sfix
from pyha.common.sfix import Sfix, ComplexSfix
from pyha.conftest import SKIP_SIMULATIONS_MASK
from pyha.simulation.sim_provider import SimProvider


class NoModelError(Exception):
    pass


class InputTypesError(Exception):
    pass


SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE = ['MODEL', 'HW_MODEL', 'RTL', 'GATE']


def flush_pipeline(func):
    """ For inputs: adds 'x.get_delay()' dummy samples, to flush out pipeline values
    For outputs: removes the first 'x.get_delay()' samples, as these are initial pipeline values"""

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
        else:
            args = list(args)
            for i, arg in enumerate(args):
                if isinstance(arg[0], float):
                    self.logger.info(
                        f'Converting float inputs to Sfix(left={default_sfix.left}, right={default_sfix.right})')
                    t = default_sfix
                    args[i] = [t(x) for x in arg]
                elif isinstance(arg[0], (complex, np.complex64)):
                    t = default_complex_sfix
                    self.logger.info(f'Converting complex inputs to ComplexSfix(left={t.left}, right={t.right})')
                    args[i] = [t(x, is_local=True) for x in arg]


        ret = func(self, *args, **kwargs)

        def output_types(li):
            ret = []
            for x in li:
                if type(x) in [list, tuple]:
                    ret.append(output_types(x))
                elif type(x) == Sfix:
                    ret.append(float(x))
                elif type(x) == ComplexSfix:
                    ret.append(float(x.real) + float(x.imag) * 1j)
                elif isinstance(x, Enum):
                    ret.append(x.value)
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

        if not hasattr(self.model, 'main') and self.simulation_type in (SIM_HW_MODEL, SIM_RTL, SIM_GATE):
            raise NoModelError('Your model has no "main" function')

        self.main_as_model = not hasattr(self.model, 'model_main') and self.simulation_type is SIM_MODEL

        # save ht HW model for conversion
        if self.simulation_type == SIM_HW_MODEL:
            Simulation.hw_instances[model.__class__.__name__] = model

    def prepare_hw_simulation(self):
        # grab the already simulated model!
        self.model = Simulation.hw_instances[self.model.__class__.__name__]
        self.sim = SimProvider(Path(self.dir_path), self.model, self.simulation_type)
        return self.sim.main()

    @type_conversions
    @in_out_transpose
    @flush_pipeline
    def hw_simulation(self, *args):
        if self.simulation_type == SIM_HW_MODEL:
            ret = self.run_hw_model(args)
        elif self.simulation_type in [SIM_RTL, SIM_GATE]:
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
            ret.append(self.model.main(*x))
            self.model._pyha_update_self()
        return ret

    @type_conversions
    @in_out_transpose
    def as_model(self, *args):
        ret = self.run_hw_model(args)
        self.pure_output = ret
        return ret

    def main(self, *args) -> np.array:
        self.logger.info(f'Running {self.simulation_type} simulation!')

        # fixme: remove this during type refactoring
        #  test that there are no Sfix arguments
        for x in args:
            if type(x) is list:
                if type(x[0]) is Sfix:
                    raise InputTypesError(
                        'You are passing Sfix values to your model, pass float instead (will be converted to sfix automatically)!')

        if self.simulation_type in (SIM_RTL, SIM_GATE) and self.cocosim is None:
            self.cocosim = self.prepare_hw_simulation()

        if self.simulation_type == SIM_MODEL:

            if self.main_as_model:
                self.logger.info('Using "main" as model, turning off register delays and fixed point effects')
                with RegisterBehaviour.force_disable():
                    with Sfix._float_mode:
                        return self.as_model(*args)

            r = self.model.model_main(*args)

            if r == []:
                return np.array(r)

            if isinstance(r, tuple):
                if isinstance(r[0], list):
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

def debug_assert_sim_match(model, expected, *x, types=None, simulations=None, rtol=1e-05, atol=1e-9, dir_path=None,
                           fuck_it=False, **kwards):
    """ Instead of asserting anything return outputs of each simulation """
    simulations = sim_rules(simulations, model)
    outs = []
    for sim_type in simulations:
        dut = Simulation(sim_type, model=model, input_types=types, dir_path=dir_path)
        hw_y = dut.main(*x)
        outs.append(hw_y)
    return outs


def assert_model_hwmodel_match(model, *x, types=None, rtol=1e-9, atol=1e-9):
    if skipping_hwmodel_simulations() or skipping_model_simulations():
        return
    outs = debug_assert_sim_match(model, types, [1], *x, simulations=[SIM_MODEL, SIM_HW_MODEL])
    # return outs
    np.testing.assert_allclose(outs[0], outs[1], rtol, atol)


def assert_hwmodel_rtl_match(model, *x, types=None):
    if skipping_hwmodel_simulations() or skipping_rtl_simulations():
        return
    outs = debug_assert_sim_match(model, types, [1], *x, simulations=[SIM_HW_MODEL, SIM_RTL])
    np.testing.assert_allclose(outs[0], outs[1], rtol=1e-9)


def plot_assert_sim_match(model, expected, *x, types=None, simulations=None, rtol=1e-05, atol=1e-9, dir_path=None,
                          skip_first=0):
    """
    Same arguments as :code:`assert_sim_match`. Instead of asserting it plots all the simulations.

    """
    import matplotlib.pyplot as plt
    simulations = sim_rules(simulations, model)
    for sim_type in simulations:
        dut = Simulation(sim_type, model=model, dir_path=dir_path)
        hw_y = dut.main(*x)
        plt.plot(hw_y[skip_first:], label=str(sim_type))

    plt.legend()
    plt.show()


def assert_sim_match(model, expected, *x, types=None, simulations=None, rtol=1e-04, atol=(2 ** -17) * 4, dir_path=None,
                     skip_first=0):
    """
    Run bunch of simulations and assert that they match outputs.

    :param model: Instance of your class
    :param types: If :code:`main` is defined, provide input types for each argument, all arguments will be
     automatically casted to these types.
    :param expected: Expected output of the simulation. If None, assert all simulations match eachother.
    :param x: Inputs, if you have multiple inputs, use *x for unpacking.
    :param simulations: Simulations to run and assert:
    - SIM_MODEL: runs model ('model_main')
    - SIM_HW_MODEL: runs HW model ('main')
    - SIM_RTL: converts to VHDL and runs RTL simulation via GHDL and Cocotb
    - SIM_GATE: runs sources trough Quartus and simulates the generated netlist
    .. note:: If None(default), runs all simulations. SIM_HW_MODEL must be run if SIM_RTL or SIM_GATE are going to run.
    :param rtol: Relative tolerance for assertion. Look np.testing.assert_allclose.
    :param atol: Absolute tolerance for assertion. Look np.testing.assert_allclose.
    :param dir_path: Where are conversion outputs written, if empty uses temporary directory.
    :param skip_first: Skip first 'n' samples for assertion.

    """
    l = logging.getLogger(__name__)
    simulations = sim_rules(simulations, model)

    for sim_type in simulations:
        dut = Simulation(sim_type, model=model, input_types=types, dir_path=dir_path)
        hw_y = dut.main(*x)
        if expected is None and sim_type is simulations[0]:
            l.warning(f'"expected=None", all sims must output: \n{hw_y}')
            expected = hw_y

        try:
            assert len(expected) > 0
            # if type(expected[0]) != type(hw_y[0]):
            #     hw_y = hw_y.astype(type(expected[0]))
            np.testing.assert_allclose(expected[skip_first:], hw_y[skip_first:len(expected)], rtol, atol=atol)
            l.info('########### Pass! ###########')
        except AssertionError as e:
            l.error('##############################################################')
            l.error('##############################################################')
            l.error(f'\t\t"{sim_type}" failed')
            l.error('##############################################################')
            l.error('##############################################################')

            print('Failures (* shows what failed):')
            print(f'Expected \t Actual \t ATOL \t\t\t RTOL')
            print(f'---------------------------------------------------')
            # abs(a-b) <= max(rel_tol * max(abs(a), abs(b)), abs_tol)
            for i, (expect, actual) in enumerate(
                    zip(np.array(expected)[skip_first:].flat, np.array(hw_y)[skip_first:len(expected)].flat)):
                if not isclose(expect, actual, rel_tol=rtol, abs_tol=atol):
                    a = abs(expect - actual)
                    r = rtol * max(abs(expect), abs(actual))
                    if r > atol:
                        print(f'{expect:.5f} \t {actual:.5f} \t {a:.5f} \t *{r:.5f}')
                    else:
                        print(f'{expect:.5f} \t {actual:.5f} \t *{a:.5f} \t {r:.5f}')

            raise


def skipping_gate_simulations():
    if SKIP_SIMULATIONS_MASK & 8:
        return True
    with suppress(KeyError):
        if int(os.environ['PYHA_SKIP_QUARTUS_SIMS']):
            return True
    return False


def skipping_rtl_simulations():
    return SKIP_SIMULATIONS_MASK & 4


def skipping_hwmodel_simulations():
    return SKIP_SIMULATIONS_MASK & 2


def skipping_model_simulations():
    return SKIP_SIMULATIONS_MASK & 1


def sim_rules(simulations, model):
    if simulations is None:
        simulations = [SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE]
    # force simulation rules, for example SIM_RTL cannot be run without SIM_HW_MODEL, that needs to be ran first.
    assert simulations in [[SIM_MODEL],
                           [SIM_MODEL, SIM_HW_MODEL],
                           [SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                           [SIM_MODEL, SIM_HW_MODEL, SIM_GATE],
                           [SIM_HW_MODEL],
                           [SIM_HW_MODEL, SIM_RTL],
                           [SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                           [SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                           [SIM_HW_MODEL, SIM_GATE]]

    # if not hasattr(model, 'model_main') and SIM_MODEL in simulations:
    #     simulations.remove(SIM_MODEL)
    #     logging.getLogger(__name__).warning('Skipping MODEL simulation, because there is no "model_main" function!')

    if skipping_model_simulations() and SIM_MODEL in simulations:
        simulations.remove(SIM_MODEL)
        logging.getLogger(__name__).warning('########## SKIPPING MODEL SIMULATIONS ##########')

    if skipping_hwmodel_simulations() and SIM_HW_MODEL in simulations:
        simulations.remove(SIM_HW_MODEL)
        logging.getLogger(__name__).warning('########## SKIPPING HW_MODEL SIMULATIONS ##########')

    if skipping_rtl_simulations() and SIM_RTL in simulations:
        simulations.remove(SIM_RTL)
        logging.getLogger(__name__).warning('########## SKIPPING RTL SIMULATIONS ##########')

    if skipping_gate_simulations() and SIM_GATE in simulations:
        simulations.remove(SIM_GATE)
        logging.getLogger(__name__).warning('########## SKIPPING GATE SIMULATIONS ##########')

    return simulations
