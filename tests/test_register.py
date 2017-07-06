import pytest

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.simulation.simulation_interface import assert_sim_match, SIM_GATE, SIM_RTL, SIM_HW_MODEL


class TestLaxySfixReg:
    def setup(self):
        class LazySfixReg(HW):
            def __init__(self):
                self.a = Sfix()
                self.DELAY = 1

            def main(self, new_value):
                self.a = new_value
                return self.a

        self.dut = LazySfixReg()

    def test_bits18(self):
        inputs = [0.1, 0.2, 0.3, 0.4]
        expect = [0.1, 0.2, 0.3, 0.4]

        assert_sim_match(self.dut, expect, inputs, rtol=1e-4)

    def test_bits9(self):
        # 0.1 fails, basically should we prequantize sfix values into model_main?
        pytest.xfail()
        inputs = [0.1, 0.2, 0.3, 0.4]
        expect = [0.1, 0.2, 0.3, 0.4]

        assert_sim_match(self.dut, expect, inputs, rtol=1e-2)


class TestRegisters:
    def setup(self):
        class Register(HW):
            def __init__(self):
                self.a = Sfix(0.123)
                self.b = 123
                self.c = False

            def main(self, na, nb, nc):
                self.a = na
                self.b = nb
                self.c = nc
                return self.a, self.b, self.c

        self.dut = Register()

    def test_basic(self):
        inputs = [[0.1, 0.2, 0.3, 0.4], [1, 2, 3, 4], [True, False, False, False]]
        expect = [[0.123, 0.1, 0.2, 0.3], [123, 1, 2, 3], [False, True, False, False]]

        assert_sim_match(self.dut, expect, *inputs, rtol=1e-4, simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])


class TestRegistersInt:
    def setup(self):
        class Register(HW):
            def __init__(self):
                self.b = 123

            def main(self, nb):
                self.b = nb
                return self.b

        self.dut = Register()

    def test_basic(self):
        inputs = [1, 2, 3, 4]
        expect = [123, 1, 2, 3]

        assert_sim_match(self.dut, expect, inputs, rtol=1e-4, simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])




class TestShiftRegisters:
    def setup(self):
        class ShiftReg(HW):
            def __init__(self, in_t=Sfix(left=0, right=-17)):
                self.in_t = in_t
                self.shr_int = [1, 2, 3, 4]
                self.shr_bool = [True, False, False, True]
                self.shr_sfix = [in_t(0.5), in_t(0.6),
                                 in_t(-0.5), in_t(0.5)]

            def main(self, new_int, new_bool, new_sfix):
                self.shr_int = [new_int] + self.shr_int[:-1]
                self.shr_bool = [new_bool] + self.shr_bool[:-1]
                self.shr_sfix = [new_sfix] + self.shr_sfix[:-1]
                return self.shr_int[-1], self.shr_bool[-1], self.shr_sfix[-1]

        self.dut = ShiftReg()

    def test_basic(self):
        inputs = [[0, -1, -2, -3, -4, -5],
                  [False, False, False, True, True, True],
                  [0.1, 0.2, 0.3, 0.4, 0.5, 0.6]]

        expect = [[4, 3, 2, 1, 0, -1],
                  [True, False, False, True, False, False],
                  [0.5, -0.5, 0.6, 0.5, 0.1, 0.2]]

        assert_sim_match(self.dut, expect, *inputs, simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])
