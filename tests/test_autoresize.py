from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, fixed_saturate, fixed_round, fixed_truncate, fixed_wrap


class TestBasicSfix:
    class A(HW):
        def __init__(self, overflow_style, round_style):
            self.a = Sfix(0, 0, -4, overflow_style=overflow_style, round_style=round_style)

            self._delay = 1

        def main(self, a):
            self.next.a = a
            return self.a

    def test_round(self):
        x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
        expected = [0.0, 0.125, 0.1875, 0.3125, 0.375, 0.5, 0.625, 0.6875, 0.8125, 0.875]

        self.dut = self.A(fixed_saturate, fixed_round)
        assert_sim_match(self.dut, [Sfix(left=0, right=-17)], expected, x,
                         simulations=[SIM_HW_MODEL])

    def test_truncate(self):
        x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
        expected = [0.0, 0.0625, 0.1875, 0.25, 0.375, 0.5, 0.5625, 0.6875, 0.75, 0.875]

        self.dut = self.A(fixed_saturate, fixed_truncate)
        assert_sim_match(self.dut, [Sfix(left=0, right=-17)], expected, x,
                         simulations=[SIM_HW_MODEL])

    def test_saturation(self):
        x = [0.9, 1.0, 1.5, 2.0]
        expected = [0.875, 0.9375, 0.9375, 0.9375]

        self.dut = self.A(fixed_saturate, fixed_truncate)
        assert_sim_match(self.dut, [Sfix(left=2, right=-17)], expected, x,
                         simulations=[SIM_HW_MODEL])

    def test_wrap(self):
        x = [0.9, 1.0, 1.5, 2.0]
        expected = [0.875, -1, -0.5, 0]

        self.dut = self.A(fixed_wrap, fixed_truncate)
        assert_sim_match(self.dut, [Sfix(left=2, right=-17)], expected, x,
                         simulations=[SIM_HW_MODEL])