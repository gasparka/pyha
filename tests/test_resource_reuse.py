from enum import Enum

import numpy as np
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, fixed_truncate, fixed_wrap
from pyha.simulation.simulation_interface import SIM_HW_MODEL, SIM_RTL, simulate, SIM_GATE
from scipy import signal


class Unit(HW):
    def __init__(self):
        self.mac = Sfix(0.0, left=0, round_style=fixed_truncate, overflow_style=fixed_wrap)

    def main(self, in0, in1):
        self.mac = self.mac + in0 * in1
        return self.mac


def test_basic_share2():
    # quartus shares mult and add (need to hack away the len bug)
    class Dut(HW):
        def __init__(self):
            self.a = [Unit() for x in range(4)]
            self.state = 0

        def main(self, in0, in1):

            # res = [x.main(in0, in1) for x in self.a]
            res = [Sfix()] * 4
            for i in range(len(self.a)):
                res[i] = self.a[i].main(in0, in1)
                # res = x.main(in0, in1)

            # res = self.a[self.state].main(in0, in1)

            # self.state = self.state + 1
            # if self.state >= len(self.a) - 1:
            #     self.state = 0

            return res

    dut = Dut()
    inputs = [[0.1] * 256, [0.1] * 256]
    ret = simulate(dut, *inputs, simulations=[SIM_HW_MODEL, SIM_GATE], dir_path='/home/gaspar/git/pyha/playground')


def rescale_taps(taps):
    """
    Rescale taps in that way that their sum equals 1
    """
    taps = np.array(taps)
    cs = sum(taps)
    # fixme: not sure here, abs seems right as it avoids overflows in core,
    # then again it reduces the fir gain
    # cs = sum(abs(taps))
    for (i, x) in enumerate(taps):
        taps[i] = x / cs

    return taps.tolist()


class FIR(HW):
    """ FIR filter, taps will be normalized to sum 1 """

    def __init__(self, taps):
        self.taps = rescale_taps(taps)

        # registers
        self.acc = [Sfix(left=1, round_style=fixed_truncate, overflow_style=fixed_wrap)] * len(self.taps)
        self.out = Sfix(0, 0, -17, round_style=fixed_truncate)

        # constants
        self.TAPS_REVERSED = [Sfix(x, 0, -17) for x in reversed(self.taps)]
        self.DELAY = 2

    def main(self, x):
        """
        Transposed form FIR implementation, this implementation has problems if you plan to rapidly switch the taps.
        """
        self.acc[0] = x * self.TAPS_REVERSED[0]
        for i in range(1, len(self.TAPS_REVERSED)):
            self.acc[i] = self.acc[i - 1] + x * self.TAPS_REVERSED[i]

        self.out = self.acc[-1]
        return self.out

    def model_main(self, x):
        return signal.lfilter(self.taps, [1.0], x)


class TheEnum(Enum):
    ENUM0, ENUM1, ENUM2, ENUM3 = range(4)

def test_fir_share():

    # shares everything
    class Dut(HW):
        def __init__(self):
            # taps = signal.remez(8, [0, 0.1, 0.2, 0.5], [1, 0])
            self.a = [FIR(np.random.rand(5)) for x in range(5)]
            # self.state = 0
            self.state = 0

        def main(self, in0):

            # res = [Sfix()] * 4
            # for i in range(len(self.a)):
            #     res[i] = self.a[i].main(in0)

            if self.state == 0:
                res = self.a[0].main(in0)
                self.state = 1
            elif self.state == 1:
                res = self.a[1].main(in0)
                self.state = 2
            elif self.state == 2:
                res = self.a[2].main(in0)
                self.state = 4
            elif self.state == 4:
                res = self.a[4].main(in0)
                self.state = 0

            # res = self.a[i].main(in0)
            #
            # self.state = self.state + 1
            # if self.state >= len(self.a) - 1:
            #     self.state = 0

            return res

    dut = Dut()
    inputs = [[0.1] * 256]
    ret = simulate(dut, *inputs, simulations=[SIM_HW_MODEL, SIM_GATE], dir_path='/home/gaspar/git/pyha/playground')
