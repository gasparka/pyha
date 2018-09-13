import numpy as np
import pytest

from pyha import Hardware, Complex, resize, Sfix, default_complex, Simulator
from pyha.cores import NumpyToDataValid, DataValid, simulate, sims_close


class FFTPower(Hardware):
    """ Turns FFT result into power ~equalish to : abs(fft_result)
    Note that this core consumes Complex samples but outputs Sfix samples.
    """

    def __init__(self):
        self._pyha_simulation_input_callback = NumpyToDataValid(dtype=default_complex)
        self.out = DataValid(Sfix())

    def main(self, inp):
        if not inp.valid:
            return DataValid(self.out.data, valid=False)

        conjugate = resize(Complex(inp.data.real, -inp.data.imag), size_res=inp.data)
        self.out.data = (conjugate * inp.data).real
        self.out.valid = inp.valid
        return self.out

    def model_main(self, data):
        return (np.conjugate(data) * data).real.flatten()


@pytest.mark.parametrize("input_power", [0.5, 0.1, 0.001, 0.00001])
def test_all(input_power):
    dut = FFTPower()
    inp = (np.random.uniform(-1, 1, size=1280) + np.random.uniform(-1, 1, size=1280) * 1j) * input_power
    inp = [complex(Complex(x, 0, -17)) for x in inp]
    sims = simulate(dut, inp, pipeline_flush='auto')
    assert sims_close(sims, rtol=1e-20, atol=1e-20)



def test_nonstandard_input_size():
    input_power = 0.0001
    dut = FFTPower()
    dut._pyha_simulation_input_callback = NumpyToDataValid(dtype=Complex(0, -3, -21, round_style='round'))
    inp = (np.random.uniform(-1, 1, size=64) + np.random.uniform(-1, 1, size=64) * 1j) * input_power
    sims = simulate(dut, inp, pipeline_flush='auto')
    assert sims_close(sims, rtol=1e-10, atol=1e-10)