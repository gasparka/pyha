import os
from enum import Enum
from unittest.mock import patch, MagicMock
import numpy as np
import pytest
from pyha.common.complex import Complex
from pyha.common.core import Hardware
from pyha.common.fixed_point import Sfix
from pyha.common.ram import RAM
from pyha.conversion.top_generator import NoOutputsError
from pyha.simulation.simulation_interface import simulate, assert_equals, sims_close, \
    assert_sim_match


def test_list_of_rams():
    class T(Hardware):
        def __init__(self):
            self.ram = [RAM([Sfix(0.0, 0, -17)] * 128), RAM([Sfix(0.0, 0, -17)] * 128)]

        def main(self, ram_select, ram_index, write_data):
            self.ram[ram_select].delayed_write(ram_index, write_data)
            other = int(not ram_select)
            r = self.ram[other].delayed_read(ram_index)
            return r

    dut = T()
    inputs = [[0, 1, 0, 1, 0, 1, 1, 0], [0, 1, 2, 3, 4, 5, 6, 7], [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7]]

    sims = simulate(dut, *inputs, simulations=['PYHA', 'RTL', 'GATE'])
    assert sims_close(sims)


def test_sfix_call_argument():
    class T(Hardware):
        def b(self, x):
            return x

        def main(self, x):
            res = self.b(Sfix(0.0, 0, -17))
            return res

    dut = T()
    inputs = [True, True, True]

    sims = simulate(dut, inputs)
    assert sims_close(sims)


def test_func_call_not_simulated():
    """ One of the functions is not simulated and code fails to determine the return type ->
     delete functions calls that have not been called during simulation"""

    class T(Hardware):
        def b(self):
            l = 123  # b should NOT be parsed, or this line gives error (no type information)
            return 1

        def a(self):
            return True

        def main(self, cond):
            if cond:
                return self.a()
            else:
                return self.b()

    dut = T()
    inputs = [True, True, True]

    sims = simulate(dut, inputs)
    assert sims_close(sims)


def test_mod():
    """ Horrible bug: % was mapped to 'rem' which is shit for negative numbers + takes more resources..."""

    class T(Hardware):
        def __init__(self):
            self.DELAY = 1
            self.comp = 0

        def main(self, x):
            self.comp = (x - 8) % 512
            return self.comp

    dut = T()
    inputs = [0, 1, 2, 3, 4, 5, 6]

    sims = simulate(dut, inputs)
    assert sims_close(sims)


class TestSubmoduleAssign:
    """ Should be delayed assignment + all fixed point elements must be resized (however deep). In VHDL we cant just assign
    a := b; as this would update values immidietly, instead we need to assign every element:
    a.next.elem1 := b.elem1;
    e.next.elem2 := b.elem2;
    ...
    """

    def test_basic(self):
        class T(Hardware):
            def __init__(self):
                self.comp = Complex(0.0, 0, -8)

            def main(self, x):
                self.comp = x
                return self.comp

        dut = T()
        inputs = [0.0j, 0.1j, 0.2j]

        sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims)

    def test_basic_list(self):
        """ Failed because list __setitem__ did NOT go into recusive __setattr__"""

        class T(Hardware):
            def __init__(self):
                self.comp = [Complex(0.0, 0, -8), Complex(0.0, 0, -8)]

            def main(self, x):
                self.comp[0] = x
                return self.comp

        dut = T()
        inputs = [0.0j, 0.1j, 0.2j]

        sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims)

    def test_deep(self):
        class TSub(Hardware):
            def __init__(self, x):
                self.comp = x

        class T(Hardware):
            def __init__(self):
                self.comp = Complex(0.0, 0, -8)
                self.sub = TSub(Complex(0.0, 0, -2))

            def main(self, x):
                self.comp = x
                self.sub.comp = x
                self.sub = TSub(x)
                return self.comp

        dut = T()
        inputs = [0.0j, 0.1j, 0.2j]

        sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims)

    def test_constructor(self):
        class T(Hardware):
            def __init__(self):
                self.sub = Complex(0.0, 0, -8)

            def main(self, x):
                self.sub = Complex(x, x)
                return self.sub

        dut = T()
        inputs = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5]

        sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims)

    def test_deep_construct(self):
        class TSub(Hardware):
            def __init__(self, comp, comp2):
                self.comp = comp
                self.comp2 = comp2

        class T(Hardware):
            def __init__(self):
                self.sub = TSub(Complex(0.0, 0, -8), Complex(0.0, 0, -4))

            def main(self, x):
                self.sub = TSub(x, comp2=x)
                return self.sub

        dut = T()
        inputs = [0.0j, 0.1j, 0.2j, 0.3j, 0.4j, 0.5j]

        sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims)

    def test_submodule_array(self):
        class T(Hardware):
            def __init__(self):
                self.sub = [Complex(), Complex()]

            def main(self, x):
                self.sub = [x] + self.sub[:-1]
                return self.sub[-1]

        dut = T()
        inputs = [0.0j, 0.1j, 0.2j, 0.3j, 0.4j, 0.5j]

        sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims)


