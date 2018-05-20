from math import isclose

import pytest
from scipy import signal

from pyha import Hardware, simulate, sims_close, hardware_sims_equal, Sfix
from pyha.common.float import Float
import numpy as np

from pyha.simulation.simulation_interface import get_ran_gate_simulation
from pyha.simulation.vhdl_simulation import VHDLSimulation


# TODO: VERY IMPORTANT THAT TESTS IN THIS FILE CHECK EXPONENT NOT ONLY RETURNED FLOAT VALUE!


def test_exponent_overflow():
    pytest.skip('overflows')

    class Dut(Hardware):
        def main(self, a, b):
            r = a + b
            return r

    base = 0.000000000002342
    a = [Float(base), Float(-base), Float(base), Float(-base)]
    b = [Float(base), Float(base), Float(-base), Float(-base)]

    dut = Dut()
    sims = simulate(dut, a, b, simulations=['PYHA', 'RTL'])

    assert sims_close(sims, rtol=1e-9, atol=1e-9)


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
        if Float.radix != 32:
            pytest.skip('Test only for 32 radix')
        a = 0.12
        b = -a * 0.9

        sims = simulate(self.dut, a, b, input_types=([Float(0.0), Float(0.0)]),
                        simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert sims['RTL'].exponent == -1
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_need_normalize2(self):
        if Float.radix != 32:
            pytest.skip('Test only for 32 radix')
        a = 0.12
        b = -a * 0.995

        sims = simulate(self.dut, a, b, input_types=([Float(0.0), Float(0.0)]),
                        simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert sims['RTL'].exponent == -2
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_result_near_zero(self):
        if Float.radix != 32:
            pytest.skip('Test only for 32 radix')
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

        # 0.989990234375000 - 0.000051021575928
        # Out[8]: 0.989939212799072

        # 0.989929199218750 +:000:11111101011011
        # 0.989990234375000 +:000:11111101011100

        a = [Float(0.99)]
        b = [Float(-0.000051)]

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
        # R32, 3, 15 -> final UNSign 137

        a = [Float(0.99)]
        b = [Float(-0.000051)]

        sims = simulate(self.dut, a, b, simulations=['PYHA',
                                                     'GATE'
                                                     ],
                        conversion_path='/home/gaspar/git/pyha/playground'
                        )
        assert VHDLSimulation.last_logic_elements == 123

    # def test_add_resources2(self):
    #     # 4: 128
    #     # 5: 139
    #     # 6: 148 (+9)
    #     # 7: 153 (+5)
    #     # 8: 161 (+8)
    #     # 9: 167 (+6)
    #     # 10:173 (+6)
    #
    #     # NEW 32 radix: 113
    #
    #     a = [Sfix(0.99, 0, -17)]
    #     b = [Sfix(-0.000051, 0, -17)]
    #
    #     sims = simulate(self.dut, a, b, simulations=['PYHA',
    #                                             'GATE'
    #                                             ],
    #                     conversion_path='/home/gaspar/git/pyha/playground'
    #                     )
    #     assert VHDLSimulation.last_logic_elements == 123


# class TestSub:
#     def setup(self):
#         class Dut(Hardware):
#             def main(self, a, b):
#                 r = a - b
#                 return r
#
#         self.dut = Dut()
#
#     def test_sub_normalize(self):
#         """ Python normalization resulted in X.50, neede to use // instead of / """
#         shrink_bits = 6
#
#         class Dut(Hardware):
#             def main(self, a, b):
#                 r = a - b
#                 return r
#
#         low = 1.0 - (2 ** -shrink_bits)
#         # a = [Float(0.99), Float(-0.99)]
#         # b = [Float(-low), Float(low)]
#         a = [Float(-0.99)]
#         b = [Float(low)]
#         dut = Dut()
#
#         sims = simulate(dut, a, b, simulations=['PYHA',
#                                                 'RTL',
#                                                 # 'GATE'
#                                                 ])
#         assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_sub_resources():
    """ Result already normalized """

    class Dut(Hardware):
        def main(self, a, b):
            r = a - b
            return r

    a = [Float(0.99, 5, 9)]
    b = [Float(-0.000051, 5, 9)]
    dut = Dut()

    sims = simulate(dut, a, b, simulations=['PYHA',
                                            'GATE'
                                            ],
                    conversion_path='/home/gaspar/git/pyha/playground'
                    )
    assert VHDLSimulation.last_logic_elements == 131


def test_suber():
    """ Bug in - routine """

    class Dut(Hardware):
        def main(self, a, b):
            r = a - b
            return r

    a = [Float(0.000006556510925)]
    b = [Float(2000.000000000000000)]
    dut = Dut()

    sims = simulate(dut, a, b, simulations=['PYHA',
                                            'RTL',
                                            # 'GATE'
                                            ])
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_sub_random():
    class Dut(Hardware):
        def main(self, a, b):
            r = a - b
            return r

    N = 2 ** 15
    gain = 2 ** np.random.uniform(-8, 8, N)
    orig = (np.random.rand(N)) * gain
    a = [Float(x) for x in orig]

    gain = 2 ** np.random.uniform(-8, 8, N)
    orig = (np.random.rand(N)) * gain
    b = [Float(x) for x in orig]
    dut = Dut()

    sims = simulate(dut, a, b, simulations=['PYHA',
                                            'RTL',
                                            # 'GATE'
                                            ])
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


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
        N = 2**12
        gain = 2 ** np.random.uniform(-8, 8, N)
        b = (np.random.rand(N)) * gain

        gain = 2 ** np.random.uniform(-8, 8, N)
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

    def test_undefflow(self):
        a = 0.00001
        b = 0.00001

        # 0.007817297415263467
        sims = simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_resources(self):
        # UNSIGNED: 26 LUT
        a = 0.99
        b = -0.000051

        simulate(self.dut, a, b, input_types=([Float(), Float()]), simulations=['PYHA', 'GATE'],
                 conversion_path='/home/gaspar/git/pyha/playground'
                 )
        if not get_ran_gate_simulation():
            pytest.skip('Gate did not run..')
        assert VHDLSimulation.last_logic_elements == 27  # 5, 9


class TestMultSfix:
    def setup(self):
        class Dut(Hardware):
            def main(self, a, b):
                r = a * b
                return r

        self.dut = Dut()

    def test_basic(self):
        a = 0.1
        b = 0.5

        # 0.007817297415263467
        sims = simulate(self.dut, a, b, input_types=([Float(), Sfix(0, 0, -17)]),
                        simulations=['MODEL_FLOAT', 'PYHA', 'RTL'])
        assert hardware_sims_equal(sims)
        assert sims_close(sims, rtol=1e-1, atol=1e-9)

    def test_resources(self):
        class Dut(Hardware):
            def __init__(self):
                self.C = 0.52621

            def main(self, a):
                r = a * self.C
                return r

        d = Dut()
        a = 0.99
        b = -0.000051

        simulate(d, a, input_types=([Float()]), simulations=['PYHA', 'GATE'],
                 conversion_path='/home/gaspar/git/pyha/playground'
                 )
        if not get_ran_gate_simulation():
            pytest.skip('Gate did not run..')
        assert VHDLSimulation.last_logic_elements == 27  # 5, 9


class TestNormalize:
    def test_bug(self):
        """ Normalizing used to quantize, this should be turned off for constants """
        val = 0.0013305734842478762
        assert isclose(Float(val), val, rel_tol=1e-2)

    def test_case(self):
        val = 17.429206550940457
        assert isclose(Float(val), val, rel_tol=1e-2)


def test_speed():
    # mult: 142.82 MHz
    # add: 75.87 MHz
    # add: 78.38 MHz @ 10M16SAU169C8G
    # add UNSIGNED: 84.89 MHz

    class Dut(Hardware):
        def __init__(self):
            self.reg = Float()
            self.ina = Float()
            self.inb = Float()

        def main(self, a, b):
            self.ina = a
            self.inb = b
            self.reg = self.ina + self.inb
            return self.reg

    a = 0.99
    b = -0.000051

    simulate(Dut(), a, b, input_types=([Float(), Float()]), simulations=['PYHA', 'GATE'],
             conversion_path='/home/gaspar/git/pyha/playground')
    if not get_ran_gate_simulation():
        pytest.skip('Gate did not run..')
    assert VHDLSimulation.last_logic_elements == 27  # 5, 9


def test_window_constants():
    # 5, 9 1602
    # 4, 9 1602
    # 3, 9 1602
    # 3, 8 1000
    # 3, 7 581
    # 4, 7 581
    # 5, 7 581
    # 5, 6 355
    class Dut(Hardware):
        def __init__(self, M):
            self.WINDOW = [Float(x, 5, 7) for x in np.hamming(M)]

        def main(self, i):
            return self.WINDOW[i]

    M = 1024 * 2 * 2 * 2
    inp = list(range(M))
    d = Dut(M)
    sims = simulate(d, inp, simulations=['PYHA',
                                         # 'RTL'
                                         'GATE'
                                         ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert hardware_sims_equal(sims)
    assert sims_close(sims, rtol=1e-1, atol=1e-9)


def test_junn():
    # 5, 9 6,470
    # 4, 9 6,128
    # 4, 8 4,883
    # 4, 7 3,627
    # 3, 7 2,630

    # 0, -8 Sfix 2,683
    # 0, -9 Sfix 3,514
    # 0, -10 Sfix 3,514
    def W(k, N):
        """ e^-j*2*PI*k*n/N, argument k = k * n """
        return np.exp(-1j * (2 * np.pi / N) * k)

    class Dut(Hardware):
        def __init__(self, M):
            exp = 3
            frac = 7
            # self.WINDOW_REAL = [Float(W(i, M).real, exp, frac) for i in range(M)]
            # self.WINDOW_IMAG = [Float(W(i, M).imag, exp, frac) for i in range(M)]
            self.WINDOW_REAL = [Sfix(W(i, M).real, 0, -10) for i in range(M)]
            self.WINDOW_IMAG = [Sfix(W(i, M).imag, 0, -10) for i in range(M)]

        def main(self, i):
            return self.WINDOW_REAL[i], self.WINDOW_IMAG[i]

    M = 1024 * 2 * 2 * 2
    inp = list(range(M))
    d = Dut(M)
    sims = simulate(d, inp, simulations=['PYHA',
                                         # 'RTL'
                                         'GATE'
                                         ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert hardware_sims_equal(sims)
    assert sims_close(sims, rtol=1e-1, atol=1e-9)


def test_float_fir():
    # SFix
    # INFO:sim:Total logic elements : 1,695
    # INFO:sim:    Total combinational functions : 1,680
    # INFO:sim:    Dedicated logic registers : 1,581
    # INFO:sim:Total registers : 1581
    # INFO:sim:Total pins : 38
    # INFO:sim:Total virtual pins : 0
    # INFO:sim:Total memory bits : 0
    # INFO:sim:Embedded Multiplier 9-bit elements : 46

    # Float
    # INFO:sim:Family : Cyclone IV E
    # INFO:sim:Total logic elements : 9,333
    # INFO:sim:    Total combinational functions : 9,331
    # INFO:sim:    Dedicated logic registers : 1,312
    # INFO:sim:Total registers : 1312
    # INFO:sim:Total pins : 30
    # INFO:sim:Total virtual pins : 0
    # INFO:sim:Total memory bits : 0
    # INFO:sim:Embedded Multiplier 9-bit elements : 0

    # Float radix 16 4, 12
    # INFO:sim:Analysis & Synthesis Status : Successful - Wed May 16 16:02:34 2018
    # INFO:sim:Quartus Prime Version : 17.1.0 Build 590 10/25/2017 SJ Lite Edition
    # INFO:sim:Revision Name : quartus_project
    # INFO:sim:Top-level Entity Name : top
    # INFO:sim:Family : Cyclone IV E
    # INFO:sim:Total logic elements : 8,171
    # INFO:sim:    Total combinational functions : 8,170
    # INFO:sim:    Dedicated logic registers : 1,504
    # INFO:sim:Total registers : 1504
    # INFO:sim:Total pins : 34
    # INFO:sim:Total virtual pins : 0
    # INFO:sim:Total memory bits : 0
    # INFO:sim:Embedded Multiplier 9-bit elements : 0
    # INFO:sim:Total PLLs : 0
    # INFO:sim:Running netlist writer.

    class FIRFloat(Hardware):
        def __init__(self, taps):
            self.DELAY = 2

            # self.TAPS = [Float(x) for x in np.array(taps).tolist()]
            self.TAPS = np.array(taps).tolist()
            self.TAPS_ORIG = taps

            # registers
            self.acc = [Float()] * len(taps)
            self.mul = [Float()] * len(taps)
            # self.out = Float()

        def main(self, x):
            """ Transposed FIR structure """
            self.acc[0] = x * self.TAPS[-1]
            for i in range(1, len(self.acc)):
                self.mul[i] = x * self.TAPS[len(self.TAPS) - 1 - i]
                self.acc[i] = self.acc[i - 1] + self.mul[i]

            return self.acc[-1]

        def model_main(self, x):
            return signal.lfilter(self.TAPS_ORIG, [1.0], x)

    # class FIRFloat(Hardware):
    #     def __init__(self, taps):
    #         self.DELAY = 2
    #         self.TAPS = np.array(taps).tolist()
    #
    #         # registers
    #         self.acc = [Sfix(left=1, right=-23)] * len(taps)
    #         self.out = Sfix(left=0, right=-17, overflow_style='saturate')
    #
    #     def main(self, x):
    #         """ Transposed FIR structure """
    #         self.acc[0] = x * self.TAPS[-1]
    #         for i in range(1, len(self.acc)):
    #             self.acc[i] = self.acc[i - 1] + x * self.TAPS[len(self.TAPS) - 1 - i]
    #
    #         self.out = self.acc[-1]
    #         return self.out
    #
    #     def model_main(self, x):
    #         return signal.lfilter(self.TAPS, [1.0], x)

    np.random.seed(0)
    taps = signal.remez(64, [0, 0.1, 0.2, 0.5], [1, 0])
    dut = FIRFloat(taps)
    inp = np.random.uniform(-1, 1, 1024)

    sims = simulate(dut, inp, input_types=[Float()], simulations=['MODEL', 'PYHA',
                                                                  # sims = simulate(dut, inp, simulations=['MODEL', 'PYHA',

                                                                  # 'RTL',
                                                                  # 'GATE'
                                                                  ],
                    conversion_path='/home/gaspar/git/pyha/playground')

    hw = [float(x) for x in sims['PYHA']]
    import matplotlib
    import matplotlib.pyplot as plt
    plt.magnitude_spectrum(sims['MODEL'], window=matplotlib.mlab.window_none, scale='dB')
    plt.magnitude_spectrum(hw, window=matplotlib.mlab.window_none, scale='dB')
    plt.show()

    plt.plot(sims['MODEL'])
    plt.plot(hw)
    plt.show()
    # plt.phase_spectrum(sims['MODEL'], window=matplotlib.mlab.window_none)
    # plt.phase_spectrum(hw, window=matplotlib.mlab.window_none)
    # plt.show()
    assert sims_close(sims)


def test_lut():
    def build_lut():
        lut = [-1] * 1024
        for i in range(-16, 16, 1):
            for j in range(-16, 16, 1):
                r = abs(i - j)
                index = ((i & 0x1F) << 5) | (j & 0x1F)
                # if r > 8:
                #     r = 0
                # lut[index] = r
                if r <= 8:
                    print(f'if i = {index} then\n ret_0 := {r}; \n end if;\n')
                # print(i, j, r, index)

        return lut

    lut = build_lut()

    # class Dut(Hardware):
    #     def __init__(self):
    #         self.LUT = build_lut()
    #
    #     def main(self, i):
    #         return self.LUT[i]
    #
    # M = 1024
    # inp = list(range(M))
    # d = Dut()
    # sims = simulate(d, inp, simulations=['PYHA',
    #                                      # 'RTL'
    #                                      'GATE'
    #                                      ],
    #                 conversion_path='/home/gaspar/git/pyha/playground')
    # assert hardware_sims_equal(sims)
    # assert sims_close(sims, rtol=1e-1, atol=1e-9)
    #
    # from pyeda.inter import *
    # X = ttvars('x', 4)
    # f1 = truthtable(X, "0000011111------")