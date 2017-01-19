import numpy as np
import pytest
from scipy.signal import chirp, hilbert

from pyha.common.sfix import ComplexSfix, Sfix
from pyha.components.cordic import ToPolar, Cordic, NCO, CordicMode
from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE, \
    assert_hwmodel_rtl_match, assert_model_hwmodel_match


def test_polar_quadrant_i():
    inputs = [0.234 + 0.92j]
    expect = [np.abs(inputs), np.angle(inputs) / np.pi]

    dut = ToPolar()
    assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                     expect, inputs,
                     rtol=1e-4,
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                     dir_path='/home/gaspar/git/pyha/playground/conv'
                     )


def test_polar_quadrant_ii():
    inputs = [-0.934 + 0.92j]
    expect = [np.abs(inputs), np.angle(inputs) / np.pi]

    dut = ToPolar()
    assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                     expect, inputs,
                     rtol=1e-4,
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                     dir_path='/home/gaspar/git/pyha/playground/conv'
                     )


def test_polar_quadrant_iii():
    inputs = [-0.934 - 0.92j]
    expect = [np.abs(inputs), np.angle(inputs) / np.pi]

    dut = ToPolar()
    assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                     expect, inputs,
                     rtol=1e-4,
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                     dir_path='/home/gaspar/git/pyha/playground/conv'
                     )


def test_polar_quadrant_iv():
    inputs = [+0.934 - 0.92j]
    expect = [np.abs(inputs), np.angle(inputs) / np.pi]

    dut = ToPolar()
    assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                     expect, inputs,
                     rtol=1e-4,
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                     dir_path='/home/gaspar/git/pyha/playground/conv'
                     )


def test_to_polar():
    duration = 1.0
    fs = 400.0
    samples = int(fs * duration)
    t = np.arange(samples) / fs

    signal = chirp(t, 20.0, t[-1], 100.0)
    signal *= (1.0 + 0.5 * np.sin(2.0 * np.pi * 3.0 * t))

    analytic_signal = hilbert(signal) * 0.5

    ref_abs = np.abs(analytic_signal)
    ref_instantaneous_phase = np.angle(analytic_signal)

    inputs = analytic_signal
    expect = [ref_abs, ref_instantaneous_phase / np.pi]

    dut = ToPolar()

    assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                     expect, inputs,
                     rtol=1e-4,
                     atol=1e-4,  # zeroes make trouble
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                     dir_path='/home/gaspar/git/pyha/playground/conv'
                     )


def test_cordic_model_hw_match():
    np.random.seed(123456)
    inputs = (np.random.rand(3, 512) * 2 - 1) * 0.5

    dut = Cordic(16, CordicMode.VECTORING)
    assert_model_hwmodel_match(dut, [Sfix(left=0, right=-17), Sfix(left=0, right=-17), Sfix(left=0, right=-32)],
                               *inputs,
                               rtol=1e-4,
                               atol=1e-4)

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
                     simulations=sims,
                     dir_path='/home/gaspar/git/pyha/playground/conv',
                     # fuck_it=True
                     )