class TestDynamicLists:
    """ In Python, everything can coexist in a list. In VHDL, list must be contain variables with same type/size.
    Pyha 'unrolls' dynamic lists to make them usable(limited) in VHDL"""

    def test_sfix(self):
        class T(Hardware):
            def __init__(self):
                self.arr = [Sfix(0.1, 0, -5), Sfix(0.2, 0, -16)]  # impossible to convert

            def main(self, x):
                return self.arr[0], self.arr[1]

        dut = T()
        inputs = [0.0, 0.1, 0.2]

        sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims)

    def test_sfix_resize(self):
        class T(Hardware):
            def __init__(self):
                self.arr = [Sfix(0.1, 0, -5), Sfix(0.2, 0, -16)]  # impossible to convert

            def main(self, x):
                self.arr[0] = x  # shoud resize to 0,-5
                self.arr[1] = x  # should resize to 0 - 16
                return self.arr[0], self.arr[1]

        dut = T()
        inputs = [0.0, 0.1, 0.2]

        sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims)

    def test_submodule(self):
        class TSub(Hardware):
            def __init__(self, size):
                self.arr = [0] * size

            def main(self, x):
                self.arr = [x] + self.arr[:-1]
                return self.arr[-1]

        class T(Hardware):
            def __init__(self):
                self.arr = [TSub(1), TSub(2)]  # impossible to convert

            def main(self, x):
                r0 = self.arr[0].main(x)
                r1 = self.arr[1].main(x)
                return r0, r1

        dut = T()
        inputs = [0, 1, 2, 3, 4]

        sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims)

    def test_index_not_constant(self):
        class T(Hardware):
            def __init__(self):
                self.arr = [Sfix(0.1, 0, -5), Sfix(0.2, 0, -16)]  # impossible to convert
                self.i = 0

            def main(self, x):
                self.arr[self.i] = x  # shoud resize to 0,-5
                return self.arr[0], self.arr[1]

        dut = T()
        inputs = [0.0, 0.1, 0.2]

        sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims)

    def test_index_not_constant_call(self):
        class TSub(Hardware):
            def __init__(self, size):
                self.arr = [Sfix(0.0, 0, -5 * size)] * size

            def main(self, x):
                self.arr = [x] + self.arr[:-1]
                return self.arr[-1]

        class T(Hardware):
            def __init__(self):
                self.arr = [TSub(1), TSub(2)]  # impossible to convert
                self.i = 0

            def main(self, x):
                ret = self.arr[self.i].main(x)
                self.arr[1].main(x)  # dummy call, to train the object for conversion
                return ret

        dut = T()
        inputs = [0.0, 0.1, 0.2]

        sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims)

    def test_for_range(self):
        class T(Hardware):
            def __init__(self):
                self.arr = [Sfix(0.1, 0, -5), Sfix(0.2, 0, -16)]  # impossible to convert
                self.i = 0

            def main(self, x):
                for i in range(len(self.arr)):
                    self.arr[i] = x

                return self.arr[0], self.arr[1]

        dut = T()
        inputs = [0.0, 0.1, 0.2]

        sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims)

    def test_for_submodule(self):
        class TSub(Hardware):
            def __init__(self, size):
                self.arr = [0.0] * size

            def main(self, x):
                self.arr = [x] + self.arr[:-1]
                return self.arr[-1]

        class T(Hardware):
            def __init__(self):
                self.arr = [TSub(1), TSub(2)]  # impossible to convert

            def main(self, x):
                tmp = x
                for sub in self.arr:
                    tmp = sub.main(tmp)

                return tmp

        dut = T()
        inputs = [0.0, 0.1, 0.2]

        sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims)


