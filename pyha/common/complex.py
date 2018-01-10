from pyha.common.core import Hardware
from pyha.common.fixed_point import Sfix


class Complex(Hardware):
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

    def __init__(self, val=0.0 + 0.0j, left=None, right=None, overflow_style='wrap',
                 round_style='truncate'):

        if type(val) is Sfix and type(left) is Sfix:
            self.real = val
            self.imag = left
        else:
            self.real = Sfix(val.real, left, right, overflow_style, round_style)
            self.imag = Sfix(val.imag, left, right, overflow_style, round_style)

    def __complex__(self):
        return float(self.real) + float(self.imag) * 1j

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False

    def __call__(self, x):
        return Complex(x, self.real.left, self.real.right, self.real.overflow_style, self.real.round_style)

    def __str__(self):
        return '{:g} [{}:{}]'.format(complex(self), self.real.left, self.real.right)

    def __repr__(self):
        return str(self)

    def _pyha_to_python_value(self):
        return complex(self)


default_complex = Complex(0, 0, -17, overflow_style='saturate', round_style='round')
