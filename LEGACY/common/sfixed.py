import logging
import math

import numpy as np


# TODO: this file is deprecated as fuck, but used in some places
# logging.basicConfig(level=logging.INFO)
# logger = logging.getLogger(__name__)


class Fixed:
    def __init__(self):
        pass


def real_max(base):
    base -= 1  # 1 sign bit
    max_val = 1 - math.pow(2, -base)
    return max_val


def real_min(base):
    return -1


def saturate_sfixed(x, base):
    base -= 1  # 1 sign bit
    max_val = math.pow(2, base) - 1
    min_val = -math.pow(2, base)

    xb = np.copy(x)
    x.real[x.real > max_val] = max_val
    x.imag[x.imag > max_val] = max_val

    x.real[x.real < min_val] = min_val
    x.imag[x.imag < min_val] = min_val

    if (x != xb).any():
        logging.warning('Saturation happened!')
        logging.info('{} -> \n {}'.format(xb, x))

    return x


def saturate_float(x, base):
    base -= 1  # 1 sign bit
    max_val = 1 - math.pow(2, -base)
    min_val = -1
    if x > max_val:
        x = max_val

    if x < min_val:
        x = min_val

    return x


def saturate_real(x, base):
    base -= 1  # 1 sign bit
    max_val = 1 - math.pow(2, -base)
    min_val = -1

    xb = np.copy(x)
    x[x.real > max_val] = max_val
    x[x.real < min_val] = min_val

    if (x != xb).any():
        logging.warning('Saturation happened!')
        logging.info('{} -> \n {}'.format(xb, x))

    return x


def saturate(x, base):
    """
    >>> x = np.array([2, 0.5, -3j, 1-1j], dtype=np.complex)
    >>> saturate(x, 12)
    array([ 0.99951172+0.j,  0.50000000+0.j, -0.00000000-1.j,  0.99951172-1.j])

    >>> saturate(x, 4)
    array([ 0.875+0.j,  0.500+0.j, -0.000-1.j,  0.875-1.j])

    """
    base -= 1  # 1 sign bit
    max_val = 1 - math.pow(2, -base)
    min_val = -1

    xb = np.copy(x)
    x.real[x.real > max_val] = max_val
    x.imag[x.imag > max_val] = max_val

    x.real[x.real < min_val] = min_val
    x.imag[x.imag < min_val] = min_val

    if (x != xb).any():
        logging.warning('Saturation happened!')
        logging.info('{} -> \n {}'.format(xb, x))

    return x


def to_sfixed_real(x, base):
    x = saturate_real(x, base)
    x *= math.pow(2, base - 1)
    x = np.round(x)
    return x


def to_sfixed(x, base):
    """
    Saturates first
    >>> x = np.array([2, 0.5, -3j, 1-1j], dtype=np.complex)
    >>> to_sfixed(x, 12)
    array([ 2047.   +0.j,  1024.   +0.j,     0.-2048.j,  2047.-2048.j])

    """
    x = saturate(x, base)
    x *= math.pow(2, base - 1)
    x = np.round(x)
    return x


def to_real(x, base):
    """
    >>> x = np.array([0.2, 0.5, -0.003j, 0.1-0.1j], dtype=np.complex)
    >>> fix = to_sfixed(x,8)
    >>> fix
    array([ 26. +0.j,  64. +0.j,   0. -0.j,  13.-13.j])
    >>> to_real(fix, 8)
    array([ 0.2031250+0.j       ,  0.5000000+0.j       ,  0.0000000-0.j       ,
            0.1015625-0.1015625j])

    >>> x = np.array([0.2, 0.5, -0.003j, 0.1-0.1j], dtype=np.complex)
    >>> fix = to_sfixed(x,18)
    >>> to_real(fix, 18)
    array([ 0.19999695+0.j        ,  0.50000000+0.j        ,
            0.00000000-0.00299835j,  0.09999847-0.09999847j])

    """
    x /= math.pow(2, base - 1)
    return x


# x = np.array([2, 0.5, -3j, 1-1j], dtype=np.complex)
# to_sfixed(x, 12)

# def test_saturate():
#     x = np.array([2, 1, -3j], dtype=np.complex)
#     assert (str(saturate(x, 12)) == '[ 0.99951172+0.j  0.99951172+0.j  0.00000000-1.j]')
#
# # test_saturate()





# def to_sfixed(x, base):
#     base -= 1  # 1 sign bit
#     max_val = 1 - math.pow(2, -base)
#     min_val = -1
#     if x > max_val:
#         logging.warning('Saturation {0} to MAX({1})'.format(x, max_val))
#         x = max_val
#     elif x < min_val:
#         logging.warning('Saturation {0} to MAX({1})'.format(x, min_val))
#         x = min_val
#     return int(round(x * math.pow(2, base)))




if __name__ == "__main__":
    import doctest

    doctest.testmod()
