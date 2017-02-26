============
Introduction
============

Essentially it is an Python to VHDL converter, with a specific focus on implementing DSP systems.

Here are the main features:
    - Strong fixed point type support(maps to VHDLs fixed point library)
    - Sequential coding
    - Object oriented coding
    - Good quality VHDL output (get what you write)


Example of converting very deep sequential stuff. Good quality of VHDL output.
Turn C like code to VHDL, debuggable!


Limitations
-----------

- Only one clock
-

Future plans
------------

- Add multirate signals processing support. For example FSK modulator block can not handle SPS atm, because that would require increasing the sample rate.
- Automatic float to fixed point:


Credits
-------

Inspiration:

- `A Structured VHDL Design Method`_: Shows how to do structured VHDL by suggesting only two processes per entity. Pyha takes this idea to extreme, by using only 1 procedure and 1 entity per whole design.
- `MyHDL`_:Pyha started as a PR for MyHDL, due to the inactivity it grew into separate project.


.. _A Structured VHDL Design Method: http://ens.ewi.tudelft.nl/Education/courses/et4351/structured_vhdl.pdf
.. _MyHDL: http://www.myhdl.org/

Essential components:

- `RedBaron`_: Enables conversion from Python to VHDL.
- `GHDL`_: Open VHDL simulator, used to verify Pyha designs.
- `Cocotb`_: Python to simulator communications.
- `PyTest`_: Best unit testing library.

.. _RedBaron: https://github.com/PyCQA/redbaron
.. _GHDL: https://github.com/tgingold/ghdl
.. _Cocotb: https://github.com/potentialventures/cocotb
.. _PyTest: http://doc.pytest.org/en/latest/

