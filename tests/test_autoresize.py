from pyha.common.hwsim import HW, SfixList
from pyha.common.sfix import Sfix, fixed_saturate, fixed_round, fixed_truncate, fixed_wrap, ComplexSfix
from pyha.conversion.conversion import get_conversion_datamodel
from pyha.conversion.coupling import reset_maker
from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL, SIM_RTL


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

        with HW.auto_resize():
            dut.main(Sfix(0.1, 2, -27))

            assert dut.next.a.left == 0
            assert dut.next.a.right == -4
            assert dut.next.a.val == 0.125

    def test_round(self):
        x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
        expected = [0.0, 0.125, 0.1875, 0.3125, 0.375, 0.5, 0.625, 0.6875, 0.8125, 0.875]

        dut = self.A(fixed_saturate, fixed_round)
        assert_sim_match(dut, expected, x,
                         simulations=[SIM_HW_MODEL, SIM_RTL])

    def test_truncate(self):
        x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
        expected = [0.0, 0.0625, 0.1875, 0.25, 0.375, 0.5, 0.5625, 0.6875, 0.75, 0.875]

        dut = self.A(fixed_saturate, fixed_truncate)
        assert_sim_match(dut, expected, x,
                         simulations=[SIM_HW_MODEL, SIM_RTL])

    def test_saturation(self):
        x = [0.9, 1.0, 1.5, 2.0]
        expected = [0.875, 0.9375, 0.9375, 0.9375]

        dut = self.A(fixed_saturate, fixed_truncate)
        assert_sim_match(dut, expected, x, types=[Sfix(left=2, right=-17)],
                         simulations=[SIM_HW_MODEL, SIM_RTL])

    def test_wrap(self):
        x = [0.9, 1.0, 1.5, 2.0]
        expected = [0.875, -1, -0.5, 0]

        dut = self.A(fixed_wrap, fixed_truncate)
        assert_sim_match(dut, expected, x, types=[Sfix(left=2, right=-17)],
                         simulations=[SIM_HW_MODEL, SIM_RTL])


class TestSfixList:
    class A1(HW):
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
        with HW.auto_resize():
            b[0] = a[0]

        assert b[0].left == 0
        assert b[0].right == -4
        assert b[0].val == 0.125

    def test_lists_to_sfixedlist(self):
        """ Metaclass shall turn lists of Sfix to SfixList """
        dut = self.A1(fixed_saturate, fixed_round)
        assert type(dut.a) == SfixList
        assert type(dut.next.a) == SfixList
        assert type(dut._pyha_initial_self.a) == SfixList
        assert type(dut._pyha_initial_self.next.a) == SfixList

        # make sure types stay after sim
        assert_sim_match(dut, None, [0.1, 0.2], simulations=[SIM_HW_MODEL])

        assert type(dut.a) == SfixList
        assert type(dut.next.a) == SfixList
        assert type(dut._pyha_initial_self.a) == SfixList
        assert type(dut._pyha_initial_self.next.a) == SfixList


    def test_basic(self):
        dut = self.A1(fixed_saturate, fixed_round)

        with HW.auto_resize():
            dut.main(Sfix(0.1, 2, -27))

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

        dut = self.A1(fixed_saturate, fixed_round)
        assert_sim_match(dut, expected, x,
                         simulations=[SIM_HW_MODEL, SIM_RTL])

    def test_truncate(self):
        x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]

        expected = [
            [0.0, 0.0625, 0.1875, 0.25, 0.375, 0.5, 0.5625, 0.6875, 0.75, 0.875],
            [0.0, 0.0625, 0.1875, 0.25, 0.375, 0.5, 0.5625, 0.6875, 0.75, 0.875]
        ]

        dut = self.A1(fixed_saturate, fixed_truncate)
        assert_sim_match(dut, expected, x,
                         simulations=[SIM_HW_MODEL, SIM_RTL])

    def test_saturation(self):
        x = [0.9, 1.0, 1.5, 2.0]
        expected = [
            [0.875, 0.9375, 0.9375, 0.9375],
            [0.875, 0.9375, 0.9375, 0.9375]
        ]

        dut = self.A1(fixed_saturate, fixed_truncate)
        assert_sim_match(dut, expected, x, types=[Sfix(left=2, right=-17)],
                         simulations=[SIM_HW_MODEL, SIM_RTL])

    def test_wrap(self):
        x = [0.9, 1.0, 1.5, 2.0]
        expected = [
            [0.875, -1, -0.5, 0],
            [0.875, -1, -0.5, 0]
        ]

        dut = self.A1(fixed_wrap, fixed_truncate)
        assert_sim_match(dut, expected, x, types=[Sfix(left=2, right=-17)],
                         simulations=[SIM_HW_MODEL, SIM_RTL])


