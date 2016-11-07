import numpy as np
import pytest
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.simulation.simulation_interface import Simulation, SIM_HW_MODEL, SIM_RTL


class Register(HW):
    def __init__(self, init_value=0.):
        self.get_delay()
        self.a = Sfix(init_value)

    def __call__(self, new_value):
        self.next.a = new_value
        return self.a

    def get_delay(self):
        return 1


@pytest.fixture(scope='session', params=[-17, -18, -19])
def bits(request):
    return request.param


@pytest.fixture(scope='session', params=[SIM_HW_MODEL, SIM_RTL])
def dut(request, bits):
    dut = Register()
    return Simulation(request.param, hw_model=dut, input_types=[Sfix(0.0, 0, bits)])


def test_functionality(dut):
    ret = dut([0.5, 0.6, 0.7])
    assert np.allclose(ret, [0.5, 0.6, 0.7])


def test_delay():
    # TODO: need a way to call other functions than __call__, top generator
    pass
