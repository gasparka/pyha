from pyha.common.sfix import Sfix
import numpy as np

from pyha.components.BladeDemod import BladeDemod
from pyha.simulation.simulation_interface import SIM_MODEL, SIM_HW_MODEL, assert_sim_match, \
    SIM_RTL, SIM_GATE


def test_from_signaltap():
    c = np.load('blade_signaltap.npy')

    dut = BladeDemod()
    # out = debug_assert_sim_match(dut, [Sfix(left=4, right=-11)] *2,
    assert_sim_match(dut, [Sfix(left=4, right=-11)] *2,
                                 [], c.real, c.imag,
                                 rtol=1e-3,
                                 atol=1e-3,
                                 simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                                 dir_path='/home/gaspar/git/pyha/playground/conv',
                                 )

    # import matplotlib.pyplot as plt
    # plt.plot(out[0], label='MODEL')
    # plt.plot(out[1], label='HW_MODEL')
    # # plt.plot(out[2], label='RTL')
    # plt.legend()
    # plt.show()