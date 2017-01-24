from pyha.common.sfix import Sfix, ComplexSfix
import numpy as np

from pyha.common.signaltap_parser import SignalTapParser
from pyha.components.BladeDemod import BladeDemod
from pyha.components.blade_to_complex import BladeToComplex
from pyha.components.quadrature_demodulator import QuadratureDemodulator
from pyha.simulation.simulation_interface import SIM_MODEL, SIM_HW_MODEL, assert_sim_match, \
    SIM_RTL, SIM_GATE, debug_assert_sim_match


def test_from_signaltap():
    c = np.load('blade_signaltap.npy')

    dut = BladeDemod()
    # out = debug_assert_sim_match(dut, [Sfix(left=4, right=-11)] *2,
    assert_sim_match(dut, [Sfix(left=4, right=-11)] *2,
                                 None, c.real, c.imag,
                                 rtol=1e-3,
                                 atol=1e-3,
                                 simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                                 dir_path='/home/gaspar/git/pyha/playground/conv',
                                 )

    # import matplotlib.pyplot as plt
    # plt.plot(out[0], label='MODEL')
    # plt.plot(out[1], label='HW_MODEL')
    # # plt.plot(out[2], label='RTL')
    # plt.legend()
    # plt.show()

def test_from_live_signaltap():
    import matplotlib.pyplot as plt
    a = SignalTapParser('/home/gaspar/git/bladeRF/hdl/quartus/work/tap.csv')
    real = a.to_float(a[' iq_correction:U_rx_iq_correction|out_real[15..0]'], 16)
    real = real[::2]

    imag = a.to_float(a[' iq_correction:U_rx_iq_correction|out_imag[15..0]'], 16)
    imag = imag[::2]
    c = np.array([0 + 0j] * len(imag))
    c.real = real
    c.imag = imag

    quad_out = a.to_float(a[' top:quadrature_demod|out0[17..0]'], 18)
    # quad_out = quad_out[::2]

    qd = 2*np.pi * np.angle(c[1:] * np.conjugate(c[:-1]))/np.pi
    #
    # plt.plot(qd)
    # plt.plot(imag)
    # plt.plot(real)
    # # plt.plot(quad_out)
    # plt.show()

    dut = BladeToComplex()
    out = debug_assert_sim_match(dut, [Sfix(left=4, right=-11)]*2,
                                 # assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                                 [], c.real, c.imag,
                                 rtol=1e-3,
                                 atol=1e-3,
                                 simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                                 dir_path='/home/gaspar/git/pyha/playground/conv',
                                 )

    import matplotlib.pyplot as plt
    plt.plot(out[0], label='MODEL')
    plt.plot(out[1], label='HW_MODEL')
    plt.plot(out[2], label='RTL')
    plt.legend()
    plt.show()