import numpy as np
from pyha.common.const import Const
from pyha.common.hwsim import HW
from pyha.common.sfix import ComplexSfix, resize, Sfix, fixed_truncate
from pyha.components.cordic import Angle
from pyha.components.util_complex import Conjugate, ComplexMultiply


class QuadratureDemodulator(HW):
    def __init__(self, gain):
        self.gain = gain * np.pi # pi term puts angle output to pi range
        self.gain_sfix = Const(Sfix(self.gain, 1, -16))
        self.conjugate = Conjugate()
        self.complex_mult = ComplexMultiply()
        self.angle = Angle()
        self.out = Sfix()

        self.delay = self.conjugate.get_delay() + \
                     self.complex_mult.get_delay() + \
                     self.angle.get_delay() + 1

    def main(self, c):
        c_conj = self.next.conjugate.main(c)
        cmult = self.next.complex_mult.main(c, c_conj)
        angle = self.next.angle.main(cmult)

        self.next.out = resize(self.gain_sfix * angle, c.real, round_style=fixed_truncate)
        return self.out

    def get_delay(self):
        return self.delay

    def model_main(self, c):
        demod = self.gain * np.angle(c[1:] * np.conjugate(c[:-1])) / np.pi
        return demod


# test modules
class QuadratureDemodulatorPartial0(HW):
    def __init__(self, gain):
        self.gain = gain
        self.conjugate = Conjugate()
        self.prev = ComplexSfix()
        self.delay = self.conjugate.get_delay()

    def main(self, c):
        r = self.next.conjugate.main(c)
        return r

    def get_delay(self):
        return self.delay

    def model_main(self, c):
        demod = np.conjugate(c[:-1])
        return demod


class QuadratureDemodulatorPartial1(HW):
    def __init__(self, gain):
        self.gain = gain

        self.conjugate = Conjugate()
        self.complex_mult = ComplexMultiply()
        self.prev = ComplexSfix()
        self.delay = self.conjugate.get_delay() + \
                     self.complex_mult.get_delay()

    def main(self, c):
        r = self.next.conjugate.main(c)
        ra = self.next.complex_mult.main(c, r)
        return ra

    def get_delay(self):
        return self.delay

    def model_main(self, c):
        demod = c[1:] * np.conjugate(c[:-1])
        return demod
