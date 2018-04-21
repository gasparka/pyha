from pyha import Hardware, simulate, sims_close, Sfix
from pyha.common.float import Float
import numpy as np


def to_real(x):
    return x


def test_float():
    class Dut(Hardware):
        def __init__(self, mem):
            # self.counter = Sfix(0.26, 0, -17)
            self.mem = mem

        def main(self, i):
            print(self.mem[i])
            print(to_real(self.mem[i]))
            return self.mem[i]

    # 0.6294942904206591
    orig = np.random.rand(2)
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
    class Dut(Hardware):
        def __init__(self, mem):
            self.mem = Float(0.5265111923217773)

        def main(self, i):
            # print(self.counter)
            return self.mem

    dut = Dut(0)
    inp = list(range(2))

    sims = simulate(dut, inp, simulations=['PYHA',
                                           'RTL',
                                           # 'GATE'
                                           ])
    assert sims_close(sims, rtol=1e-9, atol=1e-9)