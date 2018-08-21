import numpy as np
import pytest

from pyha import simulate, sims_close
from pyha.common.core import Hardware
from pyha.common.fixed_point import Sfix, right_index, left_index, resize

# in general GATE could be added here...but it takes ALOT of time
SIMULATIONS = ['PYHA', 'RTL']


def test_resize_truncate_saturate():
    """ Check that truncation works same in Pyha and RTL """

    class t5(Hardware):
        def main(self, x):
            ret = resize(x, 0, -4, round_style='truncate', overflow_style='saturate')
            return ret

    x = (np.random.rand(1024 * 2 * 2 * 2) * 2) - 1
    dut = t5()
    sims = simulate(dut, x, simulations=SIMULATIONS)
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_shift_right():
    class t0(Hardware):
        def main(self, x, n):
            ret = x >> n
            return ret

    x = [2.5, 3.0, -0.54, -2.123]

    dut = t0()
    sims = simulate(dut, x, [1] * len(x), simulations=SIMULATIONS, input_types=[Sfix(left=4, right=-18), int])
    assert sims_close(sims, rtol=1e-9, atol=1e-9)

    sims = simulate(dut, x, [2] * len(x), simulations=SIMULATIONS, input_types=[Sfix(left=4, right=-18), int])
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_right_index():
    class t1(Hardware):
        def main(self, x):
            ret = right_index(x)
            return ret

    dut = t1()
    sims = simulate(dut, [0., 0.], simulations=SIMULATIONS)
    assert sims_close(sims, rtol=1e-9, atol=1e-9)

    sims = simulate(dut, [0., 0.], simulations=SIMULATIONS, input_types=[Sfix(left=4, right=-6)])
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_left_index():
    class t2(Hardware):
        def main(self, x):
            ret = left_index(x)
            return ret

    dut = t2()
    sims = simulate(dut, [0., 0.], simulations=SIMULATIONS)
    assert sims_close(sims, rtol=1e-9, atol=1e-9)

    sims = simulate(dut, [0., 0.], simulations=SIMULATIONS, input_types=[Sfix(left=4, right=-6)])
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_sfix_add():
    class t3(Hardware):
        def main(self, x, x1):
            ret = x + x1
            return ret

    x = [0.5, -1.2, 1.9, 0.0052]
    x1 = [1.2, -0.2, -2.3, 0.000123]

    dut = t3()
    sims = simulate(dut, x, x1, simulations=SIMULATIONS, input_types=[Sfix(left=4, right=-18)] * 2)
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_sfix_sub():
    class t4(Hardware):
        def main(self, x, x1):
            ret = x - x1
            return ret

    x = [0.5, -1.2, 1.9, 0.0052]
    x1 = [1.2, -0.2, -2.3, 0.000123]
    dut = t4()
    sims = simulate(dut, x, x1, simulations=SIMULATIONS, input_types=[Sfix(left=4, right=-18)] * 2)
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_resize_right():
    class t5(Hardware):
        def main(self, x):
            ret = resize(x, 2, -4, round_style='truncate', overflow_style='saturate')
            return ret

    x = [1.352, 0.5991, -1.123]
    dut = t5()
    sims = simulate(dut, x, simulations=SIMULATIONS, input_types=[Sfix(left=2, right=-18)])
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_resize_left_defaults():
    class t6(Hardware):
        def main(self, x):
            ret = resize(x, 0, -18)
            return ret

    x = [1.352, 3.0, -1.9]
    dut = t6()
    sims = simulate(dut, x, simulations=SIMULATIONS, input_types=[Sfix(left=2, right=-18)])
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_array_indexing():
    class t7(Hardware):
        def __init__(self):
            self.a = [Sfix(0.1, 0, -28), Sfix(0.2, 0, -28), Sfix(0.3, 0, -28), Sfix(0.4, 0, -28)]

        def main(self, i):
            return self.a[i]

    x = [0, 1, 2, 3]
    dut = t7()
    sims = simulate(dut, x, simulations=SIMULATIONS)
    assert sims_close(sims, rtol=1e-9, atol=1e-9)

    # test indexing by -1
    class t8(Hardware):
        def __init__(self):
            self.a = [Sfix(0.1, 0, -28), Sfix(0.2, 0, -28), Sfix(0.3, 0, -28), Sfix(0.4, 0, -28)]

        def main(self, x):
            return self.a[-1]

    x = [0, 1]
    dut = t8()
    sims = simulate(dut, x, simulations=SIMULATIONS)
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


