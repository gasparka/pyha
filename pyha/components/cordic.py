import numpy as np

from pyha.common.hwsim import HW
from pyha.common.sfix import resize, ComplexSfix, Sfix, fixed_truncate


class CordicCore(HW):
    def __init__(self, iterations):
        self.iterations = iterations
        self.phase_lut = [np.arctan(2 ** -i) for i in range(iterations)]

    def main(self, x):
        pass

    def get_delay(self):
        return 1

    def model_main(self, c):
        def cord_model(c):
            phase = 0
            x = c.real
            y = c.imag
            for i, adj in enumerate(self.phase_lut):
                sign = 1 if y < 0 else -1
                x, y, phase = x - sign * (y * (2 ** -i)), y + sign * (x * (2 ** -i)), phase - sign * adj
            return x, y, phase

        return [cord_model(x) for x in c]