def test_singleelem_list():
    class T(Hardware):
        def __init__(self, size):
            self.arr = [Sfix(0.0, 0, -17)] * size

        def main(self, x):
            self.arr = [x] + self.arr[:-1]
            return self.arr[-1]

    dut = T(1)
    inputs = [0.1, 0.2]

    sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
    assert sims_close(sims)


def test_singleelem_list_complex():
    class T(Hardware):
        def __init__(self, size):
            self.arr = [Complex(0.0, 0, -17)] * size

        def main(self, x):
            self.arr = [x] + self.arr[:-1]
            return self.arr[-1]

    dut = T(1)
    inputs = [0.1 + 0.2j, 0.2 + 0.3j]

    sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
    assert sims_close(sims)


def test_submod_nocall():
    class TSub(Hardware):
        def __init__(self, size):
            self.arr = [0.0] * size

        def main(self, x):
            self.arr = [x] + self.arr[:-1]
            return self.arr[-1]

    class T(Hardware):
        def __init__(self):
            self.arr = [TSub(1), TSub(2)]  # impossible to convert

        def main(self, x):
            ret = self.arr[0].main(x)
            return ret

    dut = T()
    inputs = [0.0, 0.1, 0.2]

    sims = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
    assert sims_close(sims)


def test_numpy_list():
    """ Numpy arrays shall be converted to list and thus will be synthesisable  """

    class T(Hardware):
        def __init__(self, arr):
            self.arr = np.array(arr)

        def main(self, dummy):
            return self.arr

    dut = T([0.0, 0.1, 0.2])
    inputs = [0, 1, 2]

    sims = simulate(dut, inputs)
    assert sims_close(sims)


def test_convert_to_int():
    """ Test convert int() to to_integer(round_syle=fixed_truncate, overflow_style=fixed_wrap) for VHDL. """

    class T(Hardware):

        def main(self, x):
            arg = x
            a = int(arg)
            return int(arg), a

    dut = T()
    inputs = np.random.uniform(-8, 8, 512)
    inputs = [Sfix(x, 4, -17) for x in inputs]

    sims = simulate(dut, inputs)
    assert sims_close(sims)


def test_local_sfix_constant():
    """ Test that local constants of are converted to Sfix (if var type is Sfix) """

    class T(Hardware):
        def main(self, x):
            y = x
            if x == 0.5:
                y = 0  # this used to fail -> now it is converted to Sfix
            return y

    dut = T()
    inputs = [0.0, 0.5, 1.0, 0.9]

    sims = simulate(dut, inputs)
    assert sims_close(sims)


