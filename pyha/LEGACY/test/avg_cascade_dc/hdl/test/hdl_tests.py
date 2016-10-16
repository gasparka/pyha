import cocotb
import numpy as np

from LEGACY.common.sim.util import link_to_model
from tests.avg_cascade_dc.casc import Casc


@cocotb.test()
def test_main(dut):
    model = Casc(4, 2)
    inp = np.random.uniform(-1, 1, 256)
    yield link_to_model(dut, inp, model)
