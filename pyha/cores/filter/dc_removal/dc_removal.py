import pytest

from pyha import Hardware, Sfix, simulate, sims_close, Complex
import numpy as np

from pyha.cores import MovingAverage


class DCRemoval(Hardware):
    """
    Filter out DC component, based on: https://www.dsprelated.com/showarticle/58.php
    Deviation from the article that there is no delay matching, which in my opinion is ~useless as the DC component is more or less stable.
    """
    def __init__(self, window_len, dtype=Sfix):
        self.mavg = [MovingAverage(window_len, dtype), MovingAverage(window_len, dtype),
                     MovingAverage(window_len, dtype), MovingAverage(window_len, dtype)]

        self.y = dtype(0, 0, -17)

        self.DELAY = 1

    def main(self, x):
        # run input signal over all the MA's
        var = x
        for mav in self.mavg:
            var = mav.main(var)

        # dc-free signal
        self.y = x - var
        return self.y

    def model_main(self, xl):
        tmp = xl
        for mav in self.mavg:
            tmp = mav.model_main(tmp)
        y = xl - np.array([0, 0, 0, 0] + tmp.tolist()[:-4])
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