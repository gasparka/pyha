import numpy as np
from pyha.common.sfix import ComplexSfix
from pyha.components.quadrature_demodulator import QuadratureDemodulator, QuadratureDemodulatorPartial0, QuadratureDemodulatorPartial1
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
                         rtol=1e-4,
                         atol=1e-4,
                         simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         dir_path='/home/gaspar/git/pyha/playground/conv'
                         )
        # import matplotlib.pyplot as plt
        # plt.plot(out[0], label='MODEL')
        # plt.plot(out[1], label='HW_MODEL')
        # plt.plot(out[2], label='RTL')
        # plt.legend()
        # plt.show()
