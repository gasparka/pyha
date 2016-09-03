import matplotlib.pyplot as plt
import numpy as np

from LEGACY.common.register import disable_reg_delay, clock_tick
# NB! when comparing main and abstract, delete group delay from abs end and main start
# idea: just use delayless dc removal?
from common.sfix import Sfix
from test.avg_cascade_dc.casc import Casc

bits = -17


class DCRemoval(object):
    def __init__(self, window_pow, cascade):
        self.iav = Casc(window_pow, cascade)
        self.qav = Casc(window_pow, cascade)

    @clock_tick
    def main(self, new_i, new_q):
        out_i = self.next.iav.main(new_i)
        out_q = self.next.qav.main(new_q)
        return out_i, out_q

    def abstract(self, new_i, new_q):
        out_i = self.iav.abstract(new_i)
        out_q = self.qav.abstract(new_q)

        return out_i, out_q


def csin(samples, wave_freq, fs):
    import math
    phase = 2 * math.pi * wave_freq / fs

    phase_end = samples * phase
    csin = 0.5 * np.exp(1j * np.linspace(0, phase_end, samples)).astype(np.complex64)
    return csin


def test():
    # Sfix.set_float_mode(True)
    disable_reg_delay()  # NOT WORKING WHEN DISABLED
    cs = csin(1024, 10, 10 * 16)
    cs.real += 0.1

    # plt.plot(cs.real)
    # plt.plot(cs.imag)
    # plt.show()

    av = DCRemoval(4, 2)
    ai, aq = av.abstract(cs.real, cs.imag)

    plt.plot(ai)
    plt.plot(aq)
    plt.show()

    # plt.plot(cs.real)
    # plt.plot(cs.imag)
    # plt.show()

    rl = [av.main(Sfix(xi.real, 0, bits), Sfix(xi.imag, 0, bits)) for xi in cs]
    # rl = [av.main(xi.real, xi.imag) for xi in cs]
    ri, rq = zip(*rl)
    ri = [float(x) for x in ri]
    rq = [float(x) for x in rq]
    plt.plot(ri)
    plt.plot(rq)
    plt.show()

    np.testing.assert_almost_equal(ai[:-av.iav.group_delay], ri[av.qav.group_delay:])
    np.testing.assert_almost_equal(aq[:-av.iav.group_delay], rq[av.qav.group_delay:])
    # plt.plot(inp)
    # plt.plot(ab[:-av.group_delay])
    # plt.plot(rl[av.group_delay:])
    # plt.show()
    # np.testing.assert_almost_equal(ab[:-av.group_delay], rl[av.group_delay:])
    # assert (ab[:len(inp)] == rl[:len(inp)]).all()

# test()
