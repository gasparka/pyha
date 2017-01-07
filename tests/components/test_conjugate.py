from pyha.common.sfix import ComplexSfix
from pyha.components.conjugate import Conjugate
from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE


def test_basic():
    x = [0.5 + 0.1j, -0.234 + 0.1j, 0.5 - 0.1j, 1 + 1j, 1 - 1j]
    expected = [0.5 - 0.1j, -0.234 - 0.1j, 0.5 + 0.1j, 1 - 1j, 1 + 1j]

    dut = Conjugate()

    assert_sim_match(dut, [ComplexSfix(left=0, right=-18)], expected, x,
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                     )
