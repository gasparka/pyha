============
Introduction
============

Essentially this is an Python to VHDL converter, with a specific focus on implementing DSP systems.

Here are the main features:
    - Structured, all-sequential and object oriented designs
    - Fixed point type support(maps to `VHDL fixed point library`_)
    - Decent quality VHDL output (get what you write, keeps hierarchy)
    - Integration to Intel Quartus (run GATE level simulations)
    - Tools to simplify verification

Long term goal is to implement more DSP blocks, especially by using GNURadio blocks as models.
In the end it may be possible to turn GNURadio flow-graphs into FPGA designs, assuming we have matching FPGA blocks available.

.. _VHDL fixed point library: https://github.com/FPHDL/fphdl

Limitations/future work
-----------------------

Currently designs are limited to one clock signal, decimators are possible by using Streaming interface.
Future plans is to add support for multirate signal processing, this would involve automatic PLL configuration.

Synthesizability has been tested on Intel Quartus software and on Cyclone IV device (one on BladeRF and LimeSDR).
I assume it will work on other Intel FPGAs aswell, but can not give guarantees.

Fixed point conversion must be done by hand, however Pyha can keep track of all class and local variables during
the simulations, so automatic conversion is very much possible in the future.


Credits
-------

Inspiration:

- `A Structured VHDL Design Method`_: Shows how to do structured VHDL by suggesting only two processes per entity. Pyha takes this idea to extreme, by using only 1 procedure and 1 entity per whole design.
- `MyHDL`_: Initial goal of Pyha was to extend MyHDL, but things diverged quickly..


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

