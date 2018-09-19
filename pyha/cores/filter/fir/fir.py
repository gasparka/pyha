from pyha import Hardware, Sfix, simulate, sims_close
from scipy import signal
import numpy as np

# TODO: Update to latest Pyha and streaming interface!
class FIR(Hardware):
    def __init__(self, taps, dtype=Sfix):
        self.DELAY = 2
        self.TAPS = taps

        # registers
        self.acc = [dtype(left=1, right=-17)] * len(taps)
        self.out = dtype(left=0, right=-17, overflow_style='saturate')

    def main(self, x):
        """ Transposed FIR structure """
        self.acc[0] = x * self.TAPS[-1]
        for i in range(1, len(self.acc)):
            self.acc[i] = self.acc[i - 1] + x * self.TAPS[len(self.TAPS) - 1 - i]

        self.out = self.acc[-1]
        return self.out

    def model(self, x):
        return signal.lfilter(self.TAPS, [1.0], x)


def test_simple():
    taps = [0.01, 0.02]
    dut = FIR(taps)
    inp = [0.1, 0.2, 0.3, 0.4]

    sims = simulate(dut, inp)
    assert sims_close(sims)


def test_symmetric():
    np.random.seed(0)
    taps = [0.01, 0.02, 0.03, 0.04, 0.03, 0.02, 0.01]
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 64)

    sims = simulate(dut, inp)
    assert sims_close(sims, rtol=1e-3, atol=1e-3)


def test_non_symmetric():
    np.random.seed(0)
    taps = [0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07]
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 128)

    sims = simulate(dut, inp)
    assert sims_close(sims, rtol=1e-3, atol=1e-3)


def test_remez16():
    np.random.seed(0)
    taps = signal.remez(16, [0, 0.1, 0.2, 0.5], [1, 0])
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 1024)

    sims = simulate(dut, inp)
    assert sims_close(sims, rtol=1e-3, atol=1e-3)


def test_remez32():
    np.random.seed(1)
    taps = signal.remez(32, [0, 0.1, 0.2, 0.5], [1, 0])
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 64)

    sims = simulate(dut, inp)
    assert sims_close(sims, rtol=1e-3, atol=1e-3)


def test_remez128():
    np.random.seed(2)
    taps = signal.remez(128, [0, 0.1, 0.2, 0.5], [1, 0])
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 128)

    sims = simulate(dut, inp)
    assert sims_close(sims, rtol=1e-3, atol=1e-3)


def test_sfix_bug():
    """ There was Sfix None bound based bug that made only 5. output different """
    np.random.seed(4)
    taps = [0.01, 0.02, 0.03, 0.04, 0.03, 0.02, 0.01]
    dut = FIR(taps)
    inp = [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1]

    sims = simulate(dut, inp)
    assert sims_close(sims, rtol=1e-2)
