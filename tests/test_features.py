import subprocess
from enum import Enum

import pyha
import pytest
from pyha.common.complex_sfix import ComplexSfix
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.simulation.simulation_interface import SIM_HW_MODEL, SIM_RTL, SIM_GATE, assert_sim_match, SIM_MODEL, simulate, \
    assert_equals, Simulation, NoModelError


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

    def test_statemachine(self):
        class T(HW):
            def __init__(self):
                self.state = TheEnum.ENUM0

            def main(self):
                if self.state == TheEnum.ENUM0:
                    self.state = TheEnum.ENUM1
                elif self.state == TheEnum.ENUM1:
                    self.state = TheEnum.ENUM2
                elif self.state == TheEnum.ENUM2:
                    self.state = TheEnum.ENUM3
                elif self.state == TheEnum.ENUM3:
                    self.state = TheEnum.ENUM0

                return 1

        dut = T()
        inputs = [[0.1] * 256]
        ret = simulate(dut, *inputs, simulations=[SIM_HW_MODEL, SIM_GATE], dir_path='/home/gaspar/git/pyha/playground')


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
        assert_sim_match(dut, None, inputs, simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])


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

        assert_sim_match(dut, expected, *x)

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
        """ Assign of submodules is specilly handled.. """

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
        ret = simulate(dut, data)
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

        assert_sim_match(dut, expect, *inputs, simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])

    def test_submodule_shiftreg(self):
        """ May fail when list of submoduls fail to take correct initial values """

        class Sub(HW):
            def __init__(self, i=0):
                self.a = i
                # self.b = False

        class ShiftReg(HW):
            def __init__(self):
                self.shr_sub = [Sub(3), Sub(4)]

            def main(self, new_sub):
                self.shr_sub = [new_sub] + self.shr_sub[:-1]
                return self.shr_sub[-1]

        dut = ShiftReg()

        inputs = [Sub(999), Sub(9999), Sub(99999), Sub(999999)]
        expect = [Sub(4), Sub(3), Sub(999), Sub(9999)]

        ret = simulate(dut, inputs, simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])
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


class TestInterface:
    def test_basic(self):
        class T(HW):
            def main(self, i):
                return i

        dut = T()
        assert_sim_match(dut, range(4), range(4))

    def test_multi(self):
        class T(HW):
            def main(self, b, sfix):
                return b, sfix

        dut = T()
        data = [[True, False, False], [0.1, 0.2, 0.3]]
        assert_sim_match(dut, data, *data)

    def test_list(self):
        class T(HW):
            def main(self, l):
                return l

        dut = T()
        data = [[1, 2], [3, 4], [5, 6]]
        assert_sim_match(dut, data, data)

    def test_sfix(self):
        class T(HW):
            def main(self, l):
                return l

        dut = T()
        data = [0.1] * 3
        ret = simulate(dut, data)
        assert_equals(ret, data)

    def test_submodule_sfix(self):
        """ Problem where sfix values in submodule were not converted to float after sim"""

        class Sub(HW):
            def __init__(self):
                self.subsub = Sfix(0.3, 0, -17)

        class T(HW):
            def __init__(self):
                self.d = Sub()
                self.DELAY = 1

            def main(self, l):
                return self.d

        dut = T()
        data = [1] * 2
        ret = simulate(dut, data)
        assert_equals(ret)

    def test_submodule(self):
        """ May fail when model sim output is no copy() """

        class SubSub(HW):
            def __init__(self, i):
                self.a = i * 3

        class Sub(HW):
            def __init__(self, i=0):
                self.subsub = SubSub(i)
                self.a = i
                self.b = False

        class T(HW):
            def __init__(self):
                self.d = Sub()
                self.DELAY = 1

            def main(self, l):
                self.d.a = l.a
                self.d.b = l.b
                self.d.subsub.a = l.subsub.a
                return self.d

        dut = T()
        data = [Sub(1), Sub(2)]
        ret = simulate(dut, data)
        assert_equals(ret, data)


class TestComplexSfix:
    def test_py_implementation(self):
        a = ComplexSfix()
        assert a.real == Sfix(0.0)
        assert a.imag == Sfix(0.0)

        a = ComplexSfix(0)
        assert a.real == Sfix(0.0)
        assert a.imag == Sfix(0.0)

        a = ComplexSfix(0.5 + 1.2j, 1, -12)
        assert a.real == Sfix(0.5, 1, -12)
        assert a.imag == Sfix(1.2, 1, -12)

        a = ComplexSfix(0.699 + 0.012j, 0, -4)
        assert a.real.val == 0.6875
        assert a.imag.val == 0
        assert a.left == 0
        assert a.right == -4

    def test_in_out(self):
        class T(HW):
            def main(self, a):
                return a

        inputs = [0.1 + 0.5j] * 16
        dut = T()
        ret = simulate(dut, inputs)
        assert_equals(ret, inputs)


