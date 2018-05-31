from math import isclose
import pytest
from scipy import signal
from pyha import Hardware, simulate, sims_close, hardware_sims_equal
from pyha.common.float import Float
import numpy as np
from pyha.simulation.simulation_interface import get_ran_gate_simulation
from pyha.simulation.vhdl_simulation import VHDLSimulation


# TODO: VERY IMPORTANT THAT TESTS IN THIS FILE CHECK EXPONENT NOT ONLY RETURNED FLOAT VALUE!


class TestInit:
    """ Test that float is correctly constructed and VHDL loopback works """

    def test_one(self):
        a = Float(1.0)
        assert a.sign == 0
        assert a.exponent == 1
        assert a.fractional == 1 / 32
        assert float(a) == 1.0

    def test_negone(self):
        a = Float(-1.0)
        assert a.sign == 1
        assert a.exponent == 1
        assert a.fractional == 1 / 32
        assert float(a) == -1.0

    def test_init_sidecase(self):
        a = Float(0.1248085669335865)
        assert a.sign == 0
        assert a.exponent == 0
        assert a.fractional == 0.12481689453125

    def test_zero_minimum_exponent(self):
        """ Encode 0 with minimal exponent, else zero values may kill additions """
        a = Float(0.000000001)
        assert a.sign == 0
        assert a.exponent == -4
        assert a.fractional == 0.0

    def test_no_negative_zero_init(self):
        """ Try to avoid negative zero if possible """
        a = Float(-0.000000001)
        assert a.sign == 0
        assert a.exponent == -4
        assert a.fractional == 0.0

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

    def test_bug(self):
        """ Normalizing used to quantize, this should be turned off for constants """
        val = 0.0013305734842478762
        assert isclose(Float(val), val, rel_tol=1e-2)

    def test_case(self):
        val = 17.429206550940457
        assert isclose(Float(val), val, rel_tol=1e-2)


class TestPy:
    """ Test against python float """
    N = 2 ** 15
    exp_bits = 8
    fra_bits = 32

    def test_new_mult(self):
        gain = 2 ** np.random.uniform(-32, 32, self.N)
        origa = (np.random.rand(self.N) * 2 - 1) * gain

        gain = 2 ** np.random.uniform(-32, 32, self.N)
        origb = (np.random.rand(self.N) * 2 - 1) * gain

        for a, b in zip(origa, origb):
            expected = a * b
            real = Float(a, self.exp_bits, self.fra_bits) * Float(b, self.exp_bits, self.fra_bits)
            assert isclose(real, expected, rel_tol=1e-6)

    def test_add_sign(self):
        """ Bug: addition resulted in wrong sign """

        ai = 0.05305128887213797
        bi = -2.16405947606799e-07

        a = Float(ai, self.exp_bits, self.fra_bits)
        b = Float(bi, self.exp_bits, self.fra_bits)

        result = a + b
        expected = ai + bi

        assert isclose(float(result), expected, rel_tol=1e-5)

        ai = -7.124850106849597e-09
        bi = -1.3869622091703274e-08

        a = Float(ai, self.exp_bits, self.fra_bits)
        b = Float(bi, self.exp_bits, self.fra_bits)

        result = a + b
        expected = ai + bi

        assert isclose(float(result), expected, rel_tol=1e-5)

        ai = -4.454377473702924
        bi = 1.4396189355044617

        a = Float(ai, self.exp_bits, self.fra_bits)
        b = Float(bi, self.exp_bits, self.fra_bits)

        result = a + b
        expected = ai + bi

        assert isclose(float(result), expected, rel_tol=1e-5)

    def test_new_add(self):
        gain = 2 ** np.random.uniform(-32, 32, self.N)
        origa = (np.random.rand(self.N) * 2 - 1) * gain

        gain = 2 ** np.random.uniform(-32, 32, self.N)
        origb = (np.random.rand(self.N) * 2 - 1) * gain

        for a, b in zip(origa, origb):
            expected = a + b
            real = float(Float(a, self.exp_bits, self.fra_bits) + Float(b, self.exp_bits, self.fra_bits))
            assert isclose(real, expected, rel_tol=1e-5)

    def test_new_sub(self):
        gain = 2 ** np.random.uniform(-32, 32, self.N)
        origa = (np.random.rand(self.N) * 2 - 1) * gain

        gain = 2 ** np.random.uniform(-32, 32, self.N)
        origb = (np.random.rand(self.N) * 2 - 1) * gain

        for a, b in zip(origa, origb):
            expected = a - b
            real = float(Float(a, self.exp_bits, self.fra_bits) - Float(b, self.exp_bits, self.fra_bits))
            assert isclose(real, expected, rel_tol=1e-5)

    def test_suber(self):
        """ Bug in - routine - need to quantize everything """
        a = 0.000006556510925
        b = 2000.000000000000000

        expected = a - b
        real = float(Float(a, self.exp_bits, self.fra_bits) - Float(b, self.exp_bits, self.fra_bits))
        print(real, expected)
        assert isclose(real, expected, rel_tol=1e-6)


