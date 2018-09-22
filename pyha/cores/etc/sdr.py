from pyha import Hardware, Complex, scalb, Sfix, simulate
from pyha.common.datavalid import DataValid
from pyha.simulation.simulation_interface import assert_equals, sims_close
import numpy as np


class SDRSource(Hardware):
    """ Convert BladeRF/LimeSDR style I/Q (4 downto -11) into stream of Complex (0 downto -17) type """
    def __init__(self):
        self.out = DataValid(Complex(0, 0, -17, overflow_style='saturate'))

    def main(self, real, imag):
        self.out.data = scalb(Complex(real, imag), 4)
        self.out.valid = True
        return self.out

    def model(self, i, q):
        return np.array(i) * (2 ** 4) + np.array(q) * (2 ** 4) * 1j


class BladeRFSink(Hardware):
    """ Convert Pyha Complex style (0 downto -17) into BladeRF style I/Q (4 downto -11) """
    def __init__(self):
        self.out_real = Sfix(0, 0, -15, round_style='round')
        self.out_imag = Sfix(0, 0, -15, round_style='round')

        self.DELAY = 1

    def main(self, c):
        self.out_real = scalb(c.real, -4)
        self.out_imag = scalb(c.imag, -4)
        return self.out_real, self.out_imag

    def model(self, c):
        real = [x.real * (2 ** -4) for x in c]
        imag = [x.imag * (2 ** -4) for x in c]
        return real, imag


def test_source():
    i = [0.015, -0.04]
    q = [0.029, +0.02]
    dut = SDRSource()
    sim_out = simulate(dut, i, q, pipeline_flush='auto')
    assert sims_close(sim_out, rtol=1e-3)


def test_sink():
    input = [0.15 + 0.69j, -0.8+0.2j]
    dut = BladeRFSink()
    sim_out = simulate(dut, input)
    assert sims_close(sim_out)
