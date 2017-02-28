Examples
========
Here are some other examples developed in Pyha. Codes have some comments.


Submodules, lists and submodule lists. All sequential
-----------------------------------------------------
This example shows how multiple classes and instances can be used in one sequential design.
Everything is sequentially executed, you can use debugger to step around in code.
Itself it does nothing useful.

`Source code <https://github.com/petspats/pyha/blob/develop/examples/deep_sequential/deep_sequential.py>`__

`VHDL outputs <https://github.com/petspats/pyha/tree/develop/examples/deep_sequential/conversion/src>`__



Moving average
--------------
Moving average is useful construct:

- It is a matched filter for rectangular pulses
- Cheap low pass filter
- DC/bias removal applications


`Model/Doc <https://github.com/petspats/pyha/blob/develop/examples/moving_average/moving_average.ipynb>`__

`Source code <https://github.com/petspats/pyha/blob/develop/examples/moving_average/moving_average.py>`__

`VHDL outputs <https://github.com/petspats/pyha/tree/develop/examples/moving_average/conversion/src>`__


More info:

#. Good reference: http://www.analog.com/media/en/technical-documentation/dsp-book/dsp_book_Ch15.pdf
#. Usage in DC removal circuit: https://www.dsprelated.com/showarticle/58.php

FSK modulator
-------------
Frequency shift-keying modulator. It takes in bits and outputs complex stream, that could be fed
into SDR. Implementation uses NCO component, that in turn uses CORDIC algorithm for carrier generation.


`Model/Doc <https://github.com/petspats/pyha/blob/develop/examples/fsk_modulator/fsk_modulator.ipynb>`__

`Source code <https://github.com/petspats/pyha/blob/develop/examples/fsk_modulator/fsk_modulator.py>`__

`VHDL outputs <https://github.com/petspats/pyha/tree/develop/examples/fsk_modulator/conversion/src>`__

FSK demodulator
---------------
Takes in complex signal and gives out bits. It uses Quadrature demodulator followed by
matched filter (moving average). M&M clock recovery is the last DSP block, it performs timing recovery.

.. note:: Under construction, M&M clock recovery is currently not implemented


`Model/Doc <https://github.com/petspats/pyha/blob/develop/examples/fsk_demodulator/fsk_demodulator.ipynb>`__

`Source code <https://github.com/petspats/pyha/blob/develop/examples/fsk_demodulator/fsk_demodulator.py>`__

`VHDL outputs <https://github.com/petspats/pyha/tree/develop/examples/fsk_demodulator/conversion/src>`__


More info:

#. Good info on M&M: https://www.tablix.org/~avian/blog/archives/2015/03/notes_on_m_m_clock_recovery/