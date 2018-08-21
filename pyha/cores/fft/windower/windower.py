import numpy as np
import pytest
from pyha import Hardware, simulate, sims_close, Complex, Sfix
from scipy.signal import get_window

from pyhacores.fft.packager.packager import DataIndexValid, DataIndexValidPackager, DataIndexValidDePackager


# 8 bit 9 was about 1k LE
# Total logic elements	631 / 39,600 ( 2 % )
# Embedded Multiplier 9-bit elements	4 / 232 ( 2 % )

class Windower(Hardware):
    """ Windowing function determines the frequency response of FFT bins. """
    def __init__(self, M, window='hanning', coefficient_bits=8):
        self._pyha_simulation_input_callback = DataIndexValidPackager(
            dtype=Complex(0.0, 0, -17, overflow_style='saturate'))
        self._pyha_simulation_output_callback = DataIndexValidDePackager()
        self.M = M
        self.window_pure = get_window(window, M)
        self.WINDOW = [Sfix(x, 0, -(coefficient_bits-1), round_style='round', overflow_style='saturate')
                       for x in self.window_pure]
        self.out = DataIndexValid(Complex())
        self.DELAY = 1

    def main(self, inp):
        # calculate output
        self.out = inp
        self.out.data = inp.data * self.WINDOW[inp.index]
        return self.out

    def model_main(self, complex_in_list):
        return complex_in_list * self.window_pure


@pytest.mark.parametrize("M", [4, 8, 16, 32, 64, 128, 256])
def test_windower(M):
    dut = Windower(M)
    inp = np.random.uniform(-1, 1, size=(2, M)) + np.random.uniform(-1, 1, size=(2, M)) * 1j
    sims = simulate(dut, inp, simulations=['MODEL', 'PYHA'])
    assert sims_close(sims, rtol=1e-2, atol=1e-2)
