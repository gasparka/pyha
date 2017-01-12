import numpy as np

from pyha.common.sfix import ComplexSfix, Sfix
from pyha.components.cordic import CordicCore, CordicAtom
from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE


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
                     rtol=1e-4
                     # dir_path='/home/gaspar/git/pyha/playground/conv'

                     )


def test_core_vectoring():
    inputs = [0.5 + 0.1j, 1 + 0j, 0 + 1j, 0.234 + 0.9j]
    phase = [0.0] * len(inputs)

    ang = np.angle(inputs)
    abs = np.abs(inputs)
    expect = [abs * 1.646760, [0.0] * len(inputs), ang]
    dut = CordicCore(iterations=18)

    assert_sim_match(dut, [ComplexSfix(left=2, right=-17), Sfix(left=2, right=-17)],
                     expect, inputs, phase,
                     rtol=1e-5,
                     atol=1e-4,  # zeroes make trouble
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                     dir_path='/home/gaspar/git/pyha/playground/conv'
                     )
