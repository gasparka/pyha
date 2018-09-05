import numpy as np
import pytest

from pyha import Hardware, simulate, sims_close, Complex, resize, Sfix, right_index, left_index, default_complex
from pyha.cores import DataValidToNumpy, NumpyToDataValid, DataValid


class FFTPower(Hardware):
    """ Turns FFT result into power ~equalish to : abs(fft_result)
    Note that this core consumes Complex samples but outputs Sfix samples.
    """

    def __init__(self):
        self._pyha_simulation_input_callback = NumpyToDataValid(dtype=default_complex)
        self._pyha_simulation_output_callback = DataValidToNumpy()

        self.out = DataValid(Sfix(0.0, 0, -35, overflow_style='saturate'), valid=False)
        self.DELAY = 1

    def conjugate(self, x):
        imag = resize(-x.imag, left_index(x.imag), right_index(x.imag))
        return Complex(x.real, imag)

    def main(self, inp):
        if not inp.valid:
            return DataValid(self.out.data, valid=False)

        self.out.data = (self.conjugate(inp.data) * inp.data).real
        self.out.valid = inp.valid
        return self.out

    def model_main(self, data):
        return (np.conjugate(data) * data).real.flatten()


@pytest.mark.parametrize("input_power", [0.5, 0.1, 0.001, 0.00001])
def test_all(input_power):
    dut = FFTPower()
    inp = (np.random.uniform(-1, 1, size=1280) + np.random.uniform(-1, 1, size=1280) * 1j) * input_power
    inp = [complex(Complex(x, 0, -17)) for x in inp]
    sims = simulate(dut, inp, simulations=['MODEL', 'PYHA'])
    assert sims_close(sims, rtol=1e-20, atol=1e-20)
