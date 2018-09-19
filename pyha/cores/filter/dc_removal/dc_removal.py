import numpy as np
import pytest

from pyha import Hardware, Sfix, simulate, sims_close, Complex
from pyha.common.shift_register import ShiftRegister
from pyha.cores import MovingAverage
from pyha.common.datavalid import DataValid, NumpyToDataValid


class DCRemoval(Hardware):
    """
    Linear-phase DC Removal Filter
    ------------------------------

    Sharp notch filter, peak-to-peak ripple of 0.42 dB.
    Based on the Dual-MA system described in https://www.dsprelated.com/showarticle/58.php ,
    Quad-MA is discussed but IMHO not worth the BRAM.

    Args:
        window_len: Averaging window size, must be power of two. Controls the filter sharpness and the BRAM usage.
                    Optimal value is 2048. 1024 may be good enough.
        dtype: Sfix or Complex (applies to real and imag channels separately)

    """
    def __init__(self, window_len, dtype=Complex):
        assert window_len > 2
        self._pyha_simulation_input_callback = NumpyToDataValid(dtype=dtype.default())

        self.WINDOW_LEN = window_len
        self.averages = [MovingAverage(window_len, dtype), MovingAverage(window_len, dtype)]

        # input must be delayed by group delay, we can use the SHR from the first averager to get the majority of the delay.
        self.delayed_input = ShiftRegister([dtype(0.0, 0, -17)] * 3)
        self.output = DataValid(dtype(0, 0, -17))

    def main(self, input):
        """
        Args:
            input (DataValid): -1.0 ... 1.0 range, up to 18 bits

        Returns:
            DataValid:  DC-free output, 18 bits(-1.0 ... 1.0 range). Saturates on overflow.
                        Rounding it down to 12-bits (standard SDR IQ width) wont work,
                        you need ~16 bits to reliably remove the DC-offset.

        """
        avg_out = self.averages[1].main(self.averages[0].main(input))

        if not avg_out.valid:
            return DataValid(self.output.data, valid=False)

        # delay input -> use averager[0] delay to save alot of RAM
        self.delayed_input.push_next(self.averages[0].shr.peek())
        self.output.data = self.delayed_input.peek() - avg_out.data
        self.output.valid = True
        return self.output

    def model(self, input_list):
        input_list = np.array(input_list)
        avg_out = self.averages[1].model(self.averages[0].model(input_list))

        # delaying the input is important, without this you get 6db ripple...
        group_delay = int(len(self.averages) * ((self.WINDOW_LEN - 1) / 2))
        delayed_input = np.hstack([[0] * group_delay, input_list[:-group_delay]])
        y = delayed_input - avg_out
        return y

@pytest.mark.parametrize("window_len", [4, 32, 128])
@pytest.mark.parametrize("input_power", [0.25, 0.001])
@pytest.mark.parametrize("dtype", [Sfix, Complex])
def test_all(window_len, input_power, dtype):
    np.random.seed(0)
    dut = DCRemoval(window_len=window_len, dtype=dtype)
    N = window_len * 3
    if dtype == Complex:
        input_signal = (np.random.normal(size=N) + np.random.normal(size=N) * 1j)
    else:
        input_signal = np.random.normal(size=N)

    input_signal *= input_power

    sims = simulate(dut, input_signal, pipeline_flush='auto', simulations=['MODEL', 'HARDWARE', 'RTL'])
    assert sims_close(sims, rtol=1e-4, atol=1e-4)