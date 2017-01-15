import matplotlib.pyplot as plt
import numpy as np

from pyha.common.sfix import Sfix
from pyha.components.phase_accumulator import PhaseAccumlator
from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, SIM_HW_MODEL, SIM_RTL


def test_basic():
    fs = 128
    freq = 3
    t = np.linspace(0, 1, fs, endpoint=False)

    ref = np.exp(2 * np.pi * freq * t * 1j)
    ref = np.angle(ref)

    phase_step = 2 * np.pi * freq / fs
    phase_inc = [0] + [phase_step] * (len(ref) - 1)

    inputs = phase_inc
    expect = ref

    dut = PhaseAccumlator()

    assert_sim_match(dut, [Sfix(left=2, right=-32)],
                     expect, inputs,
                     rtol=1e-6,
                     # atol=1e-9,  # zeroes make trouble
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                     dir_path='/home/gaspar/git/pyha/playground/conv'
                     )


def test_bs_basic():
    fs = 128
    freq = 3
    t = np.linspace(0, 1, fs, endpoint=False)

    ref = np.exp(2 * np.pi * freq * t * 1j)
    ref = np.angle(ref)

    phase_step = 2 * np.pi * freq / fs
    phase_inc = [0] + [phase_step] * (len(ref) - 1)

    dut = PhaseAccumlator()
    dut_ret = dut.model_main(phase_inc)

    plt.plot(ref)
    plt.plot(dut_ret)
    plt.show()

    # # dut stuff
    # step = dut.model.freq_to_step(freq, fs)
    # # ret = dut([step] * fs)
    # sig, is_wrap = dut([step] * fs)
    # # sig, is_wrap = zip(*ret)
    # return sig, ref, is_wrap, freq
