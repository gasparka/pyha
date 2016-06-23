import copy
import logging

import numpy as np

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class Sfix(object):
    # Disables all quantization and saturating stuff
    _float_mode = False

    @staticmethod
    def set_float_mode(x):
        Sfix._float_mode = x

    def __init__(self, val=0.0, left=0, right=0, init_only=False):
        self.right = right
        self.left = left
        self.val = val

        # FIXME: This sucks, init should not call these anyways, make to_sfixed function
        if init_only or Sfix._float_mode:
            return

        if self.overflows():
            self.saturate()
        else:
            self.quantize()

    def max_representable(self):
        return 2 ** self.left - 2 ** self.right

    def min_representable(self):
        return -2 ** self.left

    def overflows(self):
        return self.val < self.min_representable() or \
               self.val > self.max_representable()

    def saturate(self):
        old = self.val
        if self.val > self.max_representable():
            self.val = self.max_representable()
        elif self.val < self.min_representable():
            self.val = self.min_representable()
        else:
            assert False
        logger.warning('Saturation {} -> {}'.format(old, self.val))

    def quantize(self):
        fix = self.val / 2 ** self.right
        fix = np.round(fix)
        self.val = fix * 2 ** self.right

    def __str__(self):
        return '{} [{}:{}]'.format(str(self.val), self.left, self.right)

    def __float__(self):
        return float(self.val)

    def resize(self, left, right):
        return Sfix(self.val, left, right)

    def __add__(self, other):
        return Sfix(self.val + other.val,
                    max(self.left, other.left) + 1,
                    min(self.right, other.right),
                    init_only=True)

    def __sub__(self, other):
        o = copy.copy(other)
        o.val = -other.val  # ok to "overflow"
        return self.__add__(o)

    def __mul__(self, other):
        return Sfix(self.val * other.val,
                    self.left + other.left + 1,
                    self.right + other.right,
                    init_only=True)

    def sign_bit(self):
        s = np.sign(self.val)
        if s in [0, 1]:
            return 0
        return 1

    def __rshift__(self, other):
        n = 2 ** other
        return Sfix(self.val / n,
                    self.left - other,
                    self.right - other,
                    init_only=True)

    def __abs__(self):
        return Sfix(abs(self.val),
                    self.left + 1,
                    self.right,
                    init_only=True)
