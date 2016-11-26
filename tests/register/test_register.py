import numpy as np
import pytest

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.simulation.simulation_interface import Simulation, SIM_HW_MODEL, SIM_RTL


class LazySfixRegister(HW):
    def __init__(self):
        self.get_delay()
        self.a = Sfix()

    def main(self, new_value):
        self.next.a = new_value
        return self.a

    def get_delay(self):
        return 1


@pytest.fixture(scope='session', params=[-17, -18, -19])
def bits(request):
    return request.param


@pytest.fixture(scope='module', params=[SIM_HW_MODEL, SIM_RTL])
def lazy_reg(request, bits):
    dut = LazySfixRegister()
    return Simulation(request.param, hw_model=dut, input_types=[Sfix(0.0, 0, bits)])


def test_functionality(lazy_reg):
    ret = lazy_reg.main([0.5, 0.6, 0.7])
    assert np.allclose(ret, [0.5, 0.6, 0.7])


##########################################################################################
class Register(HW):
    def __init__(self):
        self.get_delay()
        self.a = Sfix(0.123, 0, -18)
        self.b = 123
        self.c = False

    def main(self, na, nb, nc):
        self.next.a = na
        self.next.b = nb
        self.next.c = nc
        return self.a, self.b, self.c

    def get_delay(self):
        return 1


@pytest.fixture(scope='module', params=[SIM_HW_MODEL, SIM_RTL])
def dut_inits(request):
    dut = Register()
    return Simulation(request.param, hw_model=dut, input_types=[Sfix(0.0, 0, -18), int, bool])


def test_regs(dut_inits):
    ina, inb, inc = [[0.5, 0.6], [1, 2], [True, True]]
    outa, outb, outc = dut_inits.main(ina, inb, inc)
    assert np.allclose(outa, ina)
    assert (outb == inb).all()
    assert (outc.astype(bool) == inc).all()


def test_initial_value(dut_inits):
    ina, inb, inc = [[0.5], [1], [True]]

    outa, outb, outc = dut_inits.main(ina, inb, inc)
    assert float(dut_inits.pure_output[0][0]) == float(Sfix(0.123, 0, -18))
    assert dut_inits.pure_output[0][1] == 123
    assert dut_inits.pure_output[0][2] == False


##########################################################################################
class ShiftReg(HW):
    def __init__(self):
        self.shr = [1, 2, 3, 4]

    def main(self, new_sample):
        out = self.shr[-1]
        self.next.shr = [new_sample] + self.shr[:-1]
        return out


@pytest.fixture(scope='module', params=[SIM_HW_MODEL, SIM_RTL])
def dut_shr(request):
    dut = ShiftReg()
    return Simulation(request.param, hw_model=dut, input_types=[int])


def test_shift_reg(dut_shr):
    inp = [0, -1, -2, -3]
    outp = dut_shr.main(inp)
    assert (outp == [4, 3, 2, 1]).all()
