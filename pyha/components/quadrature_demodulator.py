import numpy as np

from pyha.common.const import Const
from pyha.common.hwsim import HW
from pyha.common.sfix import ComplexSfix, resize, Sfix, fixed_truncate
from pyha.components.cordic import Angle
from pyha.components.util_complex import Conjugate, ComplexMultiply


class QuadratureDemodulator(HW):
    def __init__(self, gain):

        self.gain = gain * np.pi # pi term puts angle output to pi range

        # components
        self.conjugate = Conjugate()
        self.complex_mult = ComplexMultiply()
        self.angle = Angle()
        self.out = Sfix()

        # specify component delay
        self._delay = self.conjugate._delay + \
                     self.complex_mult._delay + \
                     self.angle._delay + 1

        # constants
        self.gain_sfix = Const(Sfix(self.gain, 3, -14))

    def main(self, c):
        """ This is HW model, to be converted to VHDL """
        conj = self.conjugate.main(c)
        mult = self.complex_mult.main(c, conj)
        angle = self.angle.main(mult)
        fix_gain = resize(self.gain_sfix * angle, c.real, round_style=fixed_truncate)

        # output register
        self.next.out = fix_gain
        return self.out

    def model_main(self, c):
        """ Model that verification is ran against """
        demod = np.angle(c[1:] * np.conjugate(c[:-1]))
        fix_gain = self.gain * demod / np.pi
        return fix_gain


# test modules
class QuadratureDemodulatorPartial0(HW):
    def __init__(self, gain):
        self.gain = gain
        self.conjugate = Conjugate()
        self.prev = ComplexSfix()
        self._delay = self.conjugate._delay

    def main(self, c):
        r = self.conjugate.main(c)
        return r

    def model_main(self, c):
        demod = np.conjugate(c[:-1])
        return demod


class QuadratureDemodulatorPartial1(HW):
    def __init__(self, gain):
        self.gain = gain

        self.conjugate = Conjugate()
        self.complex_mult = ComplexMultiply()
        self.prev = ComplexSfix()
        self._delay = self.conjugate._delay + \
                     self.complex_mult._delay

    def main(self, c):
        r = self.conjugate.main(c)
        ra = self.complex_mult.main(c, r)
        return ra

    def model_main(self, c):
        demod = c[1:] * np.conjugate(c[:-1])
        return demod
