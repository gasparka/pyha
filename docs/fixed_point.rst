Fixed-point
===========

Pyha maps fixed-point operations almost directly to `VHDL fixed point library`_

.. _VHDL fixed point library: https://github.com/FPHDL/fphdl


.. automodule:: pyha.common.sfix
    :members: Sfix

Complex numbers
---------------

Puha supports complex numbers for interfacing means, arithmetic operations are not defined.
Use :code:`.real` and :code:`.imag` to do maths.

.. automodule:: pyha.common.sfix
    :members: ComplexSfix


Utility functions
-----------------
Most of the arithmetic functions are defined for Sfix class.
Sizing rules known from `VHDL fixed point library`_ apply.

.. automodule:: pyha.common.sfix
    :members: resize, left_index, right_index

