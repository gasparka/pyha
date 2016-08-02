import pytest

# from components.register.model.model import Register
import numpy as np

from components.register.model.hw_model import Register
from sim_automation.testing import Testing
import os


@pytest.fixture(scope='function', params=['MODEL', 'HW-MODEL', 'HW-RTL', 'HW-GATE'])
def dut(request):
    # limit = int(os.environ['TEST_DEPTH'])
    # if request.param_index > limit:
    #     pytest.skip('Test not to be included, increase env["TEST_DEPTH"] to run more tests')

    if request.param != 'HW-MODEL':
        pytest.skip()

    y = Register(init_value=0.0)
    dut = Testing(request, None, y, None)
    return dut


def test_init_value(dut):
    stim = [0.1, 0.2, 0.3]
    dut(stim)
    assert dut.pure_output[0][0] == 0.0

def test_delay_attr(dut):
    assert dut.hw_model.delay == 1

def test_delay_one(dut):
    stim = [0.1, 0.2, 0.3]
    out = dut(stim)
    assert np.allclose(stim, out)
