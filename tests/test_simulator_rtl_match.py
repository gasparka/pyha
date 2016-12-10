import numpy as np

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, right_index, left_index, resize
from pyha.simulation.simulation_interface import SIM_HW_MODEL, Simulation, SIM_RTL


def assert_sim_match(model, types, expected, *x):
    dut = Simulation(SIM_HW_MODEL, model=model, input_types=types)
    hw_y = dut.main(*x)

    assert np.allclose(expected, hw_y)

    dut = Simulation(SIM_RTL, model=model, input_types=types)
    rtl_y = dut.main(*x)
    assert np.allclose(rtl_y, hw_y)


def test_shift_right():
    class t0(HW):
        def main(self, x, n):
            ret = x >> n
            return ret

    x = [2.5, 3.0, -0.54, -2.123]

    assert_sim_match(t0(), [Sfix(left=4, right=-18), int], [1.25, 1.5, -0.27000046, -1.06150055], x, [1] * len(x))
    assert_sim_match(t0(), [Sfix(left=4, right=-18), int], [0.625, 0.75, -0.13500023, -0.53075027], x, [2] * len(x))


def test_right_index():
    class t1(HW):
        def main(self, x):
            ret = right_index(x)
            return ret

    assert_sim_match(t1(), [Sfix(left=4, right=-18)], [-18, -18], [0., 0.])
    assert_sim_match(t1(), [Sfix(left=4, right=-6)], [-6, -6], [0., 0.])


def test_left_index():
    class t2(HW):
        def main(self, x):
            ret = left_index(x)
            return ret

    assert_sim_match(t2(), [Sfix(left=4, right=-18)], [4, 4], [0., 0.])
    assert_sim_match(t2(), [Sfix(left=0, right=-18)], [0, 0], [0., 0.])


def test_sfix_add():
    class t3(HW):
        def main(self, x, x1):
            ret = x + x1
            return ret

    x = [0.5, -1.2, 1.9, 0.0052]
    x1 = [1.2, -0.2, -2.3, 0.000123]
    expect = [1.7, -1.4, -0.4, 0.0053215]
    assert_sim_match(t3(), [Sfix(left=4, right=-18)] * 2, expect, x, x1)


def test_sfix_sub():
    class t4(HW):
        def main(self, x, x1):
            ret = x - x1
            return ret

    x = [0.5, -1.2, 1.9, 0.0052]
    x1 = [1.2, -0.2, -2.3, 0.000123]
    expect = [-0.70000076, -1., 4.20000076, 0.00507736]
    assert_sim_match(t4(), [Sfix(left=4, right=-18)] * 2, expect, x, x1)


def test_resize_right():
    class t5(HW):
        def main(self, x):
            ret = resize(x, 2, -4)
            return ret

    x = [1.352, 0.5991, -1.123]
    expect = [1.375, 0.625, -1.125]
    assert_sim_match(t5(), [Sfix(left=2, right=-18)], expect, x)


def test_resize_left():
    class t6(HW):
        def main(self, x):
            ret = resize(x, 0, -18)
            return ret

    x = [1.352, 3.0, -1.9]
    expect = [1.0, 1.0, -1.0]
    assert_sim_match(t6(), [Sfix(left=2, right=-18)], expect, x)


def test_array_indexing():
    class t7(HW):
        def __init__(self):
            self.a = [Sfix(0.1, 0, -28), Sfix(0.2, 0, -28), Sfix(0.3, 0, -28), Sfix(0.4, 0, -28)]

        def main(self, i):
            return self.a[i]

    x = [0, 1, 2, 3]
    expect = [0.1, 0.2, 0.3, 0.4]
    assert_sim_match(t7(), [int], expect, x)

    # test indexing by -1
    class t8(HW):
        def __init__(self):
            self.a = [Sfix(0.1, 0, -28), Sfix(0.2, 0, -28), Sfix(0.3, 0, -28), Sfix(0.4, 0, -28)]

        def main(self, x):
            return self.a[-1]

    x = [0, 1]
    expect = [0.4, 0.4]
    assert_sim_match(t8(), [int], expect, x)
