from scipy import signal

from pyha.common.core import Hardware


class ComplexFIR(Hardware):
    def __init__(self):
        pass

    def model_main(self, x):
        return signal.lfilter(self.TAPS, [1.0], x)