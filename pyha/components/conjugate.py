import numpy as np

from pyha.common.hwsim import HW
from pyha.common.sfix import resize, ComplexSfix


class Conjugate(HW):
    def __init__(self):
        self.outreg = ComplexSfix()

    def main(self, x):
        self.next.outreg.real = x.real
        self.next.outreg.imag = resize(-x.imag, size_res=x.imag)
        return self.outreg

    def get_delay(self):
        return 1

    def model_main(self, x):
        return np.conjugate(x)
