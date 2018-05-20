from pyha import Hardware, simulate, sims_close
from pyha.common.float import Float
import numpy as np


class TestInit:
    """ Test that float is correctly constructed and VHDL loopback works """

    def test_one(self):
        a = Float(1.0)
        assert a.sign == 0
        assert a.exponent == 1
        assert a.fractional == 1 / Float.radix
        assert float(a) == 1.0

    def test_negone(self):
        a = Float(-1.0)
        assert a.sign == 1
        assert a.exponent == 1
        assert a.fractional == 1 / Float.radix
        assert float(a) == -1.0

    def test_init_sidecase(self):
        a = Float(0.1248085669335865)
        assert a.sign == 0
        assert a.exponent == 0
        assert a.fractional == 0.12481689453125

    def test_random(self):
        np.random.seed(0)
        N = 2 ** 16
        gain = 2 ** np.random.uniform(-8, 8, N)
        input = (np.random.rand(N) * 2 - 1) * gain
        output = [float(Float(x)) for x in input]
        np.testing.assert_allclose(input, output, rtol=1e-3)  # holds for Radix 32, 3 exp 14 mantissa

    def test_loopback(self):
        class Dut(Hardware):
            def main(self, i):
                return i

        N = 1024
        gain = 2 ** np.random.uniform(-8, 8, N)
        input = (np.random.rand(N) * 2 - 1) * gain

        dut = Dut()
        sims = simulate(dut, input, input_types=[Float()], simulations=['PYHA',
                                                                        'RTL',
                                                                        # 'GATE'
                                                                        ],
                        conversion_path='/home/gaspar/git/pyha/playground')
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_memory(self):
        class Dut(Hardware):
            def __init__(self, mem):
                self.mem = mem

            def main(self, i):
                return self.mem[i]

        N = 1024
        gain = 2 ** np.random.uniform(-8, 8, N)
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
