import numpy as np
from pyha import Hardware, Complex, Simulator
from pyha.cores import DataValid, DCRemoval, NumpyToDataValid


class DCRemovalLimeSDR(Hardware):
    """
    Filter out DC component, based on: https://www.dsprelated.com/showarticle/58.php
    """

    def __init__(self):
        self._pyha_simulation_input_callback = NumpyToDataValid(
            dtype=Complex(0.0, 0, -11, overflow_style='saturate', round_style='round'))

        self.dc_removal = DCRemoval(window_len=256)
        self.out = DataValid(Complex(0, 0, -11, round_style='round'))

    def main(self, inp):
        nodc = self.dc_removal.main(inp)
        self.out.data = nodc.data
        self.out.valid = nodc.valid
        return self.out

    def model_main(self, inp):
        return self.dc_removal.model_main(inp)


def test_all():
    np.random.seed(0)
    dut = DCRemovalLimeSDR()
    N = 512
    input_signal = (np.random.normal(size=N) + np.random.normal(size=N) * 1j) * 0.25
    Simulator(dut, extra_simulations=['RTL']).run(input_signal).assert_equal(rtol=1e-3, atol=1e-3)
