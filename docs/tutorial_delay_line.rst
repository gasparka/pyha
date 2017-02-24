Tutorial: Delay line
====================
.. note::

    In this tutorial we use integer type for register. It is perfectly synchesizable but at the moment
    always derives 32 bit logic. Main type for Pyha is fixed-point, but for this first tutorial we keep it simple.


Delay line is essentially just an


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


.. todo::

    WTF


.. automodule:: pyha.simulation.simulation_interface
:members:


    All the submodules must be defined in the __init__.


