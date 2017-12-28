import subprocess
from enum import Enum

import numpy as np
import pytest

import pyha
from pyha.common.complex_fixed_point import ComplexSfix
from pyha.common.core import Hardware
from pyha.common.fixed_point import Sfix
from pyha.simulation.legacy import assert_sim_match
from pyha.simulation.simulation_interface import simulate, assert_equals, Simulation, NoModelError, sims_close


class TestConst:
    def test_basic(self):
        class B2(Hardware):
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


class States(Enum):
    S0, S1 = range(2)


class TestEnum:
    def test_basic(self):
        class T(Hardware):
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

    def test_doc_statemachine(self):
        class T(Hardware):
            def __init__(self):
                self.state = States.S0

            def main(self, a):
                if self.state == States.S0:
                    self.state = States.S1
                    return 0
                elif self.state == States.S1:
                    self.state = States.S0
                    return a

        dut = T()
        inputs = [1] * 4
        ret = simulate(dut, inputs, simulations=['MODEL', 'PYHA', 'RTL'])
        assert_equals(ret)

    def test_statemachine(self):
        class T(Hardware):
            def __init__(self):
                self.state = TheEnum.ENUM0

            def main(self, dummy):
                if self.state == TheEnum.ENUM0:
                    self.state = TheEnum.ENUM1
                elif self.state == TheEnum.ENUM1:
                    self.state = TheEnum.ENUM2
                elif self.state == TheEnum.ENUM2:
                    self.state = TheEnum.ENUM3
                elif self.state == TheEnum.ENUM3:
                    self.state = TheEnum.ENUM0
                    return 2

                return 1

        dut = T()
        inputs = [0.1] * 8
        ret = simulate(dut, inputs)
        assert_equals(ret)


class TestStreaming:
    class Streaming(Hardware):
        def __init__(self, dtype):
            self.data = dtype
            self.valid = False

        def set_valid_data(self, data):
            self.data = data
            self.valid = True

    def test_basic(self):
        class A(Hardware):
            def __init__(self):
                self.a = TestStreaming.Streaming(0)

            def main(self, b):
                self.a.set_valid_data(b)
                return b

        dut = A()
        inputs = [1, 2, 3]
        assert_sim_match(dut, None, inputs, simulations=['PYHA', 'RTL', 'GATE'])


class TestSubmodulesList:
    def test_basic(self):
        class A(Hardware):
            def __init__(self):
                self.reg = 0

            def main(self, x):
                self.reg = x
                return self.reg

        class B(Hardware):
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
        class C2(Hardware):
            def __init__(self):
                self.regor = False

            def main(self, x):
                return x

        class A2(Hardware):
            def __init__(self, reg_init):
                self.reg = reg_init
                self.submodule = C2()

            def main(self, x):
                r = self.submodule.main(1)
                self.reg = x
                return self.reg

        class B2(Hardware):
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

        assert_sim_match(dut, expected, *x, simulations=['PYHA', 'RTL', 'GATE'])

    def test_for(self):
        class A4(Hardware):
            def __init__(self, reg_init):
                self.reg = reg_init

            def main(self, x):
                self.reg = x
                return self.reg

        class B4(Hardware):
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
        class Register(Hardware):
            def __init__(self):
                self.b = 123

            def main(self, nb):
                self.b = nb
                return self.b

        dut = Register()
        inputs = [1, 2, 3, 4]
        expect = [123, 1, 2, 3]

        assert_sim_match(dut, expect, inputs, rtol=1e-4, simulations=['PYHA', 'RTL', 'GATE'])

    def test_multi(self):
        class Register(Hardware):
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

        assert_sim_match(dut, expect, *inputs, rtol=1e-4, simulations=['PYHA', 'RTL', 'GATE'])

    def test_complexsfix(self):
        class Register(Hardware):
            def __init__(self):
                self.DELAY = 1
                self.b = ComplexSfix(0, 0, -17)
                self.a = ComplexSfix(0, 0, -17)

            def main(self, nb):
                self.b = nb
                self.a.real = nb.real
                self.a.imag = nb.imag
                return self.b, self.a

        dut = Register()
        inputs = [0.1 + 0.15j, 0.2 + 0.25j, 0.3 + 0.35j, 0.4 + 0.45j]

        sims = simulate(dut, inputs, simulations=['MODEL', 'PYHA', 'RTL'])
        assert sims_close(sims)

    def test_sfix_lazy(self):
        class LazySfixReg(Hardware):
            def __init__(self):
                self.a = Sfix()
                self.DELAY = 1

            def main(self, new_value):
                self.a = new_value
                return self.a

        dut = LazySfixReg()

        inputs = [0.1, 0.2, 0.3, 0.4]
        expect = [0.1, 0.2, 0.3, 0.4]

        sims = simulate(dut, inputs)
        assert sims_close(sims, expect, rtol=1e-4)
        assert_sim_match(dut, expect, inputs, rtol=1e-4)

    def test_submodule(self):
        """ Assign of submodules is specially handled.. """

        class Sub(Hardware):
            def __init__(self, i=0):
                self.a = i
                self.b = False

        class T(Hardware):
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
        class ShiftReg(Hardware):
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

        assert_sim_match(dut, expect, *inputs, simulations=['PYHA', 'RTL', 'GATE'])

    def test_shiftreg_sfix_lazy(self):
        class ShiftReg(Hardware):
            def __init__(self):
                self.shr_sfix = [Sfix(0.5)] * 4

            def main(self, new_sfix):
                self.shr_sfix = [new_sfix] + self.shr_sfix[:-1]
                return self.shr_sfix[-1]

        dut = ShiftReg()

        inputs = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6]
        expect = [0.5, 0.5, 0.5, 0.5, 0.1, 0.2]
        sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert_equals(sims, expected=expect)
        print(sims)

    def test_shiftreg_sfix_lazy_backward(self):
        class ShiftReg(Hardware):
            def __init__(self):
                self.shr_sfix = [Sfix(0.0)] * 4

            def main(self, new_sfix):
                self.shr_sfix = self.shr_sfix[1:] + [new_sfix]
                return self.shr_sfix[-1]

        dut = ShiftReg()

        inputs = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6]
        expect = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5]
        sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        print(sims)
        assert_equals(sims, expected=expect)

    def test_submodule_shiftreg(self):
        """ May fail when list of submoduls fail to take correct initial values """

        class Sub(Hardware):
            def __init__(self, i=0):
                self.a = i
                # self.b = False

        class ShiftReg(Hardware):
            def __init__(self):
                self.shr_sub = [Sub(3), Sub(4)]

            def main(self, new_sub):
                self.shr_sub = [new_sub] + self.shr_sub[:-1]
                return self.shr_sub[-1]

        dut = ShiftReg()

        inputs = [Sub(999), Sub(9999), Sub(99999), Sub(999999)]
        expect = [Sub(4), Sub(3), Sub(999), Sub(9999)]

        ret = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert_equals(ret, expect)


