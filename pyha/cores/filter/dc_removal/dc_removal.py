import numpy as np
import pytest

from pyha import Hardware, Sfix, simulate, sims_close, Complex
from pyha.common.shift_register import ShiftRegister
from pyha.cores import MovingAverage, DataValid, \
    NumpyToDataValid, DataValidToNumpy, DownCounter


class DCRemoval(Hardware):
    """
    Filter out DC component, based on: https://www.dsprelated.com/showarticle/58.php
    """
    def __init__(self, window_len, dtype=Sfix):
        assert window_len > 2
        self._pyha_simulation_input_callback = NumpyToDataValid(
            dtype=dtype(0.0, 0, -17, overflow_style='saturate', round_style='round'))
        self._pyha_simulation_output_callback = DataValidToNumpy()

        self.WINDOW_LEN = window_len
        self.averages = [MovingAverage(window_len, dtype), MovingAverage(window_len, dtype)]

        self.DELAY = self.averages[0].DELAY * len(self.averages) + 1

        # input must be delayed by group delay, we can use the SHR from the first averager to get the majority of the delay.
        self.delayed_input = ShiftRegister([dtype(0.0, 0, -17)] * (self.DELAY - 2))
        self.out = DataValid(dtype(0, 0, -17), valid=False)

    def main(self, inp):
        avg_out = self.averages[1].main(self.averages[0].main(inp))

        if not avg_out.valid:
            return DataValid(self.out.data, valid=False)

        # delay input -> use averager[0] delay to save alot of RAM
        self.delayed_input.push_next(self.averages[0].shr.peek())
        self.out.data = self.delayed_input.peek() - avg_out.data
        self.out.valid = True
        return self.out

    def model_main(self, input_list):
        input_list = np.array(input_list)
        avg_out = self.averages[1].model_main(self.averages[0].model_main(input_list))

        # delaying the input is important, without this you get 6db ripple...
        group_delay = int(len(self.averages) * ((self.WINDOW_LEN - 1) / 2))
        delayed_input = np.hstack([[0] * group_delay, input_list[:-group_delay]])
        y = delayed_input - avg_out
        return y


@pytest.mark.parametrize("window_len", [4, 8, 16, 32])
@pytest.mark.parametrize("input_power", [0.25, 0.001])
@pytest.mark.parametrize("dtype", [Sfix, Complex])
def test_all(window_len, input_power, dtype):
    np.random.seed(0)
    dut = DCRemoval(window_len=window_len, dtype=dtype)
    N = 256
    if dtype == Complex:
        input_signal = (np.random.normal(size=N) + np.random.normal(size=N) * 1j)
    else:
        input_signal = np.random.normal(size=N)

    input_signal *= input_power

    sim_out = simulate(dut, input_signal, simulations=['MODEL', 'PYHA'])
    assert sims_close(sim_out)