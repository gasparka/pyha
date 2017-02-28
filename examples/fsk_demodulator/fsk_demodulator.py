import numpy as np

from examples.moving_average.moving_average import MovingAverage
from pyha.components.quadrature_demodulator import QuadratureDemodulator

from pyha.simulation.simulation_interface import assert_sim_match

from pyha.common.const import Const
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.components.cordic import NCO


class FSKDemodulator(HW):
    """
    Takes in complex signal and gives out bits. It uses Quadrature demodulator followed by
    matched filter (moving average). M&M clock recovery is the last DSP block, it performs timing recovery.

    .. note:: M&M clock recovery is currently not implemented
    """

    def __init__(self, gain, sps):

        self.demod = QuadratureDemodulator(gain)
        self.match = MovingAverage(sps)


        # constants
        self._delay = self.demod._delay + self.match._delay

    def main(self, c):
        pass

    def model_main(self, symbol_list):
        d_phase = 0
        phl = []
        for symbol in symbol_list:
            d_phase += self.sensitivity if symbol else -self.sensitivity  # this is FSK
            d_phase = ((d_phase + np.pi) % (2.0 * np.pi)) - np.pi  # keep in pi range
            phl.append(d_phase * 1j)

        return np.exp(phl)


###################################################################################
# TESTS
###################################################################################

def test_basic():
    samples_per_symbol = 4
    fs = 300e3
    deviation = 70e3  # deviation from center frequency

    symbols = [1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0]

    # apply SPS
    data = []
    for x in symbols:
        data.extend([x] * samples_per_symbol)

    dut = FSKModulator(deviation, fs)

    assert_sim_match(dut, [bool],
                     None, data,
                     rtol=1e-4,
                     dir_path='/home/gaspar/git/pyha/examples/fsk_modulator/conversion')
