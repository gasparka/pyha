from pathlib import Path

import numpy as np
import pytest
import scipy
from scipy.signal import hilbert, chirp

base_path = Path(__file__).parent


@pytest.fixture(scope='module',
                params=['MODEL'])
def cord(request):
    iterations = 18
    if request.param == 'MODEL':
        from LEGACY.components import CORDIC
        return CORDIC(iterations)
    elif request.param == 'HW-MODEL':
        from LEGACY.components import CORDIC
        return CORDIC(iterations)


@pytest.fixture(scope='function', params=['MODEL', 'HW-MODEL'])
def exp(request):
    iterations = 18
    if request.param == 'MODEL':
        from LEGACY.components import CORDIC
        cord = CORDIC(iterations)
        return cord.exp
    elif request.param == 'HW-MODEL':
        from LEGACY.components import Exp
        # assert 0
        cord = Exp(iterations)
        return cord.test_interface


def test_exp(exp):
    fs = 1e3
    periods = 2
    freq = 1
    phase_inc = 2 * np.pi * freq / fs
    phase_list = np.arange(0, periods * fs * phase_inc, phase_inc)

    ref = np.exp(phase_list * 1j)

    res = exp(phase_list * 1j)

    np.testing.assert_almost_equal(res, ref, decimal=5)


def test_exp_harmonic(exp):
    # this needs no phase wrapping to work
    fs = 1e3
    periods = 2
    freq = 1
    phase_inc = 2 * np.pi * freq / fs
    phase_list = np.arange(0, periods * fs * phase_inc, phase_inc)

    phase = np.sin(phase_list)

    ref = np.exp(phase * 1j)

    res = exp(phase * 1j)

    np.testing.assert_almost_equal(res, ref, decimal=5)


def test_exp_harmonic_gain(exp):
    # - and + wrapping must work
    fs = 1e3
    periods = 2
    freq = 1
    phase_inc = 2 * np.pi * freq / fs
    phase_list = np.arange(0, periods * fs * phase_inc, phase_inc)

    phase = 3 * np.sin(phase_list)

    ref = np.exp(phase * 1j)

    res = exp(phase * 1j)

    np.testing.assert_almost_equal(res, ref, decimal=5)


def test_exp_fm_mod(exp):
    fs = 1e3
    periods = 1
    data_freq = 20

    time = np.linspace(0, periods, fs * periods, endpoint=False)  # NB! NOTICE ENDPOINT TO MATCH GNURADIO

    data = np.cos(2 * np.pi * data_freq * time)

    deviation = fs / 3
    sensitivity = 2 * np.pi * deviation / fs

    phl = np.cumsum(sensitivity * data)

    # Reference with NUMPY
    ref = np.exp(phl * 1j)

    # CORDIC solution
    mod = exp(phl * 1j)

    # GNURADIO solution
    path = base_path / 'mod_samples.32fc'
    gr_fmmod = scipy.fromfile(path.open(), dtype=scipy.complex64)

    np.testing.assert_almost_equal(gr_fmmod[:len(ref)], ref, decimal=4)
    np.testing.assert_almost_equal(ref, mod, decimal=4)


def test_angle(cord):
    duration = 1.0
    fs = 400.0
    samples = int(fs * duration)
    t = np.arange(samples) / fs

    signal = chirp(t, 20.0, t[-1], 100.0)
    signal *= (1.0 + 0.5 * np.sin(2.0 * np.pi * 3.0 * t))

    analytic_signal = hilbert(signal)

    ref_instantaneous_phase = np.angle(analytic_signal)

    cord_instantaneous_phase = cord.angle(analytic_signal)

    np.testing.assert_almost_equal(ref_instantaneous_phase, cord_instantaneous_phase, decimal=4)


def test_angle_fm_demod(cord, exp):
    fs = 1e3
    periods = 1
    data_freq = 20

    time = np.linspace(0, periods, fs * periods, endpoint=False)  # NB! NOTICE ENDPOINT TO MATCH GNURADIO

    data = np.cos(2 * np.pi * data_freq * time)

    deviation = fs / 3
    sensitivity = 2 * np.pi * deviation / fs

    phl = np.cumsum(sensitivity * data)

    mod = exp(phl * 1j)

    # DEMODULATE
    gain = fs / (2 * np.pi * deviation)
    baseband = mod
    ref_demod_data = gain * np.angle(baseband[1:] * np.conjugate(baseband[:-1]))
    cord_demod_data = gain * np.array(cord.angle(baseband[1:] * np.conjugate(baseband[:-1])))

    np.testing.assert_almost_equal(ref_demod_data, cord_demod_data, decimal=5)
    np.testing.assert_almost_equal(data[1:], cord_demod_data, decimal=5)
