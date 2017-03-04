import numpy as np

from examples.moving_average.moving_average import MovingAverage
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, ComplexSfix
from pyha.components.quadrature_demodulator import QuadratureDemodulator
from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, SIM_HW_MODEL, \
    SIM_GATE, SIM_RTL

# TODO: this is work in progress

class FSKDemodulator(HW):
    """
    Takes in complex signal and gives out bits. It uses Quadrature demodulator followed by
    matched filter (moving average). M&M clock recovery is the last DSP block, it performs timing recovery.

    .. note:: M&M clock recovery is currently not implemented
    """

    def __init__(self, deviation, fs, sps):
        self.fs = fs
        self.deviation = deviation

        self.gain = fs / (2 * np.pi * self.deviation) / np.pi

        self.demod = QuadratureDemodulator(self.gain)
        self.match = MovingAverage(sps)

        # constants
        self._delay = self.demod._delay + self.match._delay

    def main(self, input):
        """
        :type  input: ComplexSfix
        :rtype: Sfix
        """
        demod = self.demod.main(input)
        match = self.match.main(demod)

        return match

    def model_main(self, input_list):
        demod = self.demod.model_main(input_list)
        match = self.match.model_main(demod)

        return match


###################################################################################
# TESTS
###################################################################################

def test_basic():
    # test signal
    from pyha.components.fsk_modulator import FSKModulator
    samples_per_symbol = 4
    symbols = [1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0]

    data = []
    for x in symbols:
        data.extend([x] * samples_per_symbol)

    fs = 300e3
    deviation = 70e3
    mod = FSKModulator(deviation, fs)

    tx_signal = mod.model_main(data)

    # awgn channel (add some noise)
    # todo: this random stuff is not performing well
    np.random.seed(1)
    tx_signal = 0.5 * (tx_signal + np.random.normal(scale=np.sqrt(0.1)))

    dut = FSKDemodulator(deviation, fs, samples_per_symbol)

    assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                     None, tx_signal,
                     rtol=1e-4,
                     atol=1e-4,
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                     skip_first=samples_per_symbol,  # skip first moving average transient
                     dir_path='/home/gaspar/git/pyha/examples/fsk_demodulator/conversion'
                     )
