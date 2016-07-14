import numpy as np

from common.cordic import CORDIC


def test_exp():
    fs = 1e3
    periods = 2
    freq = 1
    phase_inc = 2 * np.pi * freq / fs
    phase_list = np.arange(0, periods * fs * phase_inc, phase_inc)

    ref = np.exp(phase_list * 1j)

    cord = CORDIC(18)
    res = cord.exp(phase_list * 1j)

    np.testing.assert_almost_equal(res, ref, decimal=5)


def test_exp_harmonic():
    # this needs no phase wrapping to work
    fs = 1e3
    periods = 2
    freq = 1
    phase_inc = 2 * np.pi * freq / fs
    phase_list = np.arange(0, periods * fs * phase_inc, phase_inc)

    phase = np.sin(phase_list)

    ref = np.exp(phase * 1j)

    cord = CORDIC(18)
    res = cord.exp(phase * 1j)

    np.testing.assert_almost_equal(res, ref, decimal=5)


def test_exp_harmonic_gain():
    # - and + wrapping must work
    fs = 1e3
    periods = 2
    freq = 1
    phase_inc = 2 * np.pi * freq / fs
    phase_list = np.arange(0, periods * fs * phase_inc, phase_inc)

    phase = 3 * np.sin(phase_list)

    ref = np.exp(phase * 1j)

    cord = CORDIC(18)
    res = cord.exp(phase * 1j)

    np.testing.assert_almost_equal(res, ref, decimal=5)
