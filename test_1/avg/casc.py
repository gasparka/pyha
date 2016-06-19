from scipy import signal

from common.register import disable_reg_delay, clock_tick
from test_1.avg.main import Average
import matplotlib.pyplot as plt
import numpy as np

# TODO: BUG when register turned ON (extra delay from Average module)
class Casc(object):
    def __init__(self, window_pow, casc=2):
        self.casc = casc
        self.av = [Average(window_pow) for _ in range(casc)]
        self.window_pow = window_pow
        self.window = 2 ** window_pow
        self.group_delay = int((self.window-1) * casc / 2)
        self.in_sr = [0] * (self.group_delay)

    @clock_tick
    def main(self, new_sample):
        old = self.in_sr[-1]
        self.next.in_sr = [new_sample] + self.in_sr[:-1]


        r = new_sample
        for x in self.av:
            r = x.main(r)

        out = old - r
        return out

    def abstract(self, x):
        import numpy as np
        c = np.ones(self.window) / self.window

        # multiple pass of average filter is equal to filter kernels convolced togather
        c2 = c[:]
        for _ in range(self.casc-1):
            c2 = np.convolve(c2, c, mode='full')

        p = np.convolve(x, c2, mode='full')
        out = x - p[self.group_delay:-self.group_delay]

        return out


# generate signal
def sin_real(freq, amp=1, phase=0):
    "Generate sinusoid"
    duration = 1.0
    fs = freq * 16
    samples = int(fs * duration)
    t = np.arange(samples) / float(fs)

    return amp * np.sin(2 * np.pi * freq * t + phase)


def test():
    import numpy as np
    import matplotlib.pyplot as plt
    disable_reg_delay()
    inp = np.random.uniform(-1, 1, 1000)
    av = Casc(8, 2)
    ab = av.abstract(inp)

    rl = [av.main(x) for x in inp]

    # plt.plot(inp)
    plt.plot(ab[:-av.group_delay])
    plt.plot(rl[av.group_delay:])
    plt.show()
    np.testing.assert_almost_equal(ab[:-av.group_delay], rl[av.group_delay:])
    # assert (ab[:len(inp)] == rl[:len(inp)]).all()


def test2():
    import numpy as np
    import matplotlib.pyplot as plt
    disable_reg_delay()

    ss = sin_real(100)
    inp = ss + 2
    av = Casc(8, 2)
    ab = av.abstract(inp)

    rl = [av.main(x) for x in inp]

    # plt.plot(inp)
    plt.plot(ab)
    plt.plot(rl)
    plt.show()
    np.testing.assert_almost_equal(ab[:-av.group_delay], rl[av.group_delay:])

# test2()