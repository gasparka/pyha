from math import isclose

from pyha import Hardware, simulate, sims_close, Sfix
from pyha.common.float import Float
import numpy as np

from pyha.common.util import to_real, to_twoscomplement


class TestInit:
    """ Test that float is correctly constructed and VHDL loopback works """

    def test_one(self):
        a = Float(1.0)
        assert a.sign == 1
        assert a.exponent == 1
        assert a.fractional == 1 / Float.radix
        assert float(a) == 1.0

    def test_negone(self):
        a = Float(-1.0)
        assert a.sign == -1
        assert a.exponent == 1
        assert a.fractional == 1 / Float.radix
        assert float(a) == -1.0

    def test_init_sidecase(self):
        a = Float(0.1248085669335865)
        assert a.sign == 1
        assert a.exponent == 0
        assert a.fractional == 0.12481689453125

    def test_random(self):
        np.random.seed(0)
        N = 2**17
        gain = 2 ** np.random.uniform(-8, 8, N)
        input = (np.random.rand(N) * 2 - 1) * gain
        output = [float(Float(x)) for x in input]
        np.testing.assert_allclose(input, output, rtol=1e-3)




def test_loopbackkk():
    class Dut(Hardware):
        def main(self, i):
            return i

    # 0.1248085669335865
    N = 1024 * 2
    gain = 2 ** np.random.uniform(-8, 8, N)
    orig = (np.random.rand(N) * 2 - 1) * gain
    # orig = [0.1, 0.2, 0.3, -0.3, 125.0, -152.0, 0.00001, -64.000000000000000, -32.00, 64.000000000000000]
    rnd = [Float(x) for x in orig]
    dut = Dut()

    sims = simulate(dut, rnd, simulations=['PYHA',
                                           'RTL',
                                           'GATE'
                                           ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_float_init():
    class Dut(Hardware):
        def __init__(self, mem):
            self.mem = mem

        def main(self, i):
            return self.mem[i]

    # 0.6294942904206591
    N = 1024 * 2
    gain = 2 ** np.random.uniform(-64, 64, N)
    orig = (np.random.rand(N) * 2 - 1) * gain
    rnd = [Float(x) for x in orig]
    dut = Dut(rnd)
    inp = list(range(len(rnd)))

    sims = simulate(dut, inp, simulations=['PYHA',
                                           'RTL',
                                           # 'GATE'
                                           ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_loopback():
    class Dut(Hardware):
        def main(self, i):
            return i

    N = 1024 * 2
    gain = 2 ** np.random.uniform(-64, 64, N)
    orig = (np.random.rand(N) * 2 - 1) * gain
    rnd = [Float(x) for x in orig]
    dut = Dut()

    sims = simulate(dut, rnd, simulations=['PYHA',
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
