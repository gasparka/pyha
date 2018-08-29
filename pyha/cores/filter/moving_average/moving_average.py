import numpy as np
import pytest
from scipy import signal

from pyha import Hardware, Sfix, simulate, sims_close, Complex, scalb
from pyha.common.shift_register import ShiftRegister
from pyha.cores import DataValidToNumpy, NumpyToDataValid
from pyha.cores.fft.packager.packager import DataValid


class MovingAverage(Hardware):
    """
    :param window_len: Size of the moving average window, must be power of 2 and >= 2
    :param dtype: internal storage type, Sfix/Complex
    """

    def __init__(self, window_len, dtype=Sfix):
        self._pyha_simulation_input_callback = NumpyToDataValid(
            dtype=dtype(0.0, 0, -17, overflow_style='saturate'))
        self._pyha_simulation_output_callback = DataValidToNumpy()
        self.WINDOW_LEN = window_len
        self.BIT_GROWTH = int(np.log2(window_len))
        self.DELAY = 2

        self.shr = ShiftRegister([dtype()] * self.WINDOW_LEN)
        self.acc = dtype(0.0, self.BIT_GROWTH, -17)

        # rounding the output is necessary or there will be negative trend!
        self.out = DataValid(dtype(0, 0, -17, round_style='round'), valid=False)
        self.val = False

    def main(self, inp):
        if not inp.valid:
            return DataValid(self.out.data, valid=False)

        self.shr.push_next(inp.data)  # add new element to shift register
        self.acc = self.acc + inp.data - self.shr.peek()
        self.val = True

        self.out.data = scalb(self.acc, -self.BIT_GROWTH)
        self.out.valid = self.val
        return self.out

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

    sim_out = simulate(dut, input_signal, simulations=['MODEL', 'PYHA'])
    assert sims_close(sim_out)