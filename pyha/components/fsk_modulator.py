import numpy as np

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.components.cordic import NCO


class FSKModulator(HW):
    # todo: this should handle 'sps', but needs raised clock rate then..
    def __init__(self, deviation, fs):
        self.fs = fs
        self.deviation = deviation

        self.sensitivity = 2 * np.pi * deviation / fs
        self.sensitivity_sfix = Sfix(self.sensitivity / np.pi, 0, -27)
        # self.sensitivity_sfix = Sfix(self.sensitivity / np.pi, -1, -27)

        self.nco = NCO()

        # constants
        self._delay = self.nco._delay

    def main(self, symbol):
        if symbol:
            phase_step = self.sensitivity_sfix
        else:
            phase_step = -self.sensitivity_sfix

        cout = self.nco.main(phase_step)
        return cout

    def model_main(self, symbol_list):
        d_phase = 0
        phl = []
        for symbol in symbol_list:
            d_phase += self.sensitivity if symbol else -self.sensitivity  # this is FSK
            d_phase = ((d_phase + np.pi) % (2.0 * np.pi)) - np.pi  # keep in pi range
            phl.append(d_phase * 1j)
            print(d_phase / np.pi)

        return np.exp(phl)
