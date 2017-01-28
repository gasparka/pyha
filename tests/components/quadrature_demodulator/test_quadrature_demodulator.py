import numpy as np
import scipy

from pyha.common.sfix import ComplexSfix
from pyha.common.signaltap_parser import SignalTapParser
from pyha.components.quadrature_demodulator import QuadratureDemodulator, QuadratureDemodulatorPartial0, \
    QuadratureDemodulatorPartial1
from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, debug_assert_sim_match, SIM_HW_MODEL, \
    SIM_RTL, SIM_GATE


class TestFm:
    def setup(self):
        # data signal
        fs = 1e3
        periods = 1
        data_freq = 20
        time = np.linspace(0, periods, fs * periods, endpoint=False)  # NB! NOTICE ENDPOINT TO MATCH GNURADIO
        self.data = np.cos(2 * np.pi * data_freq * time)
        # modulate
        deviation = fs / 3
        sensitivity = 2 * np.pi * deviation / fs
        phl = np.cumsum(sensitivity * self.data)
        self.mod = np.exp(phl * 1j)

        self.demod_gain = fs / (2 * np.pi * deviation)

    def test_partial_conj(self):
        inputs = self.mod

        dut = QuadratureDemodulatorPartial0(gain=self.demod_gain)
        assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         None, inputs,
                         rtol=1e-4,
                         simulations=[SIM_MODEL, SIM_HW_MODEL]
                         )

    def test_partial_conj_cmult(self):
        inputs = self.mod

        dut = QuadratureDemodulatorPartial1(gain=self.demod_gain)
        assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         None, inputs,
                         rtol=1e-4,
                         simulations=[SIM_MODEL, SIM_HW_MODEL]
                         )

    def test_demod(self):
        inputs = self.mod
        expect = self.data[1:]

        dut = QuadratureDemodulator(gain=self.demod_gain)
        # out = debug_assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
        assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         expect, inputs,
                         rtol=1e-3,
                         atol=1e-3,
                         simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         dir_path='/home/gaspar/git/pyha/playground/conv',
                         # fuck_it=True
                         )
        # import matplotlib.pyplot as plt
        # plt.plot(out[0], label='MODEL')
        # plt.plot(out[1], label='HW_MODEL')
        # plt.plot(out[2], label='RTL')
        # plt.legend()
        # plt.show()


class TestPhantom2:
    """ Uses one chunk of Phantom 2 transmission """

    def setup(self):
        inputs = scipy.fromfile(open('f2404_fs16.896_one_hop.iq'), dtype=scipy.complex64)
        inputs = inputs[18000:19000]
        self.mod = inputs
        self.demod_gain = 1.5

    def test_partial_conj_cmult(self):
        inputs = self.mod

        dut = QuadratureDemodulatorPartial1(gain=self.demod_gain)
        assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         None, inputs,
                         rtol=1e-4,
                         atol=1e-4,
                         simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL]
                         )

    def test_demod(self):
        inputs = self.mod
        expect = []

        dut = QuadratureDemodulator(gain=self.demod_gain)
        assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         expect, inputs,
                         rtol=1e-3,
                         atol=1e-3,
                         simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         dir_path='/home/gaspar/git/pyha/playground/conv',
                         )

    def test_from_signaltap(self):
        a = SignalTapParser('/home/gaspar/git/bladeRF/hdl/quartus/work/tap.csv')
        real = a.to_bladerf(a[' iq_correction:U_rx_iq_correction|out_real[15..0]'])
        real = real[::2]

        imag = a.to_bladerf(a[' iq_correction:U_rx_iq_correction|out_imag[15..0]'])
        imag = imag[::2]
        c = np.array([0+0j]*len(imag))
        c.real = real
        c.imag = imag

        quad_out = a.to_float(a[' top:quadrature_demod|out0[17..0]'], 18)
        quad_out = quad_out[::2]

        # qd = np.angle(c[1:] * np.conjugate(c[:-1]))
        #
        # plt.plot(qd)
        # # plt.plot(imag)
        # # plt.plot(real)
        # plt.plot(quad_out)
        # plt.show()

        dut = QuadratureDemodulator(gain=self.demod_gain)
        out = debug_assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
        # assert_sim_match(dut, [ComplexSfix(left=0, right=-17)],
                         [], c,
                         rtol=1e-3,
                         atol=1e-3,
                         simulations=[SIM_MODEL, SIM_HW_MODEL],
                         dir_path='/home/gaspar/git/pyha/playground/conv',
                         )

        import matplotlib.pyplot as plt
        plt.plot(out[0], label='MODEL')
        plt.plot(out[1], label='HW_MODEL')
        # plt.plot(out[2], label='RTL')
        plt.legend()
        plt.show()




