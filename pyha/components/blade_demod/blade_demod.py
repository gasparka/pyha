from pyha.common.hwsim import HW
from pyha.common.sfix import ComplexSfix
from pyha.components.blade_demod.blade_adaptor import NormalToBlade, BladeToComplex
from pyha.components.moving_average import MovingAverage
from pyha.components.quadrature_demodulator import QuadratureDemodulator


class BladeDemodPartial1(HW):
    def __init__(self, quadrature_demodulator_gain, moving_average_length):
        self.blade_to_complex = BladeToComplex()
        self.quadrature_demodulator = QuadratureDemodulator(quadrature_demodulator_gain)
        self.moving_average = MovingAverage(moving_average_length)

        self.normal_to_blade = NormalToBlade()
        # self._delay = self.quadrature_demodulator.get_delay() + self.blade_to_complex.get_delay()\
        #               + self.moving_average.get_delay()\
        #               + self.normal_to_blade.get_delay()

        self._delay = self.quadrature_demodulator.get_delay()\
                      + self.moving_average.get_delay()

    def main(self, i, q):
        # c = self.next.blade_to_complex.main(i, q)
        c = ComplexSfix(i, q)
        demod = self.next.quadrature_demodulator.main(c)
        mavg = self.next.moving_average.main(demod)
        # blade = self.next.normal_to_blade.main(demod)
        return mavg

    def get_delay(self):
        return self._delay

    def model_main(self, i, q):
        # c = self.blade_to_complex.model_main(i, q)
        c = i + q * 1j
        a = self.quadrature_demodulator.model_main(c)
        b = self.moving_average.model_main(a)
        return b
            # return self.normal_to_blade.model_main(b)


class DemodQuadMavg(HW):
    def __init__(self, quadrature_demodulator_gain, moving_average_length):
        self.quadrature_demodulator = QuadratureDemodulator(quadrature_demodulator_gain)
        self.moving_average = MovingAverage(moving_average_length)

        self._delay = self.quadrature_demodulator.get_delay() \
                      + self.moving_average.get_delay()

    def main(self, c):
        demod = self.next.quadrature_demodulator.main(c)
        mavg = self.next.moving_average.main(demod)
        return mavg

    def get_delay(self):
        return self._delay

    def model_main(self, c):
        a = self.quadrature_demodulator.model_main(c)
        b = self.moving_average.model_main(a)
        return b


class DemodQuad(HW):
    def __init__(self, quadrature_demodulator_gain):
        self.quadrature_demodulator = QuadratureDemodulator(quadrature_demodulator_gain)
        self._delay = self.quadrature_demodulator.get_delay()

    def main(self, c):
        demod = self.next.quadrature_demodulator.main(c)
        return demod

    def get_delay(self):
        return self._delay

    def model_main(self, c):
        a = self.quadrature_demodulator.model_main(c)
        return a

class BladeDemodQuad(HW):
    def __init__(self, quadrature_demodulator_gain):
        self.quadrature_demodulator = QuadratureDemodulator(quadrature_demodulator_gain)
        self._delay = self.quadrature_demodulator.get_delay()

    def main(self, c):
        demod = self.next.quadrature_demodulator.main(c)
        return demod

    def get_delay(self):
        return self._delay

    def model_main(self, c):
        a = self.quadrature_demodulator.model_main(c)
        return a


# for testing
class BladeDemodPartial0(HW):
    def __init__(self):
        self.blade_to_complex = BladeToComplex()
        self.quadrature_demodulator = QuadratureDemodulator(0.5)
        self.normal_to_blade = NormalToBlade()
        self._delay = self.quadrature_demodulator.get_delay() + self.blade_to_complex.get_delay()\
                      + self.normal_to_blade.get_delay()

    def main(self, i, q):
        c = self.next.blade_to_complex.main(i, q)
        demod = self.next.quadrature_demodulator.main(c)
        blade = self.next.normal_to_blade.main(demod)
        return blade

    def get_delay(self):
        return self._delay

    def model_main(self, i, q):
        c = self.blade_to_complex.model_main(i, q)
        a = self.quadrature_demodulator.model_main(c)
        return self.normal_to_blade.model_main(a)