class TestFunctionHistory:
    """ Test situation where PYHA simulation could resolve to multiple distinctive types. In this case locals, returns, args must prefer the Sfix types """

    def test_simple(self):
        class T(Hardware):
            def main(self, x):
                y = x
                if x == 0.5:
                    y = 0  # this sets the var type as integer...should remember that actual is Sfix
                return x

        dut = T()
        inputs = [0.0, 0.5]

        sims = simulate(dut, inputs)
        assert sims_close(sims)

    def test_args_ret(self):
        class T(Hardware):
            def l(self, b):  # make sure args is synth as Sfix, even some times it may be Int
                return b  # return shuld also be sfix

            def main(self, x):
                y = x
                if x == 0.5:
                    y = 0

                ret = self.l(y)
                return ret

        dut = T()
        inputs = [0.0, 0.5]

        sims = simulate(dut, inputs)
        assert sims_close(sims)


class TestLocalInstance:
    def test_complex(self):
        class T(Hardware):
            def main(self, dummy):
                a = Sfix(0.0, 0, -17)
                b = Sfix(1.0, 0, -17, overflow_style='saturate')
                r = Complex(a, b)
                return r

        dut = T()
        inputs = [0, 1, 2]

        sims = simulate(dut, inputs)
        assert sims_close(sims)

    def test_return(self):
        class T(Hardware):
            def main(self, dummy):
                a = Sfix(0.0, 0, -17)
                b = Sfix(1.0, 0, -17, overflow_style='saturate')
                return Complex(a, b)

        dut = T()
        inputs = [0.0 + 0.0j, 0.1 + 0.1j, 0.2 + 0.2j]

        sims = simulate(dut, inputs)
        assert sims_close(sims)

    def test_return_multi(self):
        class T(Hardware):
            def main(self, dummy):
                a = Sfix(0.0, 0, -17)
                b = Sfix(0.1, 0, -17)

                aa = Sfix(0.0, 0, -27)
                bb = Sfix(0.1, 0, -27)
                return a, Complex(a, b), Complex(aa, bb)

        dut = T()
        inputs = [0.0 + 0.0j, 0.1 + 0.1j, 0.2 + 0.2j]

        sims = simulate(dut, inputs)
        assert sims_close(sims)

    def test_reserved_name(self):
        class Register(Hardware):
            def __init__(self, first):
                self.first = first

            def __call__(self, first):
                return self(first)

        class T(Hardware):
            def main(self, dummy):
                a = Sfix(0.0, 0, -17)
                r = Register(a)
                return r

        dut = T()
        inputs = [0, 1, 2]

        sims = simulate(dut, inputs)
        assert sims_close(sims)

    def test_nested(self):
        """ This failed as Pair was added as local variable to main() """

        class Pair(Hardware):
            def __init__(self, first, second):
                self.first = first
                self.second = second

            def __call__(self, first, second):
                return Pair(first, second)

        class T(Hardware):
            def main(self, dummy):
                a = Sfix(0.0, 0, -17)
                b = Sfix(0.1, 0, -17, overflow_style='saturate')
                r = Complex(a, b)

                p = Pair(r, r)
                return p

        dut = T()
        inputs = [0, 1, 2]

        sims = simulate(dut, inputs)
        assert sims_close(sims)

    def test_more_nested(self):
        """ This failed as converter did: type1.type2.ComplexSfix(), problem was because there are two calls to ComplexSfix """

        class Pair(Hardware):
            def __init__(self, first, second):
                self.first = first
                self.second = second

            def __call__(self, first, second):
                return Pair(first, second)

        class T(Hardware):
            def main(self, dummy):
                a = Sfix(0.0, 0, -17)
                b = Sfix(0.1, 0, -17, overflow_style='saturate')
                r = Complex(a, b)

                a2 = Sfix(0.0, 0, -28)
                b2 = Sfix(0.1, 0, -28)
                r2 = Complex(a2, b2)

                p = Pair(r, r2)
                return p

        dut = T()
        inputs = [0, 1, 2]

        sims = simulate(dut, inputs)
        assert sims_close(sims)

    def test_complex_purely_local(self):
        """ This needs to make new conversion for 'r' - it is only used as local type """

        class T(Hardware):
            def main(self, dummy):
                a = Sfix(0.0, 0, -18)
                b = Sfix(0.1, 0, -18, overflow_style='saturate')
                r = Complex(a, b)
                return dummy

        dut = T()
        inputs = [0, 1, 2]

        sims = simulate(dut, inputs)
        assert sims_close(sims)


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
        ret = simulate(dut, inputs, simulations=['MODEL', 'PYHA', 'RTL', 'GATE'])
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
                self.b = Complex(0, 0, -17)

            def main(self, nb):
                self.b = nb
                return self.b

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

    def test_complex_shiftreg(self):
        """ This failed because inputs were converted with 'is_local=True', which disabled register updates. """

        class ShiftReg(Hardware):
            def __init__(self):
                self.shr_sub = [Complex()] * 1

            def main(self, new_sub):
                self.shr_sub = [new_sub] + self.shr_sub[:-1]
                return self.shr_sub[-1]

        dut = ShiftReg()

        inputs = [0.1 + 0.2j, 0.2 + 0.3j, 0.3 + 0.4j]
        expect = [0 + 0j, 0.1 + 0.2j, 0.2 + 0.3j]

        ret = simulate(dut, inputs, simulations=['PYHA', 'RTL', 'GATE'])
        assert_equals(ret, expect)

    def test_submodule_shiftreg(self):
        """ May fail when list of submoduls fail to take correct initial values """

        class Sub(Hardware):
            def __init__(self, i=0):
                self.a = i

        class ShiftReg(Hardware):
            def __init__(self):
                self.shr_sub = [Sub(3), Sub(4)]
                self.DELAY = 1

            def main(self, new_sub):
                self.shr_sub = [new_sub] + self.shr_sub[:-1]
                return self.shr_sub[-1]

        dut = ShiftReg()

        inputs = [Sub(999), Sub(9999), Sub(99999), Sub(999999)]
        expect = [Sub(3), Sub(999), Sub(9999)]

        ret = simulate(dut, inputs, simulations=['MODEL_PYHA', 'PYHA', 'RTL', 'GATE'])
        assert sims_close(ret, expect)

    def test_submodule_with_complex_shiftreg(self):
        class Sub(Hardware):
            def __init__(self, i=0.1 + 0.1j):
                self.a = Complex(i, 0, -17)

        class ShiftReg(Hardware):
            def __init__(self):
                self.shr_sub = [Sub(0.1 + 0.1j), Sub(0.2 + 0.2j)]
                self.DELAY = 1

            def main(self, new_sub):
                self.shr_sub = [new_sub] + self.shr_sub[:-1]
                return self.shr_sub[-1]

        dut = ShiftReg()

        inputs = [Sub(0.3 + 0.3j), Sub(0.4 + 0.4j), Sub(0.5 + 0.5j), Sub(0.6 + 0.6j)]

        ret = simulate(dut, inputs, simulations=['MODEL_PYHA', 'PYHA', 'RTL', 'GATE'])
        assert sims_close(ret)