class TestMainAsModel:
    """ Issue #107. Main can be interpreted as model (delays and fixed point stuffs are OFF) """

    def test_counter_int(self):
        class T(Hardware):
            def __init__(self):
                self.a = 0
                self.DELAY = 1

            def main(self, a):
                self.a = a + 1
                return self.a

        x = [1, 2, 3]

        dut = T()
        assert_sim_match(dut, None, x, simulations=['MODEL', 'PYHA'])

    def test_int_list(self):
        class T(Hardware):
            def __init__(self):
                self.a = [0, 0]
                self.DELAY = 1

            def main(self, a):
                self.a = [a] + self.a[:-1]
                return self.a[-1]

        x = [1, 2, 3]

        dut = T()
        assert_sim_match(dut, None, x, simulations=['MODEL', 'PYHA'])

    def test_counter_sfix(self):
        class T(Hardware):
            def __init__(self):
                self.a = Sfix(0.0, 0, -17)
                self.DELAY = 1

            def main(self, a):
                self.a = self.a + 0.0123
                return self.a

        x = [1] * 16
        dut = T()
        assert_sim_match(dut, None, x, simulations=['MODEL', 'PYHA'])

    def test_sfix_list(self):
        class T(Hardware):
            def __init__(self):
                self.a = [Sfix(0.0, 0, -17)] * 2
                self.DELAY = 1

            def main(self, a):
                self.a = [a] + self.a[:-1]
                return self.a[-1]

        x = [0.1, 0.2, 0.3, 0.4, 0.5]

        dut = T()
        assert_sim_match(dut, None, x, simulations=['MODEL', 'PYHA'])


