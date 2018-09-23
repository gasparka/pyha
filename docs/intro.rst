============
Introduction
============

Pyha is a Python based HDL language that allows you to describe, simulate and bebug hardware in Python.

Pyha is different from MyHDL in a way that it allow converting Python to VHDL in much higher abstraction level, for
example you can freely pass around/process lists of composite objects.

Migen and Pyha share the same foundation, which is the Gaisler style or in more general a way to separate a design into
a combinatory and sequantial parts. Migen implements this approach by a domain specific DSL, which is very good for
building hardware generators, but probably not fun for writing DSP applications and is not debuggable.

Pyha is specialized on DSP systems, or in other ways streaming systems. One center-idea is to build up a library of
components that could be easily reused.


Main features:

    - Simulate, test and debug Python. Integration to run RTL and NETLIST simulations.
    - Structured, all-sequential and object oriented designs
    - Fixed point and complex type support(maps to `VHDL fixed point library`_)

Long term goal is to implement more DSP blocks, especially by using GNURadio blocks as models.
In future it may be possible to turn GNURadio flow-graphs into FPGA designs, assuming we have matching FPGA blocks available.

.. _VHDL fixed point library: https://github.com/FPHDL/fphdl

Working principle
-----------------
.. image:: img/working_principle.png

As shown on above image, Python sources are turned into synthesizable VHDL code.
In :code:`__init__`, any valid Python code can be used, all the variables are collected as registers.
Objects of other classes (derived from HW) can be used as registers, even lists of objects is possible.

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

