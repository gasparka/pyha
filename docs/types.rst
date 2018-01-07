=====
Types
=====

Information about synthesisable types.

Builtins
--------

Integers are synthesised into 32-bit logic, thought there may be optimizations. Booleans are fully usable.

Any Pyha object or builtin can be an list element. Lists can be used as registers, function inputs/outputs and
simulation top level inputs/outputs.

Example of ``bool`` shift-register:

.. code-block:: python

    class ShiftReg(Hardware):
        def __init__(self):
            self.shr = [False] * 4 # define register

        def main(self, x):
            self.shr = [x] + self.shr[:-1] # throw away last element and add new element as first
            return self.shr # return the whole list




Constants
---------

Constants are defined by writing the variable name in **UPPERCASE**, this has no
effect in Python simulations, but usually results in great resource savings in hardware.

Example:

.. code-block:: python

    class Dut(Hardware):
        def __init__(self):
            self.regular = 1
            self.CONSTANT = 1

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

Floats can be used when performing arithmetic/comparison with fixed-point numbers, in this case they are first converted to the type of the other fixed-point operand.


Float registers are converted automatically into fixed-point representation, by default ``Sfix(0.0, left=0, right=-17)``.
Constants are converted with saturation and rounding enabled.
.. code-block:: python

    class Dut(Hardware):
        def __init__(self):
            self.reg = 0.1   # will be converted to "Sfix(left=0, right=-17)"
            self.CONST = 0.1 # will be converted to "Sfix(left=0, right=-17, 'saturate', 'round')"


Enums (state machines)
----------------------

Use Enums to build state machines.
Example:

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

User defined types can be used as registers, inputs/outputs to simulation etc..
Example:

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
            self.sum.x = a.x
            self.sum.y = a.y
            return self.sum



    inp = [Point(1, 2), Point(3, 4)] # use Point() as input to simulation
    dut = PointAcc()
    sims = simulate(dut, inp, simulations=['PYHA', 'RTL'])
