from pathlib import Path

import numpy as np
import pytest

from pyha.common.sfix import Sfix, ComplexSfix
from pyha.common.util import load_gnuradio_file
from pyha.components.blade_demod.blade_demod import BladeDemodPartial0, DemodQuad, DemodQuadMavg
from pyha.simulation.simulation_interface import SIM_MODEL, SIM_HW_MODEL, assert_sim_match, \
    SIM_RTL, SIM_GATE, plot_assert_sim_match


def test_from_signaltap():
    path = Path(__file__).parent / 'data/blade_signaltap.npy'
    c = np.load(str(path))

    dut = BladeDemodPartial0()
    assert_sim_match(dut, [Sfix(left=0, right=-15)] * 2,
                     None, c.real, c.imag,
                     rtol=1e-3,
                     atol=1e-3,
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                     )


def test_low_power():
    pytest.xfail('this is interesting as it has RTL/HWSIM mismatch')
    path = Path(__file__).parent / 'data/blade_tap_low_power_rtl_mismatch.npy'
    c = np.load(path)

    dut = BladeDemodPartial0()
    plot_assert_sim_match(dut, [Sfix(left=0, right=-15)] * 2,
                          None, c.real, c.imag,
                          rtol=1e-3,
                          atol=1e-3,
                          simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                          )


class TestUks:
    def setup(self):
        path = Path(__file__).parent / 'data/one_uksetaga_f2405350000.00_fs2181818.18_rx6_30_0_band2000000.00.iq'
        self.iq = load_gnuradio_file(str(path))
        self.shord_iq = self.iq[600:2000]
        self.demod_gain = 0.5

    def test_quad_demod(self):
        dut = DemodQuad(self.demod_gain)
        assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         None, self.shord_iq,
                         rtol=1e-2,
                         atol=1e-2
                         )

    def test_quad_demod_mavg(self):
        dut = DemodQuadMavg(self.demod_gain, 16)
        assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         None, self.shord_iq,
                         rtol=1e-2,
                         atol=1e-2,
                         skip_first=16
                         )


# class TestBlade:
#     def setup(self):
#         path = Path(__file__).parent / 'data/blade_tap_one.npy'
#         self.iq = load_gnuradio_file(str(path))
#         self.demod_gain = 0.5
#
#     def test_quad_demod(self):
#         dut = DemodQuad(self.demod_gain)
#         plot_assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
#                          None, self.iq,
#                          rtol=1e-2,
#                          atol=1e-2
#                          )
#
#     # def test_quad_demod_mavg(self):
#     #     dut = BladeDemodQuadMavg(self.demod_gain, 16)
#     #     assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
#     #                      None, self.shord_iq,
#     #                      rtol=1e-2,
#     #                      atol=1e-2,
#     #                      skip_first=16
#     #                      )

# def test_from_live_signaltap():
#     # todo: remove, only for debug
#     import matplotlib.pyplot as plt
#     from pyha.common.signaltap_parser import SignalTapParser
#     a = SignalTapParser('/home/gaspar/git/bladeRF/hdl/quartus/work/multi_valid_bug.csv')
#     real = a.to_float(a[' iq_correction:U_rx_iq_correction|out_real[15..0]'], 16)
#     real = real[::2]
#
#     imag = a.to_float(a[' iq_correction:U_rx_iq_correction|out_imag[15..0]'], 16)
#     imag = imag[::2]
#     c = np.array([0 + 0j] * len(imag))
#     c.real = real
#     c.imag = imag
#
#     np.save('blade_tap_multiple_valid_bug.npy', c)
#
#     # quad_out = a.to_float(a[' top:quadrature_demod|out0[17..0]'], 18)
#     # quad_out = quad_out[::2]
#
#     qd = 2 * np.pi * np.angle(c[1:] * np.conjugate(c[:-1])) / np.pi
#     #
#     plt.plot(qd)
#     # plt.plot(imag)
#     # plt.plot(real)
#     # plt.plot(quad_out)
#     plt.show()

    # dut = BladeDemod()
    # plot_assert_sim_match(dut, [Sfix(left=0, right=-15)] * 2,
    #                       [], c.real, c.imag,
    #                       rtol=1e-3,
    #                       atol=1e-3,
    #                       simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
    #                       dir_path='/home/gaspar/git/pyha/playground/conv',
    #                       )
