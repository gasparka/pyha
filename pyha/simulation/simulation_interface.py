from pathlib import Path
from tempfile import TemporaryDirectory
from typing import List

import numpy as np
from pyha.conversion.conversion import Conversion
from pyha.simulation.cocotb import CocotbAuto


class NoModelError(Exception):
    pass


SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE = ['MODEL', 'HW_MODEL', 'RTL', 'GATE']


class Simulation:
    hw_instances = {}

    def __init__(self, simulation_type, model=None, hw_model=None, input_types: List[object]=None):
        self.input_types = input_types
        self.hw_model = hw_model
        self.model = model
        self.simulation_type = simulation_type

        if simulation_type == SIM_MODEL and model is None:
            raise NoModelError('Trying to run "model" simulation but no model given!')

        if simulation_type in (SIM_HW_MODEL, SIM_RTL, SIM_GATE) and hw_model is None:
            raise NoModelError('Trying to run "hardware" simulation but no hardware model given!')

        if simulation_type == SIM_HW_MODEL:
            Simulation.hw_instances[hw_model.__class__.__name__] = hw_model

    def prepaire_hw_simulation(self):
        # grab the already simulated model!
        self.hw_model = Simulation.hw_instances[self.hw_model.__class__.__name__]
        conv = Conversion(self.hw_model)
        self.tmpdir = TemporaryDirectory()
        tmpdir = Path(self.tmpdir.name)
        return CocotbAuto(tmpdir, conv)


    def prepaire_input(self, args):
        args = np.transpose(args)
        return args.tolist()
        # return [int(x) for x in args]
        # pass
        # for i, (values, type) in enumerate(zip(args, [Sfix(left=0, right=-27)] * 1)):
        #     args[i] = [Sfix(x, type.left, type.right) for x in values]

    def __call__(self, *args):
        if self.simulation_type == SIM_MODEL:
            out = self.model(*args)
            return np.transpose(out)

        args = self.prepaire_input(args)

        out = []
        if self.simulation_type == SIM_HW_MODEL:
            out = [self.hw_model(*x) for x in args]
        elif self.simulation_type in [SIM_RTL, SIM_GATE]:
            prep = self.prepaire_hw_simulation()
            out = prep.run(args)
            # conversion
            # cocotb
            # simulate
            pass

        out = np.transpose(out)
        out = out.astype(float)
        return out
