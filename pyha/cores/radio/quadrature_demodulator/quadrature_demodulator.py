import numpy as np
from pyha import Hardware, Sfix, simulate, sims_close, Complex
from pyha.cores import Angle


class QuadratureDemodulator(Hardware):
    """
    http://gnuradio.org/doc/doxygen-3.7/classgr_1_1analog_1_1quadrature__demod__cf.html#details

    """

    def __init__(self, gain=1.0):
        """
        :param gain: inverse of tx sensitivity
        """
        self.gain = gain
        # components / registers
        precision = -35
        self.conjugate = Complex(0.0 + 0.0j, 0, -17, overflow_style='saturate')
        self.mult = Complex(0.0 + 0.0j, 0, precision)
        self.angle = Angle(precision=precision)
        self.y = Sfix(0, 0, -17, overflow_style='saturate')

        # pi term gets us to -1 to +1
        self.GAIN_SFIX = Sfix(gain * np.pi, 4, -13, round_style='round', overflow_style='saturate')

        self.DELAY = 1 + 1 + self.angle.DELAY
        # self.DELAY = 1 + 1

    def main(self, c):
        """
        :type c: Complex
        :rtype: Sfix
        """
        self.conjugate = Complex(c.real, -c.imag)
        self.mult = c * self.conjugate
        # TODO: invalid data bug!
        angle = self.angle.main(self.mult)

        self.y = self.GAIN_SFIX * angle
        return self.y

    def model(self, c):
        # this eats one input i.e output has one less element than input
        mult = c[1:] * np.conjugate(c[:-1])
        demod = np.angle(mult)
        demod = np.append(demod, 0.0)  # compensate for the missing sample
        fix_gain = self.gain * demod
        return fix_gain


# def test_fm_demodulation():
#     def make_fm(fs, deviation):
#         # data signal
#         periods = 1
#         data_freq = 20
#         time = np.linspace(0, periods, fs * periods, endpoint=False)
#         data = np.cos(2 * np.pi * data_freq * time) * 0.5
#
#         # modulate
#         sensitivity = 2 * np.pi * deviation / fs
#         phl = np.cumsum(sensitivity * data)
#         mod = np.exp(phl * 1j) * 0.5
#
#         return mod, data
#
#     fs = 1e3
#     deviation = fs / 3
#     demod_gain = fs / (2 * np.pi * deviation)
#
#     inp, expect = make_fm(fs, deviation)
#     expect = expect[1:]  # because model eats one sample
#
#     dut = QuadratureDemodulator(gain=demod_gain)
#     sims = simulate(dut, inp)
#     assert sims_close(sims, expected=expect, rtol=1e-3)