import logging
from pyha import Hardware, Complex, Sfix
from pyha.cores import Spectrogram
from pyha.common.datavalid import DataValid, NumpyToDataValid

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('spectrogram')


class SpectrogramLimeSDR(Hardware):
    """
    8k FFT spectrogram for LimeSDR Mini.
    """
    def __init__(self):
        self._pyha_simulation_input_callback = NumpyToDataValid(
            dtype=Complex(0.0, 0, -11, overflow_style='saturate', round_style='round'))

        # components
        fft_size = 1024*8
        avg_freq_axis = 16
        avg_time_axis = 8
        window_type = 'hamming'
        fft_twiddle_bits = 8
        window_bits = 8
        dc_removal_len = 1024
        self.spect = Spectrogram(fft_size, avg_freq_axis, avg_time_axis, window_type, fft_twiddle_bits, window_bits, dc_removal_len)
        # TODO: could be unsigned!
        self.output = DataValid(Sfix(0.0, upper_bits=32)) # no need to round because result is positive i.e. truncation = rounding

    def main(self, input):
        """
        Args:
            input (DataValid): 12 bit IQ, -1.0 ... 1.0 range

        Returns:
            DataValid: Upper 32 bits from the spectrogram core.

        """

        spect = self.spect.main(input)

        self.output.data = spect.data
        self.output.valid = spect.valid
        return self.output

    def model(self, inp):
        return self.spect.model(inp)
