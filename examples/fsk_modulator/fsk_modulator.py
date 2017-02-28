import numpy as np

from pyha.common.const import Const
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.components.cordic import NCO


class FSKModulator(HW):
    """ Frequency shift-keying modulator. It takes in bits and outputs complex stream, that could be fed
into SDR. Implementation uses NCO component, that in turn uses CORDIC algorithm for carrier generation.

    :param deviation: From center frequency
    :param fs: Sample rate
    """
    # todo: this should handle 'sps', but needs upsamper
    def __init__(self, deviation, fs):
        """
\
        :param deviation:
        :param fs:
        """
        self.fs = fs
        self.deviation = deviation

        self.sensitivity = 2 * np.pi * deviation / fs

        self.nco = NCO()

        # constants
        # / np.pi is to keep stuff in -1 to 1 range
        self.sensitivity_pos = Const(Sfix(self.sensitivity / np.pi, 0, -17))
        self.sensitivity_neg = Const(Sfix(-self.sensitivity / np.pi, 0, -17))
        self._delay = self.nco._delay

    def main(self, symbol):
        """

        :param symbol: Bit to modulate
        :return: Modulated signal in baseband
        :rtype: ComplexSfix
        """
        if symbol:
            phase_step = self.sensitivity_pos
        else:
            phase_step = self.sensitivity_neg

        cout = self.nco.main(phase_step)
        return cout

    def model_main(self, symbol_list):
        d_phase = 0
        phl = []
        for symbol in symbol_list:
            d_phase += self.sensitivity if symbol else -self.sensitivity  # this is FSK
            d_phase = ((d_phase + np.pi) % (2.0 * np.pi)) - np.pi  # keep in pi range
            phl.append(d_phase * 1j)

        return np.exp(phl)