class TestAdd:
    # todo: test exp diff overflow...
    def setup(self):
        class Dut(Hardware):
            def main(self, a, b):
                r = a + b
                return r

        self.dut = Dut()

    def test_no_normal(self):
        """ Needs no normalization """
        a = 0.1
        b = 0.1

        sims = simulate(self.dut, a, b, input_types=([Float(0.0), Float(0.0)]),
                        simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])

        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_input_normal(self):
        """ Needs only input normalization """
        a = 0.1
        b = 0.01

        sims = simulate(self.dut, a, b, input_types=([Float(0.0), Float(0.0)]),
                        simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_bad_accuracy(self):
        """ 1 More bit, to fix, or radix 16?? """
        pytest.skip('for now')
        a = 0.1
        b = -0.0999

        sims = simulate(self.dut, a, b, input_types=([Float(0.0), Float(0.0)]),
                        simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_exponent_overflow(self):
        """ Adding values with 0 and -16 exponents results in difference in 16, which does not fit in 5 bits... """
        pytest.skip('OLD')
        a = 0.7
        b = 2 ** -17
        print(Float(b).exponent)

        sims = simulate(self.dut, a, b, input_types=([Float(0.0, 5, 9), Float(0.0, 5, 9)]),
                        simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_ones(self):
        base = 1
        a = [Float(base), Float(-base), Float(base), Float(-base)]
        b = [Float(base), Float(base), Float(-base), Float(-base)]

        sims = simulate(self.dut, a, b, simulations=['PYHA', 'RTL'])

        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_result_zero(self):
        a = 1.0
        b = -1.0

        sims = simulate(self.dut, a, b, input_types=([Float(0.0), Float(0.0)]),
                        simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_overflow(self):
        """ Addition overflows ie. need to normalize the result """
        a = -1.0
        b = -1.0

        sims = simulate(self.dut, a, b, input_types=([Float(0.0), Float(0.0)]),
                        simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_need_normalize1(self):
        a = 0.12
        b = -a * 0.9

        sims = simulate(self.dut, a, b, input_types=([Float(0.0), Float(0.0)]),
                        simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert sims['RTL'].exponent == -1
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_need_normalize2(self):
        a = 0.12
        b = -a * 0.995

        sims = simulate(self.dut, a, b, input_types=([Float(0.0), Float(0.0)]),
                        simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert sims['RTL'].exponent == -2
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_result_near_zero(self):
        a = 0.12
        b = -a * 0.9999

        sims = simulate(self.dut, a, b, input_types=([Float(0.0), Float(0.0)]),
                        simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert float(sims['PYHA'][0]) == 0.0
        assert hardware_sims_equal(sims)
        # assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_no_round(self):
        """ Python side had rounding when converted to Float """

        a = [Float(0.235351562500000)]
        b = [Float(0.045410156250000)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_bug_invalid_norm(self):
        """ Failed on invalid normalization """
        a = [Float(6432.000000000000000)]
        b = [Float(4224.000000000000000)]
        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_normalize_grows(self):
        """ Add grows by one bit """

        a = [Float(0.990)]
        b = [Float(0.990)]
        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_no_add(self):
        """ Difference between operands is too big ie. add has no effect at all """
        a = [Float(0.99)]
        b = [Float(-0.000051)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_preadjust_minimal2(self):
        a = [Float(0.99)]
        b = [Float(-0.00000051)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_normalize_shrink1(self):
        """ Add shrinks by one bit """

        a = [Float(0.99), Float(-0.99), Float(-0.98172), Float(0.98172)]
        b = [Float(-0.51), Float(0.51), Float(0.5315), Float(-0.5315)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_normalize_shrink2(self):
        """ Add shrinks by 2 bit """
        a = [Float(0.99), Float(-0.99)]
        b = [Float(-0.751), Float(0.751)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    @pytest.mark.parametrize('shrink_bits', [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17])
    def test_normalize_shrink3(self, shrink_bits):
        """ Result needs shifting left """

        low = 1.0 - (2 ** -shrink_bits)
        a = [Float(1.0), Float(-0.99)]
        b = [Float(-low), Float(low)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])

        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_unsiged_sub_bug(self):
        """ Exponents here are equal..but in case of unsigned math we must always subtract smaller exponent from larger.. ie. full comparison is needed in hardware! """

        low = 1.0 - (2 ** -7)
        a = [Float(-0.99)]
        b = [Float(low)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        print(sims)

        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    @pytest.mark.parametrize('base', [1, 0, 0.0000432402, 12380, 0.0000000002342, 3247])
    def test_same_args(self, base):
        a = [Float(base), Float(-base), Float(base), Float(-base)]
        b = [Float(base), Float(base), Float(-base), Float(-base)]

        sims = simulate(self.dut, a, b, simulations=['PYHA', 'RTL'])

        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_same_args_bug(self):
        """ Exponent undeflow... """
        a = [Float(-0.0000000002342)]
        b = [Float(0.0000000002342)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_normalize_minimal_negative(self):
        """ Second case is 'negative zero', or minimal negative number """

        shrink_bits = 6

        low = 1.0 - (2 ** -shrink_bits)
        a = [Float(0.99), Float(-0.99)]
        b = [Float(-low), Float(low)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_bug(self):
        """ Failed on invalid normalization """

        a = [Float(0.004577636718750)]
        b = [Float(1112.000000000000000)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        '1112.000000000000000 011:000001000101100'
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_add_random(self):
        N = 2 ** 14
        gain = 2 ** np.random.uniform(-16, 8, N)
        orig = (np.random.rand(N)) * gain
        a = [Float(x) for x in orig]

        gain = 2 ** np.random.uniform(-16, 8, N)
        orig = (np.random.rand(N)) * gain
        b = [Float(x) for x in orig]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])

        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_sign_bug(self):
        a = [Float(1.625000000000000)]
        b = [Float(-0.611755371093750)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

        a = [Float(0.095031738281250)]
        b = [Float(-2.0548964193706665)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

        a = [Float(0.05305128887213797)]
        b = [Float(-2.16405947606799e-07)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

        a = [Float(-7.124850106849597e-09)]
        b = [Float(-1.3869622091703274e-08)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

        a = [Float(-4.454377473702924)]
        b = [Float(1.4396189355044617)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_exponent_underflow(self):
        a = [Float(0.0000001)]
        b = [Float(-0.000000095)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_add_resources(self):
        # 4: 128
        # 5: 139
        # 6: 148 (+9)
        # 7: 153 (+5)
        # 8: 161 (+8)
        # 9: 167 (+6)
        # 10:173 (+6)

        # NEW 32 radix: 113 (3, 15)
        # radix 16: 79 (3, 12)
        # radix 16: 88 (4, 12)

        # 36 bit fixed point adder: 37
        # 18 bit fixed point adder: 19

        # preadd R32 3, 15: Total logic elements : 47 (43 with unsigned)
        # preadd R16 4, 14, : Total logic elements : 56 (with dynamic shifter)

        # R32, 3, 15 -> final signed 122
        # R32, 3, 15 -> final UNSign 140 (verified, works as PY, safe 0)

        # NEW 80

        a = [Float(0.99, 3, 14)]
        b = [Float(-0.000051, 3, 14)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'GATE'
                                                     ],
                        conversion_path='/home/gaspar/git/pyha/playground'
                        )
        assert VHDLSimulation.last_logic_elements == 141

    def test_small_bug(self):
        """  Interesting bug where 2 normalizing conditions (0 and overflow) fired at the same time... resulting in wrong sign"""
        a = [Float(-0.000000855536200)]
        b = [Float(-1.0936355228858843e-07)]
        # -1.0936355228858843e-07

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)


class TestAccumulator:
    def setup(self):
        class Accumulator(Hardware):
            def __init__(self):
                self.DELAY = 1
                self.acc = Float(0.0)

            def main(self, x):
                self.acc += x
                return self.acc

        self.dut = Accumulator()

    def test_normal(self):
        inp = np.random.normal(size=1024 * 2 * 2)
        sims = simulate(self.dut, inp, input_types=[Float()], simulations=['PYHA', 'RTL'])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_normal_small(self):
        inp = np.random.normal(size=1024 * 2 * 2) * 0.0000001
        sims = simulate(self.dut, inp, input_types=[Float()], simulations=['PYHA', 'RTL'])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_normal_abs(self):
        inp = np.random.normal(size=1024 * 2 * 2)
        sims = simulate(self.dut, inp, input_types=[Float()], simulations=['PYHA', 'RTL'])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_uniform(self):
        inp = np.random.uniform(-1, 1, size=1024 * 2 * 2)
        sims = simulate(self.dut, inp, input_types=[Float()], simulations=['PYHA', 'RTL'])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_uniform_pos(self):
        inp = np.random.uniform(0, 1, size=1024 * 2 * 2)
        sims = simulate(self.dut, inp, input_types=[Float()], simulations=['PYHA', 'RTL'])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_uniform_neg(self):
        inp = np.random.uniform(-1, 0, size=1024 * 2 * 2)
        sims = simulate(self.dut, inp, input_types=[Float()], simulations=['PYHA', 'RTL'])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)


class TestNegate:
    def setup(self):
        class Dut(Hardware):
            def main(self, a):
                r = -a
                return r

        self.dut = Dut()

    def test_random(self):
        N = 2 ** 12
        gain = 2 ** np.random.uniform(-8, 8, N)
        orig = (np.random.rand(N)) * gain
        a = [Float(x) for x in orig]

        sims = simulate(self.dut, a, simulations=['PYHA',
                                                  'RTL',
                                                  ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)


class TestSub:
    def setup(self):
        class Dut(Hardware):
            def main(self, a, b):
                r = a - b
                return r

        self.dut = Dut()

    def test_sub_normalize(self):
        """ Python normalization resulted in X.50, needed to use // instead of / """
        shrink_bits = 6
        low = 1.0 - (2 ** -shrink_bits)
        a = [Float(0.99), Float(-0.99)]
        b = [Float(-low), Float(low)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_suber(self):
        """ Bug in - routine """

        a = [Float(0.000006556510925)]
        b = [Float(2000.000000000000000)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_sub_random(self):
        N = 2 ** 15
        gain = 2 ** np.random.uniform(-8, 8, N)
        orig = (np.random.rand(N)) * gain
        a = [Float(x) for x in orig]

        gain = 2 ** np.random.uniform(-8, 8, N)
        orig = (np.random.rand(N)) * gain
        b = [Float(x) for x in orig]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'RTL',
                                                     # 'GATE'
                                                     ])
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_sub_resources(self):
        # 141
        a = [Float(0.99)]
        b = [Float(-0.000051)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'GATE'
                                                     ],
                        conversion_path='/home/gaspar/git/pyha/playground'
                        )
        assert VHDLSimulation.last_logic_elements == 141


class TestMultiply:
    # todo -1 * -1
    def setup(self):
        class Dut(Hardware):
            def main(self, a, b):
                r = a * b
                return r

        self.dut = Dut()

    def test_one(self):
        a = 1.0
        b = 1.0
        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['PYHA',
                                                                                       'RTL',
                                                                                       # 'GATE'
                                                                                       ],
                        )
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-3, atol=1e-9)

    def test_one1(self):
        a = -1.0
        b = 1.0
        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['PYHA',
                                                                                       'RTL',
                                                                                       # 'GATE'
                                                                                       ],
                        )
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-3, atol=1e-9)

    def test_one2(self):
        a = 1.0
        b = -1.0
        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['PYHA',
                                                                                       'RTL',
                                                                                       # 'GATE'
                                                                                       ],
                        )
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-3, atol=1e-9)

    def test_overflow(self):
        a = -1.0
        b = -1.0
        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['PYHA',
                                                                                       'RTL',
                                                                                       # 'GATE'
                                                                                       ],
                        )
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-3, atol=1e-9)

    def test_basic(self):
        a = 0.1
        b = 0.1
        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['PYHA',
                                                                                       'RTL',
                                                                                       # 'GATE'
                                                                                       ],
                        )
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-3, atol=1e-9)

    def test_random(self):
        N = 2 ** 15
        gain = 2 ** np.random.uniform(-128, 6, N)
        b = (np.random.rand(N)) * gain

        gain = 2 ** np.random.uniform(-128, 6, N)
        a = (np.random.rand(N)) * gain

        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])

        assert hardware_sims_equal(sims)
        # sims_close(sims, rtol=1e-2, atol=1e-9)
        # pass

    def test_bug(self):
        """ Underflows exponent """
        a = 0.00028989960671009095
        b = 8.758479182399817e-05

        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['PYHA', 'RTL'])
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_low_precision(self):
        """ Due to low bitwidth"""
        a = 0.004253224423436781
        b = 17.429206550940457

        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_pyimp_bug1(self):
        a = 1.039062500000000
        b = 0.006103515625000

        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-2, atol=1e-9)

    def test_pyimp_bug2(self):
        a = 20.625000000000000
        b = 92.000000000000000

        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-3, atol=1e-9)

    def test_pyimp_bug3(self):
        a = 25.92627651759698
        b = 21.710133331565316

        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-2, atol=1e-9)

    def test_pyimp_bug4(self):
        """ Py implentation failed to normalize by 1 bit """
        a = 1.2125418755917348
        b = 0.006447032941809564

        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-2, atol=1e-9)

    def test_pyimp_bug5(self):
        """ Py failed at normalzing 1.0, which in turn overflowed in RTL """
        a = 0.031226401706880076
        b = 0.0013305734842478762

        # 0.007817297415263467
        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_arg_zero(self):
        N = 2 ** 12

        gain = 2 ** np.random.uniform(-8, 8, N)
        a = (np.random.rand(N)) * gain

        b = [0] * len(a)

        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])

        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-9, atol=1e-9)

    def test_underflow(self):
        a = 0.00001
        b = 0.00001

        # 0.007817297415263467
        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_resources(self):
        # UNSIGNED: 26 LUT
        # safe Zero: 44
        a = 0.99
        b = -0.000051

        simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['PYHA', 'GATE'],
                 conversion_path='/home/gaspar/git/pyha/playground'
                 )
        if not get_ran_gate_simulation():
            pytest.skip('Gate did not run..')
        assert VHDLSimulation.last_logic_elements == 44