@pytest.mark.slowtest
@pytest.mark.parametrize('bits', range(-1, -32, -1))
def test_sfix_constants(bits):
    class T8(Hardware):
        def __init__(self, bits):
            self.BITS = bits

        def main(self, i):
            a0 = Sfix(3.141592653589793, 2, self.BITS)
            a1 = Sfix(1.0, 0, self.BITS)
            a2 = Sfix(1.0 / 1.646760, 0, self.BITS)

            return a0, a1, a2

    x = [0]
    dut = T8(bits)
    sims = simulate(dut, x, simulations=SIMULATIONS)
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_sfix_no_const_ref():
    if 'GATE' in SIMULATIONS:
        pytest.xfail('Quartus wants the "bits" parts to be CONTSANT')
    class T8(Hardware):
        def __init__(self, bits):
            self.bits = bits

        def main(self, i):
            a0 = Sfix(3.141592653589793, 2, self.bits)
            return a0

    x = [0]
    dut = T8(-5)
    sims = simulate(dut, x, simulations=SIMULATIONS)
    assert sims_close(sims, rtol=1e-9, atol=1e-9)



@pytest.mark.slowtest
@pytest.mark.parametrize('right', range(-1, -17, -1))
@pytest.mark.parametrize('left', range(2))
def test_sfix_wrap(left, right):
    class T9(Hardware):
        def __init__(self, left, right):
            self.phase_acc = Sfix(0, left, right)
            self.DELAY = 1

        def main(self, phase_inc):
            self.phase_acc = self.phase_acc + phase_inc
            return self.phase_acc

    x = (np.random.rand(128) * 2) - 1
    dut = T9(left, right)
    sims = simulate(dut, x, simulations=SIMULATIONS, input_types=[Sfix(0, left, right)])
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


@pytest.mark.slowtest
@pytest.mark.parametrize('shift_i', range(8))
def test_sfix_add_shift_right_resize(shift_i):
    right = -18
    left = 0

    class T10(Hardware):
        def main(self, x, y, i):
            ret = resize(x - (y >> i), size_res=x, round_style='truncate', overflow_style='saturate')
            return ret

    x = (np.random.rand(1024) * 2) - 1
    y = (np.random.rand(1024) * 2) - 1
    i = [shift_i] * len(x)
    dut = T10()
    sims = simulate(dut, x, y, i, simulations=SIMULATIONS,
                    input_types=[Sfix(0, left, right), Sfix(0, left, right), int])
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


@pytest.mark.slowtest
@pytest.mark.parametrize('shift_i', range(18))
def test_sfix_shift(shift_i):
    class T13(Hardware):
        def main(self, x, i):
            left = x << i
            right = x >> i
            return left, right

    dut = T13()
    x = (np.random.rand(128) * 2) - 1
    i = [shift_i] * len(x)
    sims = simulate(dut, x, i, simulations=SIMULATIONS)
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_passtrough_boolean():
    class T14(Hardware):
        def main(self, x):
            return x

    dut = T14()
    inp = [True, False, True, False]
    sims = simulate(dut, inp, simulations=SIMULATIONS)
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_int_operations():
    # TODO: 32 bit operations would fail?
    class T15(Hardware):
        def main(self, x):
            rand = x & 0x8000
            ror = x | 0x8200
            rxor = x ^ 0xFFFF
            rorbool1 = x | True
            rorbool2 = x | False
            rshift_right = x << 1
            rshift_left = x >> 1

            return rand, ror, rxor, rorbool1, rorbool2, rshift_right, rshift_left

    dut = T15()
    inp = np.random.randint(-2 ** 30, 2 ** 30, 1024)
    sims = simulate(dut, inp, simulations=SIMULATIONS)
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_chain_multiplication():
    """ Test that Pyha fixed point library can compute very precise intermediate results """

    class Bug(Hardware):
        def main(self, c):
            inter = c * c * c
            m = resize(c * c * c, 0, -17, round_style='truncate', overflow_style='saturate')
            return m, inter

    inp = np.random.rand(1024) * 2 - 1
    inp *= 0.01

    dut = Bug()
    sims = simulate(dut, inp, simulations=SIMULATIONS)
    assert sims_close(sims, rtol=1e-9, atol=1e-9)
