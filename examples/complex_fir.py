import numpy as np
from pyha import Hardware, simulate, sims_close
from pyhacores.filter import FIR
from scipy import signal


class ComplexFIR(Hardware):
    def __init__(self, taps):
        # registers
        self.fir = [FIR(taps), FIR(taps)]

        # constants (written in CAPS)
        self.DELAY = self.fir[0].DELAY
        self.TAPS = np.asarray(taps).tolist()

    def main(self, x):
        ret = x
        # print(x.real)
        ret.real = self.fir[0].main(x.real)
        # print(x.real)
        ret.imag = self.fir[1].main(x.imag)
        # x = self.fir[0].main(x)
        return ret

    def model_main(self, x):
        """ Golden output """
        return signal.lfilter(self.TAPS, [1.0], x.real) + signal.lfilter(self.TAPS, [1.0], x.imag) * 1j
        return signal.lfilter(self.TAPS, [1.0], x)


def test_remez16():
    np.random.seed(0)
    taps = signal.remez(16, [0, 0.1, 0.2, 0.5], [1, 0])
    dut = ComplexFIR(taps)
    inp = np.random.uniform(-1, 1, 32) + np.random.uniform(-1, 1, 32) * 1j
    # inp = np.random.uniform(-1, 1, 32)

    sims = simulate(dut, inp, simulations=['MODEL', 'PYHA', 'RTL'], conversion_path='/home/gaspar/git/pyha/playground')

    # import matplotlib.pyplot as plt
    # plt.plot(sims['MODEL'], label='MODEL')
    # plt.plot(sims['PYHA'], label='PYHA')
    # plt.plot(sims['RTL'], label='RTL')
    # plt.legend()
    # plt.show()
    assert sims_close(sims)