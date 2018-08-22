import logging
import pytest
from pyha import Hardware, simulate, sims_close, Complex, resize, scalb, Sfix
import numpy as np
from pyha.common.shift_register import ShiftRegister
from pyha.cores import DataIndexValid, DataIndexValidDePackager, DataIndexValidPackager
from pyha.cores.util import toggle_bit_reverse

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('fft')


def W(k, N):
    """ e^-j*2*PI*k*n/N, argument k = k * n """
    return np.exp(-1j * (2 * np.pi / N) * k)


class StageR2SDF(Hardware):
    def __init__(self, global_fft_size, stage_nr, twiddle_bits=18, inverse=False, input_ordering='natural'):
        self.INVERSE = inverse
        self.GLOBAL_FFT_SIZE = global_fft_size
        self.STAGE_NR = stage_nr

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
        self.stage3_out = Complex(0, 0, -17, round_style='round')
        self.output_index = 0
        self.mode_delay = False

    def butterfly(self, in_up, in_down):
        up = resize(in_up + in_down, 0, -17)
        down = resize(in_up - in_down, 0, -17)
        return up, down

    def main(self, x, control):
        # Stage 1: handle the loopback memory - setup data for the butterfly
        mode = not (control & self.INPUT_STRIDE)
        self.mode_delay = mode
        if mode:
            self.shr.push_next(x)
            self.stage1_out = self.shr.peek()
        else:
            up, down = self.butterfly(self.shr.peek(), x)
            self.shr.push_next(down)
            self.stage1_out = up
        # Also fetch the twiddle factor.
        if self.IS_NATURAL_ORDER:
            self.twiddle = self.TWIDDLES[control & self.CONTROL_MASK]
        else:
            self.twiddle = self.TWIDDLES[(control >> (self.STAGE_NR + 1)) & self.CONTROL_MASK]

        # Stage 2: complex multiply
        if self.mode_delay and not self.IS_TRIVIAL_MULTIPLIER:
            self.stage2_out = self.stage1_out * self.twiddle
        else:
            self.stage2_out = self.stage1_out

        # Stage 3: gain control and rounding
        # if self.FFT_HALF > 4:
        if self.INVERSE:
            self.stage3_out = self.stage2_out
        else:
            self.stage3_out = scalb(self.stage2_out, -1)

        # delay index by same amount as data
        self.output_index = (control - (self.DELAY - 1)) % self.GLOBAL_FFT_SIZE
        return self.stage3_out, self.output_index


class R2SDF(Hardware):
    def __init__(self, fft_size, twiddle_bits=9, inverse=False, input_ordering='natural'):
        self._pyha_simulation_input_callback = DataIndexValidPackager(
            dtype=Complex(0.0, 0, -17, overflow_style='saturate'))
        self._pyha_simulation_output_callback = DataIndexValidDePackager()
        self.INPUT_ORDERING = input_ordering
        self.INVERSE = inverse
        self.FFT_SIZE = fft_size
        self.N_STAGES = int(np.log2(fft_size))
        # Note: it is NOT correct to use this gain after the magnitude/abs operation, it has to be applied to complex values
        self.GAIN_CORRECTION = 2 ** (0 if self.N_STAGES - 3 < 0 else -(self.N_STAGES - 3))
        self.DELAY = (fft_size - 1) + (self.N_STAGES * 3) + 1

        self.stages = [StageR2SDF(self.FFT_SIZE, i, twiddle_bits, inverse, input_ordering)
                       for i in range(self.N_STAGES)]
        self.out = DataIndexValid(Complex(0.0, 0, -17, round_style='round'), 0)

    def main(self, x):
        if self.INVERSE:
            tmp_data = Complex(x.data.imag, x.data.real)
        else:
            tmp_data = x.data

        # execute stages
        tmp_index = x.index
        for stage in self.stages:
            tmp_data, tmp_index = stage.main(tmp_data, tmp_index)

        if self.INVERSE:
            self.out.data = Complex(tmp_data.imag, tmp_data.real)
        else:
            self.out.data = tmp_data

        self.out.index = tmp_index
        self.out.valid = x.valid
        return self.out

    def model_main(self, x):
        x = np.array(x).reshape(-1, self.FFT_SIZE)

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

        return ffts


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
    sims = simulate(dut, input_signal, simulations=['MODEL', 'PYHA'])

    if inverse:
        assert sims_close(sims, rtol=1e-2, atol=1e-3)
    else:
        assert sims_close(sims)


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
