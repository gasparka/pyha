from pyha import Hardware, simulate, sims_close, Complex
from pyha.common.shift_register import ShiftRegister
import numpy as np


def test_basic():
    class T(Hardware):
        def __init__(self, data):
            self.shr_new = ShiftRegister(data)
            self.shr_old = data

        def main(self, inp):
            self.shr_new.push_next(inp)
            self.shr_old = self.shr_old[1:] + [inp]
            return self.shr_new.peek(), self.shr_old[0]

    N = 128
    dut = T([0] * N)

    sims = simulate(dut, list(range(N * 2)), simulations=['PYHA',
                                                           'RTL',
                                                         'GATE'
                                                         ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims['PYHA'][0] == sims['PYHA'][1]
    assert sims_close(sims)


def test_complex():
    class T(Hardware):
        def __init__(self, data):
            self.shr_new = ShiftRegister(data)
            self.shr_old = data

        def main(self, inp):
            self.shr_new.push_next(inp)
            self.shr_old = self.shr_old[1:] + [inp]
            return self.shr_new.peek(), self.shr_old[0]

    N = 32
    dut = T([Complex(0.0+0.0j, 0, -17) for _ in range(N)])

    inp = np.random.uniform(-1, 1, N * 2) + np.random.uniform(-1, 1, N * 2) * 1j
    sims = simulate(dut, inp, simulations=['PYHA',
                                                           'RTL',
                                                         'GATE'
                                                         ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims['PYHA'][0] == sims['PYHA'][1]
    assert sims_close(sims)