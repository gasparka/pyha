import numpy as np

from pyha import Hardware, Complex, simulate
from pyha.common.complex import default_complex
from pyha.common.context_managers import SimulationRunning
from pyha.common.fixed_point import default_sfix


class TimeSuite:
    def setup(self):
        class ShiftReg(Hardware):
            def __init__(self):
                self.shr_sub = [Complex()] * 1

            def main(self, new_sub):
                self.shr_sub = [new_sub] + self.shr_sub[:-1]
                return self.shr_sub[-1]

        self.dut = ShiftReg()
        n = 2 ** 13
        self.inp = np.random.uniform(-1, 1, n) + np.random.uniform(-1, 1, n)*1j

    def time_complex_shiftreg(self):
        simulate(self.dut, self.inp, simulations=['PYHA'])


class ConversionsFloat:
    """ Turning Python floats values into Sfix object, involves quantization etc.."""
    def setup(self):
        n = 2 ** 13
        self.inp = np.random.uniform(-1, 1, n)

    def time_float_to_sfix(self):
        ret = [default_sfix(x) for x in self.inp]


class ConversionComplex:
    """ Turning Python complex values into Complex object, involves quantization etc.."""
    def setup(self):
        n = 2 ** 13
        self.inp = np.random.uniform(-1, 1, n) + np.random.uniform(-1, 1, n)*1j

    def time_float_to_sfix(self):
        with SimulationRunning.enable(): # turns all objects to 'locals'
            ret = [default_complex(x) for x in self.inp]


# if __name__ == '__main__':
#     d = TimeFFT()
#     d.setup()
#     d.time_fft()