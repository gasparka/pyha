from pyha import Hardware, simulate, sims_close, Sfix
from pyha.common.float import Float
import numpy as np

from pyha.common.util import to_real


def test_float_init():
    class Dut(Hardware):
        def __init__(self, mem):
            self.mem = mem

        def main(self, i):
            return self.mem[i]

    # 0.6294942904206591
    N = 1024 * 2
    gain = 2**np.random.uniform(-64, 64, N)
    orig = (np.random.rand(N) * 2 -1) * gain
    rnd = [Float(x) for x in orig]
    dut = Dut(rnd)
    inp = list(range(len(rnd)))

    sims = simulate(dut, inp, simulations=['PYHA',
                                           # 'RTL',
                                           'GATE'
                                           ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_loopback():
    class Dut(Hardware):
        def main(self, i):
            return i

    N = 1024 * 2
    gain = 2**np.random.uniform(-64, 64, N)
    orig = (np.random.rand(N) * 2 -1) * gain
    rnd = [Float(x) for x in orig]
    dut = Dut()

    sims = simulate(dut, rnd, simulations=['PYHA',
                                           'RTL',
                                           'GATE'
                                           ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_multiply():
    class Dut(Hardware):
        def main(self, a, b):
            r = a * b
            return r

    N = 1024 * 2
    gain = 2**np.random.uniform(-64, 64, N)
    orig = (np.random.rand(N) * 2 -1) * gain
    a = [Float(x) for x in orig]

    N = 1024 * 2
    gain = 2**np.random.uniform(-64, 64, N)
    orig = (np.random.rand(N) * 2 -1) * gain
    b = [Float(x) for x in orig]
    # a = [Float(0.1)]
    # b = [Float(0.1)]
    dut = Dut()

    sims = simulate(dut, a, b, simulations=['PYHA',
                                           'RTL',
                                           'GATE'
                                           ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_add():
    class Dut(Hardware):
        def main(self, a, b):
            r = a + b
            return r

    N = 32
    gain = 2**np.random.uniform(-64, 64, N)
    orig = (np.random.rand(N) * 2 -1) * gain
    a = [Float(x) for x in orig]

    gain = 2**np.random.uniform(-64, 64, N)
    orig = (np.random.rand(N) * 2 -1) * gain
    b = [Float(x) for x in orig]
    # a = [Float(0.1)]
    # b = [Float(0.1)]
    dut = Dut()

    sims = simulate(dut, a, b, simulations=['PYHA',
                                           'RTL',
                                           # 'GATE'
                                           ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims, rtol=1e-9, atol=1e-9)



def test_add_single():
    class Dut(Hardware):
        def main(self, a, b):
            r = a + b
            return a, b, r

    a = [Float(0.1)]
    b = [Float(0.000000001)]
    dut = Dut()
    from mpmath import mp, mpf
    mp.prec = 26

    r = mpf(0.1) + mpf(0.000000001)

    sims = simulate(dut, a, b, simulations=['PYHA',
                                           'RTL',
                                           'GATE'
                                           ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_float_single():

    # 0.003999948501587
    # 0.003999999724328518 VHDL


    class Dut(Hardware):
        def __init__(self, mem):
            # self.mem = Float(0.004)
            self.mem = Float(0.0298728998750)

        def main(self, i):
            print(to_real(self.mem))
            print(self.mem)
            return self.mem

    dut = Dut(0)
    inp = list(range(2))

    sims = simulate(dut, inp, simulations=['PYHA',
                                           'RTL',
                                           # 'GATE'
                                           ],
                    conversion_path='/home/gaspar/git/pyha/playground'
                    )
    assert sims_close(sims, rtol=1e-9, atol=1e-9)