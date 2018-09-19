import numpy as np
import pytest

from pyha import Hardware, Complex, Sfix, default_complex, simulate, sims_close
from pyha.common.datavalid import DataValid, NumpyToDataValid


class FFTPower(Hardware):
    """
    FFTPower
    --------

    Multiplies complex input by its conjugate: (a + bi)(a - bi) = a**2 + b**2
    Results in a real number.

    """

    def __init__(self):
        self._pyha_simulation_input_callback = NumpyToDataValid(dtype=default_complex)
        self.output = DataValid(Sfix(bits=36))

    def main(self, input):
        """
        Args:
            input (DataValid): type not restricted

        Returns:
            DataValid: Lowest 36 bits from the result.
                Example: Input is 18 bits with format 0:-17, then output is 36 bits 1:-34

        """
        if not input.valid:
            return DataValid(self.output.data, valid=False)

        # (a + bi)(a - bi) = a**2 + b**2
        self.output.data = (input.data.real * input.data.real) + (input.data.imag * input.data.imag)
        self.output.valid = input.valid
        return self.output

    def model(self, input_list):
        return (np.conjugate(input_list) * input_list).real.flatten()


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
