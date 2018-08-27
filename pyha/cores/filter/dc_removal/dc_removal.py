import numpy as np
import pytest

from pyha import Hardware, Sfix, simulate, sims_close, Complex
from pyha.common.shift_register import ShiftRegister
from pyha.cores import MovingAverage, DataIndexValidPackager, DataIndexValidDePackager


class DCRemoval(Hardware):
    """
    Filter out DC component, based on: https://www.dsprelated.com/showarticle/58.php
    """
    def __init__(self, window_len, dtype=Sfix):
        self._pyha_simulation_input_callback = DataIndexValidPackager(
            dtype=dtype(0.0, 0, -17, overflow_style='saturate'))
        self._pyha_simulation_output_callback = DataIndexValidDePackager()

        self.WINDOW_LEN = window_len
        self.averages = [MovingAverage(window_len, dtype), MovingAverage(window_len, dtype)]

        self.DELAY = self.averages[0].DELAY * len(self.averages) + 1

        # input must be delayed by group delay, but we can use the SHR from the first averager to get the majority of the delay.
        self.input_shr = ShiftRegister([dtype(0.0, 0, -17)] * (self.DELAY - 2))
        self.y = dtype(0, 0, -17)

    def main(self, x):
        # delay input
        first_delay = self.averages[0].shr.peek()
        self.input_shr.push_next(first_delay)

        # run input signal over all the MA's
        var = x
        for mav in self.averages:
            var = mav.main(var)

        # dc-free signal
        out = self.input_shr.peek()
        if not var.valid:
            self.y = out
        else:
            self.y = out - var.data
        return self.y

    def model_main(self, input_list):
        input_list = np.array(input_list)
        tmp = input_list
        for mav in self.averages:
            tmp = mav.model_main(tmp)

        # delaying the input is important, without this you get 6db ripple...
        group_delay = int(len(self.averages) * ((self.WINDOW_LEN - 1) / 2))
        delayed_input = np.hstack([[0] * group_delay, input_list[:-group_delay]])
        y = delayed_input - tmp
        return y


@pytest.mark.parametrize("window_len", [2, 4, 8, 16, 32])
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

    sim_out = simulate(dut, input_signal)
    assert sims_close(sim_out)