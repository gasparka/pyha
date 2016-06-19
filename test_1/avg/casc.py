from scipy import signal

from common.register import disable_reg_delay, clock_tick
from test_1.avg.main import Average
import matplotlib.pyplot as plt
import numpy as np


class Casc(object):
    def __init__(self, window_pow, casc=2):
        # self.av = [Average(window_pow)] * casc
        self.av1 = Average(window_pow)
        self.av2 = Average(window_pow)
        self.window_pow = window_pow
        self.window = 2 ** window_pow
        self.group_delay = int((self.window-1) * casc / 2)
        self.in_sr = [0] * self.group_delay
        # self.sum = 0
        # self.old = 0

    @clock_tick
    def main(self, new_sample):
        old = self.in_sr[-1]
        self.next.in_sr = [new_sample] + self.in_sr[:-1]

        stage1 = self.av1.main(new_sample)
        stage2 = self.av2.main(stage1)

        out = old - stage2
        return out

    def abstract(self, x):
        import numpy as np
        c = np.ones(self.window) / self.window
        c2 = np.convolve(c, c, mode='full')
        p = np.convolve(x, c2, mode='same')

        out = x - p
        # p2 = np.convolve(p, np.ones((self.window,)) / self.window, mode='full')
        return out



def test():
    import numpy as np
    import matplotlib.pyplot as plt
    disable_reg_delay()
    inp = np.random.uniform(-1, 1, 1000)
    # inp = range(128)
    av = Casc(8)
    ab = av.abstract(inp)

    rl = [av.main(x) for x in inp]

    plt.plot(ab[:-av.group_delay])
    plt.plot(rl[av.group_delay:])
    plt.show()
    np.testing.assert_almost_equal(ab[:-av.group_delay], rl[av.group_delay:])
    # assert (ab[:len(inp)] == rl[:len(inp)]).all()

test()