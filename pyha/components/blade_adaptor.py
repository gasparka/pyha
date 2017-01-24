from pyha.common.hwsim import HW
from pyha.common.sfix import resize, scalb, ComplexSfix, Sfix


# blade rf format to 18 bit format and complex
# idea is to turn (4 downto -11) -> (0 downto -17)
class BladeToComplex(HW):
    def __init__(self):
        self.out = ComplexSfix()

    def main(self, i, q):
        outi = resize(scalb(i, 4), 0, -17)
        outq = resize(scalb(q, 4), 0, -17)

        # make complex
        self.next.out = ComplexSfix(outi, outq)
        return self.out

    def get_delay(self):
        return 1

    def model_main(self, i, q):
        return i * (2 ** 4) + q * (2 ** 4) * 1j


# move back to blade format
class ToBlade(HW):
    def __init__(self):
        self.out = Sfix()

    def main(self, x):
        self.next.out = resize(scalb(x, -4), 0, -15)
        return self.out

    def get_delay(self):
        return 1

    def model_main(self, i, q):
        return i * (2 ** -4) + q * (2 ** -4) * 1j