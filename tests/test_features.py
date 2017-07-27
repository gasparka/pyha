from enum import Enum

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.simulation.simulation_interface import SIM_HW_MODEL, SIM_RTL, SIM_GATE, assert_sim_match, SIM_MODEL, simulate, \
    assert_equals


class TestConst:
    def test_basic(self):
        class B2(HW):
            def __init__(self):
                self.REG = 1

            def main(self, a):
                return self.REG

        self.dut = B2()

        x = [1, 2, 3]
        expected = [1, 1, 1]
        assert_sim_match(self.dut, expected, x)


class TheEnum(Enum):
    ENUM0, ENUM1, ENUM2, ENUM3 = range(4)


class TestEnum:
    def test_basic(self):
        class T(HW):
            def __init__(self, mode):
                self.mode = mode

            def main(self, x):
                if self.mode == TheEnum.ENUM1:
                    return x
                else:
                    return 0

        dut = T(TheEnum.ENUM1)
        dut.main(1)

        x = list(range(16))
        expected = list(range(16))
        assert_sim_match(dut, expected, x)


class TestStreaming:
    class Streaming(HW):
        def __init__(self, dtype):
            self.data = dtype
            self.valid = False

        def set_valid_data(self, data):
            self.data = data
            self.valid = True

    def test_basic(self):
        class A(HW):
            def __init__(self):
                self.a = TestStreaming.Streaming(0)

            def main(self, b):
                self.a.set_valid_data(b)
                return b

        dut = A()
        inputs = [1, 2, 3]
        assert_sim_match(dut, None, inputs, simulations=[SIM_HW_MODEL, SIM_RTL])


class TestSubmodulesList:
    def test_basic(self):
        class A(HW):
            def __init__(self):
                self.reg = 0

            def main(self, x):
                self.reg = x
                return self.reg

        class B(HW):
            def __init__(self):
                self.sublist = [A(), A()]
                self.DELAY = 1

            def main(self, a, b):
                r0 = self.sublist[0].main(a)
                r1 = self.sublist[1].main(b)
                return r0, r1

        dut = B()
        dut.main(3, 4)
        dut.main(3, 4)
        x = [range(16), range(16)]
        expected = [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
                    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]]

        assert_sim_match(dut, expected, *x, dir_path='/home/gaspar/git/pyha/playground')

    def test_deep(self):
        class C2(HW):
            def __init__(self):
                self.regor = False

            def main(self, x):
                return x

        class A2(HW):
            def __init__(self, reg_init):
                self.reg = reg_init
                self.submodule = C2()

            def main(self, x):
                r = self.submodule.main(1)
                self.reg = x
                return self.reg

        class B2(HW):
            def __init__(self):
                self.sublist = [A2(2), A2(128)]

            def main(self, a, b):
                r0 = self.sublist[0].main(a)
                r1 = self.sublist[1].main(b)
                return r0, r1

        dut = B2()
        dut.main(1, 1)
        x = [range(16), range(16)]
        expected = [[2, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
                    [128, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]]

        assert_sim_match(dut, expected, *x, simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])

    def test_for(self):
        class A4(HW):
            def __init__(self, reg_init):
                self.reg = reg_init

            def main(self, x):
                self.reg = x
                return self.reg

        class B4(HW):
            def __init__(self):
                self.sublist = [A4(i) for i in range(4)]
                self.DELAY = 1

            def main(self, x):
                outs = [0, 0, 0, 0]
                for i in range(len(self.sublist)):
                    outs[i] = self.sublist[i].main(x)

                return outs[0]

        dut = B4()

        x = list(range(16))
        expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

        assert_sim_match(dut, expected, x)


