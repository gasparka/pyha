import numpy as np
from pyha import Hardware, Complex, Simulator, get_data_file, load_complex64_file
from pyha.cores import DataValid, DCRemoval, NumpyToDataValid


class DCRemovalLimeSDR(Hardware):
    """
    Filter out DC component, based on: https://www.dsprelated.com/showarticle/58.php
    """

    def __init__(self):
        self._pyha_simulation_input_callback = NumpyToDataValid(
            dtype=Complex(0.0, 0, -11, overflow_style='saturate'))

        self.dc_removal = DCRemoval(window_len=256)
        self.out = DataValid(Complex(0, 0, -15, round_style='round'))

    def main(self, inp):
        # potentail bug: convert inp to 18bit signal??
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

    file = get_data_file('gqrx_20180910_155357_2400499992_2999999_fc.raw')
    # file = get_data_file('gqrx_20180910_155357_2400499992_2999999_fc.raw')
    input_signal = load_complex64_file(file)[:1024 * 8]  # IQ samples
    Simulator(dut, trace=True).run(input_signal).assert_equal(rtol=1e-3, atol=1e-3)
