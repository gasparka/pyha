import logging
import math
from math import log2
import numpy as np

# mult:
# big * big
# 12451 * 52402 = 652457302 = 6.52457302 × 10^8
# 12451 = 1.2451 * 10^4
# 52402 = 5.2402 * 10^4
# 1.2451 * 5.2402  = 6.5246
# 4 + 4 = 8

# 12451 = 0.75994873 * 2 ** 14
# 52402 = 0.799591064 * 2 ** 16
# 0.75994873 * 0.799591064 = 0.607648214
# 14 + 16 = 30
# 0.607648214 * 2 ** 30
from pyha import Sfix
from pyha.common.util import to_twoscomplement

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('float')


# todo: should i use math.floor(fix) instead of int() ie. int() is wrong on negative numbers

def quantize(val, bits, rounding=False):
    if rounding:
        return round(val * 2 ** bits) / 2 ** bits
    else:
        # return round(val * 2 ** bits) / 2 ** bits
        return int(val * 2 ** bits) / 2 ** bits


def get_bits(val, bits):
    return to_twoscomplement(bits, int(val))


class Float:
    radix = 32
    use_float16 = False
    default_exponent_bits = 3
    default_fractional_bits = 14

    def __init__(self, val=0.0, exponent_bits=default_exponent_bits, fractional_bits=default_fractional_bits):
        self.init_val = val
        self.fractional_bits = fractional_bits
        self.exponent_bits = exponent_bits

        # print(self.use_float16)
        if self.use_float16:
            self.float_val = np.float16(val)
            return

        if isinstance(val, tuple):
            self.sign = val[0]
            self.exponent = val[1]
            self.fractional = val[2]
            self.normalize(lossy=True)
            self.fractional = quantize(self.fractional, self.fractional_bits, rounding=False)
        else:
            self.sign = int(val < 0)
            self.exponent = 0
            self.fractional = abs(float(val))
            # m, e = math.frexp(val)
            self.normalize(lossy=False)
            self.fractional = quantize(self.fractional, self.fractional_bits, rounding=True)

    def saturate(self):
        # todo: tests
        original = str(self)
        if self.exponent > (2 ** self.exponent_bits / 2 - 1):
            self.exponent = int(2 ** self.exponent_bits / 2 - 1)
            if self.fractional > 0:
                self.fractional = 1.0 - 2 ** -(self.fractional_bits)
            else:
                self.fractional = -1.0
            logger.warning(f'SATURATE1 {original} -> {self}')
        elif self.exponent < -(2 ** self.exponent_bits / 2):
            # self.exponent = int(-(2 ** self.exponent_bits / 2))
            self.exponent = 0
            self.fractional = 0.0
            # if self.fractional > 0:
            #     self.fractional = 1.0 - 2 ** -(self.fractional_bits)
            # else:
            #     self.fractional = -1.0
            logger.warning(f'SATURATE2 {original} -> {self}')

    def normalize(self, lossy=False):
        if self.fractional == 0: # TODO: test
            self.exponent = 0
            return
        max_fractional = 1.0 - 2 ** -(self.fractional_bits)
        min_fractional = (1 / Float.radix)
        while 0 < self.fractional < min_fractional:
            self.exponent -= 1
            self.fractional *= Float.radix
            if lossy:
                self.fractional = quantize(self.fractional, self.fractional_bits, rounding=False)

        while self.fractional > max_fractional:
            self.exponent += 1
            if lossy:
                coef = 2 ** self.fractional_bits
                self.fractional = (int(self.fractional * coef) // Float.radix) / coef
            else:
                self.fractional /= Float.radix

        self.saturate()

    def __float__(self):
        if self.use_float16:
            return float(self.float_val)
        return ((-1) ** self.sign) * self.fractional * Float.radix ** self.exponent

    def _get_exponent_bits(self):
        return to_twoscomplement(self.exponent_bits, self.exponent)

    def _get_fractional_bits(self):
        return to_twoscomplement(self.fractional_bits, int(self.fractional * 2 ** self.fractional_bits))

    def get_binary(self):
        ret = f'{"-" if self.sign else "+"}:{self._get_exponent_bits()}:{self._get_fractional_bits()}'
        return ret

    def __mul__(self, other):
        if self.use_float16:
            return Float(self.float_val * other.float_val)

        # return Float(float(self) * float(other))

        if isinstance(other, Sfix):
            new_exponent = self.exponent
            new_fractional = self.fractional * other.val
        else:
            new_exponent = self.exponent + other.exponent
            new_fractional = self.fractional * other.fractional

        new_sign = self.sign ^ other.sign

        if new_fractional == 0.0:
            new_exponent = 0

        # logger.info(f'Prequant: {to_twoscomplement(self.fractional_bits+1, int(new_fractional * 2 ** (self.fractional_bits - 1)))}')
        # new_fractional = int(new_fractional * 2 ** (self.fractional_bits*2 - 1)) / 2 ** (self.fractional_bits*2 - 1)
        # logger.info(f'Postquant: {to_twoscomplement(self.fractional_bits+1, int(new_fractional * 2 ** (self.fractional_bits - 1)))}')

        new = Float((new_sign, new_exponent, new_fractional), self.exponent_bits, self.fractional_bits)
        return new

    def __add__(self, other):
        if self.use_float16:
            return Float(self.float_val + other.float_val)

        guard = 0
        # return Float(float(self) + float(other))
        diff = abs(self.exponent - other.exponent)

        if self.exponent >= other.exponent:
            new_exponent = self.exponent
            a = ((-1) ** other.sign) * quantize(other.fractional / Float.radix ** diff, self.fractional_bits, rounding=False)
            b = ((-1) ** self.sign) * self.fractional
        else:
            new_exponent = other.exponent
            a = ((-1) ** self.sign) * quantize(self.fractional / Float.radix ** diff, self.fractional_bits, rounding=False)
            b = ((-1) ** other.sign) * other.fractional


        new_fractional = a + b
        new_fractional = quantize(new_fractional, self.fractional_bits, rounding=False)
        new_sign = 1 if new_fractional < 0 else 0
        new_fractional = abs(new_fractional)

        new = Float((new_sign, new_exponent, new_fractional), self.exponent_bits, self.fractional_bits)
        return new

    def __sub__(self, other):
        if self.use_float16:
            return Float(self.float_val - other.float_val)

        return Float(float(self) - float(other))
        diff = abs(self.exponent - other.exponent)

        if self.exponent >= other.exponent:
            new_exponent = self.exponent
            left_fract = self.fractional
            right_fract = other.fractional / Float.radix ** diff
        else:
            new_exponent = other.exponent
            left_fract = self.fractional / Float.radix ** diff
            right_fract = other.fractional

        # logger.info(f'Left fract: {to_twoscomplement(self.fractional_bits+1, int(left_fract * 2 ** (self.fractional_bits - 1)))}')
        # logger.info(f'right fract: {to_twoscomplement(self.fractional_bits+1, int(right_fract * 2 ** (self.fractional_bits - 1)))}')
        new_fractional = left_fract - right_fract

        # logger.info(f'Prequant: {to_twoscomplement(self.fractional_bits+1, int(new_fractional * 2 ** (self.fractional_bits - 1)))}')

        new_fractional = quantize(new_fractional, self.fractional_bits, rounding=False)
        # logger.info(f'Postquant: {to_twoscomplement(self.fractional_bits+1, int(new_fractional * 2 ** (self.fractional_bits - 1)))}')

        new = Float((new_exponent, new_fractional), self.exponent_bits, self.fractional_bits)
        return new

    def __call__(self, x: float):
        return Float(x, self.exponent_bits, self.fractional_bits)

    def __neg__(self):
        return Float(-float(self), self.exponent_bits, self.fractional_bits)

    def __str__(self):
        return f'{float(self):.15f} {self.get_binary()}'

    def __repr__(self):
        return str(self)

    def __format__(self, format_spec):
        return str(self)


class ComplexFloat:
    def __init__(self, val=0.0 + 0.0j, exponent_bits=Float.default_exponent_bits, fractional_bits=Float.default_fractional_bits):
        if isinstance(val, tuple):
            self.real = val[0]
            self.imag = val[1]
        else:
            self.real = Float(val.real, exponent_bits, fractional_bits)
            self.imag = Float(val.imag, exponent_bits, fractional_bits)

    def __add__(self, other):
        real = self.real + other.real
        imag = self.imag + other.imag
        return ComplexFloat((real, imag))

    def __sub__(self, other):
        real = self.real - other.real
        imag = self.imag - other.imag
        return ComplexFloat((real, imag))

    def __mul__(self, other):
        """ Complex multiplication!
        (x + yj)(u + vj) = (xu - yv) + (xv + yu)j
        Also support mult by float.
        """
        if isinstance(other, Float):
            real = self.real * other
            imag = self.imag * other
        else:
            # assert isinstance(other, ComplexFloat)
            real = (self.real * other.real) - (self.imag * other.imag)
            imag = (self.real * other.imag) + (self.imag * other.real)
        return ComplexFloat((real, imag))

    def __call__(self, x: float):
        return ComplexFloat(x, self.real.exponent_bits, self.real.fractional_bits)

    def __complex__(self):
        return float(self.real) + float(self.imag) * 1j
