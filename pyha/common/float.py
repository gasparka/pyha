import logging
from math import log2

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
from pyha.common.util import to_twoscomplement
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('float')

def quantize(val, bits, rounding=False):
    if rounding:
        return int(round(val * 2 ** bits)) / 2 ** bits
    else:
        return int(val * 2 ** bits) / 2 ** bits

def get_bits(val, bits):
    return to_twoscomplement(bits, int(val))

class Float:

    # 00000110001001001101110 201326
    # 196608.0
    # 201216.0
    def __init__(self, val=0.0, exponent_bits=6, fractional_bits=9):
        self.init_val = val
        self.fractional_bits = fractional_bits
        self.exponent_bits = exponent_bits

        if isinstance(val, tuple):
            self.exponent = val[0]
            self.fractional = val[1]
            self.normalize(lossy=True)
            self.fractional = quantize(self.fractional, self.fractional_bits - 1, rounding=False)
        else:
            self.exponent = 0
            self.fractional = val
            self.normalize(lossy=False)
            self.fractional = quantize(self.fractional, self.fractional_bits - 1, rounding=True)

    def normalize(self, lossy=False):
        max_fractional = 1.0 - 2 ** -(self.fractional_bits - 1)
        min_fractional = -1.0

        while 0 < self.fractional < 0.5 or 0 > self.fractional >= -0.5:
            self.exponent -= 1
            if lossy:
                self.fractional = (int(self.fractional * 2 ** (self.fractional_bits - 1)) * 2) / 2 ** (self.fractional_bits - 1)
            else:
                self.fractional *= 2

        while self.fractional > max_fractional or self.fractional < min_fractional:
            self.exponent += 1
            if lossy:
                self.fractional = (int(self.fractional * 2 ** (self.fractional_bits - 1)) // 2) / 2 ** (self.fractional_bits - 1)
            else:
                self.fractional /= 2

        assert self.exponent <= (2**self.exponent_bits/2-1)
        assert self.exponent >= -(2**self.exponent_bits/2)

    def __float__(self):
        return self.fractional * 2 ** self.exponent

    def _get_exponent_bits(self):
        return to_twoscomplement(self.exponent_bits, self.exponent)

    def _get_fractional_bits(self):
        return to_twoscomplement(self.fractional_bits, int(self.fractional * 2 ** (self.fractional_bits - 1)))

    def get_binary(self):
        ret = f'{self._get_exponent_bits()}:{self._get_fractional_bits()}'
        return ret

    def __mul__(self, other):
        new_exponent = self.exponent + other.exponent
        new_fractional = self.fractional * other.fractional
        new_fractional = int(new_fractional * 2 ** (self.fractional_bits - 1)) / 2 ** (self.fractional_bits - 1)
        new = Float((new_exponent, new_fractional), self.exponent_bits, self.fractional_bits)
        return new

    def __add__(self, other):
        diff = abs(self.exponent - other.exponent)

        if self.exponent >= other.exponent:
            new_exponent = self.exponent
            new_fractional = self.fractional + (other.fractional / 2 ** diff)
        else:
            new_exponent = other.exponent
            new_fractional = other.fractional + (self.fractional / 2 ** diff)

        # logger.info(f'Prequant: {to_twoscomplement(self.fractional_bits+1, int(new_fractional * 2 ** (self.fractional_bits - 1)))}')

        new_fractional = quantize(new_fractional, self.fractional_bits - 1, rounding=False)
        # logger.info(f'Postquant: {to_twoscomplement(self.fractional_bits+1, int(new_fractional * 2 ** (self.fractional_bits - 1)))}')


        new = Float((new_exponent, new_fractional), self.exponent_bits, self.fractional_bits)
        return new

    def __sub__(self, other):
        diff = abs(self.exponent - other.exponent)

        if self.exponent >= other.exponent:
            new_exponent = self.exponent
            left_fract = self.fractional
            right_fract = quantize(other.fractional / 2 ** diff, self.fractional_bits - 1, rounding=False)
        else:
            new_exponent = other.exponent
            left_fract = quantize(self.fractional / 2 ** diff, self.fractional_bits - 1, rounding=False)
            right_fract = other.fractional

        logger.info(f'Left fract: {to_twoscomplement(self.fractional_bits+1, int(left_fract * 2 ** (self.fractional_bits - 1)))}')
        logger.info(f'right fract: {to_twoscomplement(self.fractional_bits+1, int(right_fract * 2 ** (self.fractional_bits - 1)))}')
        new_fractional = left_fract - right_fract

        logger.info(f'Prequant: {to_twoscomplement(self.fractional_bits+1, int(new_fractional * 2 ** (self.fractional_bits - 1)))}')

        new_fractional = quantize(new_fractional, self.fractional_bits - 1, rounding=False)
        logger.info(f'Postquant: {to_twoscomplement(self.fractional_bits+1, int(new_fractional * 2 ** (self.fractional_bits - 1)))}')


        new = Float((new_exponent, new_fractional), self.exponent_bits, self.fractional_bits)
        return new

    def __neg__(self):
        return Float(-float(self), self.exponent_bits, self.fractional_bits)

    def __str__(self):
        return f'{float(self):.15f} {self.get_binary()}'

    def __repr__(self):
        return str(self)

    def __format__(self, format_spec):
        return str(self)


class ComplexFloat:
    def __init__(self, val=0.0 + 0.0j, exponent_bits=6, fractional_bits=10):
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
        real = (self.real * other.real) - (self.imag * other.imag)
        imag = (self.real * other.imag) + (self.imag * other.real)
        return ComplexFloat((real, imag))

    def __complex__(self):
        return float(self.real) + float(self.imag) * 1j