class TestInterface:
    def test_basic(self):
        class T(Hardware):
            def main(self, i):
                return i

        dut = T()
        assert_sim_match(dut, range(4), range(4))

    def test_return_types(self):
        class T(Hardware):
            def main(self, i):
                return i

        outs = simulate(T(), [1, 2], simulations=['PYHA', 'RTL'])
        assert type(outs['PYHA'][0]) == int
        assert type(outs['RTL'][0]) == int

        outs = simulate(T(), [True, False], simulations=['PYHA', 'RTL'])
        assert type(outs['PYHA'][0]) == bool
        assert type(outs['RTL'][0]) == bool

    def test_return_types_two(self):
        """ Bug was that when one attr was 'float' it forced conversion of all outputs to float. """
        class T(Hardware):
            def main(self, i, j):
                return i, j

        outs = simulate(T(), [1, 2], [0.1, 0.2], simulations=['MODEL', 'PYHA', 'RTL'])
        assert type(outs['PYHA'][0][0]) == int
        assert type(outs['RTL'][0][0]) == int
        assert type(outs['MODEL'][0][0]) == int

        assert type(outs['PYHA'][1][0]) == float
        assert type(outs['RTL'][1][0]) == float
        assert type(outs['MODEL'][1][0]) == float

    def test_multi(self):
        class T(Hardware):
            def main(self, b, sfix):
                return b, sfix

        dut = T()
        data = [[True, False, False], [0.1, 0.2, 0.3]]
        assert_sim_match(dut, data, *data)

    def test_list(self):
        class T(Hardware):
            def main(self, l):
                return l

        dut = T()
        data = [[1, 2], [3, 4], [5, 6]]
        assert_sim_match(dut, data, data)

    def test_sfix(self):
        class T(Hardware):
            def main(self, l):
                return l

        dut = T()
        data = [0.1] * 3
        ret = simulate(dut, data)
        assert_equals(ret, data)

    def test_submodule_sfix(self):
        """ Problem where sfix values in submodule were not converted to float after sim"""

        class Sub(Hardware):
            def __init__(self):
                self.subsub = Sfix(0.3, 0, -17)

        class T(Hardware):
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

        class SubSub(Hardware):
            def __init__(self, i):
                self.a = i * 3

        class Sub(Hardware):
            def __init__(self, i=0):
                self.subsub = SubSub(i)
                self.a = i
                self.b = False

        class T(Hardware):
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

    def test_model_numpy_output(self):
        """ Was bug when model returned numpy array it was incorrectly transposed """

        class Tst(Hardware):
            def model_main(self, dummy):
                a = np.random.rand(3)
                b = np.random.rand(3)
                return a, b

        dut = Tst()
        inputs = [0.234 + 0.92j]
        sim_out = simulate(dut, inputs, simulations=['MODEL'])
        assert len(sim_out['MODEL']) == 2
        assert len(sim_out['MODEL'][0]) == 3
        assert len(sim_out['MODEL'][1]) == 3

    def test_sims_close_numpy_expected(self):
        """ Need to convert expected to list recursively """
        inputs = [0.234 + 0.92j]
        expect = [np.abs(inputs), np.angle(inputs) / np.pi]

        class Tst(Hardware):
            def model_main(self, cin):
                return np.abs(cin), np.angle(cin) / np.pi  # NOTICE, angle is divided by np.pi

        dut = Tst()
        sim_out = simulate(dut, inputs, simulations=['MODEL'])
        assert sims_close(sim_out, expect)

    def test_sims_close_numpy_type_complex(self):
        """ Stuff failed when expected type was not 'Python' type. For example type was 'np.complex64', function
         should convert numpy types to Python types"""
        in_py = {'MODEL': [0.234 + 0.92j]}
        ex_np = np.array([0.234 + 0.92j])
        assert sims_close(in_py, ex_np)

        ex_np = np.array([0.234 + 0.92j]).astype(np.complex128)
        assert sims_close(in_py, ex_np)

    def test_sims_close_numpy_type_float(self):
        """ Stuff failed when expected type was not 'Python' type. For example type was 'np.complex64', function
         should convert numpy types to Python types"""
        in_py = {'MODEL': [0.234]}
        ex_np = np.array([0.234])
        assert sims_close(in_py, ex_np)

        ex_np = np.array([0.234]).astype(np.float128)
        assert sims_close(in_py, ex_np)

    def test_sims_close_numpy_type_int(self):
        """ Stuff failed when expected type was not 'Python' type. For example type was 'np.complex64', function
         should convert numpy types to Python types"""
        in_py = {'MODEL': [1]}
        ex_np = np.array([1])
        assert sims_close(in_py, ex_np)

        ex_np = np.array([1]).astype(np.int32)
        assert sims_close(in_py, ex_np)

    def test_sims_close_numpy_type_bool(self):
        """ Stuff failed when expected type was not 'Python' type. For example type was 'np.complex64', function
         should convert numpy types to Python types"""
        in_py = {'MODEL': [False]}
        ex_np = np.array([False])
        assert sims_close(in_py, ex_np)

        ex_np = np.array([False]).astype(np.bool)
        assert sims_close(in_py, ex_np)

    def test_auto_complex_saturates(self):
        """ Automatic conversion from Complex to ComplexSfix did not saturate """
        inp = [1 + 1j, 1 - 1j, -1 + 1j, -1 - 1j]
        expect = [1 + 1j, 1 - 1j, -1 + 1j, -1 - 1j]

        class Tst(Hardware):
            def main(self, cin):
                return cin

        dut = Tst()

        sims = simulate(dut, inp, simulations=['PYHA'])
        assert sims_close(sims, expect)

    def test_single_input(self):
        class T13(Hardware):
            def main(self, x):
                return x

        dut = T13()
        x = [1.0]
        sims = simulate(dut, x, simulations=['PYHA', 'RTL'])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)


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

    def test_in_out(self):
        class T(Hardware):
            def main(self, a):
                return a

        inputs = [0.1 + 0.5j] * 16
        dut = T()
        ret = simulate(dut, inputs)
        assert_equals(ret, inputs)

    def test_assign_local_input(self):
        """ For local object (in this case the input) there should be no register or sfix effects enabled """

        class Register(Hardware):
            def main(self, x):
                ret = x
                ret.real = x.real
                ret.imag = x.imag
                return ret

        dut = Register()
        inputs = [0.1 + 0.15j, 0.2 + 0.25j, 0.3 + 0.35j, 0.4 + 0.45j]

        sims = simulate(dut, inputs)
        assert sims_close(sims)

    # def test_assign_local_input_add(self):
    #     """ For local object (in this case the input) there should be no register or sfix effects enabled """
    #
    #     class Register(Hardware):
    #         def main(self, x):
    #             ret = x
    #             ret.real = x.real + 0.1
    #             ret.imag = x.imag + 0.1
    #             return ret
    #
    #     dut = Register()
    #     inputs = [0.1 + 0.15j, 0.2 + 0.25j, 0.3 + 0.35j, 0.4 + 0.45j]
    #
    #     sims = simulate(dut, inputs, simulations=['PYHA', 'RTL'], conversion_path='/home/gaspar/git/pyha/playground')
    #     assert sims_close(sims)


