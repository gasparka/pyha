from pyha.common.sfix import Sfix
import numpy as np

from pyha.components.blade_adaptor import BladeToComplex, NormalToBlade
from pyha.simulation.simulation_interface import SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE, \
    assert_sim_match, debug_assert_sim_match, plot_assert_sim_match


def test_to_complex():
    c = np.load('signaltap_balderf_iq.npy')

    dut = BladeToComplex()
    assert_sim_match(dut, [Sfix(left=0, right=-15)]*2,
                                 None, c.real, c.imag,
                                 rtol=1e-9,
                                 atol=1e-9,
                                 simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE]                                 )


def test_to_complex_low_power_bug():
    """ RTL sim did not work if inputs low power """
    c = np.load('low_power.npy')

    dut = BladeToComplex()
    assert_sim_match(dut, [Sfix(left=0, right=-15)]*2,
                                 None, c.real, c.imag,
                                 rtol=1e-9,
                                 atol=1e-9,
                                 simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE]
                                 )


def test_normal_to_blade():

    input = np.random.rand(128) * 2 - 1
    dut = NormalToBlade()
    assert_sim_match(dut, [Sfix(left=0, right=-17)],
                                 None, input,
                                 rtol=1e-4,
                                 atol=1e-4,
                                 simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL]
                                 )