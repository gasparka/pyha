from pyha.common.sfix import ComplexSfix
from pyha.components.cordic import CordicCore
from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE
import numpy as np


def test_core_vectoring():
    inputs = [0.5 + 0.1j]
    expect = [[0.5], [1], [1]]

    ang = np.angle(inputs)
    abs = np.abs(inputs)
    expect = [abs * 1.646760, [0.0], ang]
    dut = CordicCore(iterations=18)

    assert_sim_match(dut, [ComplexSfix(left=0, right=-17)], expect, inputs,
                     atol=1e-5,
                     simulations=[SIM_MODEL]
                     )