class TestInOutOrdering:
    """ Had problems with the serialize/deserialise ordering, some stuff was flipped """

    def test_sub(self):
        class Sub(Hardware):
            def __init__(self):
                self.v0 = Sfix(0.987, 0, -4)
                self.v1 = Sfix(0.569, 0, -4)
                self.v2 = Sfix(0.0625, 0, -4)

        class T(Hardware):
            def main(self, a):
                return a.v0, a.v1, a.v2

        inputs = [Sub()] * 2
        dut = T()
        ret = simulate(dut, inputs)
        assert_equals(ret, [[0.987] * 2, [0.569] * 2, [0.0625] * 2], rtol=1e-1)

    def test_sub_sub(self):
        class SubSub(Hardware):
            def __init__(self):
                self.v0 = Sfix(0.987, 0, -4)

        class Sub(Hardware):
            def __init__(self):
                self.s0 = SubSub()
                self.s1 = SubSub()
                self.v2 = Sfix(0.0625, 0, -4)

        class T(Hardware):
            def main(self, a):
                return a.s0.v0, a.s1.v0, a.v2

        inputs = [Sub()] * 2
        dut = T()
        ret = simulate(dut, inputs)
        assert_equals(ret, [[0.987] * 2, [0.987] * 2, [0.0625] * 2], rtol=1e-1)

    def test_sub_sub_direct(self):
        class SubSub(Hardware):
            def __init__(self):
                self.v0 = Sfix(0.987, 0, -4)
                self.v1 = Sfix(0.1, 0, -4)

        class Sub(Hardware):
            def __init__(self):
                self.s0 = SubSub()
                self.s1 = SubSub()
                self.v2 = Sfix(0.123, 0, -4)

        class T(Hardware):
            def main(self, a):
                return a

        inputs = [Sub()] * 2
        dut = T()
        ret = simulate(dut, inputs)
        assert_equals(ret)

    def test_list(self):
        class T(Hardware):
            def main(self, l):
                return l

        dut = T()
        data = [[False, False, True], [True, False, True]]
        assert_sim_match(dut, data, data)

    def test_list_unit(self):
        """ Make sure elements are not swapped due to serialization """

        class T(Hardware):
            def main(self, l):
                return l[0], l[1], l[2]

        dut = T()
        data = [[False, False, True], [True, False, True]]
        assert_sim_match(dut, None, data)

    def test_list_sub(self):
        class SubSub(Hardware):
            def __init__(self):
                self.v0 = Sfix(0.987, 0, -4)
                self.v1 = Sfix(0.1, 0, -4)
                self.arr = [1, 2, 3, 4, 5, 6, 7]

        class Sub(Hardware):
            def __init__(self):
                self.s0 = [SubSub()] * 2

        class T(Hardware):
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

        class T2(Hardware):
            def main(self, a):
                return a.s0[0].arr

        inputs = [Sub()] * 2
        dut = T2()
        ret = simulate(dut, inputs)
        assert_equals(ret)


def test_hw_sim_resets():
    """ Registers should take initial values on each new simulation(call of main) invocation,
    motivation is to provide same interface as with COCOTB based 'RTL' simulation."""

    class Rst_Hw(Hardware):
        def __init__(self):
            self.sfix_reg = Sfix(0.5, 0, -18)
            self.DELAY = 1

        def main(self, in_sfix):
            self.sfix_reg = in_sfix
            return self.sfix_reg

    dut = Simulation('PYHA', model=Rst_Hw())
    dut.main([0.1])
    first_out = float(dut.pure_output[0])
    assert first_out == 0.5

    # make new simulation, registers must reset
    dut.main([0.1])
    first_out = float(dut.pure_output[0])
    assert first_out == 0.5


