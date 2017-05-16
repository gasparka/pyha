Fixed-point
===========

Pyha maps fixed-point operations almost directly to `VHDL fixed point library`_

.. _VHDL fixed point library: https://github.com/FPHDL/fphdl


.. py:class:: pyha.common.sfix.Sfix(val=0.0, left=0, right=0, init_only=False, overflow_style='fixed_saturate', round_style='fixed_round')

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

.. py:staticmethod:: set_float_mode(x)

    Can be used to turn off all quantization effects, useful for debugging.

    :param x: True/False

..
    RTD wont support Python 3.6 yet!
    automodule:: pyha.common.sfix
    :members: Sfix


Complex numbers
---------------

Puha supports complex numbers for interfacing means, arithmetic operations are not defined.
Use :code:`.real` and :code:`.imag` to do maths.


.. py:class:: pyha.common.sfix.ComplexSfix(val=0j, left=0, right=0, overflow_style='fixed_saturate')

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



..
    RTD wont support Python 3.6 yet!
    automodule:: pyha.common.sfix
    :members: ComplexSfix


Utility functions
-----------------
Most of the arithmetic functions are defined for Sfix class.
Sizing rules known from `VHDL fixed point library`_ apply.

.. py:function:: pyha.common.sfix.resize(fix, left_index=0, right_index=0, size_res=None, overflow_style='fixed_saturate', round_style='fixed_round')

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





.. py:function:: pyha.common.sfix.left_index(x: pyha.common.sfix.Sfix)

    Use this in convertible code

    :return: left bound

    >>> a = Sfix(-0.5, 1, -7)
    >>> left_index(a)
    1



.. py:function:: pyha.common.sfix.right_index(x: pyha.common.sfix.Sfix)

    Use this in convertible code

    :return: right bound

    >>> a = Sfix(-0.5, 1, -7)
    >>> right_index(a)
    -7

..
    RTD wont support Python 3.6 yet!
    automodule:: pyha.common.sfix
    :members: resize, left_index, right_index

