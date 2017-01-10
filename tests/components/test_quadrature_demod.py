from pyha.common.sfix import Sfix
from pyha.components.dc_removal import DCRemoval
from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE


def test_basic():
    x = [1] * 16 + [-1] * 16
    expected = [0.984375, 0.953125, 0.90625, 0.84375, 0.765625, 0.671875,
                0.5625, 0.4375, 0.328125, 0.234375, 0.15625, 0.09375,
                0.046875, 0.015625, 0., 0., -1.96875, -1.90625,
                -1.8125, -1.6875, -1.53125, -1.34375, -1.125, -0.875,
                -0.65625, -0.46875, -0.3125, -0.1875, -0.09375, -0.03125,
                0., 0.]

    dut = DCRemoval(8)

    # convert_to_folder(dut, [Sfix(left=1, right=-18)],
    #                   '/home/gaspar/git/pyha/playground/conv',
    #                   x)

    assert_sim_match(dut, [Sfix(left=1, right=-18)], expected, x,
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                     # dir_path='/home/gaspar/git/pyha/playground/conv'

                     )

