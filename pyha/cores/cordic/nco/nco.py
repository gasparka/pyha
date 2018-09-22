import pytest
from pyha import Hardware, Sfix, Complex, simulate, sims_close
import numpy as np

from pyha.cores import Cordic, CordicMode


class NCO(Hardware):
    """
    Baseband signal generator. Integrated phase accumulator.
    """

    def __init__(self, cordic_iterations=14):
        """

        :param cordic_iterations:
        """
        self.cordic = Cordic(cordic_iterations, CordicMode.ROTATION)
        self.phase_acc = Sfix(0, 0, -17, wrap_is_ok=True)
        self.out = Complex(0, 0, -17, overflow_style='saturate')
        self.DELAY = self.cordic.ITERATIONS + 1 + 1
        self.INIT_X = 1.0 / 1.646760  # gets rid of cordic gain, could use for amplitude modulation

    def main(self, phase_inc):
        """
        :param phase_inc: amount of rotation applied for next clock cycle, must be normalized to -1 to 1.
        :rtype: Complex
        """
        self.phase_acc = self.phase_acc + phase_inc

        start_x = self.INIT_X
        start_y = Sfix(0.0, 0, -17)

        x, y, phase = self.cordic.main(start_x, start_y, self.phase_acc)

        self.out = Complex(x, y)
        return self.out

    def model(self, phase_list):
        p = np.cumsum(np.array(phase_list) * np.pi)
        return np.exp(p * 1j)


def test_basic():
    inputs = [0.01] * 4
    expect = [np.exp(0.01j * np.pi), np.exp(0.02j * np.pi), np.exp(0.03j * np.pi), np.exp(0.04j * np.pi)]

    dut = NCO()
    sim_out = simulate(dut, inputs)
    assert sims_close(sim_out, expect, rtol=1e-2, atol=1e-4)


@pytest.mark.parametrize('period', [0.25, 0.50, 0.75, 1, 2, 4])
def test_nco(period):
    fs = 1024
    freq = 200
    phase_inc = 2 * np.pi * freq / fs
    phase_cumsum = np.arange(0, period * fs * phase_inc, phase_inc)

    input_signal = np.diff(phase_cumsum) / np.pi

    dut = NCO()
    sims = ['MODEL', 'HARDWARE', 'RTL']
    if period == 1:
        sims.append('NETLIST')

    sim_out = simulate(dut, input_signal, simulations=sims)
    assert sims_close(sim_out, rtol=1e-2, atol=1e-4)
