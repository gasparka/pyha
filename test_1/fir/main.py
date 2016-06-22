import matplotlib.pyplot as plt
import numpy as np
from scipy import signal

from common.register import clock_tick, disable_reg_delay


# NOTE: In docu i could give two examples. One with registered multipliers and other with only adder registers
class FIR(object):
    def __init__(self, order):
        self.order = order
        self.taps = signal.remez(order, [0, 0.1, 0.2, 0.5], [1, 0]).tolist()
        self.sm = [0] * order
        self.mul = [0] * order

    @clock_tick
    def filter(self, x):
        for i in reversed(range(len(self.taps))):
            self.next.mul[i] = x * self.taps[i]
            if i == 0:
                self.next.sm[0] = self.mul[i]
            else:
                self.next.sm[i] = self.sm[i - 1] + self.mul[i]

        return self.sm[-1]

    def abstract(self, x):
        return np.convolve(x, self.taps, mode='full')[:len(x)]


def test():
    disable_reg_delay()
    dut = FIR(32)
    inp = np.random.uniform(-1, 1, 1000)
    abs_result = dut.abstract(inp)

    rtl_result = [dut.filter(x) for x in inp]

    plt.plot(abs_result)
    plt.plot(rtl_result)
    plt.show()

    np.testing.assert_almost_equal(abs_result, rtl_result)


test()
