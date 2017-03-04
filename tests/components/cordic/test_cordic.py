from pathlib import Path

import numpy as np
import pytest
from scipy.signal import chirp, hilbert

from pyha.common.sfix import ComplexSfix, Sfix
from pyha.components.cordic import ToPolar, Cordic, NCO, CordicMode, Angle, Abs
from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE, \
    assert_hwmodel_rtl_match, assert_model_hwmodel_match, debug_assert_sim_match


def test_cordic_vectoring_model_hw_match():
    np.random.seed(123456)
    inputs = (np.random.rand(3, 512) * 2 - 1) * 0.50

    dut = Cordic(16, CordicMode.VECTORING)
    assert_model_hwmodel_match(dut, [Sfix(left=1, right=-17), Sfix(left=1, right=-17), Sfix(left=0, right=-32)],
                               *inputs,
                               rtol=1e-4,
                               atol=1e-4)


def test_cordic_rotation_model_hw_match():
    np.random.seed(123456)
    inputs = (np.random.rand(3, 512) * 2 - 1) * 0.5

    dut = Cordic(16, CordicMode.ROTATION)
    assert_model_hwmodel_match(dut, [Sfix(left=1, right=-17), Sfix(left=1, right=-17), Sfix(left=0, right=-32)],
                               *inputs,
                               rtol=1e-4,
                               atol=1e-4)


def test_cordic_hw_model_rtl_match():
    # TODO: if i set phase lut precision to -18 this fails, why?
    np.random.seed(123456)
    inputs = (np.random.rand(3, 5) * 2 - 1) * 0.5

    dut = Cordic(18, CordicMode.ROTATION)
    assert_hwmodel_rtl_match(dut, [Sfix(left=0, right=-17)] * 3, *inputs)

    dut = Cordic(18, CordicMode.VECTORING)
    assert_hwmodel_rtl_match(dut, [Sfix(left=0, right=-17)] * 3, *inputs)


