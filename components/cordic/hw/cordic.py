import logging

import numpy as np

from common.sfix import Sfix
from components.cordic.hw.kernel import CORDICKernel

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class Exp(object):
    def __init__(self, iterations=18):
        self._kernel = CORDICKernel(iterations, mode='ROTATE')
        self.iterations = iterations
        self.phase_lut = [np.arctan(2 ** -i) for i in range(iterations)]
        self.phase_acc = 0
        self.sign_invert = False

    def kernel(self, x, y, phase):
        # return self._kernel.test_interface(x, y, phase, mode='ROTATE')

        x = Sfix(x, 2, -17)
        y = Sfix(y, 2, -17)
        phase = Sfix(phase, 2, -17)
        x, y, p = self._kernel(x, y, phase)
        return float(x), float(y), float(p)
        # return self._kernel(x, y, phase)

    def __call__(self, phase_inc):
        self.phase_acc += phase_inc
        if self.phase_acc > np.pi / 2:  # cordic only works from -pi/2 to pi/2
            self.sign_invert = not self.sign_invert  # need to sign invert 2,3 quadrant
            self.phase_acc -= np.pi
        elif self.phase_acc < -np.pi / 2:
            self.sign_invert = not self.sign_invert  # need to sign invert 2,3 quadrant
            self.phase_acc += np.pi

        x, y, _ = self.kernel(x=1 / 1.646760, y=0, phase=self.phase_acc)

        # FIXME: cant use kernel because have to delaymach here!
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

        delay = 19
        # phase_increments += [0] * (delay)
        res = []
        for phase_inc in phase_increments:
            i, q = self(phase_inc)
            res += [i + q * 1j]
        # return res[delay:]
        return res