class TestMemory:
    def test_regfile_basic(self):
        """ Basic write/read to same address..read the old data. """

        class DualPort(Hardware):
            def __init__(self):
                self.mem = [0, 1, 2, 3, 4]

            def main(self, addr, to_write):
                self.mem[addr] = to_write
                return self.mem[addr]

        dut = DualPort()

        to_write = [4, 3, 2, 1, 0, 0, 1, 2, 3, 4]
        addr = [0, 1, 2, 3, 4, 0, 1, 2, 3, 4]
        ret = simulate(dut, addr, to_write, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(ret)

    def test_simple_write(self):
        """ Bug: write with list objects took 2 cycles """

        class Mem(Hardware):
            def __init__(self):
                self.mem = [Complex(0.1 + 0.1j, 0, -17), Complex(0.2 + 0.2j, 0, -17)]

            def main(self, addr, to_write):
                self.mem[addr] = to_write
                return self.mem[addr]

        dut = Mem()
        to_write = [0.91 + 0.99j, 0.92 + 0.99j, 0.93 + 0.99j, 0.94 + 0.99j]
        addr = [0, 0, 0, 0]
        ret = simulate(dut, addr, to_write, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(ret)

    def test_regfile_submodule(self):
        """ Assigning objects were broken, it bypassed register effects """

        class DualPort(Hardware):
            def __init__(self):
                self.mem = [Complex(0.1 + 0.1j), Complex(0.2 + 0.2j), Complex(0.3 + 0.3j), Complex(0.4 + 0.4j),
                            Complex(0.5 + 0.5j)]

            def main(self, addr, to_write):
                self.mem[addr] = to_write
                return self.mem[addr]

        dut = DualPort()

        to_write = [0.91 + 0.99j, 0.92 + 0.99j, 0.93 + 0.99j, 0.94 + 0.99j,
                    0.95 + 0.96j, 0.99 + 0.99j, 0.99 + 0.99j, 0.99 + 0.99j,
                    0.99 + 0.99j]
        addr = [0, 1, 2, 3, 4, 0, 1, 2, 3, 4]
        ret = simulate(dut, addr, to_write, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(ret)


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

    def test_delay_compensate(self):
        """ Failed when delay was larger than amount of inputs """

        class T(Hardware):
            def __init__(self):
                self.DELAY = 100

            def main(self, x):
                y = x
                return y

        dut = T()
        inputs = [0, 0.5, 1.0, 0.9]

        sim_out = simulate(dut, inputs)
        assert sims_close(sim_out)

    def test_int_float(self):
        """ This failed because first input is 0 (not 0.0) system got confused """

        class T(Hardware):
            def main(self, x):
                y = x
                return y

        dut = T()
        inputs = [0, 0.5, 1.0, 0.9]

        sim_out = simulate(dut, inputs)
        assert sims_close(sim_out)

    def test_basic(self):
        class T(Hardware):
            def main(self, i):
                return i

        dut = T()
        assert_sim_match(dut, list(range(4)), list(range(4)))

    def test_return_types(self):
        class T(Hardware):
            def main(self, i):
                return i

        if 'PYHA_SKIP_RTL' in os.environ:
            pytest.skip()

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

        if 'PYHA_SKIP_RTL' in os.environ:
            pytest.skip()

        outs = simulate(T(), [1, 2], [0.1, 0.2], simulations=['MODEL_PYHA', 'PYHA', 'RTL'])
        assert type(outs['PYHA'][0][0]) == int
        assert type(outs['RTL'][0][0]) == int
        assert type(outs['MODEL_PYHA'][0][0]) == int

        assert type(outs['PYHA'][1][0]) == float
        assert type(outs['RTL'][1][0]) == float
        assert type(outs['MODEL_PYHA'][1][0]) == float

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

        sims = simulate(dut, inp)
        assert sims_close(sims, expect)

    def test_single_input(self):
        class T13(Hardware):
            def main(self, x):
                return x

        dut = T13()
        x = [1.0]
        sims = simulate(dut, x)
        assert sims_close(sims)

    def test_single_input_nolist(self):
        class T13(Hardware):
            def main(self, x):
                return x

            def model_main(self, xl):
                return xl

        dut = T13()
        x = 1.0
        sims = simulate(dut, x, simulations=['MODEL', 'PYHA', 'RTL'])
        assert sims_close(sims)

    def test_single_input_nolist_dual(self):
        class T13(Hardware):
            def main(self, x, y):
                return x, y

            def model_main(self, xl, yl):
                return xl, yl

        dut = T13()
        x = 1.0
        y = 0.5

        sims = simulate(dut, [x, x], [y, y], simulations=['MODEL', 'PYHA'])
        assert sims_close(sims)

    def test_no_output(self):
        class T13(Hardware):
            def main(self, x):
                pass

        dut = T13()
        x = [1.0]

        if 'PYHA_SKIP_RTL' in os.environ:
            pytest.skip()

        with pytest.raises(NoOutputsError):
            sims = simulate(dut, x, simulations=['PYHA', 'RTL'])

    def test_input_sfix(self):
        class T13(Hardware):
            def main(self, x):
                return x

        dut = T13()
        x = [Sfix(0.1, 0, -8), Sfix(0.2, 0, -8)]

        sims = simulate(dut, x)
        assert sims_close(sims, expected=x)

    def test_input_hardware(self):

        class In(Hardware):
            def __init__(self, a):
                self.a = a

        class T13(Hardware):
            def main(self, x):
                return x

        dut = T13()
        x = [In(0.1), In(0.2)]

        sims = simulate(dut, x, simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims, expected=x)

    def test_input_custom_sfix_list(self):
        """ Failed to convert """
        # TODO: this is fucked up
        pytest.xfail('Retarded use-case? or not..')

        class T13(Hardware):
            def main(self, x):
                return x

        dut = T13()
        x = [[0.0000001, 0.000002], [0.00000003, 0.000000004]]

        sims = simulate(dut, x, input_types=[Sfix(0, 0, -35)], simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims, expected=x)


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
        print(ret)
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

    def test_complex(self):
        class D(Hardware):
            def __init__(self):
                self.reg = 0.5 + 0.5j
                self.saturation = 1.5 - 1.5j  # make sure is saturated
                self.round = 0.00009 + 0.00009j  # make sure is rounded

        dut = D()
        dut._pyha_floats_to_fixed()

        assert str(dut.reg) == str(Complex(0.5 + 0.5j, 0, -17))
        assert str(dut.saturation) == str(Complex(1.5 - 1.5j, 0, -17, overflow_style='saturate'))
        assert str(dut.round) == str(Complex(0.00009 + 0.00009j, 0, -17, round_style='round'))

        # make sure the overall defaults are restored (however conversion is done with saturate and round)
        assert dut.reg.round_style == 'truncate'
        assert dut.reg.overflow_style == 'wrap'

    def test_complex_list(self):
        class Listy(Hardware):
            def __init__(self):
                self.l = [0.5 + 0.5j, 1.5 - 1.5j, 0.00009 + 0.00009j]

        dut = Listy()
        dut._pyha_floats_to_fixed()

        assert str(dut.l[0]) == str(Complex(0.5 + 0.5j, 0, -17))
        assert str(dut.l[1]) == str(Complex(1.5 - 1.5j, 0, -17, overflow_style='saturate'))
        assert str(dut.l[2]) == str(Complex(0.00009 + 0.00009j, 0, -17, round_style='round'))

        # make sure the overall defaults are restored (however conversion is done with saturate and round)
        assert dut.l[0].round_style == 'truncate'
        assert dut.l[0].overflow_style == 'wrap'

    def test_basic(self):
        dut = self.D()
        dut._pyha_floats_to_fixed()
        assert dut.reg == Sfix(0.5, 0, -17)
        assert dut.round.val == 9.1552734375e-05
        assert dut.saturation.val == 0.9999923706054688

        assert dut._pyha_next['reg'] == Sfix(0.5, 0, -17)
        assert dut._pyha_next['round'].val == 9.1552734375e-05
        assert dut._pyha_next['saturation'].val == 0.9999923706054688

        assert dut._pyha_initial_self.reg == Sfix(0.5, 0, -17)
        assert dut._pyha_initial_self.round.val == 9.1552734375e-05
        assert dut._pyha_initial_self.saturation.val == 0.9999923706054688

    def test_basic_sim(self):
        dut = self.D()
        inp = [0]
        r = simulate(dut, inp, simulations=['MODEL_PYHA', 'PYHA', 'RTL'])

        assert r['MODEL_PYHA'] == [[0.5], [1.5], [9e-05]]
        assert r['PYHA'] == [[0.5], [0.9999923706054688], [9.1552734375e-05]]
        try:
            assert r['PYHA'] == r['RTL']
        except KeyError:
            pass

    def test_object_reuse(self):
        """ Make sure object is returned to initial state after .. """
        dut = self.D()
        inp = [0]
        r = simulate(dut, inp, simulations=['MODEL_PYHA', 'PYHA', 'RTL'])
        r = simulate(dut, inp, simulations=['MODEL_PYHA', 'PYHA', 'RTL'])

        assert r['MODEL_PYHA'] == [[0.5], [1.5], [9e-05]]
        assert r['PYHA'] == [[0.5], [0.9999923706054688], [9.1552734375e-05]]
        try:
            assert r['PYHA'] == r['RTL']
        except KeyError:
            pass

    def test_list(self):
        dut = self.Listy()
        dut._pyha_floats_to_fixed()
        assert dut.float_list[0] == Sfix(0.5, 0, -17)
        assert dut.float_list[1].val == 9.1552734375e-05
        assert dut.float_list[2].val == 0.9999923706054688

        assert dut.float_list._pyha_next[0] == Sfix(0.5, 0, -17)
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
        assert dut.sub.reg == Sfix(0.5, 0, -17)
        assert dut.sub.float_list[0] == Sfix(0.5, 0, -17)

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
        assert dut.sub_list[0].reg == Sfix(0.5, 0, -17)
        assert dut.sub_list[1].reg == Sfix(0.5, 0, -17)
        assert dut.sub_list[0].float_list[0] == Sfix(0.5, 0, -17)

    def test_complex_numpy(self):
        """ System generated registers without _pyha_next, because conversion was called when SimulatinRunning was True
        RTL failed cause of the comment '# this was bugged, had no _pyha_next', which broke the ';' insertion
        """

        def W(k, N):
            """ e^-j*2*PI*k*n/N, argument k = k * n """
            return np.exp(-1j * (2 * np.pi / N) * k)

        class T(Hardware):
            def __init__(self, fft_size):
                self.FFT_SIZE = fft_size
                self.FFT_HALF = fft_size // 2
                self.TWIDDLES = [W(i, self.FFT_SIZE) for i in range(self.FFT_HALF)]
                self.twiddle_buffer = self.TWIDDLES[0]

            def main(self, x):
                self.twiddle_buffer = x  # this was bugged, had no _pyha_next
                return self.twiddle_buffer

        dut = T(4)
        sims = simulate(dut, [0.1 + 0.2j], simulations=['PYHA', 'RTL', 'GATE'])
        assert sims_close(sims, expected=[1.0 + 0j])


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
                self.a = Complex(0, 0, -28)
                self.DELAY = 1

            def f(self, inp):
                self.a = inp + 0.1
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
                tmp = inp

                return tmp

        dut = T()
        sims = simulate(dut, [0.1 + 0.2j, 0.3 - 0.4j])
        assert sims_close(sims)

    def test_deepcopy(self):
        class T(Hardware):
            def main(self, inp):
                tmp = deepcopy(inp)
                tmp = inp

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

        if 'PYHA_SKIP_RTL' in os.environ:
            pytest.skip()

        with patch('os._exit', MagicMock(return_value=0)):
            with pytest.raises(Exception):
                sims = simulate(dut, inputs, simulations=['PYHA', 'RTL'])

# def test_ghdl_version():
#     ret = subprocess.getoutput('ghdl --version | grep -m1 GHDL')
#     assert 'GHDL 0.34 (v0.34rc12-4-g06a78d2) [Dunoon edition]' == ret
#
#
# def test_cocotb_version():
#     version_file = pyha.__path__[0] + '/../cocotb/version'
#     with open(version_file, 'r') as f:
#         assert 'VERSION=1.0.1\n' == f.read()

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
