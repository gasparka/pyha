================
Tutorial: Basics
================
.. note::

    In this tutorial we use integer type for register. It is perfectly synchesizable but at the moment
    always derives 32 bit logic. Main type for Pyha is fixed-point, but for this first tutorial we keep it simple.


Pyha operates on classes, that must be derived from pyha.HW baseclass.


Model and unit-tests
--------------------

First we start with defining the model of and register:

.. code-block:: python

    from pyha.common.hwsim import HW
    class Register(HW):
        def model_main(input_list):
            # this could just return the input_list,  but i want to emphasize lists
            outputs = []
            for inp in inpup_list:
                outputs.append(inp)

            return outputs

:code:`model_main` is a special function of Pyha that is reserved for defining the model.

Next step is to define unit-tests on the model. Basically at this point we want to
define all the tests we can imagine, later we can use the same tests to verify the operation of
the RTL code.

Out unit test is as boring as the code:

.. code-block:: python

    def test_register_pos():
        inputs = [1, 2, 3, 4]
        expect = [1, 2, 3, 4]

        dut = Register()
        assert_sim_match(dut, None, expect, inputs, simulations=[SIM_MODEL])

    def test_register_neg():
        inputs = [-1, -2, -3, -4]
        expect = [-1, -2, -3, -4]

        dut = Register()
        assert_sim_match(dut, None, expect, inputs, simulations=[SIM_MODEL])



.. note::

    If you use PyCharm you can run it by right clicking on the function name and selectin 'Run py.test..'
    You may need to set File-Settings-Tools-Python Integrated Tools-Default Test Runned = py.test.
    You can also run pytest from console :code:`$ pytest`


.. automodule:: pyha.simulation.simulation_interface
:members:


Hardware model
--------------
Hardware model is implementation in python that can be converted to hardware. It differs from model:

- how?
- Works on single item instead of model that works on lists


.. code-block:: python
    :emphasize-lines: 3-8

        from pyha.common.hwsim import HW
        class Register(HW):
            def __init__(self):
                self.reg = 707  # define integer register, startup value = 707
                self._delay = 1

            def main(self, inp):
                """ Hardware model, convertable to VHDL """
                self.next.reg = inp
                return self.reg

            def model_main(input_list):
                # this could just return the input_list,  but i want to emphasize lists
                outputs = []
                for inp in inpup_list:
                    outputs.append(inp)

                return outputs

    Defining registers in Pyha goes by in __init__ function by making an object variable.
    Type of the register is determined from the initial value as is the startup value. Upon conversion,
    unconvertable structures will be ignored, like Numpy arrays or floats.

    Assigning new values must go trough the .next variable.

    For testing the new code, we can reuse the test we defined previously, but need to make some modification
    to the assert_sim_match function:

.. code-block:: python
    :emphasize-lines: 2,5
        :linenos:

        assert_sim_match(dut,
                            [int],
                            expect,
                            inputs,
                            simulations=[SIM_MODEL, SIM_HW_MODEL])


    First at line 2, we need to define what are the input types to the 'main' function, in this case it is
    int. Lastly we changed the last line to include SIM_HW_MODEL simulation. All the simulations must match the
    expected outputs in order to pass the test. That is, our inputs are now validated against the 'model_main' and
    'main'.

.. todo::

    Explain delay!

Conversion to VHDL and RTL simulation
-------------------------------------
To convert the code into VHDL we only need to add 'SIM_RTL' to the simulations list:

.. code-block:: python

    assert_sim_match(dut, [int], expect, inputs,
                        simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL])


Now three simulations are ran, GHDL is used to simulate the converted sources. By default
conversion is done into temporary folder, you can add custom output folder:

.. code-block:: python
    :emphasize-lines: 3

        assert_sim_match(dut, [int], expect, inputs,
                            simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                            dir_path='~/vhdl_conversion')

    This would write all conversion products to ~/vhdl_conversion. You can look at the
    conversion output `here`_.

.. _here: /home/gaspar/git/pyha/docs/src/tutorial_register/convert/src

.. note::

    SIM_HW_MODEL must always pecede SIM_RTL simulation. It is used to learn variable types for later conversion.





.. todo::

    All the submodules must be defined in the __init__.



GATE simulation and Quartus
---------------------------

By adding 'SIM_GATE' to the simulations list, you can run GATE level simulation. These will
usually take a long time to execute, but can be useful to gain full confidence on your design.

.. code-block:: python
    :emphasize-lines: 3

        assert_sim_match(dut, [int], expect, inputs,
                            simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                            dir_path='~/vhdl_conversion')

    Upon running the GATE simulation, there will be 'quartus' directory created in your
    selectd output path. You can use it to open the project in Intel Quartus software and do cool actions.
    One useful tool is to look at generated RTL, it can be opened from Tools-Netlist viewers-RTL viewer.



    RTL pilt!
