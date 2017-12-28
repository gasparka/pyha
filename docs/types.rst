=====
Types
=====

Document usable types in Pyha.

Builtins
--------

Integers and Booleans are fully usable in synthesisable Pyha code. Integers are likely to be
synthesised into 32-bit logic, thought there may be optimizations.

Lists are well supported, any Pyha object or builtin can be an list member. Lists can be used as registers, function inputs/outputs and
simulation top level inputs/outputs.

Example of ``bool`` shift-register:

.. code-block:: python

    class ShiftReg(Hardware):
        def __init__(self):
            self.shr = [False] * 4 # define register

        def main(self, x):
            self.shr = [x] + self.shr[:-1] # throw away last element and add new element as first
            return self.shr # return the whole list



Fixed-point
-----------

Pyha maps fixed-point operations directly to `VHDL fixed point library`_.

.. _VHDL fixed point library: https://github.com/FPHDL/fphdl/blob/master/Fixed_ug.pdf


.. automodule:: pyha
    :members: Sfix

.. automodule:: pyha
    :members: resize, left_index, right_index, scalb


Complex numbers
---------------


.. automodule:: pyha
    :members: ComplexSfix

Floats
------

Float registers are converted automatically into fixed-point representation, by default ``Sfix(left=0, right=-17, overflow_style='saturate', round_style='round')``.

TODO: convert only CONSTANTS to 'saturate', 'round' ?

.. code-block:: python

    class Dut(Hardware):
        def __init__(self):
            self.reg = 0.1 # will be converted to ``Sfix(left=0, right=-17, 'saturate', 'round')``

Floats can also be added/compared against fixed-point numbers, in this case they are first converted to the type of other operand.


Enums (state machines)
----------------------

Enums are generally used to build state-machines, below is an dummy example:

.. code-block:: python

    class States(Enum):
        S0, S1 = range(2)

    class T(Hardware):
        def __init__(self):
            self.state = States.S0

        def main(self, a):
            if self.state == States.S0:
                self.state = States.S1
                return 0
            elif self.state == States.S1:
                self.state = States.S0
                return a



User defined types
------------------

User can make new types by deriving a class from ``Hardware``. User types are fully supported, i.e. they can be used as registers, inputs/outputs to simulation etc.
Limitation is that they cannot be initiated into local variable (see example below).

.. code-block:: python

    # user type with 'x' and 'y' elements
    class Point(Hardware):
        def __init__(self, x, y):
            self.x = x
            self.y = y

    # accumulator of Points
    class PointAcc(Hardware):
        def __init__(self):
            self.sum = Point(0, 0)

        def main(self, a):
            local_var = Point(0, 1) # local instances are currently not working, see #184
            self.sum.x = a.x
            self.sum.y = a.y
            return self.sum



    inp = [Point(1, 2), Point(3, 4)]
    dut = PointAcc()
    sims = simulate(dut, inp, simulations=['PYHA', 'RTL'])
