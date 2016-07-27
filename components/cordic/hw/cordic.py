import logging

import numpy as np

from common.register import clock_tick
from common.sfix import Sfix
from components.cordic.hw.kernel import CORDICKernel

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class Exp(object):
    def __init__(self, iterations=18):
        self.input_sfix = [Sfix(left=2, right=-30)]

        self._kernel = CORDICKernel(iterations, mode='ROTATE')
        self.phase_acc = Sfix()
        self.sign_invert = [False] * self.delay
        self.phase_acc_corrected = Sfix()

    @property
    def delay(self):
        # return self.iterations + 1
        return self._kernel.delay + 2

    @clock_tick
    def __call__(self, phase_inc):
        self.next.phase_acc = (self.phase_acc_corrected + phase_inc).resize(type=phase_inc)
        self.next.sign_invert = [self.sign_invert[0]] + self.sign_invert[:-1]
        if self.phase_acc > np.pi / 2:  # cordic only works from -pi/2 to pi/2
            self.next.sign_invert[0] = not self.sign_invert[-1]  # need to sign invert 2,3 quadrant
            self.next.phase_acc_corrected = self.phase_acc - np.pi
        else:
            self.next.phase_acc_corrected = self.phase_acc

            # self.next.phase_acc = self.next.phase_acc - Sfix(np.pi, phase_inc.left, phase_inc.right)
            # self.next.phase_acc = self.next.phase_acc - Sfix(np.pi, phase_inc.left, -8)
        # elif self.phase_acc < Sfix(-np.pi / 2, phase_inc.left, phase_inc.right).val:
        #     self.next.sign_invert[0] = not self.sign_invert[-1]  # need to sign invert 2,3 quadrant
        #     self.next.phase_acc = self.next.phase_acc + Sfix(np.pi, phase_inc.left, phase_inc.right)

        x, y, _ = self._kernel(x=Sfix(1 / 1.64676025812107, 0, -17),
                               y=Sfix(0, 0, -17),
                               phase=self.phase_acc_corrected.resize(1, -16))

        # if self.sign_invert[-1]:
        #     return -x, -y
        # else:
        return x, y

    def test_adaptor(self, *args, **kwargs):
        # get rid of complex samples and convert to list
        phase_list = args[0]
        phase_list = phase_list.imag.tolist()

        # convert to increments
        phase_increments = [phase_list[0]] + np.diff(phase_list).tolist()
        return [phase_increments]

        # delay = 19
        # # phase_increments += [0] * (delay)
        # res = []
        # for phase_inc in phase_increments:
        #     i, q = self(phase_inc)
        #     res += [i + q * 1j]
        # # return res[delay:]
        # return res
