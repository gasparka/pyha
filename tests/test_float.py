from pyha import Hardware, simulate, sims_close, Sfix
from pyha.common.float import Float
import numpy as np

from pyha.common.util import to_real


def test_float():
    class Dut(Hardware):
        def __init__(self, mem):
            # self.counter = Sfix(0.26, 0, -17)
            self.mem = mem

        def main(self, i):
            # print(to_real(self.mem[i]))
            # print(self.mem[i])
            return self.mem[i]

    # 0.6294942904206591
    N = 1024 * 2
    gain = 2**np.random.uniform(-64, 64, N)
    orig = (np.random.rand(N) * 2 -1) * gain
    rnd = [Float(x) for x in orig]
    dut = Dut(rnd)
    inp = list(range(len(rnd)))

    sims = simulate(dut, inp, simulations=['PYHA',
                                           'RTL',
                                           # 'GATE'
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