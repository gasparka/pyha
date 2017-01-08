from pyha.common.sfix import ComplexSfix
from pyha.components.util_complex import Conjugate
from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE


def test_conjugate():
    inputs = [0.5 + 0.1j, -0.234 + 0.1j, 0.5 - 0.1j, 1 + 1j, 1 - 1j, -1 + 1j, -1 - 1j]
    expect = [0.5 - 0.1j, -0.234 - 0.1j, 0.5 + 0.1j, 1 - 1j, 1 + 1j, -1 - 1j, -1 + 1j]

    dut = Conjugate()

    assert_sim_match(dut, [ComplexSfix(left=0, right=-18)], expect, inputs,
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                     dir_path='/home/gaspar/git/pyha/playground/conv'
                     )