class TestFloatToSfix:
    class D(Hardware):
        def __init__(self):
            self.reg = 0.5
            self.saturation = 1.5  # make sure is saturated
            self.round = 0.00009  # make sure is rounded

        def main(self, a):
            return self.reg, self.saturation, self.round

    class Listy(Hardware):
        def __init__(self):
            self.float_list = [0.5, 0.00009, 1.5]
            # self.l = [D(), D()] # submod list

    def test_basic(self):
        dut = self.D()
        dut._pyha_floats_to_fixed()
        assert dut.reg == Sfix(0.5, 0, -17, round_style='round', overflow_style='saturate')
        assert dut.round.val == 9.1552734375e-05
        assert dut.saturation.val == 0.9999923706054688

        assert dut._pyha_next['reg'] == Sfix(0.5, 0, -17, round_style='round', overflow_style='saturate')
        assert dut._pyha_next['round'].val == 9.1552734375e-05
        assert dut._pyha_next['saturation'].val == 0.9999923706054688

        assert dut._pyha_initial_self.reg == Sfix(0.5, 0, -17, round_style='round', overflow_style='saturate')
        assert dut._pyha_initial_self.round.val == 9.1552734375e-05
        assert dut._pyha_initial_self.saturation.val == 0.9999923706054688

    def test_basic_sim(self):
        dut = self.D()
        inp = [0]
        r = simulate(dut, inp, simulations=['MODEL', 'PYHA', 'RTL'])

        assert r['MODEL'] == [[0.5], [1.5], [9e-05]]
        assert r['PYHA'] == [[0.5], [0.9999923706054688], [9.1552734375e-05]]
        try:
            assert r['PYHA'] == r['RTL']
        except KeyError:
            pass

    def test_list(self):
        dut = self.Listy()
        dut._pyha_floats_to_fixed()
        assert dut.float_list[0] == Sfix(0.5, 0, -17, round_style='round', overflow_style='saturate')
        assert dut.float_list[1].val == 9.1552734375e-05
        assert dut.float_list[2].val == 0.9999923706054688

        assert dut.float_list._pyha_next[0] == Sfix(0.5, 0, -17, round_style='round', overflow_style='saturate')
        assert dut.float_list._pyha_next[1].val == 9.1552734375e-05
        assert dut.float_list._pyha_next[2].val == 0.9999923706054688

    def test_submodule(self):
        """ Make sure submodules are affected """

        class D0(Hardware):
            def __init__(self):
                self.reg = 0.5
                self.float_list = [0.5, 0.25]

        class D1(Hardware):
            def __init__(self):
                self.sub = D0()

        dut = D1()
        dut._pyha_floats_to_fixed()
        assert dut.sub.reg == Sfix(0.5, 0, -17, round_style='round', overflow_style='saturate')
        assert dut.sub.float_list[0] == Sfix(0.5, 0, -17, round_style='round', overflow_style='saturate')

    def test_submodule_list(self):
        """ Had a bug where lists of submodules were not converted by floats to sfixed """

        class D0(Hardware):
            def __init__(self):
                self.reg = 0.5
                self.float_list = [0.5, 0.25]

        class D1(Hardware):
            def __init__(self):
                self.sub_list = [D0(), D0()]

        dut = D1()
        dut._pyha_floats_to_fixed()
        assert dut.sub_list[0].reg == Sfix(0.5, 0, -17, round_style='round', overflow_style='saturate')
        assert dut.sub_list[1].reg == Sfix(0.5, 0, -17, round_style='round', overflow_style='saturate')
        assert dut.sub_list[0].float_list[0] == Sfix(0.5, 0, -17, round_style='round', overflow_style='saturate')


