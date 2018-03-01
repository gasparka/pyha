from decimal import *

import numpy as np
import pytest

from pyha import Hardware, simulate, sims_close
from pyha.common.fixed_point import Sfix, resize

getcontext().prec = 128


def test_default():
    a = Sfix()
    assert float(a) == 0.0
    assert a.left == None
    assert a.right == None


def test_init():
    f = Sfix(0.123, 0, -8, round_style='round')
    assert f.val == 0.12109375  # round down

    f = Sfix(0.124, 0, -8, round_style='round')
    assert f.val == 0.125  # round up

    f = Sfix(1, 0, -8, overflow_style='saturate')
    assert f.val == 0.99609375  # saturates up

    f = Sfix(-2, 0, -8, overflow_style='saturate')
    assert f.val == -1  # saturates down
    assert f.left == 0
    assert f.right == -8


def test_converts():
    f = Sfix(0.123, 0, -8)
    assert str(f) == '0.121094 [0:-8]'
    assert float(f) == 0.12109375


def test_resize():
    f = Sfix(0.123, 0, -8)
    fr = f.resize(0, -12)
    assert float(fr) == float(f)  # increasing size has no effect
    assert fr != f  # makes new object
    assert fr.left == 0
    assert fr.right == -12

    fr = f.resize(0, -6, round_style='round')
    assert float(fr) == 0.125

    fr = f.resize(0, -3, round_style='round')
    assert float(fr) == 0.125

    fr = f.resize(0, -2)
    assert float(fr) == 0.0


def test_add():
    a = Sfix(0.123, 0, -8)
    b = Sfix(-0.223, 0, -18)
    c = a + b
    assert float(c) == float(a) + float(b)
    assert c.left == 1
    assert c.right == -18


def test_radd():
    b = Sfix(0.1, 0, -17)
    c = 0.1 + b
    assert c.val == 0.1999969482421875

    c = -0.1 + b
    assert c.val == 0.0

    b = Sfix(-0.1, 0, -17)
    c = 0.1 + b
    assert c.val == -7.62939453125e-06

    c = -0.1 + b
    assert c.val == -0.20000457763671875


def test_sub():
    a = Sfix(0.223, 0, -8)
    b = Sfix(0.013, 0, -18)
    c = a - b
    assert float(c) == float(a) - float(b)
    assert c.left == 1
    assert c.right == -18


def test_rsub():
    b = Sfix(0.1, 0, -17)
    c = 0.1 - b
    assert c.val == 0.0

    c = -0.1 - b
    assert c.val == -0.1999969482421875

    b = Sfix(-0.1, 0, -17)
    c = 0.1 - b
    assert c.val == 0.20000457763671875

    c = -0.1 - b
    assert c.val == 7.62939453125e-06


def test_sub_overlow():
    a = Sfix(-0.5, 0, -8)
    b = Sfix(-1, 0, -18)
    c = a - b
    assert float(c) == float(a) - float(b)
    assert c.left == 1
    assert c.right == -18


def test_mul():
    a = Sfix(0.223, 0, -8)
    b = Sfix(0.321, 0, -18)
    c = a * b
    assert float(c) == float(a) * float(b)
    assert c.left == 1
    assert c.right == -26


def test_arith():
    a = Sfix(0.223, 0, -8)
    b = Sfix(-0.098, 0, -18)
    c = Sfix(0.731, 0, -17)
    d = Sfix(0.201, 0, -6)
    e = Sfix(0.01, 0, -12)
    f = (a * b + c - d) * e
    full_prec = (float(a) * float(b) + float(c) - float(d)) * float(e)

    assert float(f) == full_prec
    assert f.left == 4
    assert f.right == -38


def test_sign_bit():
    a = Sfix(0.223, 0, -8)
    assert a.sign_bit() == 0

    a = Sfix(0.000000001, 0, -3)
    assert a.sign_bit() == 0

    a = Sfix(0.000000000, 0, -18)
    assert a.sign_bit() == 0

    a = Sfix(-0.000000000, 0, -18)
    assert a.sign_bit() == 0  # numpy gives 0 aswell

    a = Sfix(-0.0102400000, 0, -18)
    assert a.sign_bit() == 1


