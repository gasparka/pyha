from contextlib import suppress
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


SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE = ['MODEL', 'HW_MODEL', 'RTL', 'GATE']


def flush_pipeline(func):
    """ For inputs: adds 'x.get_delay()' dummy samples, to flush out pipeline values
    For outputs: removes the first 'x.get_delay()' samples, as these are initial pipelien values"""

    @wraps(func)
    def flush_pipeline_wrap(self, *args, **kwargs):
        # now = args[0].__dict__
        # next = args[0].__dict__['next'].__dict__
        #
        # now.update(deepish_copy(next))

        ret = func(*args, **kwargs)
        return ret

    return flush_pipeline_wrap


def in_out_transpose(func):
    """ Transpose input before call and output after call """
    @wraps(func)
    def transposer_wrap(self, *args, **kwargs):
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
        return ret

    return type_enforcement_wrap


class Simulation:
    hw_instances = {}

    def __init__(self, simulation_type, model=None, hw_model=None, input_types: List[object] = None):
        self.input_types = input_types
        self.hw_model = hw_model
        self.model = model
        self.simulation_type = simulation_type

        if simulation_type == SIM_MODEL and model is None:
            raise NoModelError('Trying to run "model" simulation but no model given!')

        if simulation_type in (SIM_HW_MODEL, SIM_RTL, SIM_GATE) and hw_model is None:
            raise NoModelError('Trying to run "hardware" simulation but no hardware model given!')

        # save ht HW model for conversion
        if simulation_type == SIM_HW_MODEL:
            Simulation.hw_instances[hw_model.__class__.__name__] = hw_model

        if simulation_type in (SIM_RTL, SIM_GATE):
            self.cocosim = self.prepare_hw_simulation()

    def prepare_hw_simulation(self):
        # grab the already simulated model!
        self.hw_model = Simulation.hw_instances[self.hw_model.__class__.__name__]
        conv = Conversion(self.hw_model)
        self.tmpdir = TemporaryDirectory()  # use self. to keep dir alive
        return CocotbAuto(Path(self.tmpdir.name), conv)

    @type_conversions
    @in_out_transpose
    def hw_simulation(self, *args, **kwargs):
        if self.simulation_type == SIM_HW_MODEL:
            return [self.hw_model(*x) for x in args]
        elif self.simulation_type in [SIM_RTL, SIM_GATE]:
            return self.cocosim.run(args)

    def __call__(self, *args, **kwargs):
        if self.simulation_type == SIM_MODEL:
            return np.transpose(self.model(*args))

        out = self.hw_simulation(*args)
        return out
