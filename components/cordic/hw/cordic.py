import logging

import numpy as np

from common.register import clock_tick

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class CORDICKernel(object):
    def __init__(self, iterations=18, mode='ROTATE'):
        self.iterations = iterations
        self.phase_lut = [np.arctan(2 ** -i) for i in range(iterations)]
        self.phase_acc = 0
        self.mode = mode

        # pipeline registers
        self.x = [0] * iterations
        self.y = [0] * iterations
        self.phase = [0] * iterations

    def rotate(self, i, direction, x, y, phase):
        if direction:
            next_x = x - y * (2 ** -i)
            next_y = y + x * (2 ** -i)
            next_phase = phase - self.phase_lut[i]
        else:
            next_x = x + y * (2 ** -i)
            next_y = y - x * (2 ** -i)
            next_phase = phase + self.phase_lut[i]

        return next_x, next_y, next_phase

    @clock_tick
    def kernel(self, x, y, phase):
        next = self.next
        self.next.x[0] = x
        self.next.y[0] = y
        self.next.phase[0] = phase

        for i in range(len(self.phase_lut) - 1):
            if self.mode == 'ROTATE':
                dir = not self.phase[i] < 0
            elif self.mode == 'VECTOR':
                dir = self.y[i] < 0
            # dir = self.y[i] < 0
            next.x[i + 1], next.y[i + 1], next.phase[i + 1] = \
                self.rotate(i, dir, self.x[i], self.y[i], self.phase[i])

        return self.x[-1], self.y[-1], self.phase[-1]

    def test_interface(self, x, y, phase, mode):
        self.mode = mode

        # must fill te pipeline + get one result out
        for _ in range(self.iterations + 1):
            rx, ry, rphase = self.kernel(x, y, phase)

        return rx, ry, rphase


class Exp(object):
    def __init__(self, iterations=18):
        self.iterations = iterations
        self.phase_lut = [np.arctan(2 ** -i) for i in range(iterations)]
        self.phase_acc = 0
        self.sign_invert = False

        # pipeline registers
        self.x = [0] * iterations
        self.y = [0] * iterations
        self.phase = [0] * iterations

    def cordic_rotate_vector(self, i, direction, x, y, phase):
        # logger.info('i={}, dir={}, x={}, y={}, phase={}'.format(i, direction, x, y, phase))
        if direction:
            next_x = x - y * (2 ** -i)
            next_y = y + x * (2 ** -i)
            next_phase = phase - self.phase_lut[i]
        else:
            next_x = x + y * (2 ** -i)
            next_y = y - x * (2 ** -i)
            next_phase = phase + self.phase_lut[i]

        # logger.info('-> next_x={}, next_y={}, next_phase={}'.format(next_x, next_y, next_phase))
        return next_x, next_y, next_phase

    def kernel(self, x, y, phase):
        # self.next.x[0] = x
        # self.next.y[0] = y
        # self.next.phase[0] = phase

        for i, adj in enumerate(self.phase_lut):
            dir = not phase < 0
            x, y, phase = self.cordic_rotate_vector(i, dir, x, y, phase)
        return x, y, phase

    # def kernel(self, x, y, phase):
    #     for i, adj in enumerate(self.phase_lut):
    #         sign = -1 if phase < 0 else 1
    #         x, y, phase = x - sign * (y * (2 ** -i)), y + sign * (x * (2 ** -i)), phase - sign * adj
    #     return x, y, phase

    # @clock_tick
    def __call__(self, phase_inc):
        self.phase_acc += phase_inc
        if self.phase_acc > np.pi / 2:  # cordic only works from -pi/2 to pi/2
            self.sign_invert = not self.sign_invert  # need to sign invert 2,3 quadrant
            self.phase_acc -= np.pi
        elif self.phase_acc < -np.pi / 2:
            self.sign_invert = not self.sign_invert  # need to sign invert 2,3 quadrant
            self.phase_acc += np.pi

        x, y, _ = self.kernel(x=1 / 1.646760, y=0, phase=self.phase_acc)

        if self.sign_invert:
            return -x, -y
        else:
            return x, y

    def test_interface(self, phase_list):
        # disable_reg_delay()
        # get rid of complex samples and convert to list
        phase_list = phase_list.imag.tolist()

        # convert to increments
        phase_increments = [phase_list[0]] + np.diff(phase_list).tolist()

        res = []
        for phase_inc in phase_increments:
            i, q = self(phase_inc)
            res += [i + q * 1j]
        return res
