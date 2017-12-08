import logging

import numpy as np
from pyha.common.context_managers import ContextManagerRefCounted

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class Sfix:
    """
    Signed fixed point type, like to_sfixed() in VHDL. Basic arithmetic operations
    are defined for this class.

    :param val: initial value
    :param left: bits for integer part.
    :param right: bits for fractional part. This is negative number.
    :param init_only: internal use only
    :param overflow_style: fixed_saturate(default) or fixed_wrap
    :param round_style: fixed_round(default) or fixed_truncate

    >>> Sfix(0.123, left=0, right=-17)
    0.1230010986328125 [0:-17]
    >>> Sfix(0.123, left=0, right=-7)
    0.125 [0:-7]

    >>> Sfix(2.5, left=0, right=-17)
    WARNING:pyha.common.sfix:Saturation 2.5 -> 0.9999923706054688
    0.9999923706054688 [0:-17]
    >>> Sfix(2.5, left=1, right=-17)
    WARNING:pyha.common.sfix:Saturation 2.5 -> 1.9999923706054688
    1.9999923706054688 [1:-17]
    >>> Sfix(2.5, left=2, right=-17)
    2.5 [2:-17]

    """

    # Disables all quantization and saturating stuff
    _float_mode = ContextManagerRefCounted()


    # @staticmethod
    # def set_float_mode(x):
    #     """
    #     Can be used to turn off all quantization effects, useful for debugging.
    #
    #     :param x: True/False
    #     """
    #     Sfix._float_mode = x

    def __init__(self, val=0.0, left=None, right=None, overflow_style='wrap',
                 round_style='truncate', init_only=False):

        self.round_style = round_style
        self.overflow_style = overflow_style

        val = float(val)

        if isinstance(left, Sfix):
            self.right = left.right
            self.left = left.left
        else:
            self.right = right
            self.left = left

        self.val = val
        self.init_val = val

        if self.left is None or self.right is None:
            return

        assert self.left >= self.right
        # FIXME: This sucks, init should not call these anyways, make to_sfixed function
        if init_only or Sfix._float_mode.enabled:
            return

        if overflow_style is 'saturate':
            if self.overflows() and overflow_style:
                self.saturate()
            else:
                self.quantize()
        elif overflow_style in 'wrap':
            self.quantize()
            self.wrap()
        else:
            raise Exception('Wtf')

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False

    def max_representable(self):
        if self.left < 0:
            # FIXME: I am not sure how to handle this when negative index
            # assert 0

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

    def is_lazy_init(self):
        return self.left == 0 and self.right == 0

    def saturate(self):
        old = self.val
        if self.val > self.max_representable():
            self.val = self.max_representable()
        elif self.val < self.min_representable():
            self.val = self.min_representable()
        else:
            assert False
        if not self.is_lazy_init() and not old == 1.0:
            logger.warning(f'Saturation {old} -> {self.val}')

    def wrap(self):
        fmin = self.min_representable()
        fmax = 2 ** self.left  # no need to substract minimal step, 0.9998... -> 1.0 will still be wrapped as max bit pattern
        self.val = (self.val - fmin) % (fmax - fmin) + fmin

    def quantize(self):
        fix = self.val / 2 ** self.right
        if self.round_style is 'round':
            fix = round(fix)
        else:
            # this used to be int(fix), but this is a bug when fix is negative
            fix = np.floor(fix)

        self.val = fix * 2 ** self.right

    # TODO: test, rounding not needed?
    def fixed_value(self):
        return int(np.round(self.val / 2 ** self.right))

    # def from_fixed(self, val, right):
    #     return (val * 2 ** self.outputs[i].right)

    def __str__(self):
        return f'{str(self.val)} [{self.left}:{self.right}]'

    def __repr__(self):
        return self.__str__()

    def __float__(self):
        return float(self.val)

    def __int__(self):
        return int(np.floor(self.val))

    def resize(self, left=0, right=0, type=None, overflow_style='wrap', round_style='truncate'):
        if type is not None:  # TODO: add tests
            left = type.left
            right = type.right
        return Sfix(self.val, left, right, overflow_style=overflow_style, round_style=round_style)

    def _size_add(self, other):
        """ Size rules for add/sub operation. Handles the 'None'(lazy) cases. """
        if self.left is None and other.left is None:
            left = None
        elif self.left is None:
            left = other.left + 1
        elif other.left is None:
            left = self.left + 1
        else:
            left = max(self.left, other.left) + 1
        if self.right is None and other.right is None:
            right = None
        elif self.right is None:
            right = other.right
        elif other.right is None:
            right = self.right
        else:
            right = min(self.right, other.right)
        return left, right

    def __add__(self, other):
        if type(other) == float:
            other = Sfix(other, self.left, self.right, overflow_style='saturate', round_style='round')

        left, right = self._size_add(other)

        return Sfix(self.val + other.val,
                    left,
                    right,
                    init_only=True)

    def __radd__(self, other):
        return self.__add__(other)

    def __sub__(self, other):
        if type(other) == float:
            other = Sfix(other, self.left, self.right, overflow_style='saturate', round_style='round')

        left, right = self._size_add(other)

        return Sfix(self.val - other.val,
                    left,
                    right,
                    init_only=True)

    def __rsub__(self, other):
        if type(other) == float:
            other = Sfix(other, self.left, self.right, overflow_style='saturate', round_style='round')
        return other.__sub__(self)

    def __mul__(self, other):
        if type(other) == float:
            other = Sfix(other, self.left, self.right, overflow_style='saturate', round_style='round')

        if self.left is None and other.left is None:
            left = None
        elif self.left is None:
            left = other.left + 1
        elif other.left is None:
            left = self.left + 1
        else:
            left = self.left + other.left + 1

        if self.right is None and other.right is None:
            right = None
        elif self.right is None:
            right = other.right
        elif other.right is None:
            right = self.right
        else:
            right = self.right + other.right

        return Sfix(self.val * other.val,
                    left,
                    right,
                    init_only=True)

    def sign_bit(self):
        s = np.sign(self.val)
        if s in [0, 1]:
            return 0
        return 1

    def __rshift__(self, other):
        if self.right is None or Sfix._float_mode.enabled:
            o = np.ldexp(self.val, -other)
        else:
            o = int(self.val / 2 ** self.right)
            o = (o >> other) * 2 ** self.right
        # THIS CAN WRAP!
        return Sfix(o, self.left, self.right)

    def __lshift__(self, other):
        if self.right is None or Sfix._float_mode.enabled:
            o = np.ldexp(self.val, other)
        else:
            o = int(self.val / 2 ** self.right)
            o = (o << other) * 2 ** self.right
        # THIS CAN WRAP!
        return Sfix(o, self.left, self.right)

    def __abs__(self):
        return Sfix(abs(self.val),
                    self.left + 1,
                    self.right,
                    init_only=True)

    def __lt__(self, other):
        return bool(self.val < other)

    def __gt__(self, other):
        return bool(self.val > other)

    def __neg__(self):
        left = None if self.left is None else self.left + 1
        return Sfix(-self.val,
                    left,
                    self.right,
                    init_only=True)

    def __len__(self):
        return -self.right + self.left + 1

    def __call__(self, x: float):
        return Sfix(x, self.left, self.right, self.overflow_style,
                 self.round_style)