class TestFIR:
    class FIR(Hardware):
        def __init__(self, taps):
            self.DELAY = 2

            self.TAPS = [Float(x) for x in np.array(taps).tolist()]
            self.TAPS_ORIG = taps

            # registers
            self.acc = [Float()] * len(taps)
            self.mul = [Float()] * len(taps)

        def main(self, x):
            """ Transposed FIR structure """
            self.acc[0] = x * self.TAPS[-1]
            for i in range(1, len(self.acc)):
                self.mul[i] = x * self.TAPS[len(self.TAPS) - 1 - i]
                self.acc[i] = self.acc[i - 1] + self.mul[i]

            return self.acc[-1]

        def model_main(self, x):
            return signal.lfilter(self.TAPS_ORIG, [1.0], x)

    def test_simple(self):
        taps = signal.remez(32, [0, 0.1, 0.155, 0.5], [1, 0])
        inp = np.random.uniform(-1, 1, 1024)

        sims = simulate(self.FIR(taps), inp, input_types=([Float()]), simulations=['PYHA', 'RTL'],
                        conversion_path='/home/gaspar/git/pyha/playground')
        assert hardware_sims_equal(sims)

    def test_small_input(self):
        taps = np.random.uniform(-1, 1, 128) / 2 / 2 / 2 / 2 / 2 / 2 / 2
        inp = np.random.uniform(-1, 1, 1024) / 2 / 2 / 2 / 2 / 2 / 2 / 2

        sims = simulate(self.FIR(taps), inp, input_types=([Float()]), simulations=['PYHA', 'RTL'],
                        conversion_path='/home/gaspar/git/pyha/playground')
        assert hardware_sims_equal(sims)


