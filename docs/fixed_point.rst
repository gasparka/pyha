Fixed-point
===========

Pyha maps fixed-point operations almost directly to `VHDL fixed point library`_ -
developed by David Bishop.

.. _VHDL fixed point library: https://github.com/FPHDL/fphdl


.. automodule:: pyha.common.sfix
    :members: Sfix



Resize
------
Sizing rules known from `VHDL fixed point library`_ apply.

.. automodule:: pyha.common.sfix
    :members: resize


Complex numbers
---------------

Puha supports complex numbers for interfacing means only, meaning there are no convertable arithmetics
defined. They can be function inputs or returns.

.. automodule:: pyha.common.sfix
    :members: ComplexSfix


