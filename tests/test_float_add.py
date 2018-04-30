import pytest

from pyha import Hardware, simulate, sims_close
from pyha.common.float import Float
import numpy as np


@pytest.mark.parametrize('base', [1, 0, 0.0000432402, 1238893.123, 0.0000000002342, 324788980])
def test_same(base):
    class Dut(Hardware):
        def main(self, a, b):
            r = a + b
            return r

    a = [Float(base), Float(-base), Float(base), Float(-base)]
    b = [Float(base), Float(base), Float(-base), Float(-base)]

    dut = Dut()
    sims = simulate(dut, a, b, simulations=['PYHA', 'RTL'],
                    conversion_path='/home/gaspar/git/pyha/playground')

    assert sims_close(sims, rtol=1e-9, atol=1e-9)


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
    sims = simulate(dut, a, b, simulations=['PYHA', 'RTL'],
                    conversion_path='/home/gaspar/git/pyha/playground')

    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_ones():
    """ Failed due to bug in smaller/bigger logic """

    class Dut(Hardware):
        def main(self, a, b):
            r = a + b
            return r

    base = 1
    a = [Float(-base), Float(base)]
    b = [Float(base), Float(-base)]

    dut = Dut()
    sims = simulate(dut, a, b, simulations=['PYHA', 'RTL'],
                    conversion_path='/home/gaspar/git/pyha/playground')

    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_no_round():
    """ Python side had rounding when converted to Float """

    class Dut(Hardware):
        def main(self, a, b):
            r = a + b
            return r

    a = [Float(0.235351562500000)]
    b = [Float(0.045410156250000)]
    dut = Dut()

    sims = simulate(dut, a, b, simulations=['PYHA',
                                            'RTL',
                                            # 'GATE'
                                            ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_no_rr():
    """ Failed on invalid normalization """

    class Dut(Hardware):
        def main(self, a, b):
            r = a + b
            return r

    a = [Float(0.004577636718750)]
    b = [Float(1112.000000000000000)]
    dut = Dut()

    sims = simulate(dut, a, b, simulations=['PYHA',
                                            'RTL',
                                            # 'GATE'
                                            ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_no_rrrr():
    """ Failed on invalid normalization """

    class Dut(Hardware):
        def main(self, a, b):
            r = a + b
            return r

    # 001110: 010100110
    a = [Float(6432.000000000000000)]
    b = [Float(4224.000000000000000)]
    dut = Dut()

    sims = simulate(dut, a, b, simulations=['PYHA',
                                            'RTL',
                                            # 'GATE'
                                            ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_random():
    class Dut(Hardware):
        def main(self, a, b):
            r = a + b
            return r

    N = 1024 * 2
    gain = 2 ** np.random.uniform(-16, 16, N)
    orig = (np.random.rand(N)) * gain
    a = [Float(x) for x in orig]

    gain = 2 ** np.random.uniform(-16, 16, N)
    orig = (np.random.rand(N)) * gain
    b = [Float(x) for x in orig]
    dut = Dut()

    sims = simulate(dut, a, b, simulations=['PYHA',
                                            'RTL',
                                            # 'GATE'
                                            ],
                    conversion_path='/home/gaspar/git/pyha/playground')

    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_normalize_grows():
    """ Add grows by one bit """

    class Dut(Hardware):
        def main(self, a, b):
            r = a + b
            return r

    a = [Float(0.990)]
    b = [Float(0.990)]
    dut = Dut()

    sims = simulate(dut, a, b, simulations=['PYHA',
                                            'RTL',
                                            # 'GATE'
                                            ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_normalize_no_action():
    """ Result already normalized """

    class Dut(Hardware):
        def main(self, a, b):
            r = a + b
            return r

    a = [Float(0.99)]
    b = [Float(-0.000051)]
    dut = Dut()

    sims = simulate(dut, a, b, simulations=['PYHA',
                                            'RTL',
                                            # 'GATE'
                                            ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_normalize_shrink1():
    """ Add shrinks by one bit """

    class Dut(Hardware):
        def main(self, a, b):
            r = a + b
            return r

    a = [Float(0.99), Float(-0.99), Float(-0.98172), Float(0.98172)]
    b = [Float(-0.51), Float(0.51), Float(0.5315), Float(-0.5315)]
    dut = Dut()

    sims = simulate(dut, a, b, simulations=['PYHA',
                                            'RTL',
                                            # 'GATE'
                                            ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims, rtol=1e-9, atol=1e-9)


def test_normalize_shrink2():
    """ Add shrinks by 2 bit """

    class Dut(Hardware):
        def main(self, a, b):
            r = a + b
            return r

    a = [Float(0.99), Float(-0.99)]
    b = [Float(-0.751), Float(0.751)]
    dut = Dut()

    sims = simulate(dut, a, b, simulations=['PYHA',
                                            'RTL',
                                            # 'GATE'
                                            ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims, rtol=1e-9, atol=1e-9)

@pytest.mark.parametrize('shrink_bits', [1, 2, 3, 4, 5, 6, 7])
def test_normalize_shrink3(shrink_bits):
    """ Result needs shifting left """

    class Dut(Hardware):
        def main(self, a, b):
            r = a + b
            return r

    low = 1.0 - (2**-shrink_bits)
    a = [Float(0.99), Float(-0.99)]
    b = [Float(-low), Float(low)]
    dut = Dut()

    sims = simulate(dut, a, b, simulations=['PYHA',
                                            'RTL',
                                            # 'GATE'
                                            ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims, rtol=1e-9, atol=1e-9)
