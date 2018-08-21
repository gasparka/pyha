from scipy import signal

import pytest
from pyha import Hardware, Sfix, simulate, sims_close, Complex, resize, scalb
from pyha.common.util import is_power2
import numpy as np


class MovingAverage(Hardware):
    """
    :param window_len: Size of the moving average window, must be power of 2
    :param dtype: internal storage type, Sfix/Complex
    """

    def __init__(self, window_len, dtype=Sfix):
        if window_len < 2:
            raise AttributeError('Window length must be >= 2')

        if not is_power2(window_len):
            raise AttributeError('Window length must be power of 2')

        self.WINDOW_LEN = window_len
        self.WINDOW_POW = int(np.log2(window_len))
        self.DELAY = 1

        self.mem = [dtype()] * self.WINDOW_LEN
        self.sum = dtype(0.0, 0, -17 - self.WINDOW_POW)

    def main(self, new_sample):
        # add new element to shift register
        scaled = scalb(new_sample, -self.WINDOW_POW)
        self.mem = [scaled] + self.mem[:-1]

        self.sum = self.sum + scaled - self.mem[-1]
        return resize(self.sum, 0, -17)

    def model_main(self, inputs):
        # can be expressed as FIR filter:
        taps = [1 / self.WINDOW_LEN] * self.WINDOW_LEN
        return signal.lfilter(taps, [1.0], inputs)


def test_incorrect_conf():
    with pytest.raises(AttributeError):
        mov = MovingAverage(window_len=1)  # too small window

    with pytest.raises(AttributeError):
        mov = MovingAverage(window_len=3)  # not power of 2


def test_window2():
    dut = MovingAverage(window_len=2)
    x = [0.0, 0.1, 0.2, 0.3, 0.4]
    expected = [0.0, 0.05, 0.15, 0.25, 0.35]
    sim_out = simulate(dut, x)
    assert sims_close(sim_out, expected)


def test_window4():
    dut = MovingAverage(window_len=4)
    x = [-0.2, 0.05, 1.0, -0.9571, 0.0987]
    expected = [-0.05, -0.0375, 0.2125, -0.026775, 0.0479]
    sim_out = simulate(dut, x)
    assert sims_close(sim_out, expected)


def test_max():
    dut = MovingAverage(window_len=4)
    x = [1., 1., 1., 1., 1., 1.]
    expected = [0.25, 0.5, 0.75, 1., 1., 1.]
    sim_out = simulate(dut, x)
    assert sims_close(sim_out, expected)


def test_min():
    dut = MovingAverage(window_len=8)
    x = [-1., -1., -1., -1., -1., -1., -1., -1., -1.]
    expected = [-0.125, -0.25, -0.375, -0.5, -0.625, -0.75, -0.875, -1., -1.]
    sim_out = simulate(dut, x)
    assert sims_close(sim_out, expected)


def test_noisy_signal():
    np.random.seed(0)
    dut = MovingAverage(window_len=8)
    x = np.linspace(0, 2 * 2 * np.pi, 512)
    y = 0.7 * np.sin(x)
    noise = 0.1 * np.random.normal(size=512)
    y += noise

    sim_out = simulate(dut, y)
    assert sims_close(sim_out, atol=1e-4)


def test_complex():
    np.random.seed(0)
    dut = MovingAverage(window_len=128, dtype=Complex)
    N = 2 ** 13
    x = (np.random.normal(size=N) + np.random.normal(size=N) * 1j) * 0.25

    x_quantized = [Complex(x, 0, -17).val for x in x]

    sim_out = simulate(dut, x_quantized, simulations=['MODEL', 'PYHA'])
    assert sims_close(sim_out, rtol=1e-4, atol=1e-4)