# class TestMultSfix:
#     def setup(self):
#         class Dut(Hardware):
#             def main(self, a, b):
#                 r = a * b
#                 return r
#
#         self.dut = Dut()
#
#     def test_basic(self):
#         a = 0.1
#         b = 0.5
#
#         # 0.007817297415263467
#         sims = simulate(self.dut, a, b, input_types=([Float(), Sfix(0, 0, -17)]),
#                         simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
#         assert hardware_sims_equal(sims)
#         assert sims_close(sims, rtol=1e-1, atol=1e-9)
#
#     def test_resources(self):
#         class Dut(Hardware):
#             def __init__(self):
#                 self.C = 0.52621
#
#             def main(self, a):
#                 r = a * self.C
#                 return r
#
#         d = Dut()
#         a = 0.99
#         b = -0.000051
#
#         simulate(d, a, input_types=([Float()]), simulations=['PYHA', 'GATE'],
#                  conversion_path='/home/gaspar/git/pyha/playground'
#                  )
#         if not get_ran_gate_simulation():
#             pytest.skip('Gate did not run..')
#         assert VHDLSimulation.last_logic_elements == 27  # 5, 9


# def test_speed():
#     # mult: 142.82 MHz
#     # add: 75.87 MHz
#     # add: 78.38 MHz @ 10M16SAU169C8G
#     # add UNSIGNED: 84.89 MHz
#
#     # unsigned: 82.05 MHz (C4)  81.66 MHz (MAX)
#     # 2 regs retime: 101.57
#
#     class Dut(Hardware):
#         def __init__(self):
#             self.reg = Float()
#             self.ina = Float()
#             self.inb = Float()
#
#         def main(self, a, b):
#             self.ina = a
#             self.inb = b
#             self.reg = self.ina + self.inb
#             return self.reg
#
#     a = 0.99
#     b = -0.000051
#
#     simulate(Dut(), a, b, input_types=([Float(), Float()]), simulations=['PYHA', 'GATE'],
#              conversion_path='/home/gaspar/git/pyha/playground')
#     if not get_ran_gate_simulation():
#         pytest.skip('Gate did not run..')
#     assert VHDLSimulation.last_logic_elements == 27  # 5, 9


