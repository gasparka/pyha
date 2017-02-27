Tutorial:Basic usage
====================

This tutorial will show the basic usage of Pyha features,
we will design 1 tap FIR filter that is basically just multiplication.

Full source:

Generated VHDL:

Quartus project:

Model and unit-tests
--------------------

Lets follow the model and test-driven development, it goes like this:

- Write simplest possible model of what you want to do
- Experiment with it, dont throw away the experiments, rather turn them to unit-testsUnderstand it by writing unit-tests
- Profit

Pyha operates on classes, that must be derived from pyha.HW baseclass.
First we start with defining the model of and register:

.. code-block:: python

    from pyha.common.hwsim import HW
    class BigFir(HW):
        def __init__(coef):
            self.coef = coef

        def model_main(input_list):
            # note that model works on lists
            return np.array(input_list) * self.coef


.. note:: :code:`model_main` function is reserved for defining the model.

Next step is to define unit-tests on the model. Basically at this point we want to
define all the tests we can imagine, later we can use the same tests to verify the operation of
the RTL code.

One test that i defined:

.. code-block:: python

    def test_register_pos():
        dut = BigFir(coef=0.5)
        inputs = [0.1 , 0.2, 0.3. 0.4, 0.5]
        expect = [0.05, 0.1, 0.15, 0.2, 0.25]

        assert_sim_match(dut, None, expect, inputs, simulations=[SIM_MODEL])

This makes use of one of the verification functions:

.. automodule:: pyha.simulation.simulation_interface
    :members: assert_sim_match

.. note::
    If you use PyCharm you can run unit-tests by right clicking on the function name and selecting 'Run py.test..'
    You may need to set File-Settings-Tools-Python Integrated Tools-Default Test Runner = py.test.
    You can also run pytest from console :code:`$ pytest`

Hardware model
--------------
Assuming we have now enough knowledge and unit-tests we can start implementing
the Hardware model.

.. code-block:: python
    :emphasize-lines: 13,16,23,25
    :linenos:

    from pyha.common.const import Const
    from pyha.common.sfix import Sfix, resize
    from pyha.common.hwsim import HW
    import numpy as np


    class BigFir(HW):
        def __init__(self, coef):
            self.coef = coef

            # define output registers
            # bounds will be determined during simulation
            self.out_resized = Sfix()

            # constants
            self.coef_f = Const(Sfix(coef, 0, -17))

        def main(self, input):
            # note that this works on single input

            # this will also infer saturation and rounding, can be turned off if you like
            # for registers you always assign to self.next
            self.next.out_resized = resize(input * self.coef_f, size_res=input)

            return self.out_resized

        def model_main(self, input_list):
            # note that model works on lists
            return np.array(input_list) * self.coef


In Line 13, we defined a register named :code:`out_resized`.

.. note::
    All the class variables are interpreted as registers, unconvertable types like float or Numpy arrays will be ignord for conversion. All the assignments to registers go trough :code:`self.next`

Line 16 turns the floating point coef into fixed-point and also applies constant keyword.

There is a new function called :code:`main`, this is default name for the hardware oriented model.
In line 23 we assign the register value with the resized result of multiplication.

Lastly on line 25 we return the value, you could return multiple values as well.

Testing
~~~~~~~
We need to make only minor modifications to our test functions in order to run HW simulations:

.. code-block:: python
    :emphasize-lines: 8, 10
    :linenos:

    def test_basic():
        from pyha.simulation.simulation_interface import SIM_MODEL, assert_sim_match, SIM_HW_MODEL
        dut = BigFir(coef=0.5)
        inputs = [0.1, 0.2, 0.3, 0.4, 0.5]
        expect = [0.05, 0.1, 0.15, 0.2, 0.25]

        assert_sim_match(dut,
                         [Sfix(left=0, right=-17)],
                         expect, inputs,
                         simulations=[SIM_MODEL, SIM_HW_MODEL])

On line 7 we added the input signature of our 'main' function and on line 9
we added a HW simulation instruction.

Upon running we would get:

.. code-block:: python

    INFO:Running MODEL simulation!
    INFO:Running HW_MODEL simulation!
    ERROR:##############################################################
    ERROR:##############################################################
    ERROR:		"HW_MODEL" failed
    ERROR:##############################################################
    ERROR:##############################################################

    ... stack trace ...

