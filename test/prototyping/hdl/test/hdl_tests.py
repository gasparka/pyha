import cocotb
import numpy as np

from common.sim.util import link_to_model
from test.shift_reg.shift_reg import ShiftReg


@cocotb.test()
def test_main(dut):
    inp = np.random.uniform(-1, 1, 256)
    model = ShiftReg(16)
    yield link_to_model(dut, inp, model)
