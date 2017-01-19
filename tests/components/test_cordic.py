import numpy as np
import pytest
from scipy.signal import chirp, hilbert

from pyha.common.sfix import ComplexSfix, Sfix
from pyha.components.cordic import CordicCore, CordicAtom, CordicCoreAlt, ToPolar, Cordic, NCO
from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE, \
    debug_assert_sim_match, assert_model_rtl_match


def test_atom():
    phase_lut = [np.arctan(2 ** -i) for i in range(32)]
    i = [0, 1, 2, 3, 4, 5]
    x = [0.5, 0.2, 0.1, 0.99]
    y = [1., 0.87, 0.0, 0.56]
    phase = [0] * len(i)
    phase_adj = [phase_lut[x] for x in i]

    inputs = [i, x, y, phase, phase_adj]
    expect = [[1.5, 0.635, 0.1, 1.06],
              [0.5, 0.77, -0.025, 0.43625],
              [0.785398, 0.463648, 0.244979, 0.124355]]

    dut = CordicAtom()
    assert_sim_match(dut, [int] + [Sfix(left=2, right=-17)] * 4, expect, *inputs,
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                     rtol=1e-4,
                     atol=1e-5,
                     dir_path='/home/gaspar/git/pyha/playground/conv'

                     )


def test_core_alt_vectoring():
    inputs = [0.5 + 0.1j, 1 + 0j, 0 + 1j, 0.234 + 0.9j]
    phase = [0.0] * len(inputs)

    ang = np.angle(inputs)
    abs = np.abs(inputs)
    expect = [abs * 1.646760, [0.0] * len(inputs), ang]
    dut = CordicCoreAlt(iterations=18)

    assert_sim_match(dut, [ComplexSfix(left=2, right=-17), Sfix(left=2, right=-17)],
                     expect, inputs, phase,
                     rtol=1e-4,
                     atol=1e-4,  # zeroes make trouble
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                     dir_path='/home/gaspar/git/pyha/playground/conv'
                     )


def test_core_vectoring():
    inputs = [0.5 + 0.1j, 1 + 0j, 0 + 1j, 0.234 + 0.9j, +0.9 - 0.9j]
    phase = [0.0] * len(inputs)

    ang = np.angle(inputs)
    abs = np.abs(inputs)
    expect = [abs * 1.646760, [0.0] * len(inputs), ang]
    dut = CordicCore(iterations=17)

    assert_sim_match(dut, [ComplexSfix(left=0, right=-17), Sfix(left=2, right=-17)],
                     expect, inputs, phase,
                     rtol=1e-5,
                     atol=1e-4,  # zeroes make trouble
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                     dir_path='/home/gaspar/git/pyha/playground/conv'
                     )


# def test_core_vectoring2():
#     inputs = [0.5 + 0.1j, 1 + 0j, 0 + 1j, 0.234 + 0.9j]
#     phase = [0.0] * len(inputs)
#
#     ang = np.angle(inputs)
#     abs = np.abs(inputs)
#     expect = [abs * 1.646760, [0.0] * len(inputs), ang]
#     dut = CordicCore(iterations=17)
#
#     assert_sim_match(dut, [ComplexSfix(left=0, right=-17), Sfix(left=2, right=-17)],
#                      expect, inputs, phase,
#                      rtol=1e-4,
#                      atol=1e-4,  # zeroes make trouble
#                      simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
#                      dir_path='/home/gaspar/git/pyha/playground/conv'
#                      )
# def test_angle():
#     inputs = [0.5 + 0.1j, 1 + 0j, 0 + 1j, 0.234 + 0.9j]
#
#     ang = np.angle(inputs)
#     abs = np.abs(inputs)
#     expect = [abs, ang]
#     dut = ToPolar()
#
#     assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
#                      expect, inputs,
#                      rtol=1e-4,
#                      atol=1e-4,  # zeroes make trouble
#                      simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
#                      dir_path='/home/gaspar/git/pyha/playground/conv'
#                      )

def test_polar_quadrant_i():
    inputs = [0.234 + 0.92j]
    expect = [np.abs(inputs), np.angle(inputs)]

    dut = ToPolar()
    assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                     expect, inputs,
                     rtol=1e-4,
                     atol=1e-5,  # zeroes make trouble
                     simulations=[SIM_MODEL, SIM_HW_MODEL],
                     dir_path='/home/gaspar/git/pyha/playground/conv'
                     )


def test_polar_quadrant_ii():
    inputs = [-0.934 + 0.92j]
    expect = [np.abs(inputs), np.angle(inputs)]

    dut = ToPolar()
    assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                     expect, inputs,
                     rtol=1e-4,
                     atol=1e-5,  # zeroes make trouble
                     simulations=[SIM_MODEL, SIM_HW_MODEL],
                     dir_path='/home/gaspar/git/pyha/playground/conv'
                     )


def test_polar_quadrant_iii():
    inputs = [-0.934 - 0.92j]
    expect = [np.abs(inputs), np.angle(inputs)]

    dut = ToPolar()
    assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                     expect, inputs,
                     rtol=1e-4,
                     atol=1e-5,  # zeroes make trouble
                     simulations=[SIM_MODEL, SIM_HW_MODEL],
                     dir_path='/home/gaspar/git/pyha/playground/conv'
                     )


def test_polar_quadrant_iv():
    inputs = [+0.934 - 0.92j]
    expect = [np.abs(inputs), np.angle(inputs)]

    dut = ToPolar()
    assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                     expect, inputs,
                     rtol=1e-4,
                     atol=1e-5,  # zeroes make trouble
                     simulations=[SIM_MODEL, SIM_HW_MODEL],
                     dir_path='/home/gaspar/git/pyha/playground/conv'
                     )


def test_angle():
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
    expect = [ref_abs, ref_instantaneous_phase]

    dut = ToPolar()

    assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                     expect, inputs,
                     rtol=1e-4,
                     atol=1e-4,  # zeroes make trouble
                     simulations=[SIM_MODEL, SIM_HW_MODEL],
                     dir_path='/home/gaspar/git/pyha/playground/conv'
                     )


def test_cordic_model_rtl_match():
    # TODO: if i set phase lut precision to -18 this fails, why?
    np.random.seed(123456)
    inputs = (np.random.rand(3, 5) * 2 - 1) * 0.5

    dut = Cordic(18)
    assert_model_rtl_match(dut, [Sfix(left=0, right=-17)] * 3, *inputs)



# @pytest.mark.parametrize('period', [0.25, 0.50, 0.75, 1, 2, 4])
@pytest.mark.parametrize('period', [0.75])
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

