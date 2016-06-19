from scipy import signal

from common.register import disable_reg_delay, clock_tick
from test_1.avg.casc import Casc
from test_1.avg.main import Average
import matplotlib.pyplot as plt
import numpy as np

# NB! when comparing main and abstract, delete group delay from abs end and main start
# idea: just use delayless dc removal?
class DCRemoval(object):
    def __init__(self):
        self.iav = Casc(8, 4)
        self.qav = Casc(8, 4)

    @clock_tick
    def main(self, new_i, new_q):
        out_i = self.iav.main(new_i)
        out_q = self.qav.main(new_q)
        return out_i, out_q

    def abstract(self, new_i, new_q):
        out_i = self.iav.abstract(new_i)
        out_q = self.qav.abstract(new_q)

        return out_i, out_q


def csin(samples, wave_freq, fs):
    import math
    phase = 2 * math.pi * wave_freq / fs

    phase_end = samples * phase
    csin = np.exp(1j * np.linspace(0, phase_end, samples)).astype(np.complex64)
    return csin

def test():
    disable_reg_delay() # NOT WORKING WHEN DISABLED
    cs = csin(1024, 10, 10*16)
    cs.real += 0.1

    # plt.plot(cs.real)
    # plt.plot(cs.imag)
    # plt.show()

    av = DCRemoval()
    ai,aq = av.abstract(cs.real, cs.imag)

    plt.plot(ai)
    plt.plot(aq)
    plt.show()

    # plt.plot(cs.real)
    # plt.plot(cs.imag)
    # plt.show()

    rl = [av.main(xi.real, xi.imag) for xi in cs]
    ri, rq = zip(*rl)
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

test()