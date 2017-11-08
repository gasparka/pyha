""" Real life example. FIR"""
import numpy as np
from pyha.common.hwsim import Hardware
from pyha.common.sfix import Sfix, fixed_truncate, fixed_wrap
from pyha.simulation.simulation_interface import assert_sim_match
from scipy import signal


class FIR(Hardware):
    """ Transposed FIR filter """

    def __init__(self, taps):
        self.taps = np.array(taps).tolist()

        # registers
        # self.acc = [Sfix(left=0, round_style=fixed_truncate, overflow_style=fixed_wrap)] * (len(self.taps) + 1)
        self.acc = [Sfix(left=0, round_style=fixed_truncate, overflow_style=fixed_wrap)] * len(self.taps)


        # constants
        self.TAPSS = [Sfix(x, 0, -17) for x in self.taps]
        self.DELAY = 1

        # # constants
        # self.DELAY = 1
        # self.TAPS = taps
        #
        # # registers
        # self.acc = [0.0] * (len(self.TAPS) + 1)

    def main(self, x):
        # for i in range(1, len(self.acc)):
        #     self.acc[i] = self.acc[i - 1] + x * self.TAPSS[len(self.TAPSS) - i]

        # self.acc[1] = self.acc[0] + x * self.TAPSS[3]
        # self.acc[2] = self.acc[1] + x * self.TAPSS[2]
        # self.acc[3] = self.acc[2] + x * self.TAPSS[1]
        # self.acc[4] = self.acc[3] + x * self.TAPSS[0]
        for i in range(len(self.acc)):
            if i == 0:
                self.acc[0] = x * self.TAPSS[-1]
            else:
                self.acc[i] = self.acc[i - 1] + x * self.TAPSS[len(self.TAPSS) - 1 - i]

        # self.acc[0] = x * self.TAPSS[3]
        # self.acc[1] = self.acc[0] + x * self.TAPSS[2]
        # self.acc[2] = self.acc[1] + x * self.TAPSS[1]
        # self.acc[3] = self.acc[2] + x * self.TAPSS[0]


        return self.acc[-1]

    def model_main(self, x):
        return signal.lfilter(self.taps, [1.0], x)


def test_simple():
    taps = [0.01, 0.02]
    dut = FIR(taps)
    inp = [0.1, 0.2, 0.3, 0.4]

    assert_sim_match(dut, None, inp)


def test_symmetric():
    taps = [0.01, 0.02, 0.03, 0.04, 0.03, 0.02, 0.01]
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 64)

    assert_sim_match(dut, None, inp)


def test_sfix_bug():
    """ There was Sfix None bound based bug that made only 5. output different """
    np.random.seed(4)
    taps = [0.01, 0.02, 0.03, 0.04, 0.03, 0.02, 0.01]
    dut = FIR(taps)
    inp = [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1]

    assert_sim_match(dut, None, inp)


def test_non_symmetric():
    taps = [0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07]
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 128)

    assert_sim_match(dut, None, inp)


def test_remez16():
    np.random.seed(0)
    taps = signal.remez(16, [0, 0.1, 0.2, 0.5], [1, 0])
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 64)

    assert_sim_match(dut, None, inp, dir_path='/home/gaspar/git/pyhacores/playground')


def test_remez32():
    np.random.seed(1)
    taps = signal.remez(32, [0, 0.1, 0.2, 0.5], [1, 0])
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 64)

    assert_sim_match(dut, None, inp)


def test_remez128():
    np.random.seed(2)
    taps = signal.remez(128, [0, 0.1, 0.2, 0.5], [1, 0])
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 128)

    assert_sim_match(dut, None, inp)