class TestRegisters:
    def test_basic(self):
        class Register(HW):
            def __init__(self):
                self.b = 123

            def main(self, nb):
                self.b = nb
                return self.b

        dut = Register()
        inputs = [1, 2, 3, 4]
        expect = [123, 1, 2, 3]

        assert_sim_match(dut, expect, inputs, rtol=1e-4, simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])

    def test_multi(self):
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

        dut = Register()
        inputs = [[0.1, 0.2, 0.3, 0.4], [1, 2, 3, 4], [True, False, False, False]]
        expect = [[0.123, 0.1, 0.2, 0.3], [123, 1, 2, 3], [False, True, False, False]]

        assert_sim_match(dut, expect, *inputs, rtol=1e-4, simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])

    def test_sfix_lazy(self):
        class LazySfixReg(HW):
            def __init__(self):
                self.a = Sfix()
                self.DELAY = 1

            def main(self, new_value):
                self.a = new_value
                return self.a

        dut = LazySfixReg()

        inputs = [0.1, 0.2, 0.3, 0.4]
        expect = [0.1, 0.2, 0.3, 0.4]

        assert_sim_match(dut, expect, inputs, rtol=1e-4)

    def test_submodule(self):
        class Sub(HW):
            def __init__(self, i=0):
                self.a = i
                self.b = False

        class T(HW):
            def __init__(self):
                self.d = Sub()
                self.DELAY = 1

            def main(self, l):
                self.d = l
                return self.d

        dut = T()
        data = [Sub(1), Sub(2)]
        ret = simulate(dut, data, dir_path='/home/gaspar/git/pyha/playground')
        assert_equals(ret, data)

    def test_shiftregs(self):
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

        dut = ShiftReg()

        inputs = [[0, -1, -2, -3, -4, -5],
                  [False, False, False, True, True, True],
                  [0.1, 0.2, 0.3, 0.4, 0.5, 0.6]]

        expect = [[4, 3, 2, 1, 0, -1],
                  [True, False, False, True, False, False],
                  [0.5, -0.5, 0.6, 0.5, 0.1, 0.2]]

        assert_sim_match(dut, expect, *inputs, simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         dir_path='/home/gaspar/git/pyha/playground')

    def test_submodule_shiftreg(self):
        class Sub(HW):
            def __init__(self, i=0):
                self.a = i
                self.b = False

        class ShiftReg(HW):
            def __init__(self):
                self.shr_sub = [Sub(1), Sub(2), Sub(3), Sub(4)]

            def main(self, new_sub):
                self.shr_sub = [new_sub] + self.shr_sub[:-1]
                return self.shr_sub[-1]

        dut = ShiftReg()

        inputs = [Sub(0), Sub(1), Sub(2), Sub(3), Sub(4), Sub(5)]
        expect = [Sub(0), Sub(1), Sub(2), Sub(3), Sub(4), Sub(5)]

        ret = simulate(dut, inputs, dir_path='/home/gaspar/git/pyha/playground')
        assert_equals(ret, expect)


class TestMainAsModel:
    """ Issue #107. Main can be interpreted as model (delays and fixed point stuffs are OFF) """

    def test_counter_int(self):
        class T(HW):
            def __init__(self):
                self.a = 0
                self.DELAY = 1

            def main(self, a):
                self.a = a + 1
                return self.a

        x = [1, 2, 3]

        dut = T()
        assert_sim_match(dut, None, x, simulations=[SIM_MODEL, SIM_HW_MODEL])

    def test_int_list(self):
        class T(HW):
            def __init__(self):
                self.a = [0, 0]
                self.DELAY = 1

            def main(self, a):
                self.a = [a] + self.a[:-1]
                return self.a[-1]

        x = [1, 2, 3]

        dut = T()
        assert_sim_match(dut, None, x, simulations=[SIM_MODEL, SIM_HW_MODEL])

    def test_counter_sfix(self):
        class T(HW):
            def __init__(self):
                self.a = Sfix(0.0, 0, -17)
                self.DELAY = 1

            def main(self, a):
                self.a = self.a + 0.0123
                return self.a

        x = [1] * 16
        dut = T()
        assert_sim_match(dut, None, x, simulations=[SIM_MODEL, SIM_HW_MODEL])

    def test_sfix_list(self):
        class T(HW):
            def __init__(self):
                self.a = [Sfix(0.0, 0, -17)] * 2
                self.DELAY = 1

            def main(self, a):
                self.a = [a] + self.a[:-1]
                return self.a[-1]

        x = [0.1, 0.2, 0.3, 0.4, 0.5]

        dut = T()
        assert_sim_match(dut, None, x, simulations=[SIM_MODEL, SIM_HW_MODEL])
