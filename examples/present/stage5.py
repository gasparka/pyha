""" Real life example. FIR"""

import numpy as np
from scipy import signal

from pyha.common.hwsim import Hardware
from pyha.common.sfix import Sfix
from pyha.simulation.simulation_interface import simulate, assert_equals, SIM_MODEL, SIM_HW_MODEL


class FIR(Hardware):
    """ Transposed FIR filter """

    def __init__(self, taps):
        # constants
        self.DELAY = 1
        self.TAPS = np.array(taps).tolist()

        # registers
        self.acc = [Sfix(left=0)] * len(taps)
        # self.acc = [0.0] * len(taps)



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
                self.acc[0] = x * self.TAPS[-1]
            else:
                self.acc[i] = self.acc[i - 1] + x * self.TAPS[len(self.TAPS) - 1 - i]

        # old = deepcopy(self.acc)
        # self.acc[0] = x * self.TAPS[1]
        # self.acc[1] = old[0] + x * self.TAPS[0]

        # for i in range(len(self.acc)):
        #     if i == 0:
        #         self.acc[0] = x * self.TAPS[-1]
        #     else:
        #         self.acc[i] = old[i - 1] + x * self.TAPS[len(self.TAPS) - 1 - i]

        # self.acc[2] = self.acc[1] + x * self.TAPSS[1]
        # self.acc[3] = self.acc[2] + x * self.TAPSS[0]


        return self.acc[-1]

    def model_main(self, x):
        return signal.lfilter(self.TAPS, [1.0], x)


simulations = [SIM_MODEL, SIM_HW_MODEL]


def test_simple():
    taps = [0.01, 0.02]
    dut = FIR(taps)
    inp = [0.1, 0.2, 0.3, 0.4]

    sims = simulate(dut, inp, simulations=simulations)
    assert_equals(sims)


def test_symmetric():
    taps = [0.01, 0.02, 0.03, 0.04, 0.03, 0.02, 0.01]
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 64)

    sims = simulate(dut, inp, simulations=simulations)
    assert_equals(sims)


def test_sfix_bug():
    """ There was Sfix None bound based bug that made only 5. output different """
    np.random.seed(4)
    taps = [0.01, 0.02, 0.03, 0.04, 0.03, 0.02, 0.01]
    dut = FIR(taps)
    inp = [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1]

    sims = simulate(dut, inp, simulations=simulations)
    assert_equals(sims)


def test_non_symmetric():
    taps = [0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07]
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 128)

    sims = simulate(dut, inp, simulations=simulations)
    assert_equals(sims)


def test_remez16():
    np.random.seed(0)
    taps = signal.remez(16, [0, 0.1, 0.2, 0.5], [1, 0])
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 64)

    sims = simulate(dut, inp, simulations=simulations)
    assert_equals(sims)


def test_remez32():
    np.random.seed(1)
    taps = signal.remez(32, [0, 0.1, 0.2, 0.5], [1, 0])
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 64)

    sims = simulate(dut, inp, simulations=simulations)
    assert_equals(sims)


def test_remez128():
    np.random.seed(2)
    taps = signal.remez(128, [0, 0.1, 0.2, 0.5], [1, 0])
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 128)

    sims = simulate(dut, inp, simulations=simulations)
    assert_equals(sims, rtol=1e-5)
