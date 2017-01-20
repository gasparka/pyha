import pytest

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, right_index, left_index, resize, fixed_truncate, fixed_wrap
from pyha.simulation.simulation_interface import SIM_HW_MODEL, SIM_RTL, assert_sim_match, debug_assert_sim_match, \
    SIM_GATE
import numpy as np



def assert_exact_match(model, types, *x):
    outs = debug_assert_sim_match(model, types, [1], *x, simulations=[SIM_HW_MODEL, SIM_RTL])
    np.testing.assert_allclose(outs[0], outs[1], rtol=1e-9)

def test_shift_right():
    class t0(HW):
        def main(self, x, n):
            ret = x >> n
            return ret

    x = [2.5, 3.0, -0.54, -2.123]

    assert_exact_match(t0(), [Sfix(left=4, right=-18), int], x, [1] * len(x))
    assert_exact_match(t0(), [Sfix(left=4, right=-18), int], x, [2] * len(x))


def test_right_index():
    class t1(HW):
        def main(self, x):
            ret = right_index(x)
            return ret

    assert_exact_match(t1(), [Sfix(left=4, right=-18)], [0., 0.])
    assert_exact_match(t1(), [Sfix(left=4, right=-6)], [0., 0.])


def test_left_index():
    class t2(HW):
        def main(self, x):
            ret = left_index(x)
            return ret

    assert_exact_match(t2(), [Sfix(left=4, right=-18)], [0., 0.])
    assert_exact_match(t2(), [Sfix(left=0, right=-18)], [0., 0.])


def test_sfix_add():
    class t3(HW):
        def main(self, x, x1):
            ret = x + x1
            return ret

    x = [0.5, -1.2, 1.9, 0.0052]
    x1 = [1.2, -0.2, -2.3, 0.000123]
    assert_exact_match(t3(), [Sfix(left=4, right=-18)] * 2, x, x1)


def test_sfix_sub():
    class t4(HW):
        def main(self, x, x1):
            ret = x - x1
            return ret

    x = [0.5, -1.2, 1.9, 0.0052]
    x1 = [1.2, -0.2, -2.3, 0.000123]
    assert_exact_match(t4(), [Sfix(left=4, right=-18)] * 2, x, x1)


def test_resize_right():
    class t5(HW):
        def main(self, x):
            ret = resize(x, 2, -4)
            return ret

    x = [1.352, 0.5991, -1.123]
    assert_exact_match(t5(), [Sfix(left=2, right=-18)], x)


def test_resize_left():
    class t6(HW):
        def main(self, x):
            ret = resize(x, 0, -18)
            return ret

    x = [1.352, 3.0, -1.9]
    assert_exact_match(t6(), [Sfix(left=2, right=-18)], x)


def test_array_indexing():
    class t7(HW):
        def __init__(self):
            self.a = [Sfix(0.1, 0, -28), Sfix(0.2, 0, -28), Sfix(0.3, 0, -28), Sfix(0.4, 0, -28)]

        def main(self, i):
            return self.a[i]

    x = [0, 1, 2, 3]
    assert_exact_match(t7(), [int], x)

    # test indexing by -1
    class t8(HW):
        def __init__(self):
            self.a = [Sfix(0.1, 0, -28), Sfix(0.2, 0, -28), Sfix(0.3, 0, -28), Sfix(0.4, 0, -28)]

        def main(self, x):
            return self.a[-1]

    x = [0, 1]
    assert_exact_match(t8(), [int], x)

@pytest.mark.slowtest
@pytest.mark.parametrize('bits', range(-1, -32, -1))
def test_sfix_constants(bits):
    class T8(HW):
        def __init__(self, bits):
            self.bits_const = bits

        def main(self, i):
            a0 = Sfix(3.141592653589793, 2, self.bits_const)
            a1 = Sfix(1.0, 0, self.bits_const)
            a2 = Sfix(1.0 / 1.646760, 0, self.bits_const)

            return a0, a1, a2

    x = [0, 1, 2]
    assert_exact_match(T8(bits), [int], x)


@pytest.mark.slowtest
@pytest.mark.parametrize('right', range(-1, -32, -1))
@pytest.mark.parametrize('left', range(2))
def test_sfix_wrapper(left, right):
    class T9(HW):
        def __init__(self):
            self.phase_acc = Sfix()

        def main(self, phase_inc):
            self.next.phase_acc = resize(self.phase_acc + phase_inc, size_res=phase_inc, overflow_style=fixed_wrap,
                                         round_style=fixed_truncate)
            return self.phase_acc

        def get_delay(self):
            return 1

    x = (np.random.rand(1024 * 2 * 2 * 2) * 2) - 1
    assert_exact_match(T9(), [Sfix(0, left, right)], x)


@pytest.mark.slowtest
@pytest.mark.parametrize('shift_i', range(8))
def test_sfix_add_shift_right_resize(shift_i):
    right = -18
    left = 0

    class T10(HW):
        def main(self, x, y, i):
            ret = resize(x - (y >> i), size_res=x)
            return ret

    x = (np.random.rand(1024) * 2) - 1
    y = (np.random.rand(1024) * 2) - 1
    i = [shift_i] * len(x)
    assert_exact_match(T10(), [Sfix(0, left, right), Sfix(0, left, right), int], x, y, i)

@pytest.mark.slowtest
@pytest.mark.parametrize('shift_i', range(8))
def test_sfix_shift_right(shift_i):
    right = -18
    left = 2

    class T12(HW):
        def main(self, x, i):
            ret = x >> i
            return ret

    x = (np.random.rand(1024) * 2 * 2) - 1
    i = [shift_i] * len(x)
    assert_exact_match(T12(), [Sfix(0, left, right), int], x, i)

@pytest.mark.slowtest
@pytest.mark.parametrize('shift_i', range(8))
def test_sfix_shift_left(shift_i):
    right = -18
    left = 6

    class T13(HW):
        def main(self, x, i):
            ret = x << i
            return ret

    x = (np.random.rand(1024) * 2 * 2) - 1
    i = [shift_i] * len(x)
    assert_exact_match(T13(), [Sfix(0, left, right), int], x, i)
