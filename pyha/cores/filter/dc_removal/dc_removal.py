from pyha import Hardware, Sfix, simulate, sims_close, Complex
import numpy as np

from pyhacores.filter import MovingAverage


class DCRemoval(Hardware):
    """
    Filter out DC component, loosely based on: https://www.dsprelated.com/showarticle/58.php
    Change is that the delay is not matched to the output (this keeps the delay at only 1 sample).
    Delay matching does not matter as the DC is ~constant...though it makes it hard to verify against the model.
    """
    def __init__(self, window_len, dtype=Sfix):
        self.mavg = [MovingAverage(window_len, dtype), MovingAverage(window_len, dtype),
                     MovingAverage(window_len, dtype), MovingAverage(window_len, dtype),
                     ]
        self.y = dtype(0, 0, -17)

        self.DELAY = 1

    def main(self, x):
        # run input signal over all the MA's
        tmp = x

        for mav in self.mavg:
            tmp = mav.main(tmp)

        # dc-free signal
        self.y = x - tmp
        return self.y

    def model_main(self, xl):
        # for simple case this may be equal to ``xl -= np.mean(xl)``
        tmp = xl
        for mav in self.mavg:
            tmp = mav.model_main(tmp)

        # this actually not quite equal to main, delay issues?
        y = xl - np.array([0, 0, 0, 0] + tmp.tolist()[:-4])
        return y


def test_basic():
    x = [0.5] * 16 + [-0.5] * 16

    dut = DCRemoval(8)
    sim_out = simulate(dut, x)
    assert sims_close(sim_out, atol=1e-4)


def test_sfix():
    input_pure = np.sin(2 * np.pi * np.linspace(0, 40, 1024)) * 0.5
    x = input_pure + 0.25

    dut = DCRemoval(128)
    sim_out = simulate(dut, x)
    # this cant be easily matched to model as the delay is not synchronised...
    assert sims_close(sim_out, expected=input_pure, atol=1e-2, skip_first_n=512)


def test_complex():
    noise = np.random.normal(size=1024) + np.random.normal(size=1024) * 1j
    input_signal = 0.25 * noise + 0.5

    dut = DCRemoval(128, dtype=Complex)
    sim_out = simulate(dut, input_signal)
    assert sims_close(sim_out, expected=input_signal, atol=1e-2, skip_first_n=512)