# def test_window_constants():
#     # 5, 9 1602
#     # 4, 9 1602
#     # 3, 9 1602
#     # 3, 8 1000
#     # 3, 7 581
#     # 4, 7 581
#     # 5, 7 581
#     # 5, 6 355
#     class Dut(Hardware):
#         def __init__(self, M):
#             self.WINDOW = [Float(x, 5, 7) for x in np.hamming(M)]
#
#         def main(self, i):
#             return self.WINDOW[i]
#
#     M = 1024 * 2 * 2 * 2
#     inp = list(range(M))
#     d = Dut(M)
#     sims = simulate(d, inp, simulations=['PYHA',
#                                          # 'RTL'
#                                          'GATE'
#                                          ],
#                     conversion_path='/home/gaspar/git/pyha/playground')
#     assert hardware_sims_equal(sims)
#     assert sims_close(sims, rtol=1e-1, atol=1e-9)


# def test_junn():
#     # 5, 9 6,470
#     # 4, 9 6,128
#     # 4, 8 4,883
#     # 4, 7 3,627
#     # 3, 7 2,630
#
#     # 0, -8 Sfix 2,683
#     # 0, -9 Sfix 3,514
#     # 0, -10 Sfix 3,514
#     def W(k, N):
#         """ e^-j*2*PI*k*n/N, argument k = k * n """
#         return np.exp(-1j * (2 * np.pi / N) * k)
#
#     class Dut(Hardware):
#         def __init__(self, M):
#             exp = 3
#             frac = 7
#             # self.WINDOW_REAL = [Float(W(i, M).real, exp, frac) for i in range(M)]
#             # self.WINDOW_IMAG = [Float(W(i, M).imag, exp, frac) for i in range(M)]
#             self.WINDOW_REAL = [Sfix(W(i, M).real, 0, -10) for i in range(M)]
#             self.WINDOW_IMAG = [Sfix(W(i, M).imag, 0, -10) for i in range(M)]
#
#         def main(self, i):
#             return self.WINDOW_REAL[i], self.WINDOW_IMAG[i]
#
#     M = 1024 * 2 * 2 * 2
#     inp = list(range(M))
#     d = Dut(M)
#     sims = simulate(d, inp, simulations=['PYHA',
#                                          # 'RTL'
#                                          'GATE'
#                                          ],
#                     conversion_path='/home/gaspar/git/pyha/playground')
#     assert hardware_sims_equal(sims)
#     assert sims_close(sims, rtol=1e-1, atol=1e-9)
