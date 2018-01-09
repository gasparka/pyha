====================
Simulation / Testing
====================

Pyha provides an simple interface for simulations and asserts in order to quickly write unit-tests.
Main idea is to compare the ``MODEL`` output against the hardware simulations.


Simulation
----------

.. automodule:: pyha
    :members: simulate


Asserts
-------

Use the following functions with the ``assert`` statement.

.. automodule:: pyha
    :members: sims_close, hardware_sims_equal


Delays
------

Each register in signal path delays the output by one sample, resulting in a mismatch compared to a software ``MODEL``.
The delay will be compensated if you specify the delay with ``self.DELAY``.

Example:

.. code-block:: python

    class T(Hardware):
        def __init__(self):
            self.reg = 0
            self.DELAY = 1 # 1 register on signal path (input -> output)

        def main(self, a):
            self.reg = a
            return self.reg