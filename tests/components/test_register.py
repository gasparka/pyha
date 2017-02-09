import numpy as np
import pytest

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.simulation.simulation_interface import Simulation, SIM_HW_MODEL, SIM_RTL


class LazySfixRegister(HW):
    def __init__(self):
        self.a = Sfix()
        self._delay = 1

    def main(self, new_value):
        self.next.a = new_value
        return self.a


@pytest.fixture(scope='session', params=[-17, -18, -19])
def bits(request):
    return request.param


@pytest.fixture(scope='module', params=[SIM_HW_MODEL, SIM_RTL])
def lazy_reg(request, bits):
    dut = LazySfixRegister()
    return Simulation(request.param, model=dut, input_types=[Sfix(0.0, 0, bits)])


def test_functionality(lazy_reg):
    ret = lazy_reg.main([0.5, 0.6, 0.7])
    assert np.allclose(ret, [0.5, 0.6, 0.7])


##########################################################################################
class Register(HW):
    def __init__(self):
        self.a = Sfix(0.123, 0, -18)
        self.b = 123
        self.c = False
        self._delay = 1

    def main(self, na, nb, nc):
        self.next.a = na
        self.next.b = nb
        self.next.c = nc
        return self.a, self.b, self.c


@pytest.fixture(scope='module', params=[SIM_HW_MODEL, SIM_RTL])
def dut_inits(request):
    dut = Register()
    return Simulation(request.param, model=dut, input_types=[Sfix(0.0, 0, -18), int, bool])


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
        self.shr_int = [1, 2, 3, 4]
        self.shr_bool = [True, False, False, True]
        self.shr_sfix = [Sfix(0.5, 2, -18), Sfix(0.6, 2, -18),
                         Sfix(-0.5, 2, -18), Sfix(2.1, 2, -18)]

    def main(self, new_int, new_bool, new_sfix):
        self.next.shr_int = [new_int] + self.shr_int[:-1]
        self.next.shr_bool = [new_bool] + self.shr_bool[:-1]
        self.next.shr_sfix = [new_sfix] + self.shr_sfix[:-1]
        return self.shr_int[-1], self.shr_bool[-1], self.shr_sfix[-1]


@pytest.fixture(scope='module', params=[SIM_HW_MODEL, SIM_RTL])
def dut_shr(request):
    dut = ShiftReg()
    return Simulation(request.param, model=dut, input_types=[int, bool, Sfix(left=2, right=-18)])


def test_shift_reg(dut_shr):
    # first output values are initial valus defined in __init__
    in_int = [0, -1, -2, -3, -4, -5]
    in_bool = [False, False, False, True, True, True]
    in_sfix = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6]
    out_int, out_bool, out_sfix = dut_shr.main(in_int, in_bool, in_sfix)
    assert (out_int == [4, 3, 2, 1, 0, -1]).all()
    assert (out_bool.astype(bool) == [True, False, False, True, False, False]).all()
    assert np.allclose(out_sfix, [2.1, -0.5, 0.6, 0.5, 0.1, 0.2], rtol=1e-4)
