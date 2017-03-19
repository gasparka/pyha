import logging
import textwrap

import numpy as np

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

fixed_truncate = 'fixed_truncate'
fixed_round = 'fixed_round'

fixed_saturate = 'fixed_saturate'
fixed_wrap = 'fixed_wrap'


class ComplexSfix:
    """
    Use real and imag members to access underlying Sfix elements.

    :param val:
    :param left: left bound for both components
    :param right: right bound for both components
    :param overflow_style: fixed_saturate(default) or fixed_wrap

    >>> a = ComplexSfix(0.45 + 0.88j, left=0, right=-17)
    >>> a
    0.45+0.88j [0:-17]
    >>> a.real
    0.4499969482421875 [0:-17]
    >>> a.imag
    0.8799972534179688 [0:-17]

    Another way to construct it:

    >>> a = Sfix(-0.5, 0, -17)
    >>> b = Sfix(0.5, 0, -17)
    >>> ComplexSfix(a, b)
    -0.50+0.50j [0:-17]


    """

    def __init__(self, val=0.0 + 0.0j, left=None, right=None, overflow_style=fixed_saturate,
                 round_style=fixed_round):

        self.overflow_style = overflow_style
        self.round_style = round_style
        if type(val) is Sfix and type(left) is Sfix:
            self.init_val = val.init_val + left.init_val * 1j
            self._real = val
            self._imag = left
        else:
            self.init_val = val
            self._real = Sfix(val.real, left, right, overflow_style, round_style)
            self._imag = Sfix(val.imag, left, right, overflow_style, round_style)

    @property
    def imag(self):
        return self._imag

    @imag.setter
    def imag(self, value):
        from pyha.common.hwsim import auto_resize
        self._imag = auto_resize(self._imag, value)

    @property
    def real(self):
        return self._real

    @real.setter
    def real(self, value):
        from pyha.common.hwsim import auto_resize
        self._real = auto_resize(self._real, value)

    @property
    def left(self):
        assert self._real.left == self._imag.left
        return self._real.left

    @property
    def right(self):
        assert self._real.right == self._imag.right
        return self._real.right

    @property
    def val(self):
        return self._real.val + self._imag.val * 1j

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False

    def __call__(self, x):
        return ComplexSfix(x, self.left, self.right)

    def __str__(self):
        return f'{self._real.val:.2f}{"" if self._imag.val < 0.0 else "+"}{self._imag.val:.2f}j [{self.left}:{self.right}]'

    def __repr__(self):
        return str(self)

    def has_same_bounds(self, other):
        if self.left == other.left and self.right == other.right:
            return True
        return False

    def bitwidth(self):
        return (self.left + abs(self.right)) * 2 + 2

    def __len__(self):
        return self.bitwidth()

    def to_stdlogic(self):
        return f'std_logic_vector({self.bitwidth() - 1} downto 0)'

    def vhdl_reset(self):
        return f'(real=>{self._real.vhdl_reset()}, imag=>{self._imag.vhdl_reset()})'

    def fixed_value(self):
        assert self.bitwidth() <= 64  # must fit into numpy int, this is cocotb related?
        real = self._real.fixed_value()
        imag = self._imag.fixed_value()
        mask = (2 ** (self.bitwidth() // 2)) - 1
        return ((real & mask) << (self.bitwidth() // 2)) | (imag & mask)

    def vhdl_type_name(self):
        from pyha.conversion.coupling import pytype_to_vhdl
        return pytype_to_vhdl(self)

    def vhdl_type_define(self):
        dtype = f'sfixed({self.left} downto {self.right})'
        return textwrap.dedent(f"""\
            type {self.vhdl_type_name()} is record
                real: {dtype};
                imag: {dtype};
            end record;
            function ComplexSfix(a, b: sfixed({self.left} downto {self.right})) return {self.vhdl_type_name()};
            """)

    def vhdl_init_function(self):
        return textwrap.dedent(f"""\
            function ComplexSfix(a, b: sfixed({self.left} downto {self.right})) return {self.vhdl_type_name()} is
            begin
                return (a, b);
            end function;
            """)


# TODO: Verify stuff against VHDL library
class Sfix:
    """
    Signed fixed point type, like to_sfixed() in VHDL. Basic arithmetic operations
    are defined for this class.

    More info: https://www.dsprelated.com/showarticle/139.php

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

    # original idea was to use float for internal computations, now it has turned out that\
    # it is hard to match VHDL fixed point library outputs, thus in the future it may be better
    # to implement stuff as integer arithmetic

    # Disables all quantization and saturating stuff
    _float_mode = False

    # TODO: finish this, there is unit test for it
    # @staticmethod
    # def auto_size(val, bits):
    #     """
    #     Find optimal sfixed format for value
    #
    #     :param val: May be list, then format is optimal including all elements
    #     :param bits:
    #     :return:
    #     """
    #     # FIXME: int_bits possibly not correct, since we cannot reporesent max positive value, actuall maximum value is (max_int) - (frac_min)
    #     # calculates for signed type
    #     if type(val) is list:
    #         maxabs = max(abs(x) for x in val)
    #         int_bits = np.floor(np.log2(np.abs(maxabs))) + 1
    #         fract_bits = -bits + int_bits + 1
    #         ret = [Sfix(x, int_bits, fract_bits) for x in val]
    #         return [Sfix(x, int_bits, fract_bits) for x in val]
    #     else:
    #         int_bits = np.floor(np.log2(np.abs(val))) + 1
    #         fract_bits = -bits + int_bits + 1
    #         return Sfix(val, int_bits, fract_bits)

    @staticmethod
    def set_float_mode(x):
        """
        Can be used to turn off all quantization effects, useful for debugging.

        :param x: True/False
        """
        Sfix._float_mode = x

    def __init__(self, val=0.0, left=None, right=None, overflow_style=fixed_saturate,
                 round_style=fixed_round, init_only=False):

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

        if left is None or right is None:
            return

        assert self.left >= self.right
        # FIXME: This sucks, init should not call these anyways, make to_sfixed function
        if init_only or Sfix._float_mode:
            return

        if overflow_style is fixed_saturate:
            if self.overflows() and overflow_style:
                self.saturate()
            else:
                self.quantize()
        elif overflow_style in fixed_wrap:  # TODO: add tests
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

        if self.round_style is fixed_round:
            fix = round(fix)
            # fix = np.round(fix)
        else:
            fix = int(fix)

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

    def resize(self, left=0, right=0, type=None, overflow_style=fixed_saturate, round_style=fixed_round):
        if type is not None:  # TODO: add tests
            left = type.left
            right = type.right
        return Sfix(self.val, left, right, overflow_style=overflow_style, round_style=round_style)


    @staticmethod
    def max(a, b):
        if a is None:
            return b
        if b is None:
            return a

        return max(a, b)

    @staticmethod
    def min(a, b):
        if a is None:
            return b
        if b is None:
            return a

        return min(a, b)

    def __add__(self, other):
        if type(other) == float:
            other = Sfix(other, self.left, self.right)

        return Sfix(self.val + other.val,
                    self.max(self.left, other.left) + 1,
                    self.min(self.right, other.right),
                    init_only=True)

    def __sub__(self, other):
        if type(other) == float:
            other = Sfix(other, self.left, self.right)
        return Sfix(self.val - other.val,
                    self.max(self.left, other.left) + 1,
                    self.min(self.right, other.right),
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
        # todo: in float mode this should not lose precison
        o = int(self.val / 2 ** self.right)
        o = (o >> other) * 2 ** self.right
        return Sfix(o,
                    self.left,
                    self.right,
                    init_only=True)

    def __lshift__(self, other):
        # todo: in float mode this should not lose precison
        o = int(self.val / 2 ** self.right)
        o = (o << other) * 2 ** self.right
        return Sfix(o,
                    self.left,
                    self.right,
                    overflow_style=fixed_wrap)

    def __abs__(self):
        return Sfix(abs(self.val),
                    self.left + 1,
                    self.right,
                    init_only=True)

    # TODO: add tests
    def __lt__(self, other):
        return bool(self.val < other)

    # TODO: add tests
    def __gt__(self, other):
        return bool(self.val > other)

    # TODO: add tests
    def __neg__(self):
        left = None if self.left is None else self.left + 1
        return Sfix(-self.val,
                    left,
                    self.right,
                    init_only=True)

    # TODO: add tests
    def __len__(self):
        assert self.left >= 0
        return -self.right + self.left + 1

    def __call__(self, x: float):
        return Sfix(x, self.left, self.right)

    def to_stdlogic(self):
        return f'std_logic_vector({self.left + abs(self.right)} downto 0)'

    def vhdl_reset(self):
        return f'Sfix({self.init_val}, {self.left}, {self.right})'


def resize(fix, left_index=0, right_index=0, size_res=None, overflow_style=fixed_saturate, round_style=fixed_round):
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
    n = 2 ** i
    return Sfix(x.val * n, x.left + i, x.right + i)
