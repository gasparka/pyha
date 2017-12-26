Fixed-point
===========

Pyha maps fixed-point operations directly to `VHDL fixed point library`_

.. _VHDL fixed point library: https://github.com/FPHDL/fphdl


.. automodule:: pyha
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

