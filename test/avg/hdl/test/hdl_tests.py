# Simple tests for an adder module
import cocotb
import numpy as np

from common.sim.util import link_to_model
from test.avg.main import Average


@cocotb.test()
def test_main(dut):
    inp = np.random.uniform(-1, 1, 256)
    model = Average(4)
    yield link_to_model(dut, inp, model)
