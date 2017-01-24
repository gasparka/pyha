from pyha.common.hwsim import HW
from pyha.components.blade_adaptor import BladeToComplex, NormalToBlade
from pyha.components.quadrature_demodulator import QuadratureDemodulator
import numpy as np

class BladeDemod(HW):
    def __init__(self):
        self.blade_to_complex = BladeToComplex()
        self.quadrature_demodulator = QuadratureDemodulator(2.0)
        self.normal_to_blade = NormalToBlade()
        self._delay = self.quadrature_demodulator.get_delay() + self.blade_to_complex.get_delay()\
                      + self.normal_to_blade.get_delay()

    def main(self, i, q):
        c = self.next.blade_to_complex.main(i, q)
        demod = self.next.quadrature_demodulator.main(c)
        blade = self.next.quadrature_demodulator.main(demod)
        return blade

    def get_delay(self):
        return self._delay

    def model_main(self, i, q):
        c = self.blade_to_complex.model_main(i, q)
        a = self.quadrature_demodulator.model_main(c)
        return self.normal_to_blade.model_main(a)


