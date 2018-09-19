import numpy as np
import pytest

from pyha import Hardware, Complex, resize, Sfix, default_complex
from pyha.cores import NumpyToDataValid, DataValid, simulate, sims_close


class FFTPower(Hardware):
    """ Turns FFT result into power ~equalish to : abs(fft_result)
    Note that this core consumes Complex samples but outputs Sfix samples.
    TODO: Should output unsigned
    TODO: rename to MultConjugate?
    """

    def __init__(self):
        self._pyha_simulation_input_callback = NumpyToDataValid(dtype=default_complex)
        self.out = DataValid(Sfix(bits=36))

    def main(self, inp):
        if not inp.valid:
            return DataValid(self.out.data, valid=False)

        # (a + bi)(a - bi) = a**2 + b**2
        self.out.data = (inp.data.real * inp.data.real) + (inp.data.imag * inp.data.imag)
        self.out.valid = inp.valid
        return self.out

    def model(self, data):
        return (np.conjugate(data) * data).real.flatten()


@pytest.mark.parametrize("input_power", [0.5, 0.1, 0.001, 0.00001])
def test_all(input_power):
    dut = FFTPower()
    inp = (np.random.uniform(-1, 1, size=1280) + np.random.uniform(-1, 1, size=1280) * 1j) * input_power
    inp = [complex(Complex(x, 0, -17)) for x in inp]
    sims = simulate(dut, inp, pipeline_flush='auto', simulations=['MODEL', 'HARDWARE'])
    assert sims_close(sims, rtol=1e-20, atol=1e-20)


def test_nonstandard_input_size():
    input_power = 0.0001
    dut = FFTPower()

    dtype = Complex(0, -4, -21, round_style='round')

    dut._pyha_simulation_input_callback = NumpyToDataValid(dtype)
    inp = (np.random.uniform(-1, 1, size=64) + np.random.uniform(-1, 1, size=64) * 1j) * input_power
    inp = [complex(dtype(x)) for x in inp]
    sims = simulate(dut, inp, pipeline_flush='auto', conversion_path='/tmp/pyha_output')
    assert sims_close(sims, rtol=1e-20, atol=1e-20)
