==========
Simulation
==========

Example:

.. code-block:: python

    # simple pass-through module
    class T(Hardware):
        def main(self, a, b):
            return a, b

    dut = T()
    outs = simulate(T(),         # model to simulate
            [1,     2,      3],  # inputs to 'a'
            [0.1,   0.2,    0.3],# input to 'b'. Note: Pyha converts floats to Sfix
            ['MODEL', 'PYHA', 'RTL', 'GATE'] # list of simulations to run
    )

    # Note: returned Sfix values are converted back to float
    {
    'MODEL':[[1, 2, 3], [0.1,                 0.2,                0.3]],
    'PYHA': [[1, 2, 3], [0.09999847412109375, 0.1999969482421875, 0.3000030517578125]],
    'RTL':  [[1, 2, 3], [0.09999847412109375, 0.1999969482421875, 0.3000030517578125]],
    'GATE': [[1, 2, 3], [0.09999847412109375, 0.1999969482421875, 0.3000030517578125]]
    }

One goal of Pyha is to provide an simple interface for simulations. Main abstraction is that each call to ``main`` is
interpreted as an clock tick, or if you like the clock is associate with the inputs to the ``main`` function.

Pyha also provides the option to fill in the ``model_main`` function, serving as a model.

.. automodule:: pyha
    :members: simulate


Use the combo of ``simulate`` and ``assert sims_close`` for writing unit-tests.

.. automodule:: pyha
    :members: sims_close, hardware_sims_equal

.. automodule:: pyha
    :members: hardware_sims_equal


Delays
------

Use self.DELAY