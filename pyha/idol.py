
from pyha.common.const import Const
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL
from scipy import signal
import numpy as np

def normalize_taps(taps):
    """
    Rescale taps in that way that their abs sum equals 1, this assures no overflows in filter cores
    """
    taps = np.array(taps)
    cs = sum(abs(taps))
    for (i, x) in enumerate(taps):
        taps[i] = x / cs

    return taps.tolist()

class FIR(HW):
    """ FIR filter, taps will be normalized to sum 1 """
    def __init__(self, taps, type):
        self.taps = normalize_taps(taps)

        # registers
        self.mul = [Sfix(0.0)] * len(self.taps)
        self.acc = [Sfix(0.0, left=1, right=self.mul[0].right)] * len(self.taps)
        self.out = type

        # constants
        self.taps_fix_reversed = Const([Sfix(x, 0, -17) for x in reversed(self.taps)])
        self._delay = 3

    def main(self, x):
        """
        Transposed form FIR implementation, uses full precision
        """
        for i in range(len(self.taps_fix_reversed)):
            self.next.mul[i] = x * self.taps_fix_reversed[i]
            if i == 0:
                self.next.acc[0] = self.mul[i]
            else:
                self.next.acc[i] = self.acc[i - 1] + self.mul[i]

        self.next.out = self.acc[-1]
        return self.out

    def model_main(self, x):
        return signal.lfilter(self.taps, [1.0], x)


def test_non_symmetric():
    taps = [0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07]
    dut = FIR(taps, type=Sfix(left=0, right=-17))
    inp = np.random.uniform(-1, 1, 128)

    assert_sim_match(dut, [Sfix(left=0, right=-17)], None, inp,
                     simulations=[SIM_HW_MODEL],
                     rtol=1e-4,
                     atol=1e-4)