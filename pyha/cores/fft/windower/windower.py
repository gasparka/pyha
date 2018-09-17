import numpy as np
import pytest
from scipy.signal import get_window

from pyha import Hardware, Complex, Sfix
from pyha.common.complex import default_complex
from pyha.cores import NumpyToDataValid, DataValidToNumpy, DataValid, simulate, sims_close


class Windower(Hardware):
    """ Windowing function determines the frequency response of the FFT bins. """
    def __init__(self, fft_size, window='hanning', coefficient_bits=18):
        self._pyha_simulation_input_callback = NumpyToDataValid(dtype=default_complex)
        self._pyha_simulation_output_callback = DataValidToNumpy()
        self.FFT_SIZE = fft_size
        self.window_pure = get_window(window, fft_size)
        self.WINDOW = [Sfix(x, 0, -(coefficient_bits-1), round_style='round', overflow_style='saturate')
                       for x in self.window_pure]

        # error bias without rounding!
        self.out = DataValid(Complex(0, 0, -17, round_style='round'), valid=False)
        self.index_counter = 1
        self.coef = self.WINDOW[0]

    def main(self, inp):
        if not inp.valid:
            return DataValid(self.out.data, valid=False)

        self.index_counter = (self.index_counter + 1) % self.FFT_SIZE
        self.coef = self.WINDOW[self.index_counter]

        self.out.data = inp.data * self.coef
        self.out.valid = inp.valid
        return self.out

    def model_main(self, complex_in_list):
        shaped = np.reshape(complex_in_list, (-1, self.FFT_SIZE))
        return (shaped * self.window_pure).flatten()


@pytest.mark.parametrize("fft_size", [4, 8, 16, 32, 256])
@pytest.mark.parametrize("input_power", [0.1, 0.001])
def test_windower(fft_size, input_power):
    np.random.seed(0)
    dut = Windower(fft_size)
    inp = np.random.uniform(-1, 1, size=2 * fft_size) + np.random.uniform(-1, 1, size=2 * fft_size) * 1j
    inp *= input_power

    sim_out = simulate(dut, inp, pipeline_flush='auto')
    assert sims_close(sim_out, rtol=1e-5, atol=1e-5)
