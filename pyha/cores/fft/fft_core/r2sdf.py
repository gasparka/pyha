import logging

import numpy as np
import pytest

from pyha import Hardware, simulate, sims_close, Complex, resize, scalb, Simulator, default_complex
from pyha.common.shift_register import ShiftRegister
from pyha.cores import DataValid, NumpyToDataValid, DataValidToNumpy, DownCounter
from pyha.cores.util import toggle_bit_reverse

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('fft')


def numpy_model(inp, fft_size, input_ordering='natural', inverse=False):
    """ This basically sums up what is going on in this file """
    x = np.array(inp).reshape(-1, fft_size)

    if input_ordering == 'bitreversed':
        x = toggle_bit_reverse(x)

    if inverse:
        ffts = np.fft.ifft(x, fft_size)
        ffts *= fft_size
    else:
        ffts = np.fft.fft(x, fft_size)
        ffts /= fft_size

    if input_ordering == 'natural':
        ffts = toggle_bit_reverse(ffts)

    return ffts.flatten()


def W(k, N):
    """ e^-j*2*PI*k*n/N, argument k = k * n """
    return np.exp(-1j * (2 * np.pi / N) * k)


class StageR2SDF(Hardware):
    def __init__(self, global_fft_size, stage_nr, twiddle_bits=18, inverse=False, input_ordering='natural'):
        self._pyha_simulation_input_callback = NumpyToDataValid(dtype=default_complex)

        self.INVERSE = inverse
        self.GLOBAL_FFT_SIZE = global_fft_size
        self.STAGE_NR = stage_nr
        self.INPUT_ORDERING = input_ordering

        if input_ordering == 'bitreversed':
            self.IS_NATURAL_ORDER = False
            self.INPUT_STRIDE = 2 ** stage_nr  # distance from butterfly input a to b
            self.LOCAL_FFT_SIZE = global_fft_size // self.INPUT_STRIDE
            self.CONTROL_MASK = (self.LOCAL_FFT_SIZE - 1)

            twid = [W(i, self.LOCAL_FFT_SIZE) for i in range(self.LOCAL_FFT_SIZE // 2)]
            twid = toggle_bit_reverse(twid)
            twid = np.roll(twid, 1, axis=0)
            self.TWIDDLES = [Complex(x, 0, -(twiddle_bits - 1), overflow_style='saturate', round_style='round')
                             for x in twid]

        elif input_ordering == 'natural':
            self.IS_NATURAL_ORDER = True
            self.LOCAL_FFT_SIZE = global_fft_size // 2 ** stage_nr
            self.INPUT_STRIDE = self.LOCAL_FFT_SIZE // 2
            self.CONTROL_MASK = (self.INPUT_STRIDE - 1)

            self.TWIDDLES = [Complex(W(i, self.LOCAL_FFT_SIZE), 0, -(twiddle_bits - 1), overflow_style='saturate',
                                     round_style='round')
                             for i in range(self.INPUT_STRIDE)]

        self.DELAY = 3 + self.INPUT_STRIDE
        self.IS_TRIVIAL_MULTIPLIER = len(self.TWIDDLES) == 1  # mult by 1.0, useless
        self.shr = ShiftRegister([Complex() for _ in range(self.INPUT_STRIDE)])
        self.twiddle = self.TWIDDLES[0]
        self.stage1_out = Complex(0, 0, -17)
        self.stage2_out = Complex(0, 0, -17 - (twiddle_bits - 1))
        self.output_index = 0
        self.mode_delay = False
        self.control = 0 # replacing this with fixed-point counter saves no resources..

        self.out = DataValid(Complex(0, 0, -17, round_style='round'), valid=False)
        self.final_counter = DownCounter(self.DELAY - 1)
        self.start_counter = DownCounter(self.DELAY - 1)

    def butterfly(self, in_up, in_down):
        up = resize(in_up + in_down, 0, -17)
        down = resize(in_up - in_down, 0, -17)
        return up, down

    def main(self, inp):
        if not inp.valid:
            return DataValid(self.out.data, valid=False)

        # Stage 1: handle the loopback memory - setup data for the butterfly
        self.control = (self.control + 1) % (self.LOCAL_FFT_SIZE)
        mode = not (self.control & self.INPUT_STRIDE)
        self.mode_delay = mode
        if mode:
            self.shr.push_next(inp.data)
            self.stage1_out = self.shr.peek()
        else:
            up, down = self.butterfly(self.shr.peek(), inp.data)
            self.shr.push_next(down)
            self.stage1_out = up
        # Also fetch the twiddle factor.
        if self.IS_NATURAL_ORDER:
            self.twiddle = self.TWIDDLES[self.control & self.CONTROL_MASK]
        else:
            self.twiddle = self.TWIDDLES[self.control >> (self.STAGE_NR + 1)]

        # Stage 2: complex multiply
        if self.mode_delay and not self.IS_TRIVIAL_MULTIPLIER:
            self.stage2_out = self.stage1_out * self.twiddle
        else:
            self.stage2_out = self.stage1_out

        # Stage 3: gain control and rounding
        # if self.FFT_HALF > 4:
        if self.INVERSE:
            self.out.data = self.stage2_out
        else:
            self.out.data = scalb(self.stage2_out, -1)

        self.start_counter.tick()
        self.out.valid = self.start_counter.is_over()
        return self.out

    def model_main(self, inp):
        if self.INPUT_ORDERING == 'natural':
            offset = self.LOCAL_FFT_SIZE // 2
            twiddles = [W(i, self.LOCAL_FFT_SIZE) for i in range(offset)]
            packets = np.array(np.reshape(inp, (-1, self.LOCAL_FFT_SIZE)))
            for pack in packets:
                for i in range(offset):
                    pack[i], pack[i + offset] = pack[i] + pack[i + offset], \
                                                (pack[i] - pack[i + offset]) * twiddles[i]

        elif self.INPUT_ORDERING == 'bitreversed':
            input_stride = 2 ** self.STAGE_NR
            local_fft_size = self.GLOBAL_FFT_SIZE // input_stride
            twiddles = toggle_bit_reverse([W(i, local_fft_size) for i in range(local_fft_size // 2)])
            packets = np.array(np.reshape(inp, (len(twiddles), -1)))  # note: this shape is upside down compared to NORMAL order function

            offset = input_stride
            for packet_i, pack in enumerate(packets):
                for i in range(offset):
                    pack[i], pack[i + offset] = pack[i] + pack[i + offset], \
                                                (pack[i] - pack[i + offset]) * twiddles[packet_i]
        if not self.INVERSE:
            packets = packets / 2
        return packets.flatten()


@pytest.mark.parametrize("fft_size", [2, 4, 8, 16, 32, 64])
@pytest.mark.parametrize("input_ordering", ['natural', 'bitreversed'])
def test_stage_all(fft_size, input_ordering):
    np.random.seed(0)
    input_signal = np.random.uniform(-1, 1, fft_size) + np.random.uniform(-1, 1, fft_size) * 1j
    input_signal *= 0.125
    expected = numpy_model(input_signal, fft_size, input_ordering)

    stage = 0
    inp = input_signal
    while 2 ** stage != fft_size:
        dut = StageR2SDF(fft_size, stage, input_ordering=input_ordering, inverse=False)

        sim = Simulator(dut).run(inp)
        sim.assert_equal(rtol=1e-5, atol=1e-5)
        inp = sim.out[0][0]
        stage += 1

    # test that final model answer is equal to the numpy one
    np.testing.assert_allclose(inp, expected)



class R2SDF(Hardware):
    def __init__(self, fft_size, twiddle_bits=9, inverse=False, input_ordering='natural'):
        self._pyha_simulation_input_callback = NumpyToDataValid(dtype=default_complex)
        self.INPUT_ORDERING = input_ordering
        self.INVERSE = inverse
        self.FFT_SIZE = fft_size
        self.N_STAGES = int(np.log2(fft_size))

        self.stages = [StageR2SDF(self.FFT_SIZE, i, twiddle_bits, inverse, input_ordering)
                       for i in range(self.N_STAGES)]

    def main(self, inp):
        var = inp
        if self.INVERSE:
            var = DataValid(Complex(inp.data.imag, inp.data.real), inp.valid)

        # execute stages
        for stage in self.stages:
            var = stage.main(var)

        if self.INVERSE:
            return DataValid(Complex(var.data.imag, var.data.real), var.valid)
        return var


    def model_main(self, inp):
        # from pyha.simulation.simulation import Tracer
        # if not Tracer.is_enabled():

        # from copy import deepcopy
        # lol = deepcopy(inp)
        # # if self.INVERSE:
        # #     lol = lol.imag + lol.real * 1j
        #
        # var = lol
        # for stage in self.stages:
        #     var = stage.model_main(var)
        #
        # # if self.INVERSE:
        # #     var = var.imag + var.real*1j
        # # return var
        # first_out = var


        x = np.array(inp).reshape(-1, self.FFT_SIZE)

        if self.INPUT_ORDERING == 'bitreversed':
            x = toggle_bit_reverse(x)

        if self.INVERSE:
            ffts = np.fft.ifft(x, self.FFT_SIZE)
            ffts *= self.FFT_SIZE
        else:
            ffts = np.fft.fft(x, self.FFT_SIZE)
            ffts /= self.FFT_SIZE

        if self.INPUT_ORDERING == 'natural':
            ffts = toggle_bit_reverse(ffts)

        return ffts.flatten()
        # else:
        # calculate via model_main to provide tracing info
        # from copy import deepcopy
        # lol = deepcopy(inp)
        # if self.INVERSE:
        #     lol = lol.imag + lol.real * 1j
        #
        # var = lol
        # for stage in self.stages:
        #     var = stage.model_main(var)
        #
        # if self.INVERSE:
        #     var = var.imag + var.real*1j
        # return var


def test_minimal_model_test():
    fft_size = 4
    np.random.seed(0)
    input_signal = np.random.uniform(-1, 1, fft_size) + np.random.uniform(-1, 1, fft_size) * 1j
    dut = R2SDF(fft_size, twiddle_bits=18, input_ordering='natural', inverse=False)
    mod = dut.model_main(input_signal)

    var = input_signal
    for stage in dut.stages:
        var = stage.model_main(var)
    other = var

    pass

@pytest.mark.parametrize("fft_size", [4])
@pytest.mark.parametrize("input_ordering", ['natural'])
@pytest.mark.parametrize("inverse", [False])
def test_lolz(fft_size, input_ordering, inverse):
    np.random.seed(0)
    input_signal = np.random.uniform(-1, 1, fft_size) + np.random.uniform(-1, 1, fft_size) * 1j

    if inverse:
        input_signal /= fft_size
    else:
        input_signal *= 0.125

    dut = R2SDF(fft_size, twiddle_bits=18, input_ordering=input_ordering, inverse=inverse)
    if inverse:
        Simulator(dut).run(input_signal).assert_equal(rtol=1e-3, atol=1e-3)
    else:
        Simulator(dut).run(input_signal).assert_equal(rtol=1e-4, atol=1e-4)


@pytest.mark.parametrize("fft_size", [2, 4, 8, 16, 32, 64, 128, 256])
@pytest.mark.parametrize("input_ordering", ['bitreversed', 'natural'])
@pytest.mark.parametrize("inverse", [True, False])
def test_all(fft_size, input_ordering, inverse):
    np.random.seed(0)
    input_signal = np.random.uniform(-1, 1, fft_size) + np.random.uniform(-1, 1, fft_size) * 1j

    if inverse:
        input_signal /= fft_size
    else:
        input_signal *= 0.125

    dut = R2SDF(fft_size, twiddle_bits=18, input_ordering=input_ordering, inverse=inverse)
    if inverse:
        Simulator(dut).run(input_signal).assert_equal(rtol=1e-3, atol=1e-3)
    else:
        Simulator(dut).run(input_signal).assert_equal(rtol=1e-4, atol=1e-4)


# low level tests, more for debugging
# class TestRev8:
#     def test_layer1(self):
#         input_signal = np.array(
#             [0.01 + 0.01j, 0.02 + 0.02j, 0.03 + 0.03j, 0.04 + 0.04j, 0.05 + 0.05j, 0.06 + 0.06j, 0.07 + 0.07j,
#              0.08 + 0.08j])
#         bitrev_input_signal = toggle_bit_reverse(input_signal)
#         input_control = [0, 1, 2, 3, 4, 5, 6, 7, 8]
#
#         expected = [6.00000000e-02 + 6.00000000e-02j, - 4.00000000e-02 - 4.00000000e-02j,
#                     1.00000000e-01 + 1.00000000e-01j, - 4.00000000e-02 + 4.00000000e-02j,
#                     8.00000000e-02 + 8.00000000e-02j, - 5.65685425e-02 - 3.46944695e-18j,
#                     1.20000000e-01 + 1.20000000e-01j, - 6.93889390e-18 + 5.65685425e-02j]
#         expected = np.array(expected) / 2
#
#         # (0.01 + 0.01j)(0.05 + 0.05j)(-0.04 - 0.04j)(1 + 0j)
#         # (0.03 + 0.03j)(0.07 + 0.07j)(-0.04 - 0.04j)(0 - 1j)
#         # (0.02 + 0.02j)(0.06 + 0.06j)(-0.04 - 0.04j)(0.7071067811865476 - 0.7071067811865475j)
#         # (0.04 + 0.04j)(0.08 + 0.08j)(-0.04 - 0.04j)(-0.7071067811865475 - 0.7071067811865476j)
#
#         with Sfix._float_mode:
#             dut = StageR2SDF(8, stage_nr=0, twiddle_bits=18, input_ordering='bitreversed')
#             sims = simulate(dut, bitrev_input_signal, input_control, simulations=['PYHA'])
#         np.testing.assert_allclose(expected, sims['PYHA'][0])
#
#     def test_layer2(self):
#         input_control = [0, 1, 2, 3, 4, 5, 6, 7, 8]
#         input_signal = [6.00000000e-02 + 6.00000000e-02j, - 4.00000000e-02 - 4.00000000e-02j,
#                         1.00000000e-01 + 1.00000000e-01j, - 4.00000000e-02 + 4.00000000e-02j,
#                         8.00000000e-02 + 8.00000000e-02j, - 5.65685425e-02 - 3.46944695e-18j,
#                         1.20000000e-01 + 1.20000000e-01j, - 6.93889390e-18 + 5.65685425e-02j]
#
#         expected = [1.60000000e-01 + 1.60000000e-01j, -8.00000000e-02 + 6.93889390e-18j,
#                     -4.00000000e-02 - 4.00000000e-02j, 6.93889390e-18 - 8.00000000e-02j,
#                     2.00000000e-01 + 2.00000000e-01j, -5.65685425e-02 + 5.65685425e-02j,
#                     -4.00000000e-02 + 4.00000000e-02j, - 5.65685425e-02 + 5.65685425e-02j]
#         expected = np.array(expected) / 2
#
#         # (0.060000000000000005 + 0.060000000000000005j)(0.1 + 0.1j)(-0.04 - 0.04j)(1 + 0j)
#         # (-0.04 - 0.04j)(-0.04000000000000001 + 0.04000000000000001j)(6.938893903907228e-18 - 0.08000000000000002j)(1 + 0j)
#         # (0.08 + 0.08j)(0.12 + 0.12j)(-0.039999999999999994 - 0.039999999999999994j)(6.123233995736766e-17 - 1j)
#         # (-0.056568542494923796 - 3.469446951953614e-18j)(-6.938893903907228e-18 + 0.0565685424949238j)(-0.05656854249492379 - 0.05656854249492381j)(6.123233995736766e-17 - 1j)
#
#         # (-0.04 - 0.04j)                                   (1 + 0j)
#         # (6.938893903907228e-18 - 0.08000000000000002j)    (1 + 0j)
#         # (-0.039999999999999994 - 0.039999999999999994j)   (0 - 1j)
#         # (-0.05656854249492379 - 0.05656854249492381j)     (0 - 1j)
#
#         # F4 - 0.04 - 0.04j[0:-17] *            0 - 1j
#         # F4 0 - 0.08j[0:-17] *                 1 + 0j
#         # F4 - 0.04 - 0.04j[0:-17] *            0 - 1j
#         # F4 - 0.0565685 - 0.0565685j[0:-17] *  1 + 0j
#
#         with Sfix._float_mode:
#             dut = StageR2SDF(8, stage_nr=1, twiddle_bits=18, input_ordering='bitreversed')
#             sims = simulate(dut, input_signal, input_control, simulations=['PYHA'])
#         np.testing.assert_allclose(expected, sims['PYHA'][0])
#
#     def test_full(self):
#         fft_size = 8
#         input_signal = np.array(
#             [0.01 + 0.01j, 0.02 + 0.02j, 0.03 + 0.03j, 0.04 + 0.04j, 0.05 + 0.05j, 0.06 + 0.06j, 0.07 + 0.07j,
#              0.08 + 0.08j])
#         bitrev_input_signal = toggle_bit_reverse(input_signal)
#
#         dut = R2SDF(fft_size, twiddle_bits=18, input_ordering='bitreversed')
#         rev_sims = simulate(dut, bitrev_input_signal, input_callback=package, output_callback=unpackage,
#                             simulations=['MODEL', 'PYHA'])
#         assert sims_close(rev_sims)
#
#
# class TestRev4:
#     def test_layer4(self):
#         input_signal = np.array([0.1 + 0.1j, 0.2 + 0.2j, 0.3 + 0.3j, 0.4 + 0.4j])
#         bitrev_input_signal = toggle_bit_reverse(input_signal)
#         input_control = [0, 1, 2, 3]
#
#         expected = [0.2 + 0.2j, -0.1 - 0.1j, 0.3 + 0.3j, -0.1 + 0.1j]
#
#         with Sfix._float_mode:
#             dut = StageR2SDF(4, stage_nr=0, twiddle_bits=18, input_ordering='bitreversed')
#             sims = simulate(dut, bitrev_input_signal, input_control, simulations=['PYHA'])
#         np.testing.assert_allclose(expected, sims['PYHA'][0])
#
#     def test_layer2(self):
#         input_signal = [0.2 + 0.2j, -0.1 - 0.1j, 0.3 + 0.3j, -0.1 + 0.1j]
#         input_control = [0, 1, 2, 3]
#
#         expected = [0.5 + 0.5j, -0.2 + 0.0j, -0.1 - 0.1j, 0.0 - 0.2j]
#         expected = np.array(expected) / 2
#
#         with Sfix._float_mode:
#             dut = StageR2SDF(4, stage_nr=1, twiddle_bits=18, input_ordering='bitreversed')
#             sims = simulate(dut, input_signal, input_control, simulations=['PYHA'])
#         np.testing.assert_allclose(expected, sims['PYHA'][0])
#
#     def test_full(self):
#         fft_size = 4
#         input_signal = np.array([0.1 + 0.1j, 0.2 + 0.2j, 0.3 + 0.3j, 0.4 + 0.4j])
#         bitrev_input_signal = toggle_bit_reverse(input_signal)
#
#         dut = R2SDF(fft_size, twiddle_bits=18, input_ordering='bitreversed')
#         rev_sims = simulate(dut, bitrev_input_signal, input_callback=package, output_callback=unpackage,
#                             simulations=['MODEL', 'PYHA'])
#         assert sims_close(rev_sims)
