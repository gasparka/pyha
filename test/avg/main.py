from common.register import disable_reg_delay, clock_tick
from common.sfix import Sfix

bits = -17


# TODO: implement using shift_reg component?
class Average(object):
    def __init__(self, window_pow):
        self.window_pow = window_pow
        self.window = 2 ** window_pow
        self.in_sr = [Sfix(0, 0, bits)] * self.window
        self.sum = Sfix(0)
        self.old = 0

    @clock_tick
    def main(self, new_sample):
        old = self.in_sr[-1]
        self.next.in_sr = [new_sample] + self.in_sr[:-1]

        self.next.sum = (self.sum + new_sample - old).resize(4, bits)
        out = (self.sum >> self.window_pow).resize(0, bits)
        return out

    def abstract(self, x):
        import numpy as np
        return np.convolve(x, np.ones((self.window,)) / self.window, mode='full')


def test():
    import numpy as np
    import matplotlib.pyplot as plt
    disable_reg_delay()
    Sfix.set_float_mode(True)
    inp = np.random.uniform(-1, 1, 1000)
    # inp = range(128)
    av = Average(4)
    ab = av.abstract(inp)

    rl = [float(av.main(Sfix(x, 0, bits))) for x in inp]

    # rl = []
    # for x in inp:
    #     rl.append(av.main(x))

    plt.plot(ab)
    plt.plot(rl)
    plt.show()
    np.testing.assert_almost_equal(ab[:len(inp)], rl[:len(inp)])
    # assert (ab[:len(inp)] == rl[:len(inp)]).all()

# test()
