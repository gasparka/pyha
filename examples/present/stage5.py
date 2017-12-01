""" Real life example. FIR"""
import numpy as np
from scipy import signal

from pyha.common.fixed_point import Sfix, fixed_saturate
from pyha.common.hwsim import Hardware
from pyha.simulation.simulation_interface import simulate, assert_equals, MODEL, PYHA, RTL

"""
1. Näitan model_main ning teste...4 erinevat reshiimi.
    Demon mingit müra eemaldamise testi, kust visuaalselt näha mis toimps. (jupiter?)
    
* Kuidas model aitab arendusel, saab kasutada pytest unit teste ning testid on TAASKASUTATAVAD, samad testid
    saab jooksutada riistvaras!
* Kuidas asju saab debugida!
* Kuidas keerukaid objekte saab in/outida!
* Taaskasutus...näitan kuidas kaks tükki paralleeri panna ning seriaali...massiivid?
* Näitan kuidas mitu FIRi panna interleaved reshiimi, mis säästab korrutajaid.
* Vaja pöörata tähelepanu põhi abstraktsioonile, mis on main funktsioon, iga call on üks clock
* Teine põhi point on REGISTRID, pyha on siin suht eriline..
* Fixed-point detailid või lasta üle?

* Kui sügavale minna? Kas näidata dev protsessi - see meeldiks mulle aga võtab aega + on detailne.
    Teine võimalus lihtsalt demoda kiirelt kõiki võimalusi.
    Teha kaks eraldi videot? Üks käib kiirelt featuritest üle...teine on rohkem põhjalik?
    Tundub et liiga deep on see....
    Teine võimalus ongi näidata, et FIR on ja kohe hakata taaskasutama seda, ilma detialideta.
    Esimene video peab olema võimalikult lihtne/ilma detailideta ja demoma pyha erinevaid featureid.
    Tundub et 3 videot teha on mõistlik

"""


class FIR(Hardware):
    def __init__(self, taps):
        # constants (written in CAPS)
        self.DELAY = 2
        self.TAPS = np.array(taps).tolist()

        # registers
        self.acc = [Sfix()] * len(taps)
        self.out = Sfix(left=0, right=-17, overflow_style=fixed_saturate)

    def main(self, x):
        """ Hardware implementation, transposed FIR structure """
        for i in range(len(self.acc)):
            if i == 0:
                self.acc[0] = x * self.TAPS[-1]
            else:
                self.acc[i] = self.acc[i - 1] + x * self.TAPS[len(self.TAPS) - 1 - i]

        self.out = self.acc[-1]
        return self.out

    def model_main(self, x):
        """ Golden output """
        return signal.lfilter(self.TAPS, [1.0], x)


simulations = [MODEL, PYHA, RTL]


def test_simple():
    taps = [0.01, 0.02]
    dut = FIR(taps)
    inp = [0.1, 0.2, 0.3, 0.4]

    sims = simulate(dut, inp, simulations=simulations)
    print(sims)
    assert_equals(sims)


def test_wtf():
    taps = [0.01, 0.02, 0.03, 0.04, 0.03, 0.02, 0.01]
    inp = np.random.uniform(-1, 1, 16)
    print(np.convolve(inp, taps, mode='full'))
    print(signal.lfilter(taps, [1.0], inp))


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
    inp = np.random.uniform(-1, 1, 1024)

    import matplotlib.pyplot as plt
    plt.plot(inp)
    plt.show()

    sims = simulate(dut, inp, simulations=simulations)
    import matplotlib.pyplot as plt
    plt.plot(sims['MODEL'])
    plt.plot(sims['HW_MODEL'])
    plt.show()

    assert_equals(sims, rtol=1e-4)

    a = 0.2120513916015625
    b = 0.21208651196033795
    import math
    math.isclose(a, b)


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
    print(len(sims['MODEL']), len(sims['HW_MODEL']))
    assert_equals(sims, rtol=1e-5)

# class FIR(Hardware):
#     def __init__(self, taps):
#         # constants
#         self.DELAY = 1
#         self.TAPS = np.array(taps).tolist()
#
#         # registers
#         self.acc = [Sfix(left=0)] * len(taps)
#
#     def main(self, x):
#
#         for i in range(len(self.acc)):
#             self.acc[i+1] = self.acc[i] + x * self.TAPSS[len(self.TAPSS) - i - 1]
#
#         # for i in range(1, len(self.acc)):
#         #     self.acc[i] = self.acc[i - 1] + x * self.TAPSS[len(self.TAPSS) - i]
#
#         # self.acc[1] = self.acc[0] + x * self.TAPSS[3]
#         # self.acc[2] = self.acc[1] + x * self.TAPSS[2]
#         # self.acc[3] = self.acc[2] + x * self.TAPSS[1]
#         # self.acc[4] = self.acc[3] + x * self.TAPSS[0]
#
#         for i in range(len(self.acc)):
#             if i == 0:
#                 self.acc[0] = x * self.TAPS[-1]
#             else:
#                 self.acc[i] = self.acc[i - 1] + x * self.TAPS[len(self.TAPS) - 1 - i]
#
#         # old = deepcopy(self.acc)
#         # self.acc[0] = x * self.TAPS[1]
#         # self.acc[1] = old[0] + x * self.TAPS[0]
#
#         # for i in range(len(self.acc)):
#         #     if i == 0:
#         #         self.acc[0] = x * self.TAPS[-1]
#         #     else:
#         #         self.acc[i] = old[i - 1] + x * self.TAPS[len(self.TAPS) - 1 - i]
#
#         # self.acc[2] = self.acc[1] + x * self.TAPSS[1]
#         # self.acc[3] = self.acc[2] + x * self.TAPSS[0]
#
#         return self.acc[-1]
#
#     def model_main(self, x):
#         from scipy.signal import lfilter
#         return lfilter(self.TAPS, [1.0], x)
