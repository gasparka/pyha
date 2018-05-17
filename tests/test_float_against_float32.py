from math import isclose

from pyha.common.float import Float
import numpy as np

N = 2**15
exp_bits = 8
fra_bits = 32

def test_new_mult():
    gain = 2 ** np.random.uniform(-32, 32, N)
    origa = (np.random.rand(N) * 2 - 1) * gain

    gain = 2 ** np.random.uniform(-32, 32, N)
    origb = (np.random.rand(N) * 2 - 1) * gain

    for a, b in zip(origa, origb):
        expected = a * b
        real = Float(a, exp_bits, fra_bits) * Float(b, exp_bits, fra_bits)
        assert isclose(real, expected, rel_tol=1e-6)


def test_new_add():
    gain = 2 ** np.random.uniform(-32, 32, N)
    origa = (np.random.rand(N) * 2 - 1) * gain

    gain = 2 ** np.random.uniform(-32, 32, N)
    origb = (np.random.rand(N) * 2 - 1) * gain

    for a, b in zip(origa, origb):
        expected = a + b
        real = float(Float(a, exp_bits, fra_bits) + Float(b, exp_bits, fra_bits))
        assert isclose(real, expected, rel_tol=1e-5)


def test_new_sub():
    gain = 2 ** np.random.uniform(-32, 32, N)
    origa = (np.random.rand(N) * 2 - 1) * gain

    gain = 2 ** np.random.uniform(-32, 32, N)
    origb = (np.random.rand(N) * 2 - 1) * gain

    for a, b in zip(origa, origb):
        expected = a - b
        real = float(Float(a, exp_bits, fra_bits) - Float(b, exp_bits, fra_bits))
        assert isclose(real, expected, rel_tol=1e-5)


def test_suber():
    """ Bug in - routine - need to quantize everything """
    a = 0.000006556510925
    b = 2000.000000000000000

    expected = a - b
    real = float(Float(a, exp_bits, fra_bits) - Float(b, exp_bits, fra_bits))
    print(real, expected)
    assert isclose(real, expected, rel_tol=1e-6)