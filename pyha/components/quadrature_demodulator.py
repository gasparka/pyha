import numpy as np

from pyha.common.const import Const
from pyha.common.hwsim import HW
from pyha.common.sfix import ComplexSfix, resize, Sfix, fixed_truncate
from pyha.components.cordic import Angle
from pyha.components.util_complex import Conjugate, ComplexMultiply


class QuadratureDemodulator(HW):
    """
    http://gnuradio.org/doc/doxygen-3.7/classgr_1_1analog_1_1quadrature__demod__cf.html#details

    :param gain: inverse of tx sensitivity. In RTL this is further multiplied by PI, because CORDIC returns angle in -1 to 1 range.
    """
    def __init__(self, gain):
        self.gain = gain

        # components / registers
        self.conjugate = Conjugate()
        self.complex_mult = ComplexMultiply()
        self.angle = Angle()
        self.out = Sfix()

        # constants
        # pi term puts angle output to pi range
        self.gain_sfix = Const(Sfix(self.gain * np.pi, 3, -14))

        self._delay = self.conjugate._delay + \
                     self.complex_mult._delay + \
                     self.angle._delay + 1

    def main(self, c):
        """

        :param c: baseband
        :type c: ComplexSfix
        :return: demodulated signal
        :rtype: Sfix
        """
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
        fix_gain = self.gain * demod
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
