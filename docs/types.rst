=====
Types
=====

Information about synthesisable types.

Builtins
--------

Integers are synthesised into 32-bit logic, thought there may be optimizations. Variable bit-width integers can be implemented with the ``Sfix`` class.
Booleans are fully usable.

Any Pyha object or builtin can be used in a list. Lists can be used as registers, function inputs/outputs or
simulation top-level inputs/outputs.

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
effect in Python simulations, but usually saves resources in hardware.

Example:

.. code-block:: python

    class Dut(Hardware):
        def __init__(self):
            self.regular = 1
            self.CONSTANT = 1

Fixed-point
-----------

Fixed-point types follow the style set by the VHDL fixed point library by David Bishop, you should read the user manual.

* deviations from that..ie >> means scalb

Pyha has a auto-resize feature, meaning all assignments to registers will be forced to the type of the register.
Pyha can also convert simulation inputs to fixed point numbers.

.. _VHDL fixed point library: https://github.com/FPHDL/fphdl/blob/master/Fixed_ug.pdf


.. automodule:: pyha
    :members: Sfix

.. automodule:: pyha
    :members: resize, left_index, right_index, scalb


Complex numbers
---------------

.. automodule:: pyha
    :members: Complex

Floats
------

Floats can be used when performing arithmetic/comparison with fixed-point numbers, in this case they are first converted to the type of the other fixed-point operand.


Float registers are converted automatically into fixed-point representation, by default ``Sfix(left=0, right=-17)``.

.. code-block:: python

    class Dut(Hardware):
        def __init__(self):
            self.reg = 0.1   # will be converted to "Sfix(0.1, 0, -17)"


Enums (state machines)
----------------------

Use Enums to build state machines.
Example:

.. code-block:: python

    class States(Enum):
        S0, S1 = range(2)

    class T(Hardware):
        def __init__(self):
            self.state = States.S0 # state register

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
            self.sum.x += a.x
            self.sum.y += a.y
            return self.sum



    inp = [Point(1, 2), Point(3, 4)] # use Point() as input to simulation
    dut = PointAcc()
    sims = simulate(dut, inp, simulations=['PYHA', 'RTL'])

Shift registers
---------------

Two ways..the regular Python way and much more optimized ShiftRegister.


RAM
---


ROM
---

