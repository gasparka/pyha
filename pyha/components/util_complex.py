import numpy as np

from pyha.common.hwsim import HW
from pyha.common.sfix import resize, ComplexSfix, Sfix, fixed_truncate


class Conjugate(HW):
    def __init__(self):
        self.outreg = ComplexSfix()

        self._delay = 1

    def main(self, x):
        self.next.outreg.real = x.real
        self.next.outreg.imag = resize(-x.imag, size_res=x.imag)
        return self.outreg

    def model_main(self, x):
        return np.conjugate(x)


class ComplexMultiply(HW):
    """ (x + yj)(u + vj) = (xu - yv) + (xv + yu)j """

    def __init__(self):
        self.real_xu = Sfix()
        self.real_yv = Sfix()

        self.imag_xv = Sfix()
        self.imag_yu = Sfix()

        self.outreg = ComplexSfix()

        self._delay = 2

    def main(self, a, b):
        # assert a.has_same_bounds(b)
        # self.next.real_xu = a.real * b.real
        # self.next.real_yv = a.imag * b.imag
        # self.next.outreg.real = resize(self.real_xu - self.real_yv,
        #                                size_res=a.real, round_style=fixed_truncate)
        #
        # self.next.imag_xv = a.real * b.imag
        # self.next.imag_yu = a.imag * b.real
        # self.next.outreg.imag = resize(self.imag_xv + self.imag_yu,
        #                                size_res=a.imag, round_style=fixed_truncate)

        self.next.real_xu = resize(a.real * b.real, size_res=a.real, round_style=fixed_truncate)
        self.next.real_yv = resize(a.imag * b.imag, size_res=a.real, round_style=fixed_truncate)
        self.next.outreg.real = resize(self.real_xu - self.real_yv,
                                       size_res=a.real, round_style=fixed_truncate)

        self.next.imag_xv = resize(a.real * b.imag, size_res=a.real, round_style=fixed_truncate)
        self.next.imag_yu = resize(a.imag * b.real, size_res=a.real, round_style=fixed_truncate)
        self.next.outreg.imag = resize(self.imag_xv + self.imag_yu,
                                       size_res=a.real, round_style=fixed_truncate)

        return self.outreg

    def model_main(self, a, b):
        return np.array(a) * np.array(b)
