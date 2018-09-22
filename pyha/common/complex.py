import logging
import math

from pyha.common.context_managers import SimPath
from pyha.common.fixed_point import Sfix

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('complex')

class Complex:
    """
    Complex number with ``.real`` and ``.imag`` elements. Default type is ``Complex(left=0, right=-17)``.

    :param val:
    :param left: left bound for both components
    :param right: right bound for both components
    :param overflow_style: 'wrap' (default) or 'saturate'.
    :param round_style: 'truncate' (default) or 'round'

    >>> a = Complex(0.45 + 0.88j, left=0, right=-17)
    >>> a
    0.45+0.88j [0:-17]
    >>> a.real
    0.4499969482421875 [0:-17]
    >>> a.imag
    0.8799972534179688 [0:-17]

    Another way to construct:

    >>> a = Sfix(-0.5, 0, -17)
    >>> b = Sfix(0.5, 0, -17)
    >>> Complex(a, b)
    -0.50+0.50j [0:-17]

    """
    __slots__ = ('round_style', 'overflow_style', 'right', 'left', 'val', 'wrap_is_ok', 'signed', 'bits', 'upper_bits')

    def __init__(self, val=0.0 + 0.0j, left=0, right=-17, overflow_style='wrap', round_style='truncate',
                 init_only=False, wrap_is_ok=False, signed=True, bits=None, upper_bits=None):

        self.upper_bits = upper_bits
        self.bits = bits
        self.signed = signed
        self.wrap_is_ok = wrap_is_ok
        self.round_style = round_style
        self.overflow_style = overflow_style
        self.right = right
        self.left = left
        self.val = val

        if init_only:
            return

        if isinstance(val, Sfix):
            self.val = float(val) + float(left)*1j
            self.left = val.left
            self.right = val.right

        if Sfix._float_mode.enabled:
            return

        self.quantize()
        if self.overflows():
            if self.overflow_style is 'saturate':
                self.saturate()
            elif self.overflow_style in 'wrap':
                self.wrap()
            else:
                raise Exception(f'Unknown overflow style {self.overflow_style}')

    @property
    def real(self):
        return Sfix(self.val.real, self.left, self.right, init_only=True)

    # @real.setter
    # def real(self, value):
    #     self.val = value.val + self.val.imag*1j
    #     self.fixed_effects()

    @property
    def imag(self):
        return Sfix(self.val.imag, self.left, self.right, init_only=True)

    # @imag.setter
    # def imag(self, value):
    #     self.val = self.val.real + value.val*1j
    #     self.fixed_effects()

    def max_representable(self):
        return 2 ** self.left - 2 ** self.right

    def min_representable(self):
        return -2 ** self.left

    def overflows(self):
        max = self.max_representable()
        min = self.min_representable()
        return self.val.real < min or self.val.imag < min or self.val.real > max or self.val.imag > max

    def saturate(self):
        max = self.max_representable()
        min = self.min_representable()
        real = self.val.real
        imag = self.val.imag

        if self.val.real > max:
            real = max
        elif self.val.real < min:
            real = min

        if self.val.imag > max:
            imag = max
        elif self.val.imag < min:
            imag = min

        self.val = real + imag * 1j

    def wrap(self):
        fmin = self.min_representable()
        fmax = 2 ** self.left  # no need to substract minimal step, 0.9998... -> 1.0 will still be wrapped as max bit pattern
        real = (self.val.real - fmin) % (fmax - fmin) + fmin
        imag = (self.val.imag - fmin) % (fmax - fmin) + fmin
        new_val = real + imag*1j

        logger.error(f'WRAP {self.val:g} -> {new_val:g}\t[{SimPath}]')
        self.val = new_val

    def quantize(self):
        fix = self.val / 2 ** self.right
        if self.round_style is 'round':
            fix = round(fix.real) + round(fix.imag) * 1j
        else:
            fix = math.floor(fix.real) + math.floor(fix.imag) * 1j

        self.val = fix * 2 ** self.right

    def resize(self, left=0, right=0, type=None, overflow_style='wrap', round_style='truncate', wrap_is_ok=False,
               signed=True):
        if type is not None:
            left = type.left
            right = type.right

        return Complex(self.val, left, right, overflow_style=overflow_style, round_style=round_style)

    def __complex__(self):
        return complex(self.val)

    def __eq__(self, other):
        if type(other) is type(self):
            return all([getattr(self, k) == getattr(other, k) for k in self.__slots__])
        return False

    def __call__(self, x, left=None, right=None):
        if left is None:
            left = self.left

        if right is None:
            right = self.right

        return Complex(complex(x), left, right, self.overflow_style,
                    self.round_style, False, self.wrap_is_ok, self.signed)

    def __len__(self):
        if self.signed:
            return -self.right + self.left + 1
        else:
            return -self.right + self.left

    def __str__(self):
        return '{:g} [{}:{}]'.format(complex(self), self.left, self.right)

    def __repr__(self):
        return str(self)

    def _pyha_to_python_value(self):
        return complex(self)

    def _convert_other_operand(self, other):
        if isinstance(other, complex):
            other = Complex(other, self.left, self.right, overflow_style='saturate', round_style='round',
                         signed=self.signed)
        elif isinstance(other, (float, int)):
            other = Sfix(other, self.left, self.right, overflow_style='saturate', round_style='round',
                         signed=self.signed)
        return other

    def __add__(self, other):
        other = self._convert_other_operand(other)
        left = max(self.left, other.left) + 1
        right = min(self.right, other.right)
        return Complex(self.val + other.val,
                       left,
                       right,
                       init_only=True)

    def __radd__(self, other):
        return self.__add__(other)

    def __sub__(self, other):
        other = self._convert_other_operand(other)
        left = max(self.left, other.left) + 1
        right = min(self.right, other.right)
        return Complex(self.val - other.val,
                       left,
                       right,
                       init_only=True)

    def __rsub__(self, other):
        other = self._convert_other_operand(other)
        return other.__sub__(self)

    def __mul__(self, other):
        """ Complex multiplication!
        (x + yj)(u + vj) = (xu - yv) + (xv + yu)j
        Also support mult by float.
        """
        other = self._convert_other_operand(other)
        extra_bit = 1 # for complex mult, from addition
        if isinstance(other, (Sfix, float)):
            extra_bit = 0 # for real mult

        left = (self.left + other.left + 1) + extra_bit
        right = self.right + other.right
        return Complex(self.val * other.val,
                       left,
                       right,
                       init_only=True)

    def __rshift__(self, other):
        return Complex(self.val / 2 ** other, self.left, self.right)

    def __lshift__(self, other):
        # TODO: how to handle this in model code, should it always wrap?
        return Complex(self.val * 2 ** other, self.left, self.right)

    def scalb(self, i):
        n = 2 ** i
        return Complex(self.val * n, self.left + i, self.right + i, overflow_style='saturate', round_style='round')

    @staticmethod
    def default():
        return default_complex


default_complex = Complex(0, 0, -17, overflow_style='saturate', round_style='round')
