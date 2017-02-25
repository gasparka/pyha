============
Introduction
============

Essentially it is a Python to VHDL converter, with a specific focus on implementing DSP systems.

Here are the main features:
    - Strong fixed point type support(maps to VHDLs fixed point library)
    - Sequential coding
    - Object oriented coding
    - Test driven development
    - Model based design


Example of converting very deep sequential stuff. Good quality of VHDL output.

Reccommend pycharm as development platform.


Limitations
-----------

- Only one clock
-

Future plans
------------
Add multirate signals processing support. For example FSK modulator block can not
handle SPS atm, because that would require increasing the sample rate.


Credits
-------

MyHDL, RedBaron, CocoTb