# def test_play_shift():
#     # idol = 0.223 / 2
#     # idol = 0.223 / 2
#     a = Sfix(0.223, 2, -8)
#     idol = a.val / 2
#     b = a >> 1
#     l = Sfix(a.val/2, 1, -9)
#
#     wrong = Sfix(a.val/2, 2, -8)
#
#     pass

# def test_shift_right():
#     a = Sfix(0.223, 0, -8)
#     b = a >> 1
#     assert b.val == a.val / 2
#     assert b.left == a.left - 1
#     assert b.right == a.right + (-1)
#
#     b = a >> 2
#     assert b.val == a.val / 2 / 2
#     assert b.left == a.left - 2
#     assert b.right == a.right + (-2)
#
#     b = a >> 3
#     assert b.val == a.val / 2 / 2 / 2
#     assert b.left == a.left - 3
#     assert b.right == a.right + (-3)

# def test_shift_right():
#     a = Sfix(0.223, 0, -8)
#     b = a >> 1
#     assert b.val == a.val / 2
#     assert b.left == a.left - 1
#     assert b.right == a.right + (-1)
#
#     b = a >> 2
#     assert b.val == a.val / 2 / 2
#     assert b.left == a.left - 2
#     assert b.right == a.right + (-2)
#
#     b = a >> 3
#     assert b.val == a.val / 2 / 2 / 2
#     assert b.left == a.left - 3
#     assert b.right == a.right + (-3)


def test_abs():
    a = Sfix(0.355, 0, -12)
    b = abs(a)
    assert a.val == b.val
    assert b.left == a.left + 1
    assert b.right == a.right

    a = Sfix(-0.05, 0, -12)
    b = abs(a)
    assert b.val == -a.val
    assert b.left == a.left + 1
    assert b.right == a.right

    c = abs(b)
    assert c.left == 2


def test_repr_limits():
    pytest.skip()
    a = Sfix(0, 0, -12)
    assert a.max_representable() == 0.999755859375
    assert a.min_representable() == -1.0

    a = Sfix(0, 1, -12)
    assert a.max_representable() == 1.999755859375
    assert a.min_representable() == -2.0

    a = Sfix(0, 2, -12)
    assert a.max_representable() == 3.999755859375
    assert a.min_representable() == -4.0

    a = Sfix(0, -1, -12)
    assert a.max_representable() == 0.499755859375
    assert a.min_representable() == -0.5


def test_non_unit_resize():
    pytest.skip()
    a = Sfix(0.8, -1, -12)
    assert a.val == 0.499755859375

    a = Sfix(1.5, 1, -12)
    b = a.resize(-1, -12)
    assert b.val == 0.499755859375


# def test_auto_size_bits_single():
#     a = 0.9
#     b = Sfix.auto_size(a, 18)
#     np.isclose(b.val, a)
#     assert b.left == 0
#     assert b.right == -17
#
#     a = 1.54
#     b = Sfix.auto_size(a, 18)
#
#     np.isclose(b.val, a)
#     assert b.left == 1
#     assert b.right == -16
#
#     a = -a
#     b = Sfix.auto_size(a, 18)
#     np.isclose(b.val, a)
#     assert b.left == 1
#     assert b.right == -16
#
#     a = np.pi
#     b = Sfix.auto_size(a, 18)
#     np.isclose(b.val, a)
#     assert b.left == 2
#     assert b.right == -15
#
#     a = np.pi / 2
#     b = Sfix.auto_size(a, 18)
#     np.isclose(b.val, a)
#     assert b.left == 1
#     assert b.right == -16
#
#     a = -np.pi * 2
#     b = Sfix.auto_size(a, 18)
#     np.isclose(b.val, a)
#     assert b.left == 3
#     assert b.right == -14


def test_BROKEN_SHIT():
    pytest.skip()
    # this could pass if number negative, but since it is so close to MAX
    # it cannot pass as positive value, need extra bit here
    # is this same for VHDL implementation??
    assert 0
    a = 0.00390623013197
    b = Sfix.auto_size(a, 18)
    np.isclose(b.val, a)
    assert b.left == -7
    assert b.right == -24


