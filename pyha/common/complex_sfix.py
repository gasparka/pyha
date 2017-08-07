from pyha.common.hwsim import HW
from pyha.common.sfix import fixed_saturate, fixed_round, Sfix
from pyha.conversion.conversion_types import VHDLModule


class ComplexSfixPy:
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
    >>> ComplexSfixPy(a, b)
    -0.50+0.50j [0:-17]


    """

    def __init__(self, val=0.0 + 0.0j, left=None, right=None, overflow_style=fixed_saturate,
                 round_style=fixed_round):

        if type(val) is Sfix and type(left) is Sfix:
            self.real = val
            self.imag = left
        else:
            self.real = Sfix(val.real, left, right, overflow_style, round_style)
            self.imag = Sfix(val.imag, left, right, overflow_style, round_style)

    @property
    def left(self):
        assert self.real.left == self.imag.left
        return self.real.left

    @property
    def right(self):
        assert self.real.right == self.imag.right
        return self.real.right

    @property
    def val(self):
        return self.real.val + self.imag.val * 1j

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False

    def __call__(self, x, **kwargs):
        return ComplexSfix(x, self.left, self.right, **kwargs)

    def __str__(self):
        return f'{self.real.val:.5f}{"" if self.imag.val < 0.0 else "+"}{self.imag.val:.5f}j [{self.left}:{self.right}]'

    def __repr__(self):
        return str(self)

    def has_same_bounds(self, other):
        if self.left == other.left and self.right == other.right:
            return True
        return False


class ComplexModule(VHDLModule):
    def _pyha_to_python_value(self):
        return self.current.val

    def _pyha_deserialize(self, serial):
        o = super()._pyha_deserialize(serial)
        return o.real + o.imag * 1j


class ComplexSfix(HW, ComplexSfixPy):
    _pyha_converter = ComplexModule

    def __init__(self, val=0.0 + 0.0j, left=None, right=None, overflow_style=fixed_saturate, round_style=fixed_round):
        super().__init__(val, left, right, overflow_style, round_style)


default_complex_sfix = ComplexSfix(0, 0, -17)
