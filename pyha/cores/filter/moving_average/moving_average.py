from scipy import signal
import pytest
from pyha import Hardware, Sfix, simulate, sims_close, Complex, resize, scalb
import numpy as np


class MovingAverage(Hardware):
    """
    :param window_len: Size of the moving average window, must be power of 2 and >= 2
    :param dtype: internal storage type, Sfix/Complex
    """

    def __init__(self, window_len, dtype=Sfix):
        self.WINDOW_LEN = window_len
        self.BIT_GROWTH = int(np.log2(window_len))
        self.DELAY = 1

        self.mem = [dtype()] * self.WINDOW_LEN
        self.sum = dtype(0.0, 0, -17 - self.BIT_GROWTH)

    def main(self, new_sample):
        # add new element to shift register
        scaled = scalb(new_sample, -self.BIT_GROWTH)
        self.mem = [scaled] + self.mem[:-1]

        self.sum = self.sum + scaled - self.mem[-1]
        return resize(self.sum, 0, -17)

    def model_main(self, inputs):
        # can be expressed as FIR filter:
        taps = [1 / self.WINDOW_LEN] * self.WINDOW_LEN
        return signal.lfilter(taps, [1.0], inputs)


@pytest.mark.parametrize("window_len", [2, 4, 8, 16, 32])
@pytest.mark.parametrize("input_power", [0.25, 0.001])
@pytest.mark.parametrize("dtype", [Sfix, Complex])
def test_all(window_len, input_power, dtype):
    np.random.seed(0)
    dut = MovingAverage(window_len=window_len, dtype=dtype)
    N = 128
    if dtype == Complex:
        input_signal = (np.random.normal(size=N) + np.random.normal(size=N) * 1j)
    else:
        input_signal = np.random.normal(size=N)

    input_signal *= input_power

    sim_out = simulate(dut, input_signal)
    assert sims_close(sim_out)