class TestComplex:
    class A2(HW):
        def __init__(self, overflow_style, round_style):
            self.a = ComplexSfix(0, 0, -4, overflow_style=overflow_style, round_style=round_style)
            self._delay = 1

        def main(self, a):
            self.next.a.real = a
            self.next.a.imag = a
            return self.a

    def test_basic(self):
        dut = self.A2(fixed_saturate, fixed_round)

        with HW.auto_resize():
            dut.main(Sfix(0.1, 2, -27))

            assert dut.next.a.real.left == 0
            assert dut.next.a.real.right == -4
            assert dut.next.a.real.val == 0.125

            assert dut.next.a.imag.left == 0
            assert dut.next.a.imag.right == -4
            assert dut.next.a.imag.val == 0.125

    def test_round(self):
        x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
        expected = [0.0 + 0.0j, 0.125 + 0.125j, 0.1875 + 0.1875j, 0.3125 + 0.3125j, 0.375 + 0.375j, 0.5 + 0.5j
            , 0.625 + 0.625j, 0.6875 + 0.6875j, 0.8125 + 0.8125j, 0.875 + 0.875j]

        dut = self.A2(fixed_saturate, fixed_round)
        assert_sim_match(dut, expected, x,
                         simulations=[SIM_HW_MODEL, SIM_RTL])

    def test_truncate(self):
        x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
        expected = [0.0 + 0.0j, 0.0625 + 0.0625j, 0.1875 + 0.1875j, 0.25 + 0.25j, 0.375 + 0.375j, 0.5 + 0.5j
            , 0.5625 + 0.5625j, 0.6875 + 0.6875j, 0.75 + 0.75j, 0.875 + 0.875j]

        dut = self.A2(fixed_saturate, fixed_truncate)
        assert_sim_match(dut, expected, x,
                         simulations=[SIM_HW_MODEL, SIM_RTL])

    def test_saturation(self):
        x = [0.9, 1.0, 1.5, 2.0]
        expected = [0.875 + 0.875j, 0.9375 + 0.9375j, 0.9375 + 0.9375j, 0.9375 + 0.9375j]

        dut = self.A2(fixed_saturate, fixed_truncate)
        assert_sim_match(dut, expected, x, types=[Sfix(left=2, right=-17)],
                         simulations=[SIM_HW_MODEL, SIM_RTL])

    def test_wrap(self):
        x = [0.9, 1.0, 1.5, 2.0]
        expected = [0.875 + 0.875j, -1 - 1j, -0.5 - 0.5j, 0 + 0j]

        dut = self.A2(fixed_wrap, fixed_truncate)
        assert_sim_match(dut, expected, x, types=[Sfix(left=2, right=-17)],
                         simulations=[SIM_HW_MODEL, SIM_RTL])


class TestLazySfix:
    class A3(HW):
        def __init__(self):
            self.a = Sfix()
            self.b = Sfix(left=1)
            self.c = Sfix(right=-4)

            self._delay = 1

        def main(self, a):
            self.next.a = a
            self.next.b = a
            self.next.c = a
            return self.a, self.b, self.c


    def test_basic(self):
        dut = self.A3()

        with HW.auto_resize():
            dut.main(Sfix(0.1, 2, -27))

            assert dut.next.a.left == 2
            assert dut.next.a.right == -27
            assert dut.next.a.val == 0.10000000149011612

            assert dut.next.b.left == 1
            assert dut.next.b.right == -27
            assert dut.next.b.val == 0.10000000149011612

            assert dut.next.c.left == 2
            assert dut.next.c.right == -4
            assert dut.next.c.val == 0.125

    def test_sim(self):
        x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]

        dut = self.A3()
        assert_sim_match(dut, None, x,
                         simulations=[SIM_HW_MODEL, SIM_RTL])