# default are 'saturate' and 'round' as this is the case in VHDL lib....
def resize(fix, left_index=0, right_index=0, size_res=None, overflow_style='saturate', round_style='round'):
    """
    Resize fixed point number.

    :param fix: Sfix object to resize
    :param left_index: new left bound
    :param right_index: new right bound
    :param size_res: provide another Sfix object as size reference
    :param overflow_style: fixed_saturate(default) or fixed_wrap
    :param round_style: fixed_round(default) or fixed_truncate
    :return: New resized Sfix object

    >>> a = Sfix(0.89, left=0, right=-17)
    >>> a
    0.8899993896484375 [0:-17]
    >>> b = resize(a, 0, -6)
    >>> b
    0.890625 [0:-6]

    >>> c = resize(a, size_res=b)
    >>> c
    0.890625 [0:-6]


    """
    if isinstance(fix, (float, int)):
        if size_res is not None:
            left_index = size_res.left
            right_index = size_res.right
        return Sfix(fix, left_index, right_index, overflow_style=overflow_style, round_style=round_style)

    return fix.resize(left_index, right_index, size_res, overflow_style=overflow_style, round_style=round_style)


def left_index(x: Sfix):
    """
    Use this in convertible code

    :return: left bound

    >>> a = Sfix(-0.5, 1, -7)
    >>> left_index(a)
    1

    """
    return x.left


def right_index(x: Sfix):
    """
    Use this in convertible code

    :return: right bound

    >>> a = Sfix(-0.5, 1, -7)
    >>> right_index(a)
    -7
    """
    return x.right


def scalb(x: Sfix, i: int):
    """
    Shift decimal point by i, basically it performs shift operation without losing precison

    >>> a = Sfix(0.5, 0, -17)
    >>> a
    0.5 [0:-17]
    >>> scalb(a, 8)
    128.0 [8:-9]
    >>> scalb(a, -8)
    0.001953125 [-8:-25]
    """
    n = 2 ** i
    return Sfix(x.val * n, x.left + i, x.right + i, overflow_style='saturate', round_style='round')
