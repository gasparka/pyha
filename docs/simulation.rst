====================
Simulation / Testing
====================


Simulation
----------

One goal of Pyha is to provide an simple interface for simulations. Main abstraction is that each call to ``main`` is
interpreted as an clock tick, or if you like the clock is associate with the inputs to the ``main`` function.

Pyha provides simple function ``simulate`` to run multiple simulations on the same input data:

* ``'MODEL'`` passes inputs directly to ``model_main`` function. If ``model_main`` does not exsist, uses the ``main`` function by turning off register effects and fixed point.
* ``'PYHA'`` cycle accurate simulator in Python domain, debuggable.
* ``'RTL'`` converts sources to VHDL and runs RTL simulation by using GHDL simulator.
* ``'GATE'`` runs VHDL sources trough Quartus and uses the generated generated netlist for simulation. Use to gain ~full confidence in your design. It is slow!

Example:

.. code-block:: python

    # simple pass-through module
    class T(Hardware):
        def main(self, a, b):
            return a, b

    outs = simulate(T(),         # object to simulate
            [1,     2,      3],  # inputs to 'a'
            [0.1,   0.2,    0.3],# input to 'b'. Note: Pyha converts floats to Sfix
            simulations=['MODEL', 'PYHA', 'RTL', 'GATE'] # list of simulations to run
    )

    # contents of 'out':
    # Note: returned Sfix values are converted back to float
    {
    'MODEL':[[1, 2, 3], [0.1,                 0.2,                0.3]],
    'PYHA': [[1, 2, 3], [0.09999847412109375, 0.1999969482421875, 0.3000030517578125]],
    'RTL':  [[1, 2, 3], [0.09999847412109375, 0.1999969482421875, 0.3000030517578125]],
    'GATE': [[1, 2, 3], [0.09999847412109375, 0.1999969482421875, 0.3000030517578125]]
    }


Pyha also provides the option to fill in the ``model_main`` function, serving as a model.


.. automodule:: pyha
    :members: simulate


Asserts
-------

Results of the ``simulate`` function can be compared by using the ``sims_close`` or ``hardware_sims_equal`` functions.
This is fast way to write unit tests.
Use the combo of ``simulate`` and ``assert sims_close`` for writing unit-tests.

.. automodule:: pyha
    :members: sims_close, hardware_sims_equal


Delays
------

Each register in signal path delays the output by one sample, in order to compare with model,
Pyha can compensate this delay (and also flush the pipeline). Use self.DELAY.

Example:

.. code-block:: python

    class T(Hardware):
        def __init__(self):
            self.reg = 0
            self.DELAY = 1 # one register on signal path (input -> output)

        def main(self, a):
            self.reg = a
            return self.reg