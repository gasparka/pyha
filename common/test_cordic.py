from pathlib import Path

import numpy as np
import scipy
from scipy.signal import hilbert, chirp

from common.cordic import CORDIC

base_path = Path(__file__).parent

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


def test_exp_fm_mod():
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
    cord = CORDIC(18)
    mod = cord.exp(phl * 1j)

    # GNURADIO solution
    path = base_path / 'mod_samples.32fc'
    gr_fmmod = scipy.fromfile(path.open(), dtype=scipy.complex64)

    np.testing.assert_almost_equal(gr_fmmod[:len(ref)], ref, decimal=4)
    np.testing.assert_almost_equal(ref, mod, decimal=4)


def test_angle():
    duration = 1.0
    fs = 400.0
    samples = int(fs * duration)
    t = np.arange(samples) / fs

    signal = chirp(t, 20.0, t[-1], 100.0)
    signal *= (1.0 + 0.5 * np.sin(2.0 * np.pi * 3.0 * t))

    analytic_signal = hilbert(signal)

    ref_instantaneous_phase = np.angle(analytic_signal)

    cord = CORDIC(18)
    cord_instantaneous_phase = cord.angle(analytic_signal)

    np.testing.assert_almost_equal(ref_instantaneous_phase, cord_instantaneous_phase, decimal=4)
