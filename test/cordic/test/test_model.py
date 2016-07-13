import numpy as np

from test.cordic.model.main import Polar


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

def test_chirp_envelope():
    import numpy as np
    from scipy.signal import hilbert, chirp

    duration = 1.0
    fs = 400.0
    samples = int(fs * duration)
    t = np.arange(samples) / fs

    signal = chirp(t, 20.0, t[-1], 100.0)
    signal *= (1.0 + 0.5 * np.sin(2.0 * np.pi * 3.0 * t))

    analytic_signal = hilbert(signal)
    amplitude_envelope = np.abs(analytic_signal)

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

    dut = Polar(18)
    powl = []
    analytic_signal = np.append(analytic_signal,
                                [0 + 0 * 1j] * (dut.delay))  # add delay worth of inputs, so we get all samples out
    for sig in analytic_signal:
        hdl_phase, hdl_pow = dut.main(sig.real, sig.imag)
        powl.append(hdl_pow)
    # plt.plot(powl)
    # plt.plot(amplitude_envelope)
    # plt.show()
    np.testing.assert_almost_equal(powl[dut.delay:], amplitude_envelope, decimal=3)


def test_chirp_phase():
    # FIXME: unwrapped phase is different, is this normal?
    import numpy as np
    from scipy.signal import hilbert, chirp

    duration = 1.0
    fs = 400.0
    samples = int(fs * duration)
    t = np.arange(samples) / fs

    signal = chirp(t, 20.0, t[-1], 100.0)
    signal *= (1.0 + 0.5 * np.sin(2.0 * np.pi * 3.0 * t))

    analytic_signal = hilbert(signal)
    instantaneous_phase = np.angle(analytic_signal)

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

    dut = Polar(18)
    dut_phase = []
    analytic_signal = np.append(analytic_signal, [0 + 0 * 1j] * (dut.delay))
    for sig in analytic_signal:
        # hdl_phase, hdl_pow = dut._implementation_abstract(sig.real, sig.imag)
        hdl_phase, hdl_pow = dut.main(sig.real, sig.imag)
        dut_phase.append(hdl_phase)

    dut_phase = np.unwrap(dut_phase)
    instantaneous_phase = np.unwrap(instantaneous_phase)
    # plt.plot(analytic_signal.real)
    # plt.plot(dut_phase)
    # plt.plot(instantaneous_phase)
    # plt.show()
    np.testing.assert_almost_equal(dut_phase[dut.delay:], instantaneous_phase, decimal=3)



    # TODO: UNWRAP CODE
    # # plt.plot(powl)
    # # plt.plot(powl[dut.delay:])
    # wrap = 0
    # tmp = []
    # for i, _ in enumerate(dut_phase[1:]):
    #     dut_phase[i] += wrap
    #     # dut_phase[i - 1] += wrap
    #     # diff = (dut_phase[i] + wrap) - (dut_phase[i-1] + wrap)
    #     # tmp.append(dut_phase[i] + wrap)
    #     diff = (dut_phase[i]) - (dut_phase[i - 1])
    #     if diff > np.pi:
    #         wrap -= 2 * np.pi
    #         # dut_phase[i] += wrap
    #         # dut_phase[i:] = [x - 2 * np.pi for x in dut_phase[i:]]
    #         # wrap -= 2*np.pi
    #     elif diff < -np.pi:
    #         wrap += 2 * np.pi
    #         # dut_phase[i] += wrap
    #         # dut_phase[i:] = [x + 2 * np.pi for x in dut_phase[i:]]
    #         # dut_phase[i] += wrap
