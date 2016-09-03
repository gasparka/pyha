# %matplotlib inline
import logging

import numpy as np
from LEGACY.common.register import clock_tick


def resize(param, x):
    return 1


logging.basicConfig(level=logging.WARNING)
logger = logging.getLogger(__name__)


class Polar(object):
    def __init__(self, cordic_length=18, phase_unit='rad'):
        self.phase_unit = phase_unit
        self.x = [0] * cordic_length
        self.y = [0] * cordic_length
        self.phase = [0] * cordic_length

        self.wrap = 0

        # create phase LUT
        self.cordic_length = cordic_length
        self.phase_lut = [np.arctan(2 ** -i) for i in range(cordic_length)]
        self.first_phase = -np.pi
        if phase_unit is 'degrees':
            self.first_phase = -180
            self.phase_lut = [x * 180 / np.pi for x in self.phase_lut]

    @property
    def delay(self):
        return self.cordic_length

    def cordic_rotate_vector(self, i, direction, x, y, phase):
        # if direction:
        #     next_x = resize(x - y >> i, x)
        #     next_y = resize(y + x >> i, y)
        #     next_phase = resize(phase - self.phase_lut[i], phase)
        # else:
        #     next_x = resize(x + y >> i, x)
        #     next_y = resize(y - x >> i, y)
        #     next_phase = resize(phase + self.phase_lut[i], phase)
        logger.info('i={}, dir={}, x={}, y={}, phase={}'.format(i, direction, x, y, phase))
        if direction:
            next_x = x - y * (2 ** -i)
            next_y = y + x * (2 ** -i)
            next_phase = phase - self.phase_lut[i]
        else:
            next_x = x + y * (2 ** -i)
            next_y = y - x * (2 ** -i)
            next_phase = phase + self.phase_lut[i]

        logger.info('-> next_x={}, next_y={}, next_phase={}'.format(next_x, next_y, next_phase))
        return next_x, next_y, next_phase

    @clock_tick
    def main(self, x, y):
        next = self.next

        # inital rotation by pi
        # http://www.andraka.com/files/crdcsrvy.pdf page 3
        if x < 0:
            next.x[0] = -x
            next.y[0] = -y
            next.phase[0] = -np.pi
        else:
            next.x[0] = x
            next.y[0] = y
            next.phase[0] = 0

        for i in range(len(self.phase_lut) - 1):
            dir = self.y[i] < 0
            next.x[i + 1], next.y[i + 1], next.phase[i + 1] = \
                self.cordic_rotate_vector(i, dir, self.x[i], self.y[i], self.phase[i])

        # return phase, x * 1 / 1.646760
        diff = self.phase[-1] - self.phase[-2]
        if diff > np.pi:
            self.wrap -= 2 * np.pi
        elif diff < -np.pi:
            self.wrap += 2 * np.pi

        # self.phase[-1] += self.wrap
        self.phase[-2:] = np.unwrap(self.x[-2:])
        return self.phase[-1], self.x[-1] * 1 / 1.646760

    def _implementation_abstract(self, x, y):

        if x < 0:
            x = -x
            y = -y
            phase = -np.pi
        else:
            x = x
            y = y
            phase = 0

        for i, adj in enumerate(self.phase_lut):
            sign = 1 if y < 0 else -1
            x, y, phase = x - sign * (y * (2 ** -i)), y + sign * (x * (2 ** -i)), phase - sign * adj
        return phase, x * 1 / 1.646760

    def _abstract(self, x, y):
        inp = x + y * 1j
        phase = np.angle(inp, deg=self.phase_unit == 'degrees')
        pow = np.abs(inp)
        return phase, pow


def test_abstract():
    dut = Polar()
    input = 0.5 + 0.2j
    x = input.real
    y = input.imag
    phase, pow = dut._abstract(x, y)

    phase2, pow2 = dut._implementation_abstract(x, y)

    np.testing.assert_almost_equal(phase, phase2, decimal=3)
    np.testing.assert_almost_equal(pow, pow2, decimal=3)


def test_main():
    dut = Polar(18)
    input = 0.5 + 0.2j
    x = input.real
    y = input.imag
    phase, pow = dut._abstract(x, y)
    # phase2, pow2 = dut._implementation_abstract(x, y)

    for _ in range(dut.delay + 1):
        hdl_phase, hdl_pow = dut.main(x, y)
        # print(hdl_phase, hdl_pow)
    # print('REQ ', phase, pow)
    np.testing.assert_almost_equal(phase, hdl_phase, decimal=3)
    np.testing.assert_almost_equal(pow, hdl_pow, decimal=3)


# test_main()

