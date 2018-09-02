import numpy as np
import pytest
from scipy.signal import get_window

from pyha import Hardware, simulate, sims_close, Complex, Sfix
from pyha.cores import NumpyToDataValid, DataValidToNumpy, \
    DataValid


class Windower(Hardware):
    """ Windowing function determines the frequency response of the FFT bins. """
    def __init__(self, fft_size, window='hanning', coefficient_bits=18):
        self._pyha_simulation_input_callback = NumpyToDataValid(
            dtype=Complex(0.0, 0, -17, overflow_style='saturate', round_style='round'))
        self._pyha_simulation_output_callback = DataValidToNumpy()
        self.FFT_SIZE = fft_size
        self.window_pure = get_window(window, fft_size)
        self.WINDOW = [Sfix(x, 0, -(coefficient_bits-1), round_style='round', overflow_style='saturate')
                       for x in self.window_pure]
        # round is important if you dislike error bias!
        self.out = DataValid(Complex(0, 0, -17, round_style='round'), valid=False)
        self.index_counter = 1 # starting from 0 is mistake because of register delay
        self.coef = self.WINDOW[0]

    def main(self, inp):
        if not inp.valid:
            return DataValid(self.out.data, valid=False, final=False)

        self.index_counter = (self.index_counter + 1) % self.FFT_SIZE
        self.coef = self.WINDOW[self.index_counter]

        self.out.data = inp.data * self.coef
        self.out.valid = inp.valid
        self.out.final = inp.final
        return self.out

    def model_main(self, complex_in_list):
        shaped = np.reshape(complex_in_list, (-1, self.FFT_SIZE))
        return (shaped * self.window_pure).flatten()


@pytest.mark.parametrize("M", [4, 8, 16, 32, 64, 128, 256])
@pytest.mark.parametrize("input_power", [0.1, 0.001])
def test_windower(M, input_power):
    np.random.seed(0)
    dut = Windower(M)
    inp = np.random.uniform(-1, 1, size=2 * M) + np.random.uniform(-1, 1, size=2 * M) * 1j
    inp *= input_power
    sims = simulate(dut, inp, simulations=['MODEL', 'PYHA'])
    assert sims_close(sims, rtol=1e-5, atol=1e-5)