class TestCallModifications:
    """ Test various ways of calling functions.. """

    def test_simple(self):
        """
        self.b(x) -> b(self, x);
        """

        class T(Hardware):
            def __init__(self):
                self.a = 0
                self.DELAY = 1

            def f(self, inp):
                self.a = inp

            def main(self, inp):
                self.f(inp)
                return self.a

        dut = T()

        sims = simulate(dut, [1, 2, 3, 4, 5, 6], simulations=['MODEL', 'PYHA', 'RTL'])
        assert sims_close(sims)

    def test_simple_submod(self):
        """
        self.sub.main(x) -> MODULE_NAME.main(self.sub, x);
        """

        class Tsub(Hardware):
            def __init__(self):
                self.a = 0

            def main(self, inp):
                self.a = inp

        class T(Hardware):
            def __init__(self):
                self.sub = Tsub()
                self.DELAY = 1

            def main(self, inp):
                self.sub.main(inp)
                return self.sub.a

        dut = T()

        sims = simulate(dut, [1, 2, 3, 4, 5, 6])
        assert sims_close(sims)

    def test_direct_return(self):
        """
        return self.b(x) ->

        b(self, x, pyha_ret_0);
        ret_0 := pyha_ret_0;
        """

        class T(Hardware):
            def __init__(self):
                self.a = 0
                self.DELAY = 1

            def f(self, inp):
                self.a = inp
                return self.a

            def main(self, inp):
                return self.f(inp)

        dut = T()
        sims = simulate(dut, [1, 2, 3, 4, 5, 6])
        assert sims_close(sims)

    def test_return_to_local(self):
        """
        a = self.b(x) ->

        b(self, x, ret_0);
        a := ret_0;
        """

        class T(Hardware):
            def __init__(self):
                self.a = 0
                self.DELAY = 1

            def f(self, inp):
                self.a = inp
                return self.a

            def main(self, inp):
                ret = self.f(inp)
                return ret

        dut = T()

        sims = simulate(dut, [1, 2, 3, 4, 5, 6])
        assert sims_close(sims)

    def test_return_to_self_resize(self):
        """

        self.a = self.b(x) ->

        b(self, x, ret_0);
        self.a := resize(ret_0, ...);
        """

        class T(Hardware):
            def __init__(self):
                self.a = Sfix(0, 0, -28)
                self.DELAY = 1

            def f(self, inp):
                return inp + 0.1

            def main(self, inp):
                self.a = self.f(inp)
                return self.a

        dut = T()

        sims = simulate(dut, [0.1, 0.2, 0.3, 0.4])
        assert sims_close(sims)

    def test_return_to_self_resize_complex(self):
        """
        Same as above but for Complex type...may have deepcopy issues
        This has issues...
        """

        class T(Hardware):
            def __init__(self):
                self.a = ComplexSfix(0, 0, -28)
                self.DELAY = 1

            def f(self, inp):
                self.a.imag = inp.real + 0.1
                self.a.real = inp.imag + 0.1
                return self.a

            def main(self, inp):
                r = self.f(inp)
                return r

        dut = T()

        sims = simulate(dut, [0.1 + 0.2j, 0.2 - 0.98j])
        assert sims_close(sims)

    def test_expression_complex(self):
        """
        self.a = self.b(x) + 0.1 ->

        b(self, x, ret_0);
        self.a := resize(ret_0 + 0.1, ...);
        """

        class T(Hardware):
            def __init__(self):
                self.a = Sfix(0, 0, -28)
                self.DELAY = 1

            def f(self, inp):
                return inp

            def main(self, inp):
                self.a = self.f(inp) + 0.1
                return self.a

        dut = T()

        sims = simulate(dut, [0.1, 0.2, 0.3, 0.4])
        assert sims_close(sims)

    def test_call_is_argument(self):
        """
        self.a = self.b(self.b(0)) ->

        b(self, x, ret_0);
        b(self, ret_0, ret_1);
        self.a := resize(ret_1, ...);
        """

        class T(Hardware):
            def __init__(self):
                self.a = Sfix(0, 0, -28)
                self.DELAY = 1

            def f(self, inp):
                return inp

            def main(self, inp):
                self.a = self.f(self.f(inp))
                return self.a

        dut = T()

        sims = simulate(dut, [0.1, 0.2, 0.3, 0.4])
        assert sims_close(sims)

    def test_multi_call(self):
        """
        self.a = self.b(x) + self.b(x) ->

        b(self, x, ret_0);
        b(self, x, ret_1);
        self.a := resize(ret_0 + 0.1, ...);
        """

        class T(Hardware):
            def __init__(self):
                self.a = Sfix(0, 0, -28)
                self.DELAY = 1

            def f(self, inp):
                return inp

            def main(self, inp):
                self.a = self.f(inp) + self.f(inp)
                return self.a

        dut = T()

        sims = simulate(dut, [0.1, 0.2, 0.3, 0.4])
        assert sims_close(sims)

    def test_multi_return_local(self):
        """
        a, b = self.b(x)->

        b(self, x, ret_0, ret_1);
        a := ret_0;
        b := ret_1;
        """

        class T(Hardware):
            def __init__(self):
                self.a = Sfix(0, 0, -28)
                # self.DELAY = 1

            def f(self, inp):
                return inp + 0.1, inp + 0.2 + 0.4

            def main(self, inp):
                a, b = self.f(inp)
                return a, b

        dut = T()

        sims = simulate(dut, [0.1, 0.2, 0.3, 0.4])
        assert sims_close(sims)

    def test_multi_return_register(self):
        """
        a, b = self.b(x)->

        b(self, x, ret_0, ret_1);
        a := ret_0;
        b := ret_1;
        """

        class T(Hardware):
            def __init__(self):
                self.a = Sfix(0, 0, -28)
                self.b = Sfix(0, 0, -18)
                self.DELAY = 1

            def f(self, inp):
                return inp + 0.1, inp + 0.2 + 0.1

            def main(self, inp):
                self.a, self.b = self.f(inp)
                return self.a, self.b

        dut = T()

        sims = simulate(dut, [0.1, 0.2, 0.3, 0.4])
        assert sims_close(sims)

    def test_is_if_argument(self):
        class T(Hardware):
            def f(self, inp):
                return inp

            def main(self, inp):
                if self.f(inp) == 1:
                    return 1
                elif self.f(inp) == 2:
                    return 2
                else:
                    return 0

        dut = T()

        sims = simulate(dut, [0, 1, 1, 0, 2, 3, 1])
        assert sims_close(sims)

    def test_is_in_if_body(self):
        class T(Hardware):
            def f(self, inp):
                return inp

            def main(self, inp):
                if inp == 1:
                    return self.f(inp)
                else:
                    a = 5
                    return self.f(inp)

        dut = T()

        sims = simulate(dut, [0, 1, 1, 0, 2, 3, 1])
        assert sims_close(sims)

    def test_is_in_for_body(self):
        class T(Hardware):
            def f(self, inp):
                return inp

            def main(self, inp):
                for i in range(10):
                    a = self.f(inp)
                return a

        dut = T()

        sims = simulate(dut, [0, 1, 1, 0, 2, 3, 1])
        assert sims_close(sims)

    def test_is_in_for_body_if_cond(self):
        class T(Hardware):
            def f(self, inp):
                return inp

            def main(self, inp):
                for i in range(10):
                    if self.f(inp) == 1:
                        return 1
                return 0

        dut = T()

        sims = simulate(dut, [0, 1, 1, 0, 2, 3, 1])
        assert sims_close(sims)

    def test_if_nested(self):
        class T(Hardware):
            def f(self, inp):
                return inp

            def main(self, inp):
                for i in range(10):
                    if True:
                        if self.f(inp) == 1:
                            return 1
                        elif self.f(inp) == 2:
                            return 2
                return 0

        dut = T()

        sims = simulate(dut, [0, 1, 1, 0, 2, 3, 1])
        assert sims_close(sims)


