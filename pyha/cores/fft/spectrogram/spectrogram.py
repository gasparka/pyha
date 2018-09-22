import numpy as np
import pytest
from scipy.signal import get_window

from pyha import Hardware, simulate, sims_close, Complex, default_complex
from pyha.cores import DCRemoval, Windower, R2SDF, FFTPower, BitreversalFFTshiftAVGPool
from pyha.common.datavalid import NumpyToDataValid


def numpy_model(x, fft_size, avg_freq_axis, avg_time_axis, window_type='hanning'):
    """ DC removal here is inferior to the one used in hardware! """
    no_dc = x - np.mean(x)
    resh = np.reshape(no_dc, (-1, fft_size))
    windowed = resh * get_window(window_type, fft_size)
    transform = np.fft.fft(windowed) / fft_size
    power = (transform * np.conj(transform)).real

    unshift = np.fft.fftshift(power, axes=1)

    # average in freq axis
    avg_y = np.split(unshift.T, len(unshift.T) // avg_freq_axis)
    avg_y = np.average(avg_y, axis=1)

    # average in time axis
    avg_x = np.split(avg_y.T, len(avg_y.T) // avg_time_axis)
    avg_x = np.average(avg_x, axis=1)
    return avg_x


class Spectrogram(Hardware):
    """
    Spectrogram
    -----------

    Combines a bunch of cores to build a spectrogram system.

    Args:
        fft_size: see R2SDF
        avg_freq_axis: see BitreversalFFTshiftAVGPool
        avg_time_axis: see BitreversalFFTshiftAVGPool
        window_type: see Windower
        fft_twiddle_bits: see R2SDF
        window_bits: see Windower
        dc_removal_len: see DCRemoval
    """

    def __init__(self, fft_size, avg_freq_axis=2, avg_time_axis=1, window_type='hanning', fft_twiddle_bits=18,
                 window_bits=18, dc_removal_len=1024):

        self._pyha_simulation_input_callback = NumpyToDataValid(dtype=default_complex)
        self.AVG_FREQ_AXIS = avg_freq_axis
        self.AVG_TIME_AXIS = avg_time_axis
        self.FFT_SIZE = fft_size
        self.WINDOW_TYPE = window_type

        # components
        self.dc_removal = DCRemoval(dc_removal_len)
        self.windower = Windower(fft_size, self.WINDOW_TYPE, coefficient_bits=window_bits)
        self.fft = R2SDF(fft_size, twiddle_bits=fft_twiddle_bits)
        self.power = FFTPower()
        self.dec = BitreversalFFTshiftAVGPool(fft_size, avg_freq_axis, avg_time_axis)

    def main(self, input):
        """
        Args:
            input (DataValid): -1.0 ... 1.0 range, up to 18 bits

        Returns:
            DataValid: Result from the BitreversalFFTshiftAVGPool core

        """
        dc_out = self.dc_removal.main(input)
        window_out = self.windower.main(dc_out)
        fft_out = self.fft.main(window_out)
        power_out = self.power.main(fft_out)
        dec_out = self.dec.main(power_out)
        return dec_out

    def model(self, input_list):
        no_dc = self.dc_removal.model(input_list)
        window = self.windower.model(no_dc)
        transform = self.fft.model(window)
        power = self.power.model(transform)
        dec_out = self.dec.model(power)
        return dec_out


@pytest.mark.parametrize("avg_freq_axis", [1, 2, 16])
@pytest.mark.parametrize("avg_time_axis", [2, 4, 8])
@pytest.mark.parametrize("fft_size", [128, 256])
@pytest.mark.parametrize("input_power", [0.25, 0.001])
def test_all(fft_size, avg_freq_axis, avg_time_axis, input_power):
    np.random.seed(0)
    input_size = (avg_time_axis) * fft_size
    if input_size < 1024:  # must be atleast DC-removal size?
        input_size = 1024
    orig_inp = (np.random.uniform(-1, 1, size=input_size) + np.random.uniform(-1, 1,
                                                                              size=input_size) * 1j) * input_power
    dut = Spectrogram(fft_size, avg_freq_axis, avg_time_axis)

    orig_inp_quant = np.vectorize(lambda x: complex(Complex(x, 0, -17)))(orig_inp)

    sims = simulate(dut, orig_inp_quant, pipeline_flush='auto', simulations=['MODEL', 'HARDWARE'])
    assert sims_close(sims, rtol=1e-7, atol=1e-7)
