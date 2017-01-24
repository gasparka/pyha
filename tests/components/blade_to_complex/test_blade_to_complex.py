from pyha.common.sfix import Sfix
import numpy as np

from pyha.common.signaltap_parser import SignalTapParser
from pyha.components.blade_to_complex import BladeToComplex
from pyha.simulation.simulation_interface import SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE, \
    assert_sim_match, debug_assert_sim_match, plot_assert_sim_match


def test_from_signaltap():
    c = np.load('signaltap_balderf_iq.npy')

    dut = BladeToComplex()
    assert_sim_match(dut, [Sfix(left=0, right=-15)]*2,
                                 None, c.real, c.imag,
                                 rtol=1e-9,
                                 atol=1e-9,
                                 simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                                 dir_path='/home/gaspar/git/pyha/playground/conv',
                                 )


def test_low_power_bug():
    """ RTL sim did not work if inputs low power """
    c = np.load('low_power.npy')

    dut = BladeToComplex()
    assert_sim_match(dut, [Sfix(left=0, right=-15)]*2,
                                 None, c.real, c.imag,
                                 rtol=1e-9,
                                 atol=1e-9,
                                 simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                                 dir_path='/home/gaspar/git/pyha/playground/conv',
                                 )
