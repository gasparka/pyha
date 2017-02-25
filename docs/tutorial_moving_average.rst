Tutorial: Moving Average
========================

Moving average is useful construct:

- It is a matched filter for rectangular pulses (demodulators make use of this)
- Cheap low pass filter for reducsing noise
- High window length can yield DC compoent of a signal


Model and unit-tests
--------------------

Moving average filter can be implemented as a FIR filter, here is an example for
window length of 4:

.. ipython:: python

    window_len = 4
    taps = [1 / window_len] * window_len
    taps


To test this this we make a simple signal with noise:

.. ipython:: python
:savefig:

        import numpy as np
        import matplotlib.pyplot as plt

        x = np.linspace(0,2*2*np.pi,512)
        y = 0.9*np.sin(x) + 0.1*np.random.normal(size=512) * 0.2

    plt.plot(x,y)
    plt.plot(x,y, color='red')
    plt.show()

.. code-block:: python

    class MovingAverage(HW):
        def __init__(self, window_len):
            self.window_len = window_len

        def model_main(self, inputs):
            taps = [1 / self.window_len] * self.window_len
            ret = np.convolve(inputs, taps, mode='full') # filter
            return ret[:-self.window_len + 1]