class TestInOutOrdering:
    """ Had problems with the serialize/deserialise ordering, some stuff was flipped """

    def test_sub(self):
        class Sub(HW):
            def __init__(self):
                self.v0 = Sfix(0.987, 0, -4)
                self.v1 = Sfix(0.569, 0, -4)
                self.v2 = Sfix(0.123, 0, -4)

        class T(HW):
            def main(self, a):
                return a.v0, a.v1, a.v2

        inputs = [Sub()] * 2
        dut = T()
        ret = simulate(dut, inputs)
        assert_equals(ret, [[0.987] * 2, [0.569] * 2, [0.123] * 2], rtol=1e-1)

    def test_sub_sub(self):
        class SubSub(HW):
            def __init__(self):
                self.v0 = Sfix(0.987, 0, -4)

        class Sub(HW):
            def __init__(self):
                self.s0 = SubSub()
                self.s1 = SubSub()
                self.v2 = Sfix(0.123, 0, -4)

        class T(HW):
            def main(self, a):
                return a.s0.v0, a.s1.v0, a.v2

        inputs = [Sub()] * 2
        dut = T()
        ret = simulate(dut, inputs)
        assert_equals(ret, [[0.987] * 2, [0.987] * 2, [0.123] * 2], rtol=1e-1)

    def test_sub_sub_direct(self):
        class SubSub(HW):
            def __init__(self):
                self.v0 = Sfix(0.987, 0, -4)
                self.v1 = Sfix(0.1, 0, -4)

        class Sub(HW):
            def __init__(self):
                self.s0 = SubSub()
                self.s1 = SubSub()
                self.v2 = Sfix(0.123, 0, -4)

        class T(HW):
            def main(self, a):
                return a

        inputs = [Sub()] * 2
        dut = T()
        ret = simulate(dut, inputs)
        assert_equals(ret)

    def test_list(self):
        class T(HW):
            def main(self, l):
                return l

        dut = T()
        data = [[False, False, True], [True, False, True]]
        assert_sim_match(dut, data, data)

    def test_list_unit(self):
        """ Make sure elements are not swapped due to serialization """

        class T(HW):
            def main(self, l):
                return l[0], l[1], l[2]

        dut = T()
        data = [[False, False, True], [True, False, True]]
        assert_sim_match(dut, None, data)

    def test_list_sub(self):
        class SubSub(HW):
            def __init__(self):
                self.v0 = Sfix(0.987, 0, -4)
                self.v1 = Sfix(0.1, 0, -4)
                self.arr = [1, 2, 3, 4, 5, 6, 7]

        class Sub(HW):
            def __init__(self):
                self.s0 = [SubSub()] * 2

        class T(HW):
            def main(self, a):
                return a

        inputs = [Sub()] * 2
        dut = T()
        ret = simulate(dut, inputs)
        assert_equals(ret)

        inputs = [[Sub()] * 2] * 2
        dut = T()
        ret = simulate(dut, inputs)
        assert_equals(ret)

        class T2(HW):
            def main(self, a):
                return a.s0[0].arr

        inputs = [Sub()] * 2
        dut = T2()
        ret = simulate(dut, inputs)
        assert_equals(ret)


def test_hw_sim_resets():
    """ Registers should take initial values on each new simulation(call of main) invocation,
    motivation is to provide same interface as with COCOTB based RTL simulation."""

    class Rst_Hw(HW):
        def __init__(self):
            self.sfix_reg = Sfix(0.5, 0, -18)
            self.DELAY = 1

        def main(self, in_sfix):
            self.sfix_reg = in_sfix
            return self.sfix_reg

    dut = Simulation(SIM_HW_MODEL, model=Rst_Hw())
    dut.main([0.1])
    first_out = float(dut.pure_output[0])
    assert first_out == 0.5

    # make new simulation, registers must reset
    dut.main([0.1])
    first_out = float(dut.pure_output[0])
    assert first_out == 0.5


def test_ghdl_version():
    # ghdl has same version for 'all versions'
    ret = subprocess.getoutput('ghdl --version | grep -m1 GHDL')
    assert 'GHDL 0.34dev (20151126) [Dunoon edition]' == ret


def test_cocotb_version():
    version_file = pyha.__path__[0] + '/../cocotb/version'
    with open(version_file, 'r') as f:
        assert 'VERSION=1.0\n' == f.read()


def test_sim_no_model():
    class NoMain(HW):
        def model_main(self):
            pass

    class NoModelMain(HW):
        def main(self):
            pass

    with pytest.raises(NoModelError):
        Simulation(SIM_MODEL, None)

    with pytest.raises(NoModelError):
        Simulation(SIM_HW_MODEL, NoMain(), None)

    with pytest.raises(NoModelError):
        Simulation(SIM_GATE, NoMain(), None)

    with pytest.raises(NoModelError):
        Simulation(SIM_RTL, NoMain(), None)

    # with pytest.raises(NoModelError):
    #     Simulation(SIM_MODEL, NoModelMain(), None)

    # this shall not raise as we are not simulating model
    Simulation(SIM_HW_MODEL, NoModelMain(), None)

    # ok, not using main
    Simulation(SIM_MODEL, NoMain(), None)


def tst_conv2d(a, b):
    res = 0
    for a_row, b_row in zip(a, b):
        for a_item, b_item in zip(a_row, b_row):
           res += a_item * b_item


    class Tst(HW):
        def __init__(self):
            self.sum = [0] * 10

        def main(self, a, b):
            i = 1
            for a_row, b_row in zip(a, b):
                for a_item, b_item in zip(a_row, b_row):
                    if i == 0:
                        self.sum[i] = a_item * b_item
                    else:
                        self.sum[i] = self.sum[i - 1] + a_item * b_item

                    self.sum[i] = self.sum[i-1] + a_item * b_item
                    # res += a_item * b_item

            return self.sum[-1]



