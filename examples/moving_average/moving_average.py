import numpy as np
import pytest
from pyha.simulation.simulation_interface import assert_sim_match

from pyha.common.const import Const
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, left_index, right_index, fixed_wrap
from pyha.common.sfix import resize
from pyha.common.util import is_power2


class MovingAverage(HW):
    """
    Moving average algorithm.

    :param window_len: Size of the moving average window, must be power of 2
    """

    def __init__(self, window_len):
        if window_len < 2:
            raise AttributeError('Window length must be >= 2')

        if not is_power2(window_len):
            raise AttributeError('Window length must be power of 2')

        self.window_len = window_len

        # registers
        # Sfix() -> bounds will be derived from simulation
        self.shift_register = [Sfix()] * self.window_len
        self.sum = Sfix()

        # constants
        self.window_pow = Const(int(np.log2(window_len)))

        # module delay
        self._delay = 1

    def main(self, x):
        """
        This works by keeping a history of 'window_len' elements and sum of them.
        Every clock last element will be subtracted and new added to the sum.
        Sum is then divided by the 'window_len'.
        More good infos: https://www.dsprelated.com/showarticle/58.php

        :param x: input to average
        :return: averaged output
        :rtype: Sfix
        """

        # add new element to shift register
        self.next.shift_register = [x] + self.shift_register[:-1]

        # calculate new sum
        nsum = self.sum + x - self.shift_register[-1]

        # resize sum, overflow is impossible
        self.next.sum = resize(nsum,
                               left_index=self.window_pow + left_index(x),
                               right_index=right_index(x),
                               overflow_style=fixed_wrap)

        # divide sum by amout of window_len, and resize to same format as input 'x'
        ret = resize(self.sum >> self.window_pow, size_res=x)
        return ret

    def model_main(self, inputs):
        taps = [1 / self.window_len] * self.window_len
        ret = np.convolve(inputs, taps, mode='full')
        return ret[:-self.window_len + 1]


###################################################################################
# TESTS
###################################################################################

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


def test_noisy_signal():
    np.random.seed(0)
    mov = MovingAverage(window_len=8)
    x = np.linspace(0, 2 * 2 * np.pi, 512)
    y = 0.7 * np.sin(x)
    noise = 0.1 * np.random.normal(size=512)
    y += noise

    assert_sim_match(mov, [Sfix(left=0, right=-17)],
                     None,  # you can leave expected=None, then expected = output of model
                     y, rtol=1e-4, atol=1e-4,
                     dir_path='/home/gaspar/git/pyha/examples/moving_average/conversion')