def test_chirp():
    import numpy as np
    import matplotlib.pyplot as plt
    from scipy.signal import hilbert, chirp

    duration = 1.0
    fs = 400.0
    samples = int(fs * duration)
    t = np.arange(samples) / fs

    signal = chirp(t, 20.0, t[-1], 100.0)
    signal *= (1.0 + 0.5 * np.sin(2.0 * np.pi * 3.0 * t))

    analytic_signal = hilbert(signal)
    amplitude_envelope = np.abs(analytic_signal)
    instantaneous_phase = np.unwrap(np.angle(analytic_signal))
    # instantaneous_phase = np.angle(analytic_signal)
    instantaneous_frequency = np.diff(instantaneous_phase) / (2.0 * np.pi) * fs

    # fig = plt.figure()
    # ax0 = fig.add_subplot(311)
    # ax0.plot(t, signal, label='signal')
    # ax0.plot(t, amplitude_envelope, label='envelope')
    # ax0.set_xlabel("time in seconds")
    # ax0.legend()
    # ax1 = fig.add_subplot(312)
    # ax1.plot(t[1:], instantaneous_frequency)
    # ax1.set_xlabel("time in seconds")
    # ax1.set_ylim(0.0, 120.0)
    #
    # ax2 = fig.add_subplot(313)
    # ax2.plot(instantaneous_phase)
    # ax2.set_xlabel("time in seconds")
    # # ax2.set_ylim(0.0, 120.0)
    # plt.show()
    #
    # # ====================================== ENVELOPE
    # dut = Polar(18)
    # powl = []
    # analytic_signal = np.append(analytic_signal, [0 + 0*1j] * (dut.delay)) # add delay worth of inputs, so we get all samples out
    # for sig in analytic_signal:
    #     hdl_phase, hdl_pow = dut.main(sig.real, sig.imag)
    #     powl.append(hdl_pow)
    # plt.plot(powl)
    # plt.plot(amplitude_envelope)
    # plt.show()
    # np.testing.assert_almost_equal(powl[dut.delay:], amplitude_envelope, decimal=3)

    # ====================================== INSTANT PHASE
    dut = Polar(38)
    powl = []
    analytic_signal = np.append(analytic_signal, [0 + 0 * 1j] * (dut.delay))
    for sig in analytic_signal:
        # hdl_phase, hdl_pow = dut._implementation_abstract(sig.real, sig.imag)
        hdl_phase, hdl_pow = dut.main(sig.real, sig.imag)
        powl.append(hdl_phase)

    # plt.plot(powl)
    # plt.plot(powl[dut.delay:])
    plt.plot(powl[dut.delay:])
    plt.plot(instantaneous_phase)
    plt.show()
    np.testing.assert_almost_equal(powl[dut.delay:], instantaneous_phase, decimal=3)

    pass


test_chirp()


# def test_chirp_envelope():
#     import numpy as np
#     import matplotlib.pyplot as plt
#     from scipy.signal import hilbert, chirp
#
#     duration = 1.0
#     fs = 400.0
#     samples = int(fs * duration)
#     t = np.arange(samples) / fs
#
#     signal = chirp(t, 20.0, t[-1], 100.0)
#     signal *= (1.0 + 0.5 * np.sin(2.0 * np.pi * 3.0 * t))
#
#     analytic_signal = hilbert(signal)
#     amplitude_envelope = np.abs(analytic_signal)
#     instantaneous_phase = np.unwrap(np.angle(analytic_signal))
#     instantaneous_frequency = np.diff(instantaneous_phase) / (2.0 * np.pi) * fs
#
#     fig = plt.figure()
#     ax0 = fig.add_subplot(311)
#     ax0.plot(t, signal, label='signal')
#     ax0.plot(t, amplitude_envelope, label='envelope')
#     ax0.set_xlabel("time in seconds")
#     ax0.legend()
#     ax1 = fig.add_subplot(312)
#     ax1.plot(t[1:], instantaneous_frequency)
#     ax1.set_xlabel("time in seconds")
#     ax1.set_ylim(0.0, 120.0)
#
#     ax2 = fig.add_subplot(313)
#     ax2.plot(instantaneous_phase)
#     ax2.set_xlabel("time in seconds")
#     # ax2.set_ylim(0.0, 120.0)
#     plt.show()
#
#     # ======================================
#     dut = Polar(18)
#     phl = []
#     powl = []
#     for sig in analytic_signal:
#         # hdl_phase, hdl_pow = dut.main(sig.real, sig.imag)
#         hdl_phase, hdl_pow = dut._implementation_abstract(sig.real, sig.imag)
#         phl.append(hdl_phase)
#         powl.append(hdl_pow)
#     plt.plot(phl)
#     plt.plot(powl)
#     plt.plot(amplitude_envelope)
#     plt.show()
#     pass