def test_lazy_operands():
    class T(Hardware):
        def __init__(self):
            self.a = Sfix(0, 0, -28)
            self.b = Sfix(0, 0, -18)
            self.DELAY = 1

        def main(self, inp):
            self.a += 0.1
            self.b *= self.a
            return self.a, self.b

    dut = T()

    sims = simulate(dut, [0.1, 0.2, 0.3, 0.4])
    assert sims_close(sims)


from copy import copy, deepcopy


class TestRemoveCopyDeepcopy:
    def test_copy(self):
        class T(Hardware):
            def main(self, inp):
                tmp = copy(inp)
                tmp.real = inp.imag
                tmp.imag = inp.real

                return tmp

        dut = T()

        sims = simulate(dut, [0.1 + 0.2j, 0.3 - 0.4j])
        assert sims_close(sims)

    def test_deepcopy(self):
        class T(Hardware):
            def main(self, inp):
                tmp = deepcopy(inp)
                tmp.real = inp.imag
                tmp.imag = inp.real

                return tmp

        dut = T()

        sims = simulate(dut, [0.1 + 0.2j, 0.3 - 0.4j])
        assert sims_close(sims)

    def test_keeps_local_copy(self):
        class T(Hardware):

            def copy(self):
                return 1

            def main(self, inp):
                return self.copy()

        dut = T()

        sims = simulate(dut, [0.1 + 0.2j, 0.3 - 0.4j])
        assert sims_close(sims)


class TestPitfalls:
    def test_assign_to_input_182(self):
        """ Fails because inputs in VHDL are INPUTS, cannot be assigned, see #182 """

        class Register(Hardware):
            def main(self, x):
                x = x + 0.1
                return x

        dut = Register()
        inputs = [0.1, 0.2]

        with pytest.raises(Exception):
            sims = simulate(dut, inputs, simulations=['PYHA', 'RTL'])

    def test_object_assignment_183(self):
        """ In Python it goes by pointer but VHDL always makes copy., see #183 """

        class Register(Hardware):
            def main(self, x):
                tmp = x
                tmp.real = x.imag
                tmp.imag = x.real
                return tmp

        dut = Register()
        inputs = [0.1 + 0.2 * 1j, 0.2 + 0.5 * 1j]

        sims = simulate(dut, inputs)
        with pytest.raises(Exception):
            assert sims_close(sims)


def test_ghdl_version():
    ret = subprocess.getoutput('ghdl --version | grep -m1 GHDL')
    assert 'GHDL 0.34 (v0.34rc12-4-g06a78d2) [Dunoon edition]' == ret


def test_cocotb_version():
    version_file = pyha.__path__[0] + '/../cocotb/version'
    with open(version_file, 'r') as f:
        assert 'VERSION=1.0\n' == f.read()


def test_sim_no_model():
    class NoMain(Hardware):
        def model_main(self):
            pass

    class NoModelMain(Hardware):
        def main(self):
            pass

    with pytest.raises(NoModelError):
        Simulation('MODEL', None)

    with pytest.raises(NoModelError):
        Simulation('PYHA', NoMain(), None)

    with pytest.raises(NoModelError):
        Simulation('GATE', NoMain(), None)

    with pytest.raises(NoModelError):
        Simulation('RTL', NoMain(), None)

    # with pytest.raises(NoModelError):
    #     Simulation(SIM_MODEL, NoModelMain(), None)

    # this shall not raise as we are not simulating model
    Simulation('PYHA', NoModelMain(), None)

    # ok, not using main
    Simulation('MODEL', NoMain(), None)

