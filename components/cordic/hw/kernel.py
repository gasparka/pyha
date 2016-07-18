import numpy as np

from common.register import clock_tick
from common.sfix import Sfix


class CORDICKernel(object):
    def __init__(self, iterations=18, mode='ROTATE'):
        # FIXME: +1 due to pipeline for structure!, this acts as output register
        self.iterations = iterations + 1
        self.phase_lut = Sfix.auto_size([np.arctan(2 ** -i) for i in range(self.iterations)], bits=32)
        self.mode = mode

        # pipeline registers
        self.x = [Sfix()] * self.iterations
        self.y = [Sfix()] * self.iterations
        self.phase = [Sfix()] * self.iterations

    @property
    def delay(self):
        return self.iterations + 1

    def rotate(self, i, x, y, phase):
        if self.mode == 'ROTATE':
            direction = not phase < 0
        elif self.mode == 'VECTOR':
            direction = y < 0
        else:
            raise Exception('Unknown mode')

        if direction:
            next_x = x - (y >> i)
            next_y = y + (x >> i)
            next_phase = phase - self.phase_lut[i]
        else:
            next_x = x + (y >> i)
            next_y = y - (x >> i)
            next_phase = phase + self.phase_lut[i]
        return next_x.resize(2, -17), next_y.resize(2, -17), next_phase.resize(2, -17)

    @clock_tick
    def __call__(self, x, y, phase):
        next = self.next
        next.x[0], next.y[0], next.phase[0] = x, y, phase

        for i in range(len(self.phase_lut) - 1):
            next.x[i + 1], next.y[i + 1], next.phase[i + 1] = \
                self.rotate(i, self.x[i], self.y[i], self.phase[i])

        return self.x[-1], self.y[-1], self.phase[-1]

    def test_interface(self, x, y, phase, mode):
        self.mode = mode

        x = Sfix(x, 2, -17)
        y = Sfix(y, 2, -17)
        phase = Sfix(phase, 2, -17)
        for i in range(self.delay):
            rx, ry, rphase = self(x, y, phase)

        return float(rx), float(ry), float(rphase)
