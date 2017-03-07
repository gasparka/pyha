from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL

from pyha.common.hwsim import HW, SfixList
from pyha.common.sfix import Sfix, fixed_saturate, fixed_round, fixed_truncate, fixed_wrap


class TestSfix:
    class A(HW):
        def __init__(self, overflow_style, round_style):
            self.a = Sfix(0, 0, -4, overflow_style=overflow_style, round_style=round_style)

            self._delay = 1

        def main(self, a):
            self.next.a = a
            return self.a

    def test_basic(self):
        dut = self.A(fixed_saturate, fixed_round)

        HW.is_hw_simulation = True
        dut.main(Sfix(0.1, 2, -27))
        HW.is_hw_simulation = False

        assert dut.next.a.left == 0
        assert dut.next.a.right == -4
        assert dut.next.a.val == 0.125

    def test_round(self):
        x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
        expected = [0.0, 0.125, 0.1875, 0.3125, 0.375, 0.5, 0.625, 0.6875, 0.8125, 0.875]

        dut = self.A(fixed_saturate, fixed_round)
        assert_sim_match(dut, [Sfix(left=0, right=-17)], expected, x,
                         simulations=[SIM_HW_MODEL])

    def test_truncate(self):
        x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
        expected = [0.0, 0.0625, 0.1875, 0.25, 0.375, 0.5, 0.5625, 0.6875, 0.75, 0.875]

        dut = self.A(fixed_saturate, fixed_truncate)
        assert_sim_match(dut, [Sfix(left=0, right=-17)], expected, x,
                         simulations=[SIM_HW_MODEL])

    def test_saturation(self):
        x = [0.9, 1.0, 1.5, 2.0]
        expected = [0.875, 0.9375, 0.9375, 0.9375]

        dut = self.A(fixed_saturate, fixed_truncate)
        assert_sim_match(dut, [Sfix(left=2, right=-17)], expected, x,
                         simulations=[SIM_HW_MODEL])

    def test_wrap(self):
        x = [0.9, 1.0, 1.5, 2.0]
        expected = [0.875, -1, -0.5, 0]

        dut = self.A(fixed_wrap, fixed_truncate)
        assert_sim_match(dut, [Sfix(left=2, right=-17)], expected, x,
                         simulations=[SIM_HW_MODEL])


class TestSfixList:
    class A(HW):
        def __init__(self, overflow_style, round_style):
            self.a = [Sfix(0, 0, -4,
                           overflow_style=overflow_style,
                           round_style=round_style)] * 2

            self._delay = 1

        def main(self, a):
            self.next.a[0] = a
            self.next.a[1] = a
            return self.a[0], self.a[1]

    def test_sfixlist_operation(self):
        a = [Sfix(0.1, 1, -27)] * 2
        b = SfixList(a, Sfix(0, 0, -4))
        b[0] = a[0]

        assert b[0].left == 0
        assert b[0].right == -4
        assert b[0].val == 0.125

    def test_lists_to_sfixedlist(self):
        """ Metaclass shall turn lists of Sfix to SfixList """
        dut = self.A(fixed_saturate, fixed_round)
        assert type(dut.a) == SfixList

    def test_basic(self):
        dut = self.A(fixed_saturate, fixed_round)

        HW.is_hw_simulation = True
        dut.main(Sfix(0.1, 2, -27))
        HW.is_hw_simulation = False

        assert dut.next.a[0].left == 0
        assert dut.next.a[0].right == -4
        assert dut.next.a[0].val == 0.125

        assert dut.next.a[1].left == 0
        assert dut.next.a[1].right == -4
        assert dut.next.a[1].val == 0.125

    def test_round(self):
        x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
        expected = [
            [0.0, 0.125, 0.1875, 0.3125, 0.375, 0.5, 0.625, 0.6875, 0.8125, 0.875],
            [0.0, 0.125, 0.1875, 0.3125, 0.375, 0.5, 0.625, 0.6875, 0.8125, 0.875]
            ]

        dut = self.A(fixed_saturate, fixed_round)
        assert_sim_match(dut, [Sfix(left=0, right=-17)], expected, x,
                         simulations=[SIM_HW_MODEL])

    def test_truncate(self):
        x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]

        expected = [
            [0.0, 0.0625, 0.1875, 0.25, 0.375, 0.5, 0.5625, 0.6875, 0.75, 0.875],
            [0.0, 0.0625, 0.1875, 0.25, 0.375, 0.5, 0.5625, 0.6875, 0.75, 0.875]
            ]

        dut = self.A(fixed_saturate, fixed_truncate)
        assert_sim_match(dut, [Sfix(left=0, right=-17)], expected, x,
                         simulations=[SIM_HW_MODEL])

    def test_saturation(self):
        x = [0.9, 1.0, 1.5, 2.0]
        expected = [
            [0.875, 0.9375, 0.9375, 0.9375],
            [0.875, 0.9375, 0.9375, 0.9375]
            ]

        dut = self.A(fixed_saturate, fixed_truncate)
        assert_sim_match(dut, [Sfix(left=2, right=-17)], expected, x,
                         simulations=[SIM_HW_MODEL])

    def test_wrap(self):
        x = [0.9, 1.0, 1.5, 2.0]
        expected = [
            [0.875, -1, -0.5, 0],
            [0.875, -1, -0.5, 0]
            ]

        dut = self.A(fixed_wrap, fixed_truncate)
        assert_sim_match(dut, [Sfix(left=2, right=-17)], expected, x,
                         simulations=[SIM_HW_MODEL])