.. code-block:: python

    AssertionError:
    Not equal to tolerance rtol=1e-05, atol=1e-09
    E
    (mismatch 100.0%)
    x: array([ 0.05,  0.1 ,         0.15,       0.05,       0.1])
    y: array([ 0.  ,  0.050003,     0.099998,   0.150002,   0.099998])


So the HW simulation failed, if you look closely you can see that the expected and
actual outputs are just delayed by 1.

Alternatively you can use a debug function:

.. automodule:: pyha.simulation.simulation_interface
    :members: plot_assert_sim_match

It would output:

.. image:: ../examples/basic_plot.png

This is an standard hardware behaviour. Pyha provides special variable
:code:`self._delay` that specifies the delay of the model. This field is useful because:

- It documents the delay
- Upper level blocks can use it to define their own delay
- Pyha simulations will adjust for the delay, so you can easily compare to your model.

.. note:: Use :code:`self._delay` to match your hardware against models

After setting the :code:`self._delay = 1` in the __init__, we get:

.. code-block:: python

    AssertionError:
    Not equal to tolerance rtol=1e-05, atol=1e-09
    (mismatch 80.0%)
    x: array([ 0.05,        0.1 ,       0.15,       0.05,        0.1 ])
    y: array([ 0.050003,    0.099998,   0.150002,   0.050003,    0.099998])


Now values are aligned, but the tolerances are too strict, remember that we are using fixed-point after all.
One way to fix this would be to add more precision to our types, for example :code:`Sfix(left=0, right=-19)`.
However better way is to just reduce the :code:`rtol` to 1e-4. We want to keep our 18 bit fixed-point numbers
because Intel Cyclone FPGAs have DSP blocks that work on 18 bit data.

In general i am okay when simulations pass rtol=1e-3. Sometimes you have to adjust atol also, be careful as it starts dominating your rtol value!

RTL simulations
~~~~~~~~~~~~~~~

All you have to do is add :code:`SIM_RTL` to the simulations list.

In case you want to view the converted VHDL files, you can use :code:`dir_path='~/vhdl_conversion'`
option.

Example:

.. code-block:: python

    assert_sim_match(dut,
                     [Sfix(left=0, right=-17)],
                     expect, inputs,
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                     dir_path='~/vhdl_conversion')

GATE simulation and Quartus
~~~~~~~~~~~~~~~~~~~~~~~~~~~

By adding 'SIM_GATE' to the simulations list, you can run GATE level simulation. These will
usually take a long time to execute, but can be useful to gain full confidence on your design.

Running the GATE simulation, will produce 'quartus' directory in :code:`dir_path`.
You can use it to open the project in Intel Quartus and investigate results.
One useful tool there is RTL viewer, it can be opened from Tools-Netlist viewers-RTL viewer.

RTL of this tutorial:

.. image:: ../examples/basic_rtl.png

.. note:: Design will be optimized if you mark :code:`self.coef` as Const, Quartus will use shift instead of multiply.

Finished code
~~~~~~~~~~~~~
.. code-block:: python

    from pyha.common.const import Const
    from pyha.common.sfix import Sfix, resize, fixed_truncate
    from pyha.common.hwsim import HW
    import numpy as np


    class BigFir(HW):
        def __init__(self, coef):
            self.coef = coef

            # define output registers
            # bounds will be determined during simulation
            self.out_resized = Sfix()

            # constants
            self.coef_f = Sfix(coef, 0, -17)

            # uncomment this and quartus will optimize away multiplication (assuming coef=0.5)
            # self.coef_f = Const(Sfix(coef, 0, -17))


            self._delay = 1

        def main(self, input):
            # note that this works on single input

            # this will also infer saturation logic
            # for registers you always assign to self.next
            self.next.out_resized = resize(input * self.coef_f, size_res=input,
                                           round_style=fixed_truncate)

            return self.out_resized

        def model_main(self, input_list):
            # note that model works on lists
            return np.array(input_list) * self.coef


    def test_basic():
        from pyha.simulation.simulation_interface import SIM_MODEL, assert_sim_match, SIM_HW_MODEL, SIM_RTL, SIM_GATE
        dut = BigFir(coef=0.5)
        inputs = [0.1, 0.2, 0.3, 0.2, 0.1]
        expect = [0.05, 0.1, 0.15, 0.1, 0.05]

        assert_sim_match(dut,
                         [Sfix(left=0, right=-17)],
                         expect, inputs,
                         simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         rtol=1e-4,
                         dir_path='~/vhdl_conversion')
