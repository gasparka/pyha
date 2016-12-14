from pyha.common.sfix import Sfix
from pyha.components.dc_removal import DCRemoval
import numpy as np

from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, SIM_HW_MODEL, SIM_RTL


def test_basic():
    x = [2] * 8 + [-2] * 8
    expected = [1.75, 1.5, 1.25, 1., 0.75, 0.5, 0.25, 0., -3.5,
              -3., -2.5, -2., -1.5, -1., -0.5, 0.]
    dut = DCRemoval(8)

    assert_sim_match(dut, [Sfix(left=2, right=-18)], expected, x,
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL])