def test_auto_size_negative_int_bits():
    pytest.skip()
    a = 0.00390623013197
    b = Sfix.auto_size(a, 18)
    np.isclose(b.val, a)
    assert b.left == -7
    assert b.right == -24

    a = 0.45
    b = Sfix.auto_size(a, 18)
    np.isclose(b.val, a)
    assert b.left == -2
    assert b.right == -19

    a = 0.25
    b = Sfix.auto_size(a, 18)
    np.isclose(b.val, a)
    assert b.left == -1
    assert b.right == -18

    a = -0.000000025124
    b = Sfix.auto_size(a, 18)
    np.isclose(b.val, a)
    assert b.left == -25
    assert b.right == -42


def test_auto_size_bits_list():
    pytest.skip()
    a = [0.5, 1.2, 3.2]
    b = Sfix.auto_size(a, 18)
    for x, y in zip(a, b):
        np.isclose(y.val, x)
        assert y.left == 2
        assert y.right == -15

    a = [np.arctan(2 ** -i) for i in range(8)]
    b = Sfix.auto_size(a, 18)
    for x, y in zip(a, b):
        np.isclose(y.val, x)
        assert y.left == 0
        assert y.right == -17

    a = [np.arctan(2 ** -i) for i in range(8, 12)]
    b = Sfix.auto_size(a, 18)
    for x, y in zip(a, b):
        np.isclose(y.val, x)
        assert y.left == -8
        assert y.right == -25


def test_max_representable():
    pytest.skip()
    # TODO: unknown case
    # a = Sfix(0, 0, 0)
    # assert a.max_representable() == 0

    a = Sfix(0, 1, 0)
    assert a.max_representable() == 1

    a = Sfix(0, 1, -1)
    assert a.max_representable() == 1.5

    a = Sfix(0, 1, -2)
    assert a.max_representable() == 1.75

    a = Sfix(0, 2, -2)
    assert a.max_representable() == 3.75

    a = Sfix(0, -1, 0)
    assert a.max_representable() == 0.5

    a = Sfix(0, -2, 0)
    assert a.max_representable() == 0.25

    # TODO: unknown case
    # a = Sfix(0, -1, -1)
    # assert a.max_representable() == 0.5 ??

    # FIXME: BULLSHIT, 0.25 is correct??
    a = Sfix(0, -1, -2)
    assert a.max_representable() == 0.75

    a = Sfix(0, -2, -3)
    assert a.max_representable() == 0.25 + 0.25 / 2


def test_neg():
    a = Sfix(0.223, 0, -8)
    b = -a
    assert b.val == -0.22265625
    assert b.left == 1
    assert b.right == -8


def test_len():
    a = Sfix(0.223, 0, -8)
    assert len(a) == 9

    a = Sfix(0.223, 2, -8)
    assert len(a) == 11

    a = Sfix(0.223, -2, -8)
    assert len(a) == 7

    a = Sfix(0.223, 8, 3)
    assert len(a) == 6


def test_gt():
    a = Sfix(0.223, 0, -8)
    assert a > 0.1
    assert not a > 0.3


def test_lt():
    a = Sfix(0.223, 0, -8)
    assert not a < 0.1
    assert a < 0.3


class TestLazy:
    def test_add_none(self):
        a = Sfix(0.123, None, None)
        b = Sfix(-0.223, 0, -18)
        c = a + b
        assert float(c) == float(a) + float(b)
        assert c.left == 1
        assert c.right == -18

    def test_sub_none(self):
        a = Sfix(0.223, 0, -8)
        b = Sfix(0.013, None, None)
        c = a - b
        assert float(c) == float(a) - float(b)
        assert c.left == 1
        assert c.right == -8

    def test_neg(self):
        a = Sfix(0.223, 0, None)
        b = -a
        assert b.val == -0.223
        assert b.left == 1
        assert b.right == None

        a = Sfix(0.223, None, None)
        b = -a
        assert b.val == -0.223
        assert b.left == None
        assert b.right == None

        a = Sfix(0.223, None, -5)
        b = -a
        assert b.val == -0.223
        assert b.left == None
        assert b.right == -5

    def test_shift(self):
        """ Shift operator but bounds are None, can happen for Lazy code """

        a = Sfix(2.0)
        b = a >> 1
        assert b.val == 1.0
        assert b.left == None
        assert b.right == None

        b = a >> 2
        assert b.val == 0.5
        assert b.left == None
        assert b.right == None

        b = a << 1
        assert b.val == 4.0
        assert b.left == None
        assert b.right == None

        b = a << 2
        assert b.val == 8.0
        assert b.left == None
        assert b.right == None


