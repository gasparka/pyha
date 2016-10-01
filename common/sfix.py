import logging

import numpy as np

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def resize(fix, left=0, right=0, type=None, overflow_style='SATURATE'):
    return fix.resize(left, right, type, overflow_style=overflow_style)



# TODO: Verify stuff against VHDL library
class Sfix(object):
    # Disables all quantization and saturating stuff
    _float_mode = False

    @staticmethod
    def auto_size(val, bits):
        # FIXME: int_bits possibly not correct, since we cannot reporesent max positive value, actuall maximum value is (max_int) - (frac_min)
        # calculates for signed type
        if type(val) is list:
            maxabs = max(abs(x) for x in val)
            int_bits = np.floor(np.log2(np.abs(maxabs))) + 1
            fract_bits = -bits + int_bits + 1
            ret = [Sfix(x, int_bits, fract_bits) for x in val]
            return [Sfix(x, int_bits, fract_bits) for x in val]
        else:
            int_bits = np.floor(np.log2(np.abs(val))) + 1
            fract_bits = -bits + int_bits + 1
            return Sfix(val, int_bits, fract_bits)

    @staticmethod
    def set_float_mode(x):
        Sfix._float_mode = x

    def __init__(self, val=0.0, left=0, right=0, init_only=False, overflow_style='SATURATE'):
        self.right = right
        self.left = left
        self.val = val
        self.init_val = val

        # FIXME: This sucks, init should not call these anyways, make to_sfixed function
        if init_only or Sfix._float_mode:
            return

        if overflow_style is 'SATURATE':
            if self.overflows() and overflow_style:
                self.saturate()
            else:
                self.quantize()
        elif overflow_style is 'WRAP':  # TODO: add tests
            self.quantize()
            self.wrap()
        else:
            raise Exception('Wtf')

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False

    # FIXME: THESE ARE FUCKED UP
    def max_representable(self):
        if self.left < 0:
            # FIXME: I am not sure how to handle this when negative index
            assert 0

            if self.right == 0:
                return 2 ** self.left
            else:
                return 2 ** self.left - 2 ** self.right
        else:
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

        # TODO: tests break
        # raise Exception('Saturation {} -> {}'.format(old, self.val))

    # TODO: add tests
    def wrap(self):
        fmin = self.min_representable()
        fmax = self.max_representable()
        self.val = (self.val - fmin) % (fmax - fmin) + fmin

    def quantize(self):
        fix = self.val / 2 ** self.right
        fix = np.round(fix)
        self.val = fix * 2 ** self.right

    # TODO: test, rounding not needed?
    def fixed_value(self):
        return int(np.round(self.val / 2 ** self.right))

    def __str__(self):
        return '{} [{}:{}]'.format(str(self.val), self.left, self.right)

    def __repr__(self):
        return self.__str__()

    def __float__(self):
        return float(self.val)

    def resize(self, left=0, right=0, type=None, overflow_style='SATURATE'):
        if type is not None:  # TODO: add tests
            left = type.left
            right = type.right
        return Sfix(self.val, left, right, overflow_style=overflow_style)

    def __add__(self, other):
        return Sfix(self.val + other.val,
                    max(self.left, other.left) + 1,
                    min(self.right, other.right),
                    init_only=True)

    def __sub__(self, other):
        if type(other) == float:
            other = Sfix(other, self.left, self.right)
        return Sfix(self.val - other.val,
                    max(self.left, other.left) + 1,
                    min(self.right, other.right),
                    init_only=True)

    def __mul__(self, other):
        if type(other) == float:
            other = Sfix(other, self.left, self.right)
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

    # TODO: add tests
    def __lt__(self, other):
        return self.val < other

    # TODO: add tests
    def __gt__(self, other):
        return self.val > other

    # TODO: add tests
    def __neg__(self):
        return Sfix(-self.val,
                    self.left + 1,
                    self.right,
                    init_only=True)

    # TODO: add tests
    def __len__(self):
        assert self.left >= 0
        return -self.right + self.left + 1


    def to_stdlogic(self):
        return 'std_logic_vector({} downto 0)'.format(self.left + abs(self.right))
