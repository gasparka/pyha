import numpy as np


class CORDIC():
    def __init__(self, iterations=18):
        self.iterations = iterations
        self.phase_lut = [np.arctan(2 ** -i) for i in range(iterations)]

    def kernel(self, x, y, phase):
        for i, adj in enumerate(self.phase_lut):
            sign = -1 if phase < 0 else 1
            x, y, phase = x - sign * (y * (2 ** -i)), y + sign * (x * (2 ** -i)), phase - sign * adj
        return x, y, phase

    def exp(self, phase_inc, samples):
        phase_acc = 0
        sign = 1
        res = []
        for _ in range(samples):
            phase_acc += phase_inc
            if phase_acc > np.pi / 2:  # cordic only works from -pi/2 to pi/2
                phase_acc -= np.pi
                sign *= -1  # need to sign invert 2,3 quadrant

            x, y, _ = self.kernel(x=1 / 1.646760, y=0, phase=phase_acc)
            res += [sign * x + sign * y * 1j]

        return res
