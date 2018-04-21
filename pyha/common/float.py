from math import log2


def ilog2(A):
    """get  integer exponent of a floating-point value"""
    if A == 1.0 or A == 0.0:
        return 0
    N = 0
    Y = A
    if A > 1.0:
        while Y >= 2.0:
            Y = Y / 2.0
            N = N + 1
        return N

    # O < Y < 1
    while Y < 1.0:
        Y = Y * 2.0
        N = N - 1
    return N


class Float:
    def __init__(self, val):
        self.val = val
        self.sign = 0
        if val < 0.0:
            self.sign = 1
            val = -val

        self.exponent = ilog2(val)
        t = int(val * 2 ** (23)) # quantize
        self.mantissa = t / 2 ** (23 + self.exponent) - 1
        # self.mantissa = (val / (2.0 ** self.exponent)) - 1
        print(self.sign, self.exponent, self.mantissa)

    def __float__(self):
        res = (self.mantissa+1) * (2 ** self.exponent)
        if self.sign:
            res = -res
        return res

    def get_binary(self):
        '00111110100001010001111010111000'
        ret = f'{self.sign}:{self.exponent:08b}:{int(self.mantissa*2**24):023b}'
        return ret


    def __str__(self):
        return f'{float(self):.15f} {self.get_binary()}'

    def __repr__(self):
        return str(self)

    def __format__(self, format_spec):
        return str(self)