class TestToPolar:
    # todo: speedup tests by converting only once
    def test_polar_quadrant_i(self):
        inputs = [0.234 + 0.92j]
        expect = [np.abs(inputs), np.angle(inputs) / np.pi]

        dut = ToPolar()
        assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         expect, inputs,
                         rtol=1e-4)

    def test_polar_quadrant_ii(self):
        inputs = [-0.234 + 0.92j]
        expect = [np.abs(inputs), np.angle(inputs) / np.pi]

        dut = ToPolar()
        assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         expect, inputs,
                         rtol=1e-4)

    def test_polar_quadrant_iii(self):
        inputs = [-0.234 - 0.92j]
        expect = [np.abs(inputs), np.angle(inputs) / np.pi]

        dut = ToPolar()
        assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         expect, inputs,
                         rtol=1e-4)

    def test_polar_quadrant_iv(self):
        inputs = [0.234 - 0.92j]
        expect = [np.abs(inputs), np.angle(inputs) / np.pi]

        dut = ToPolar()
        assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         expect, inputs,
                         rtol=1e-4)

    def test_overflow_condition(self):
        pytest.xfail('abs would be > 1 (1.84)')
        inputs = [0.92j + 0.92j]
        expect = [np.abs(inputs), np.angle(inputs) / np.pi]

        dut = ToPolar()
        assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         expect, inputs,
                         rtol=1e-4)

    def _chirp_stimul(self):
        duration = 1.0
        fs = 256
        samples = int(fs * duration)
        t = np.arange(samples) / fs
        signal = chirp(t, 20.0, t[-1], 100.0)
        signal *= (1.0 + 0.5 * np.sin(2.0 * np.pi * 3.0 * t))
        # import matplotlib.pyplot as plt
        # plt.plot(signal)
        # plt.show()
        analytic_signal = hilbert(signal) * 0.5
        ref_abs = np.abs(analytic_signal)
        ref_instantaneous_phase = np.angle(analytic_signal)
        return analytic_signal, ref_abs, ref_instantaneous_phase

    def test_to_polar(self):
        analytic_signal, ref_abs, ref_instantaneous_phase = self._chirp_stimul()

        inputs = analytic_signal
        expect = [ref_abs, ref_instantaneous_phase / np.pi]

        dut = ToPolar()

        assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         expect, inputs,
                         rtol=1e-4,
                         atol=1e-4,  # zeroes make trouble
                         )

    def test_angle(self):
        analytic_signal, ref_abs, ref_instantaneous_phase = self._chirp_stimul()

        inputs = analytic_signal
        expect = ref_instantaneous_phase / np.pi

        dut = Angle()

        assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         expect, inputs,
                         rtol=1e-4,
                         atol=1e-4,  # zeroes make trouble
                         )

    def test_abs(self):
        analytic_signal, ref_abs, ref_instantaneous_phase = self._chirp_stimul()

        inputs = analytic_signal
        expect = ref_abs

        dut = Abs()

        assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         expect, inputs,
                         rtol=1e-4,
                         atol=1e-4,  # zeroes make trouble
                         )

    def test_angle_phantom_cmultconj(self):
        # phantom 2 -> demod = c[1:] * np.conjugate(c[:-1])
        path = Path(__file__).parent / 'phantom_cmult_conjugate.npy'
        sig = np.load(str(path))

        inputs = sig
        expect = []

        dut = Angle()

        # assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
        out = debug_assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         expect, inputs,
                         rtol=1e-4,
                         atol=1e-4,  # zeroes make trouble
                         simulations=[SIM_MODEL, SIM_HW_MODEL]
                         )
        np.testing.assert_allclose(out[0][200:], out[1][200:], 1e-3, 1e-4)
        np.testing.assert_allclose(out[0][200:], out[1][200:], 1e-3, 1e-4)
        # np.testing.assert_allclose(out[0], out[2], 1e-3, 1e-4)
        # import matplotlib.pyplot as plt
        # plt.plot(out[0], label='MODEL')
        # plt.plot(out[1], label='HW_MODEL')
        # plt.plot(out[2], label='RTL')
        # plt.legend()
        # plt.show()

    def test_angle_phantom_cmultconj_mismatch(self):
        # todo: first 100 samples, RTL and HW_SIM not matching!
        pytest.xfail('Lazyness')

        # phantom 2 -> demod = c[1:] * np.conjugate(c[:-1])
        path = Path(__file__).parent / 'phantom_cmult_conjugate.npy'
        sig = np.load(str(path))

        inputs = sig
        expect = []

        dut = Angle()

        # assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
        out = debug_assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         expect, inputs,
                         rtol=1e-4,
                         atol=1e-4,  # zeroes make trouble
                         )
        # np.testing.assert_allclose(out[0], out[1], 1e-3, 1e-4)
        # np.testing.assert_allclose(out[0], out[2], 1e-3, 1e-4)
        import matplotlib.pyplot as plt
        plt.plot(out[0], label='MODEL')
        plt.plot(out[1], label='HW_MODEL')
        plt.plot(out[2], label='RTL')
        plt.legend()
        plt.show()


@pytest.mark.parametrize('period', [0.25, 0.50, 0.75, 1, 2, 4])
def test_nco(period):
    fs = 64
    freq = 1
    phase_inc = 2 * np.pi * freq / fs
    phase_cumsum = np.arange(0, period * fs * phase_inc, phase_inc)

    ref = np.exp(phase_cumsum * 1j)

    pil = np.diff(phase_cumsum) / np.pi
    pil = np.insert(pil, 0, [0.0])

    inputs = pil
    expect = ref

    dut = NCO()
    sims = [SIM_MODEL, SIM_HW_MODEL, SIM_RTL]
    if period == 4:
        sims = [SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE]
    # outs = debug_assert_sim_match(dut, [Sfix(left=0, right=-24)],
    assert_sim_match(dut, [Sfix(left=0, right=-18)],
                     expect, inputs,
                     rtol=1e-4,
                     simulations=sims
                     )
