

import numpy as np
from scipy import signal

from pyha.common.fixed_point import Sfix, resize, fixed_wrap, fixed_truncate
from pyha.common.core import Hardware


class FIR(Hardware):
    """ Transposed FIR filter """

    def __init__(self, taps):
        # constants
        self.DELAY = 1
        self.TAPS = np.array(taps).tolist()

        # registers
        # self.acc = [Sfix(left=0)] * len(taps)
        self.in_history = [Sfix(0.0)] * len(taps)
        # self.out = Sfix()

        self.retime1 = Sfix(0.0)
        self.retime2 = Sfix(0.0)
        self.retime3 = Sfix(0.0)

        self.inre1 = Sfix()
        self.inre2 = Sfix()



        # self.acc = [0.0] * len(taps)
        # self.sum = Sfix(0.0)


        # # constants
        # self.DELAY = 1
        # self.TAPS = taps
        #
        # # registers
        # self.acc = [0.0] * (len(self.TAPS) + 1)

    def main(self, x):
        self.inre1 = x
        self.inre2 = self.inre1

        self.in_history = self.in_history[1:] + [self.inre2]

        sum = Sfix(0.0, 1, -34)
        for i in range(len(self.TAPS)):
            sum = resize(sum + self.in_history[i] * self.TAPS[i], 1, -34, overflow_style=fixed_wrap, round_style=fixed_truncate)

        self.retime1 = sum
        self.retime2 = self.retime1
        self.retime3 = self.retime2

        return self.retime3
        # self.out = self.retime[-1]
        # return self.out
        # for i in range(1, len(self.acc)):
        #     self.acc[i] = self.acc[i - 1] + x * self.TAPSS[len(self.TAPSS) - i]

        # self.acc[1] = self.acc[0] + x * self.TAPSS[3]
        # self.acc[2] = self.acc[1] + x * self.TAPSS[2]
        # self.acc[3] = self.acc[2] + x * self.TAPSS[1]
        # self.acc[4] = self.acc[3] + x * self.TAPSS[0]

        # for i in range(len(self.acc)):
        #     if i == 0:
        #         self.acc[0] = x * self.TAPS[-1]
        #     else:
        #         self.acc[i] = self.acc[i - 1] + x * self.TAPS[len(self.TAPS) - 1 - i]

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


        # return self.acc[-1]

    def model_main(self, x):
        return signal.lfilter(self.TAPS, [1.0], x)


simulations = [MODEL, PYHA, GATE]


def test_remezTT_TTTT():
    np.random.seed(0)
    taps = signal.remez(4, [0, 0.1, 0.2, 0.5], [1, 0])
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 64)

    sims = simulate(dut, inp, simulations=simulations,
                    conversion_path='/home/gaspar/git/pyha/playground')
    # assert_equals(sims)


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
