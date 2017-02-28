Examples
========
Here are some other examples developed in Pyha. Codes have some comments.


Submodules, lists and submodule lists. All sequential
-----------------------------------------------------
This example shows how multiple classes and instances can be used in one sequential design.
Everything is sequentially executed, you can use debugger to step around in code.
Itself it does nothing useful.

Source:

Code

VHDL outputs

Quartus project


Moving average
--------------
Moving average is useful construct:

- It is a matched filter for rectangular pulses
- Cheap low pass filter
- DC/bias removal applications


Sources:

`Model/Doc <https://github.com/petspats/pyha/blob/feature/documentation/examples/moving_average/mavg.ipynb>`__

`Source code <https://github.com/petspats/pyha/blob/feature/documentation/examples/moving_average/mavg.ipynb>`__

`VHDL outputs <https://github.com/petspats/pyha/tree/feature/documentation/examples/moving_average/conversion/src>`__


More info:

#. Good reference: http://www.analog.com/media/en/technical-documentation/dsp-book/dsp_book_Ch15.pdf
#. Usage in DC removal cricuit: https://www.dsprelated.com/showarticle/58.php

FSK modulator
-------------
Frequency shift-keying modulator. It takes in bits and outputs complex stream, that could be fed
into SDR. Implementation uses NCO component, that in turn uses CORDIC algorithm for carrier generation.

Sources:

`Model/Doc <https://github.com/petspats/pyha/blob/feature/documentation/examples/moving_average/mavg.ipynb>`__

`Source code <https://github.com/petspats/pyha/blob/feature/documentation/examples/moving_average/mavg.ipynb>`__

`VHDL outputs <https://github.com/petspats/pyha/tree/feature/documentation/examples/moving_average/conversion/src>`__

FSK demodulator
---------------
Takes in complex signal and gives out bits. It uses Quadrature demodulator followed by
matched filter (moving average). M&M clock recovery is the last DSP block, it performs timing recovery.

.. note:: M&M clock recovery is currently not implemented

Sources:

Code

VHDL outputs

Quartus project


https://www.tablix.org/~avian/blog/archives/2015/03/notes_on_m_m_clock_recovery/