# 2D CONV IDEA
# def tst_conv2d(a, b):
#     res = 0
#     for a_row, b_row in zip(a, b):
#         for a_item, b_item in zip(a_row, b_row):
#             res += a_item * b_item
#
#     class Tst(Hardware):
#         def __init__(self):
#             self.sum = [0] * 10
#
#         def main(self, a, b):
#             i = 1
#             for a_row, b_row in zip(a, b):
#                 for a_item, b_item in zip(a_row, b_row):
#                     if i == 0:
#                         self.sum[i] = a_item * b_item
#                     else:
#                         self.sum[i] = self.sum[i - 1] + a_item * b_item
#
#                     self.sum[i] = self.sum[i - 1] + a_item * b_item
#                     # res += a_item * b_item
#
#             return self.sum[-1]


# STUFF FOR RESOURCE REUSE
# class Unit(Hardware):
#     def __init__(self):
#         self.mac = Sfix(0.0, left=0, round_style=fixed_truncate, overflow_style=fixed_wrap)
#
#     def main(self, in0, in1):
#         self.mac = self.mac + in0 * in1
#         return self.mac
#
#
# def test_basic_share2():
#     # quartus shares mult and add (need to hack away the len bug)
#     class Dut(Hardware):
#         def __init__(self):
#             self.a = [Unit() for x in range(4)]
#             self.state = 0
#
#         def main(self, in0, in1):
#
#             # res = [x.main(in0, in1) for x in self.a]
#             res = [Sfix()] * 4
#             for i in range(len(self.a)):
#                 res[i] = self.a[i].main(in0, in1)
#                 # res = x.main(in0, in1)
#
#             # res = self.a[self.state].main(in0, in1)
#
#             # self.state = self.state + 1
#             # if self.state >= len(self.a) - 1:
#             #     self.state = 0
#
#             return res
#
#     dut = Dut()
#     inputs = [[0.1] * 256, [0.1] * 256]
#     ret = simulate(dut, *inputs, simulations=['PYHA', 'GATE'], conversion_path='/home/gaspar/git/pyha/playground')
#
#
# def rescale_taps(taps):
#     """
#     Rescale taps in that way that their sum equals 1
#     """
#     taps = np.array(taps)
#     cs = sum(taps)
#     # fixme: not sure here, abs seems right as it avoids overflows in core,
#     # then again it reduces the fir gain
#     # cs = sum(abs(taps))
#     for (i, x) in enumerate(taps):
#         taps[i] = x / cs
#
#     return taps.tolist()
#
#
# class FIR(Hardware):
#     """ FIR filter, taps will be normalized to sum 1 """
#
#     def __init__(self, taps):
#         self.taps = rescale_taps(taps)
#
#         # registers
#         self.acc = [Sfix(left=1, round_style=fixed_truncate, overflow_style=fixed_wrap)] * len(self.taps)
#         self.out = Sfix(0, 0, -17, round_style=fixed_truncate)
#
#         # constants
#         self.TAPS_REVERSED = [Sfix(x, 0, -17) for x in reversed(self.taps)]
#         self.DELAY = 2
#
#     def main(self, x):
#         """
#         Transposed form FIR implementation, this implementation has problems if you plan to rapidly switch the taps.
#         """
#         self.acc[0] = x * self.TAPS_REVERSED[0]
#         for i in range(1, len(self.TAPS_REVERSED)):
#             self.acc[i] = self.acc[i - 1] + x * self.TAPS_REVERSED[i]
#
#         self.out = self.acc[-1]
#         return self.out
#
#     def model_main(self, x):
#         return signal.lfilter(self.taps, [1.0], x)
#
#
# class TheEnum(Enum):
#     ENUM0, ENUM1, ENUM2, ENUM3 = range(4)
#
# def test_fir_share():
#
#     # shares everything
#     class Dut(Hardware):
#         def __init__(self):
#             # taps = signal.remez(8, [0, 0.1, 0.2, 0.5], [1, 0])
#             self.a = [FIR(np.random.rand(5)) for x in range(4)]
#             # self.state = 0
#             self.state = 0
#
#         def main(self, in0):
#
#             # res = [Sfix()] * 4
#             # for i in range(len(self.a)):
#             #     res[i] = self.a[i].main(in0)
#
#             if self.state == 0:
#                 res = self.a[0].main(in0)
#                 self.state = 1
#             elif self.state == 1:
#                 res = self.a[1].main(in0)
#                 self.state = 2
#             elif self.state == 2:
#                 res = self.a[2].main(in0)
#                 self.state = 4
#             elif self.state == 4:
#                 res = self.a[3].main(in0)
#                 self.state = 0
#
#             # res = self.a[i].main(in0)
#             #
#             # self.state = self.state + 1
#             # if self.state >= len(self.a) - 1:
#             #     self.state = 0
#
#             return res
#
#     dut = Dut()
#     inputs = [[0.1] * 256]
#     ret = simulate(dut, *inputs, simulations=['PYHA', 'RTL', 'GATE'], conversion_path='/home/gaspar/git/pyha/playground')
