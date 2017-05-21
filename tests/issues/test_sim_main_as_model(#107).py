from contextlib import AbstractContextManager

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, SIM_HW_MODEL


class TestCounterInt:
    class T0(HW):
        def __init__(self):
            self.a = 0
            self._delay = 1

        def main(self, a):
            self.a = a + 1
            return self.a

    def test_simulate(self):
        x = [1, 2, 3]

        dut = self.T0()
        assert_sim_match(dut, None, x, simulations=[SIM_MODEL, SIM_HW_MODEL])


class TestIntList:
    class T0(HW):
        def __init__(self):
            self.a = [0, 0]
            self._delay = 1

        def main(self, a):
            self.a = [a] + self.a[:-1]
            return self.a[-1]

    def test_simulate(self):
        x = [1, 2, 3]

        dut = self.T0()
        assert_sim_match(dut, None, x, simulations=[SIM_MODEL, SIM_HW_MODEL])


class TestCounterSfix:
    class T0(HW):
        def __init__(self):
            self.a = Sfix(0.0, 0, -17)
            self._delay = 1

        def main(self, a):
            self.a = self.a + 0.0123
            return self.a

    def test_simulate(self):
        x = [1] * 16

        dut = self.T0()
        assert_sim_match(dut, None, x, simulations=[SIM_MODEL, SIM_HW_MODEL])


class TestSfixList:
    class T0(HW):
        def __init__(self):
            self.a = [Sfix(0.0, 0, -17)] * 2
            self._delay = 1

        def main(self, a):
            self.a = [a] + self.a[:-1]
            return self.a[-1]

    def test_simulate(self):
        x = [0.1, 0.2, 0.3, 0.4, 0.5]

        dut = self.T0()
        assert_sim_match(dut, None, x, simulations=[SIM_MODEL, SIM_HW_MODEL])
