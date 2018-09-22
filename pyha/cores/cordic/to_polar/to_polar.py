from pyha import Hardware, Sfix, simulate, sims_close, Complex
from pyha.cores import Cordic, CordicMode
import numpy as np


class ToPolar(Hardware):
    """
    Converts IQ to polar form, returning 'abs' and 'angle'. Angle is in [-1 to 1] range i.e. divided by np.pi.
    """

    def __init__(self, precision=-17):
        self.core = Cordic(14, CordicMode.VECTORING, precision=precision)
        self.y_abs = Sfix(0, 0, -17, overflow_style='saturate')
        self.y_angle = Sfix(0, 0, -17, overflow_style='saturate')

        self.DELAY = self.core.ITERATIONS + 1

    def main(self, c):
        """
        :type c: Complex
        :return: abs (gain corrected) angle (in 1 to -1 range)
        """
        phase = Sfix(0.0, 0, -17)

        abs, _, angle = self.core.main(c.real, c.imag, phase)

        # get rid of CORDIC gain and extra bits
        self.y_abs = abs * (1.0 / 1.646760)
        self.y_angle = angle
        return self.y_abs, self.y_angle

    def model(self, cin):
        return np.abs(cin), np.angle(cin) / np.pi  # NOTICE, angle is divided by np.pi


class Angle(Hardware):
    """
    Equal to Numpy.angle()/pi
    """

    def __init__(self, precision=-17):
        self.core = ToPolar(precision=precision)
        self.DELAY = self.core.DELAY

    def main(self, c):
        _, angle = self.core.main(c)
        return angle

    def model(self, cin):
        # note that angle in -1..1 range
        return np.angle(cin) / np.pi


class Abs(Hardware):
    """
    Equal to Numpy.abs()
    """

    def __init__(self, precision=-17):
        self.core = ToPolar(precision=precision)
        self.DELAY = self.core.DELAY

    def main(self, c):
        abs, _ = self.core.main(c)
        return abs

    def model(self, cin):
        return [np.abs(x) for x in cin]


def test_quadrant_i():
    inputs = [0.234 + 0.92j]
    expect = [np.abs(inputs), np.angle(inputs) / np.pi]

    dut = ToPolar()
    sim_out = simulate(dut, inputs)
    assert sims_close(sim_out, expect)


def test_quadrant_ii():
    inputs = [-0.234 + 0.92j]
    expect = [np.abs(inputs), np.angle(inputs) / np.pi]

    dut = ToPolar()
    sim_out = simulate(dut, inputs)
    assert sims_close(sim_out, expect)


def test_quadrant_iii():
    inputs = [-0.234 - 0.92j]
    expect = [np.abs(inputs), np.angle(inputs) / np.pi]

    dut = ToPolar()
    sim_out = simulate(dut, inputs)
    assert sims_close(sim_out, expect)


def test_quadrant_iv():
    inputs = [0.234 - 0.92j]
    expect = [np.abs(inputs), np.angle(inputs) / np.pi]

    dut = ToPolar()
    sim_out = simulate(dut, inputs)
    assert sims_close(sim_out, expect)


def test_overflow_condition():
    import pytest
    pytest.xfail('abs would be > 1 (1.84)')
    inputs = [0.92j + 0.92j]
    expect = [np.abs(inputs), np.angle(inputs) / np.pi]
    dut = ToPolar()
    sim_out = simulate(dut, inputs)
    assert sims_close(sim_out, expect)


def chirp_stimul():
    """ Amplitude modulated chirp signal """
    from scipy.signal import chirp, hilbert
    duration = 1.0
    fs = 256
    samples = int(fs * duration)
    t = np.arange(samples) / fs
    signal = chirp(t, 20.0, t[-1], 100.0)
    signal *= (1.0 + 0.5 * np.sin(2.0 * np.pi * 3.0 * t))
    analytic_signal = hilbert(signal) * 0.5
    ref_abs = np.abs(analytic_signal)
    ref_instantaneous_phase = np.angle(analytic_signal)
    return analytic_signal, ref_abs, ref_instantaneous_phase


def test_chirp():
    analytic_signal, ref_abs, ref_instantaneous_phase = chirp_stimul()

    inputs = analytic_signal
    expect = [ref_abs, ref_instantaneous_phase / np.pi]

    dut = ToPolar()
    sim_out = simulate(dut, inputs)
    assert sims_close(sim_out, expect, atol=1e-4)


def test_angle_randoms():
    np.random.seed(123)
    inputs = (np.random.rand(1024) * 2 - 1) + ((np.random.rand(1024) * 2 - 1) * 1j)
    inputs *= 0.25
    expect = np.angle(inputs) / np.pi

    dut = Angle()
    sim_out = simulate(dut, inputs)
    assert sims_close(sim_out, expected=expect, rtol=1e-1)


def test_angle_unit():
    np.random.seed(123456)
    inputs = [-0.04036712646484375 - 0.03749847412109375j]
    expect = np.angle(inputs) / np.pi

    dut = Angle()
    sim_out = simulate(dut, inputs, simulations=['MODEL', 'HARDWARE'])
    sims_close(sim_out, expected=expect, rtol=1e-2)


def test_angle_basic():
    inputs = [np.exp(0.5j), np.exp(0.1j)]
    expect = [0.5 / np.pi, 0.1 / np.pi]

    dut = Angle()
    sim_out = simulate(dut, inputs)
    assert sims_close(sim_out, expect, atol=1e-4)


def test_angle_chirp():
    analytic_signal, ref_abs, ref_instantaneous_phase = chirp_stimul()

    inputs = analytic_signal
    expect = ref_instantaneous_phase / np.pi

    dut = Angle()
    sim_out = simulate(dut, inputs)
    assert sims_close(sim_out, expect, atol=1e-4)


def test_abs_basic():
    inputs = [-0.25 * np.exp(0.5j), 0.123 * np.exp(0.1j)]
    expect = [0.25, 0.123]

    dut = Abs()
    sim_out = simulate(dut, inputs)
    assert sims_close(sim_out, expect)


def test_abs_chirp():
    analytic_signal, ref_abs, ref_instantaneous_phase = chirp_stimul()

    inputs = analytic_signal
    expect = ref_abs

    dut = Abs()
    sim_out = simulate(dut, inputs)
    assert sims_close(sim_out, expect)
