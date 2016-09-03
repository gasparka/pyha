# %matplotlib inline
import logging

import numpy as np
from LEGACY.common.register import clock_tick


def resize(param, x):
    return 1


logging.basicConfig(level=logging.WARNING)
logger = logging.getLogger(__name__)


class Polar(object):
    def __init__(self, cordic_length=18, phase_unit='rad'):
        self.phase_unit = phase_unit
        self.x = [0] * cordic_length
        self.y = [0] * cordic_length
        self.phase = [0] * cordic_length

        self.wrap = 0

        # create phase LUT
        self.cordic_length = cordic_length
        self.phase_lut = [np.arctan(2 ** -i) for i in range(cordic_length)]
        self.first_phase = -np.pi
        if phase_unit is 'degrees':
            self.first_phase = -180
            self.phase_lut = [x * 180 / np.pi for x in self.phase_lut]

    @property
    def delay(self):
        return self.cordic_length

    def cordic_rotate_vector(self, i, direction, x, y, phase):
        # if direction:
        #     next_x = resize(x - y >> i, x)
        #     next_y = resize(y + x >> i, y)
        #     next_phase = resize(phase - self.phase_lut[i], phase)
        # else:
        #     next_x = resize(x + y >> i, x)
        #     next_y = resize(y - x >> i, y)
        #     next_phase = resize(phase + self.phase_lut[i], phase)
        logger.info('i={}, dir={}, x={}, y={}, phase={}'.format(i, direction, x, y, phase))
        if direction:
            next_x = x - y * (2 ** -i)
            next_y = y + x * (2 ** -i)
            next_phase = phase - self.phase_lut[i]
        else:
            next_x = x + y * (2 ** -i)
            next_y = y - x * (2 ** -i)
            next_phase = phase + self.phase_lut[i]

        logger.info('-> next_x={}, next_y={}, next_phase={}'.format(next_x, next_y, next_phase))
        return next_x, next_y, next_phase

    @clock_tick
    def main(self, x, y):
        next = self.next

        # inital rotation by pi
        # http://www.andraka.com/files/crdcsrvy.pdf page 3
        if x < 0:
            next.x[0] = -x
            next.y[0] = -y
            next.phase[0] = -np.pi
        else:
            next.x[0] = x
            next.y[0] = y
            next.phase[0] = 0

        for i in range(len(self.phase_lut) - 1):
            dir = self.y[i] < 0
            next.x[i + 1], next.y[i + 1], next.phase[i + 1] = \
                self.cordic_rotate_vector(i, dir, self.x[i], self.y[i], self.phase[i])

        return self.phase[-1], self.x[-1] * 1 / 1.646760

    def _implementation_abstract(self, x, y):

        if x < 0:
            x = -x
            y = -y
            phase = -np.pi
        else:
            x = x
            y = y
            phase = 0

        for i, adj in enumerate(self.phase_lut):
            sign = 1 if y < 0 else -1
            x, y, phase = x - sign * (y * (2 ** -i)), y + sign * (x * (2 ** -i)), phase - sign * adj
        return phase, x * 1 / 1.646760

    def _abstract(self, x, y):
        inp = x + y * 1j
        phase = np.angle(inp, deg=self.phase_unit == 'degrees')
        pow = np.abs(inp)
        return phase, pow