class TestFloatMode:
    def test_no_saturation(self):
        with Sfix._float_mode:
            f = Sfix(-1.5, 0, -8)
            assert f.val == -1.5
            assert f.left == 0
            assert f.right == -8

    def test_no_wrap(self):
        with Sfix._float_mode:
            f = Sfix(-1.5, 0, -8, overflow_style='wrap')
            assert f.val == -1.5
            assert f.left == 0
            assert f.right == -8

    def test_no_quantization(self):
        with Sfix._float_mode:
            f = Sfix(0.12345678, 0, -2)
            assert f.val == 0.12345678
            assert f.left == 0
            assert f.right == -2

    def test_resize_no_effect(self):
        with Sfix._float_mode:
            f = Sfix(0.12345678, 0, -20)
            b = resize(f, 0, -2)
            assert b.val == 0.12345678
            assert b.left == 0
            assert b.right == -2

    def test_shift_right(self):
        with Sfix._float_mode:
            f = Sfix(0.12345678, 0, -2)
            b = f >> 1
            assert b.val == 0.12345678 / 2
            assert b.left == 0
            assert b.right == -2

    def test_shift_left(self):
        with Sfix._float_mode:
            f = Sfix(0.12345678, 0, -2)
            b = f << 1
            assert b.val == 0.12345678 * 2
            assert b.left == 0
            assert b.right == -2


class TestIndexing:

    def test_get_fully_fractional(self):
        class Dut(Hardware):
            def main(self, fix, index):
                return fix[index]

        dut = Dut()
        N = 2 ** 13
        fix = np.random.uniform(-1, 1, N)
        index = np.random.uniform(-17, 0, N).astype(int)

        sims = simulate(dut, fix, index, simulations=['PYHA', 'RTL'])
        assert sims_close(sims)

    def test_get_fully_int(self):
        class Dut(Hardware):
            def main(self, fix, index):
                return fix[index]

        dut = Dut()
        N = 2 ** 13
        fix = np.random.uniform(0, 2 ** 17, N)
        index = np.random.uniform(0, 17, N).astype(int)

        sims = simulate(dut, fix, index, input_types=[Sfix(0, 17, 0), int], simulations=['PYHA', 'RTL'])
        assert sims_close(sims)

    def test_get_combined(self):
        class Dut(Hardware):
            def main(self, fix, index):
                return fix[index]

        dut = Dut()
        N = 2 ** 13
        fix = np.random.uniform(0, 2 ** 8, N)
        index = np.random.uniform(-8, 8, N).astype(int)

        sims = simulate(dut, fix, index, input_types=[Sfix(0, 8, -8), int], simulations=['PYHA', 'RTL'])
        assert sims_close(sims)

    def test_set_basic(self):
        class Dut(Hardware):
            def main(self, fix, index, bit_val):
                tmp = fix
                tmp[index] = bit_val
                return tmp

        dut = Dut()
        fix = [0.0]
        index = [-1]
        bit_val = [True]

        sims = simulate(dut, fix, index, bit_val, simulations=['PYHA', 'RTL'])
        assert sims_close(sims)

    def test_set_combined(self):
        class Dut(Hardware):
            def main(self, fix, index, bit_val):
                tmp = fix
                tmp[index] = bit_val
                return tmp

        dut = Dut()
        N = 2 ** 13
        fix = np.random.uniform(0, 2 ** 8, N)
        index = np.random.uniform(-8, 8, N).astype(int)
        bit_val = np.random.uniform(0, 1, N).astype(bool)

        sims = simulate(dut, fix, index, bit_val, input_types=[Sfix(0, 8, -8), int, bool], simulations=['PYHA', 'RTL'])
        assert sims_close(sims)
