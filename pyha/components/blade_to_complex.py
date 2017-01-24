from pyha.common.hwsim import HW
from pyha.common.sfix import resize, scalb, ComplexSfix


# blade rf format to 18 bit format and complex
# idea is to turn (4 downto -11) -> (0 downto -17)
# have a feeling much of this block is major overkill..but who knows
class BladeToComplex(HW):
    def __init__(self):
        self.out = ComplexSfix()

    def main(self, i, q):
        # # go to 18 bits
        inorm = resize(i, 4, -21)
        qnorm = resize(q, 4, -21)

        # scale away blade rf format
        iscale = scalb(inorm, 4)
        qscale = scalb(qnorm, 4)

        # out
        outi = resize(iscale, 0, -17)
        outq = resize(qscale, 0, -17)


        # make complex
        self.next.out = ComplexSfix(outi, outq)
        return self.out

    def get_delay(self):
        return 1

    def model_main(self, i, q):
        return i * (2 ** 4) + q * (2 ** 4) * 1j
