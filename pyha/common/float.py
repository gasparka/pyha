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

    # 00000110001001001101110 201326
    # 196608.0
    # 201216.0
    def __init__(self, val):
        self.init_val = val
        self.sign = 0
        if val < 0.0:
            self.sign = 1
            val = -val

        self.exponent = ilog2(val)
        self.mantissa = (val / 2 ** self.exponent) - 1
        self.mantissa = int(self.mantissa * 2 ** 23) / 2 ** 23 # quantize
        # self.val = float(self)

        # print(self.sign, self.exponent, self.mantissa)

    def __mul__(self, other):
        return Float(float(self) * float(other))

    def __add__(self, other):
        diff = abs(self.exponent - other.exponent)
        # other = float(other) * 2 ** 26
        # self.mantissa += (other.mantissa / 2 ** 26)
        # self.mantissa = int(self.mantissa * 2 ** 23) / 2 ** 23 # quantize
        new = Float(self.init_val)
        new.mantissa = ((new.mantissa + 1) - ((other.mantissa + 1) / 2 ** diff)) - 1
        new.mantissa = int(new.mantissa * 2 ** 23) / 2 ** 23 # quantize
        print(new)

        from mpmath import mp, mpf
        mp.prec = 26

        r = mpf(0.1) - mpf(0.01)

        #                  0.089999988675117 0:01111011:01110000101000111101010
        # <class 'list'>: [0.089999996125698 0:01111011:01110000101000111101011, 0.109999991953373 0:01111011:11000010100011110101101]
        return Float(float(self) + float(other))

    def __float__(self):
        res = (self.mantissa+1) * (2 ** self.exponent)
        if self.sign:
            res = -res
        return res

    def get_binary(self):
        '00111110100001010001111010111000'
        ret = f'{self.sign}:{self.exponent+127:08b}:{int(self.mantissa*2**23):023b}'
        return ret

    def __str__(self):
        return f'{float(self):.15f} {self.get_binary()}'

    def __repr__(self):
        return str(self)

    def __format__(self, format_spec):
        return str(self)
