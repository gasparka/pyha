from pyha.common.hwsim import HW
from pyha.common.sfix import resize, scalb, ComplexSfix


# blade rf format to 18 bit format and complex

class BladeToComplex(HW):
    def __init__(self):
        pass

    def main(self, i, q):
        # go to 18 bits
        inorm = resize(i, 4, -13)
        qnorm = resize(q, 4, -13)

        # scale away blade rf format
        iscale = scalb(inorm, 4)
        qscale = scalb(qnorm, 4)

        # make complex
        c = ComplexSfix(iscale, qscale)
        return c

    def model_main(self, i, q):
        return i * (2 ** 4) + q * (2 ** 4) * 1j
