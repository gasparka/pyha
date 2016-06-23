from decimal import *

from common.sfix import Sfix

getcontext().prec = 128


def test_default():
    a = Sfix()
    assert float(a) == 0.0
    assert a.left == 0
    assert a.right == 0


def test_init():
    f = Sfix(0.123, 0, -8)
    assert f.val == 0.12109375  # round down

    f = Sfix(0.124, 0, -8)
    assert f.val == 0.125  # round up

    f = Sfix(1, 0, -8)
    assert f.val == 0.99609375  # saturates up

    f = Sfix(-2, 0, -8)
    assert f.val == -1  # saturates down
    assert f.left == 0
    assert f.right == -8


def test_converts():
    f = Sfix(0.123, 0, -8)
    assert str(f) == '0.12109375 [0:-8]'
    assert float(f) == 0.12109375


def test_resize():
    f = Sfix(0.123, 0, -8)
    fr = f.resize(0, -12)
    assert float(fr) == float(f)  # increasing size has no effect
    assert fr != f  # makes new object
    assert fr.left == 0
    assert fr.right == -12

    fr = f.resize(0, -6)
    assert float(fr) == 0.125

    fr = f.resize(0, -3)
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


def test_sub():
    a = Sfix(0.223, 0, -8)
    b = Sfix(0.013, 0, -18)
    c = a - b
    assert float(c) == float(a) - float(b)
    assert c.left == 1
    assert c.right == -18


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


def test_arith_too_precise():
    a = Sfix(0.223, 0, -8)
    b = Sfix(-0.098, 0, -18)
    c = Sfix(0.731, 0, -17)
    d = Sfix(0.201, 0, -6)
    e = Sfix(0.01, 0, -12)
    g = Sfix(0.01, 0, -18)
    f = a * b * c * d * e * g

    full_prec = Decimal(float(a)) * Decimal(float(b)) * Decimal(float(c)) * Decimal(float(d)) * Decimal(
        float(e)) * Decimal(float(g))

    assert float(f) != full_prec


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


def test_shift_right():
    a = Sfix(0.223, 0, -8)
    b = a >> 1
    assert b.val == a.val / 2
    assert b.left == a.left - 1
    assert b.right == a.right + (-1)

    b = a >> 2
    assert b.val == a.val / 2 / 2
    assert b.left == a.left - 2
    assert b.right == a.right + (-2)

    b = a >> 3
    assert b.val == a.val / 2 / 2 / 2
    assert b.left == a.left - 3
    assert b.right == a.right + (-3)


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
    a = Sfix(0.8, -1, -12)
    assert a.val == 0.499755859375

    a = Sfix(1.5, 1, -12)
    b = a.resize(-1, -12)
    assert b.val == 0.499755859375

# TODO: test restricted arguments
