from math import isclose

from pyha.common.float import Float
import numpy as np

def test_new_mult():
    N = 1024 * 2
    gain = 2 ** np.random.uniform(-32, 32, N)
    origa = (np.random.rand(N) * 2 - 1) * gain

    N = 1024 * 2
    gain = 2 ** np.random.uniform(-32, 32, N)
    origb = (np.random.rand(N) * 2 - 1) * gain

    for a, b in zip(origa, origb):
        expected = a * b
        real = Float(a, 8, 24) * Float(b, 8, 24)
        assert isclose(real, expected, rel_tol=1e-6)


def test_new_add():
    N = 1024 * 2
    gain = 2 ** np.random.uniform(-32, 32, N)
    origa = (np.random.rand(N) * 2 - 1) * gain

    N = 1024 * 2
    gain = 2 ** np.random.uniform(-32, 32, N)
    origb = (np.random.rand(N) * 2 - 1) * gain

    for a, b in zip(origa, origb):
        expected = a + b
        real = float(Float(a, 8, 24) + Float(b, 8, 24))
        assert isclose(real, expected, rel_tol=1e-5)


def test_new_sub():
    N = 1024 * 2
    gain = 2 ** np.random.uniform(-32, 32, N)
    origa = (np.random.rand(N) * 2 - 1) * gain

    N = 1024 * 2
    gain = 2 ** np.random.uniform(-32, 32, N)
    origb = (np.random.rand(N) * 2 - 1) * gain

    for a, b in zip(origa, origb):
        expected = a - b
        real = float(Float(a, 8, 24) - Float(b, 8, 24))
        assert isclose(real, expected, rel_tol=1e-5)


def test_suber():
    """ Bug in - routine - need to quantize everything """
    a = 0.000006556510925
    b = 2000.000000000000000

    expected = a - b
    real = float(Float(a) - Float(b))
    print(real, expected)
    assert isclose(real, expected, rel_tol=1e-6)