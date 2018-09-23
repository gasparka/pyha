import numpy as np
import pytest
from scipy import signal

from pyha import Hardware, Sfix, Complex, scalb, simulate, sims_close
from pyha.common.shift_register import ShiftRegister
from pyha.cores import DownCounter
from pyha.common.datavalid import DataValid, NumpyToDataValid


class MovingAverage(Hardware):
    """
    Moving average filter
    ---------------------

    Useful for cleaning noisy data (low-pass filter) and as an matched-filter for rectangular signals.

    Args:
        window_len: Averaging window size, must be power of two. Determines the BRAM usage.
                    For matched-filter, this must equal the samples-per-symbol.
        dtype: Sfix or Complex (applies to real and imag channels separately)
    """

    def __init__(self, window_len, dtype=Sfix):
        self._pyha_simulation_input_callback = NumpyToDataValid(dtype=dtype.default())

        self.WINDOW_LEN = window_len
        self.BIT_GROWTH = int(np.log2(window_len))

        self.shr = ShiftRegister([dtype()] * self.WINDOW_LEN)
        self.acc = dtype(0.0, self.BIT_GROWTH, -17)

        self.output = DataValid(dtype(0, 0, -17, round_style='round')) # negative trend without rounding!
        self.start_counter = DownCounter(1)

    def main(self, input):
        """
        Args:
            input (DataValid): -1.0 ... 1.0 range, up to 18 bits

        Returns:
            DataValid: Accumulator scaled and rounded to 18 bits(-1.0 ... 1.0 range). Overflow impossible.

        """
        if not input.valid:
            return DataValid(self.output.data, valid=False)

        self.shr.push_next(input.data)  # add new element to shift register
        self.acc = self.acc + input.data - self.shr.peek()
        self.output.data = scalb(self.acc, -self.BIT_GROWTH)  # round to standard 18bit format

        # make sure we don't propagate invalid samples
        self.start_counter.tick()
        self.output.valid = self.start_counter.is_over()
        return self.output

    def model(self, inputs):
        # https://stackoverflow.com/questions/13728392/moving-average-or-running-mean/27681394#27681394
        # can be expressed as FIR filter with special taps:
        taps = [1 / self.WINDOW_LEN] * self.WINDOW_LEN
        return signal.lfilter(taps, [1.0], inputs)


@pytest.mark.parametrize("window_len", [2, 16, 64, 128])
@pytest.mark.parametrize("input_power", [0.25, 0.001])
@pytest.mark.parametrize("dtype", [Sfix, Complex])
def test_all(window_len, input_power, dtype):
    np.random.seed(0)
    dut = MovingAverage(window_len=window_len, dtype=dtype)
    N = window_len * 4
    if dtype == Complex:
        input_signal = (np.random.normal(size=N) + np.random.normal(size=N) * 1j)
    else:
        input_signal = np.random.normal(size=N)

    input_signal *= input_power

    sims = simulate(dut, input_signal, pipeline_flush='auto', simulations=['MODEL', 'HARDWARE', 'RTL', 'NETLIST'])
    assert sims_close(sims, rtol=1e-5, atol=1e-5)