class TestLazySfixList:
    class A4(HW):
        def __init__(self):
            self.a = [Sfix()] * 2
            self.b = [Sfix(left=1)] * 2
            self.c = [Sfix(right=-4)] * 2

            self._delay = 1

        def main(self, a):
            self.next.a[0] = a
            self.next.b[0] = a
            self.next.c[0] = a
            return self.a[0], self.b[0], self.c[0]

    def test_basic(self):
        dut = self.A4()
        with HW.auto_resize():
            dut.main(Sfix(0.1, 2, -27))

            assert dut.next.a[0].left == 2
            assert dut.next.a[0].right == -27
            assert dut.next.a[0].val == 0.10000000149011612

            assert dut.next.b[0].left == 1
            assert dut.next.b[0].right == -27
            assert dut.next.b[0].val == 0.10000000149011612

            assert dut.next.c[0].left == 2
            assert dut.next.c[0].right == -4
            assert dut.next.c[0].val == 0.125

    def test_type_build(self):
        """ Fill Nones in initial type """
        dut = self.A4()
        assert_sim_match(dut, None, [0.1, 0.2, 0.3], simulations=[SIM_HW_MODEL])
        assert dut.a.type == Sfix(0, 0, -17)
        assert dut.b.type == Sfix(0, 1, -17)
        assert dut.c.type == Sfix(0, 0, -4)

    def test_reset(self):
        dut = self.A4()
        assert_sim_match(dut, None, [0.1, 0.2, 0.3], simulations=[SIM_HW_MODEL])
        conv, datamodel = get_conversion_datamodel(dut)

        expect = [
            'self.\\next\\.a := (Sfix(0.0, 0, -17), Sfix(0.0, 0, -17));',
            'self.\\next\\.b := (Sfix(0.0, 1, -17), Sfix(0.0, 1, -17));',
            'self.\\next\\.c := (Sfix(0.0, 0, -4), Sfix(0.0, 0, -4));'
        ]
        ret = reset_maker(datamodel.self_data)

        assert expect == ret

    def test_sim(self):
        x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]

        assert_sim_match(self.A4(), None, x,
                         simulations=[SIM_HW_MODEL, SIM_RTL])


class TestLazyComplexSfix:
    class A5(HW):
        def __init__(self):
            self.a = ComplexSfix()
            self.b = ComplexSfix(left=1)
            self.c = ComplexSfix(right=-4)

            self._delay = 1

        def main(self, a):
            self.next.a.real = a
            self.next.a.imag = a

            self.next.b.real = a
            self.next.b.imag = a

            self.next.c.real = a
            self.next.c.imag = a
            return self.a, self.b, self.c

    def test_basic(self):
        dut = self.A5()

        with HW.auto_resize():
            dut.main(Sfix(0.1, 2, -27))

            assert dut.next.a.real.left == 2
            assert dut.next.a.real.right == -27
            assert dut.next.a.real.val == 0.10000000149011612

            assert dut.next.b.imag.left == 1
            assert dut.next.b.imag.right == -27
            assert dut.next.b.imag.val == 0.10000000149011612

            assert dut.next.c.real.left == 2
            assert dut.next.c.real.right == -4
            assert dut.next.c.real.val == 0.125

    def test_sim(self):
        x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]

        dut = self.A5()
        assert_sim_match(dut, None, x,
                         simulations=[SIM_HW_MODEL, SIM_RTL])


class TestAssignConstant:
    class A6(HW):
        def __init__(self):
            self.a = Sfix(0, 0, -17)
            self.b = Sfix(0, 2, -17)

            self.c = ComplexSfix(0, 0, -17)
            self._delay = 1

        def main(self, a):
            self.next.a = 0.123
            self.next.b = -2

            self.next.c.real = 0.78
            self.next.c.imag = -0.56
            return self.a, self.b, self.c

    def test_basic(self):
        dut = self.A6()

        with HW.auto_resize():
            dut.main(0)

            assert dut.next.a.left == 0
            assert dut.next.a.right == -17
            assert dut.next.a.val == 0.1230010986328125

            assert dut.next.b.left == 2
            assert dut.next.b.right == -17
            assert dut.next.b.val == -2

            assert dut.next.c.real.left == 0
            assert dut.next.c.real.right == -17
            assert dut.next.c.real.val == 0.779998779296875

            assert dut.next.c.imag.left == 0
            assert dut.next.c.imag.right == -17
            assert dut.next.c.imag.val == -0.55999755859375

    def test_sim(self):
        x = [1, 2]

        dut = self.A6()
        assert_sim_match(dut, None, x,
                         simulations=[SIM_HW_MODEL, SIM_RTL])

        # class TestListConcat:
        #     """ Currently list assigns will not be resized"""
        #     class A3(HW):
        #         def __init__(self):
        #             self.a = [Sfix(0, 0, -4)] * 2
        #
        #             self._delay = 1
        #
        #         def main(self, a):
        #             self.next.a = self.a[:-1] + [a]
        #             return self.a[-1]


        # def test_lol(self):
        #     a = [Sfix(0.1, 1, -27)] * 2
        #     b = SfixList(a, Sfix(0, 0, -4))
        #
        #     l = b[:-1] + [b]
        #
        # def test_basic(self):
        #     dut = self.A3()
        #
        #     with HW.auto_resize():
        #         dut.main(Sfix(0.1, 2, -27))
        #
        #         assert dut.next.a[0].left == 0
        #         assert dut.next.a[0].right == -4
        #         assert dut.next.a[0].val == 0.125
