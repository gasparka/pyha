from pyha.common.sfix import ComplexSfix, Sfix
from pyha.components.cordic import CordicCore
from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE
import numpy as np


def test_core_vectoring():
    inputs = [0.5 + 0.1j, 1+0j, 0+1j, 0.234+0.9j]
    phase = [0.0] * len(inputs)

    ang = np.angle(inputs)
    abs = np.abs(inputs)
    expect = [abs * 1.646760, [0.0] * len(inputs), ang]
    dut = CordicCore(iterations=18)

    assert_sim_match(dut, [ComplexSfix(left=2, right=-17), Sfix(left=2, right=-17)],
                     expect, inputs, phase,
                     rtol=1e-5,
                     atol=1e-4, #zeroes make trouble
                     simulations=[SIM_MODEL, SIM_HW_MODEL]
                     )
