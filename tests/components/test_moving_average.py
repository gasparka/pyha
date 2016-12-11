import numpy as np
import pytest

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, resize, left_index, right_index
from pyha.common.util import is_power2
from pyha.simulation.simulation_interface import assert_sim_match


class MovingAverage(HW):
    def __init__(self, window_len):
        if window_len < 2:
            raise AttributeError('Window length must be power >= 2')

        if not is_power2(window_len):
            raise AttributeError('Window length must be power of 2')

        self.window_len = window_len
        self.window_pow = int(np.log2(window_len))

        # registers
        self.shift_register = [Sfix()] * self.window_len
        self.sum = Sfix()

    def main(self, x):
        self.next.shift_register = [x] + self.shift_register[:-1]

        self.next.sum = resize(self.sum + x - self.shift_register[-1],
                               left_index=self.window_pow + left_index(x),
                               right_index=right_index(x))

        ret = resize(self.sum >> self.window_pow, size_res=x)
        return ret

    def get_delay(self):
        return 1

    def model_main(self, inputs):
        # def ite_avg(i):
        #     return sum(inputs[0 + i:self.window_len + i]) / self.window_len
        #
        # return [ite_avg(i) for i in range(len(inputs) - self.window_len + 1)]
        # return result
        ret = np.convolve(inputs, np.ones((self.window_len,)) / self.window_len, mode='full')
        return ret[:-self.window_len + 1]


def test_window1():
    with pytest.raises(AttributeError):
        mov = MovingAverage(window_len=1)


def test_window2():
    mov = MovingAverage(window_len=2)
    x = [0., 1., 2., 3., 4.]
    expected = [0.0, 0.5, 1.5, 2.5, 3.5]
    assert_sim_match(mov, [Sfix(left=4, right=-18)], expected, x)


def test_window3():
    mov = MovingAverage(window_len=4)
    x = [-0.2, 1.05, 2, -1.9571, 1.0987]
    expected = [-0.05, 0.2125, 0.7125, 0.223225, 0.5479]
    assert_sim_match(mov, [Sfix(left=1, right=-18)], expected, x, rtol=1e-4)


def test_max():
    mov = MovingAverage(window_len=4)
    x = [2., 2., 2., 2., 2., 2.]
    expected = [0.5, 1., 1.5, 2., 2., 2.]
    assert_sim_match(mov, [Sfix(left=1, right=-18)], expected, x)


def test_min():
    mov = MovingAverage(window_len=8)
    x = [-1, -1, -1, -1, -1, -1, -1, -1, -1]
    expected = [-0.125, -0.25, -0.375, -0.5, -0.625, -0.75, -0.875, -1., -1.]
    assert_sim_match(mov, [Sfix(left=0, right=-18)], expected, x)
