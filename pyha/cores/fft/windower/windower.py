import numpy as np
import pytest
from scipy.signal import get_window

from pyha import Hardware, Complex, Sfix
from pyha.common.complex import default_complex
from pyha.cores import NumpyToDataValid, DataValidToNumpy, DataValid, simulate, sims_close


class Windower(Hardware):
    """
    Window function
    ---------------

    Window function determines the frequency response of the FFT bins.
    Coefficients are stored as constants in LUTS, you will probably want to use the 'hamming' window
    with 8 bit coefficients as the storage cost is very low for even large windows.

    Args:
        window_length: Same as the FFT transform size.
        window (str): Name of the windowing function (imported from Scipy).
        coefficient_bits: Storage bit-width of the coefficients.
    """
    def __init__(self, window_length, window='hanning', coefficient_bits=18):
        self._pyha_simulation_input_callback = NumpyToDataValid(dtype=default_complex)
        self.FFT_SIZE = window_length
        self.window_pure = get_window(window, window_length)
        self.WINDOW = [Sfix(x, 0, -(coefficient_bits-1), round_style='round', overflow_style='saturate')
                       for x in self.window_pure]

        self.output = DataValid(Complex(0, 0, -17, round_style='round'))
        self.index_counter = 1
        self.coef = self.WINDOW[0]

    def main(self, input):
        if not input.valid:
            return DataValid(self.output.data, valid=False)

        self.index_counter = (self.index_counter + 1) % self.FFT_SIZE
        self.coef = self.WINDOW[self.index_counter]

        self.output.data = input.data * self.coef
        self.output.valid = input.valid
        return self.output

    def model(self, input_list):
        shaped = np.reshape(input_list, (-1, self.FFT_SIZE))
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
