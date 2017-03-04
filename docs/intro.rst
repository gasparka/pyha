============
Introduction
============

Essentially this is a Python to VHDL converter, with a specific focus on implementing DSP systems.

Main features:

    - Simulate in Python. Integration to run RTL and GATE simulations.
    - Structured, all-sequential and object oriented designs
    - Fixed point type support(maps to `VHDL fixed point library`_)
    - Decent quality VHDL output (get what you write, keeps hierarchy)
    - Integration to Intel Quartus (run GATE level simulations)
    - Tools to simplify verification


Long term goal is to implement more DSP blocks, especially by using GNURadio blocks as models.
In future it may be possible to turn GNURadio flow-graphs into FPGA designs, assuming we have matching FPGA blocks available.

.. _VHDL fixed point library: https://github.com/FPHDL/fphdl

Working principle
-----------------
.. image:: img/working_principle.png

As shown on above image, Python sources are turned into synthesizable VHDL code.
In :code:`__init__`, you can write any valid Python code, it is ignored for conversion, only variables are collected as registers.
You can use objects of other classes (derived from HW) as registers, even lists of objects is possible.

In addition, there are tools to help verification by automating RTL and GATE simulations.


Limitations/future work
-----------------------

Currently designs are limited to one clock signal, decimators are possible by using Streaming interface.
Future plans is to add support for multirate signal processing, this would involve automatic PLL configuration.
I am thinking about integration with Qsys to handle all the nasty clocking stuff.

Synthesizability has been tested on Intel Quartus software and on Cyclone IV device (one on BladeRF and LimeSDR).
I assume it will work on other Intel FPGAs as well, no guarantees.

Fixed point conversion must be done by hand, however Pyha can keep track of all class and local variables during
the simulations, so automatic conversion is very much possible in the future.

Integration to bus structures is another item in the wish-list. Streaming blocks already exist in very basic form.
Ideally AvalonMM like buses should be supported, with automatic HAL generation, that would allow design of reconfigurable FIR filters for example.


Credits
-------

Inspiration:

- `A Structured VHDL Design Method`_: Shows how to do structured VHDL by suggesting only two processed design with the use of functions and structures. Pyha takes this idea to extreme, by using only 1 procedure and 1 entity per whole design.
- `MyHDL`_: It is great! I started from scratch because i wanted to try higher level approach for the conversion.

.. _A Structured VHDL Design Method: http://ens.ewi.tudelft.nl/Education/courses/et4351/structured_vhdl.pdf
.. _MyHDL: http://www.myhdl.org/

Essential components:

- `RedBaron`_: Enables conversion from Python to VHDL.
- `GHDL`_: Open VHDL simulator.
- `Cocotb`_: Python to simulator communications.
- `PyTest`_: Unit testing.

.. _RedBaron: https://github.com/PyCQA/redbaron
.. _GHDL: https://github.com/tgingold/ghdl
.. _Cocotb: https://github.com/potentialventures/cocotb
.. _PyTest: http://doc.pytest.org/en/latest/

