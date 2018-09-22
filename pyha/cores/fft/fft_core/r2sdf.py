import numpy as np
import pytest
from pyha import Hardware, simulate, sims_close, Complex, resize, scalb, default_complex
from pyha.common.shift_register import ShiftRegister
from pyha.cores import DownCounter
from pyha.common.datavalid import DataValid, NumpyToDataValid
from pyha.cores.util import toggle_bit_reverse


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
    def __init__(self, global_fft_size, stage_nr, twiddle_bits=18, inverse=False, input_ordering='natural',
                 allow_gain_control=True):
        self._pyha_simulation_input_callback = NumpyToDataValid(dtype=default_complex)

        self.ALLOW_GAIN_CONTROL=allow_gain_control
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

        self.IS_TRIVIAL_MULTIPLIER = len(self.TWIDDLES) == 1  # mult by 1.0, useless
        self.shr = ShiftRegister([Complex() for _ in range(self.INPUT_STRIDE)])
        self.twiddle = self.TWIDDLES[0]
        self.stage1_out = Complex(0, 0, -17)
        self.stage2_out = Complex(0, 0, -17 - (twiddle_bits - 1))
        self.output_index = 0
        self.mode_delay = False
        self.control = 0  # replacing this with fixed-point counter saves no resources..

        self.out = DataValid(Complex(0, 0, -17, round_style='round'), valid=False)
        self.start_counter = DownCounter(2 + self.INPUT_STRIDE)

    def butterfly(self, in_up, in_down):
        up = resize(in_up + in_down, 0, -17)
        down = resize(in_up - in_down, 0, -17)
        return up, down

    def main(self, inp):
        if not inp.valid:
            return DataValid(self.out.data, valid=False)

        # Stage 1: handle the loopback memory; that sets the INPUT_STRIDE; also fetch the twiddle factor for stage 2
        if self.IS_NATURAL_ORDER:
            self.control = (self.control + 1) % (self.LOCAL_FFT_SIZE)
            self.twiddle = self.TWIDDLES[self.control & self.CONTROL_MASK]
        else:
            self.control = (self.control + 1) % (self.GLOBAL_FFT_SIZE)
            self.twiddle = self.TWIDDLES[self.control >> (self.STAGE_NR + 1)]
        mode = not (self.control & self.INPUT_STRIDE)
        self.mode_delay = mode
        if mode:
            self.shr.push_next(inp.data)
            self.stage1_out = self.shr.peek()
        else:
            up, down = self.butterfly(self.shr.peek(), inp.data)
            self.shr.push_next(down)
            self.stage1_out = up

        # Stage 2: complex multiply
        if self.mode_delay and not self.IS_TRIVIAL_MULTIPLIER:
            self.stage2_out = self.stage1_out * self.twiddle
        else:
            self.stage2_out = self.stage1_out

        # Stage 3: gain control and rounding
        if self.ALLOW_GAIN_CONTROL and not self.INVERSE:
            self.out.data = scalb(self.stage2_out, -1)
        else:
            self.out.data = self.stage2_out

        self.start_counter.tick()
        self.out.valid = self.start_counter.is_over()
        return self.out

    def model(self, inp):
        def fft_model(inp):
            if self.INPUT_ORDERING == 'natural':
                offset = self.LOCAL_FFT_SIZE // 2
                twiddles = [W(i, self.LOCAL_FFT_SIZE) for i in range(offset)]
                packets = np.array(np.reshape(inp, (-1, self.LOCAL_FFT_SIZE)))
                for pack in packets:
                    for i in range(offset):
                        pack[i], pack[i + offset] = pack[i] + pack[i + offset], \
                                                    (pack[i] - pack[i + offset]) * twiddles[i]

                return packets.flatten()

            elif self.INPUT_ORDERING == 'bitreversed':
                input_stride = 2 ** self.STAGE_NR
                local_fft_size = self.GLOBAL_FFT_SIZE // input_stride
                twiddles = toggle_bit_reverse([W(i, local_fft_size) for i in range(local_fft_size // 2)])
                packets = np.array(np.reshape(inp, (
                len(twiddles), -1)))  # note: this shape is upside down compared to NORMAL order function

                offset = input_stride
                for packet_i, pack in enumerate(packets):
                    for i in range(offset):
                        pack[i], pack[i + offset] = pack[i] + pack[i + offset], \
                                                    (pack[i] - pack[i + offset]) * twiddles[packet_i]
                return packets.flatten()

        glob_packs = np.array(np.reshape(inp, (-1, self.GLOBAL_FFT_SIZE)))
        ret = np.array([fft_model(pack) for pack in glob_packs])

        if not self.INVERSE and self.ALLOW_GAIN_CONTROL:
            ret = ret / 2
        return ret.flatten()


@pytest.mark.parametrize("fft_size", [2, 4, 8, 16, 128])
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

        sims = simulate(dut, inp, pipeline_flush='auto')
        assert sims_close(sims, rtol=1e-5, atol=1e-5)
        inp = sims['MODEL']
        stage += 1

    # test that final model answer is equal to the numpy one
    np.testing.assert_allclose(inp, expected)


class R2SDF(Hardware):
    """
    FFT core
    --------

    Uses the R2SDR structure with 18bit data-width and rounded logic - no DC-bias introduced.
    Scaling is opposite to Numpy i.e. "fft *= FFT_SIZE" and "ifft /= FFT_SIZE", this way values always stay
    in -1 ... 1 range.

    Args:
        fft_size: Transform size, must be power of 2.
        twiddle_bits: Stored as constants in LUTS. For big transforms you should try ~9 bits.
        inverse (bool): True to perform inverse transform.
        input_ordering (str): 'natural' or 'bitreversed'.
            Output order is inverse of this - Natural(in) -> Bitreversed(out) or Bitreversed(in) -> Natural(out).
    """

    def __init__(self, fft_size, twiddle_bits=9, inverse=False, input_ordering='natural'):
        self._pyha_simulation_input_callback = NumpyToDataValid(dtype=default_complex)
        self.INPUT_ORDERING = input_ordering
        self.INVERSE = inverse
        self.FFT_SIZE = fft_size
        self.N_STAGES = int(np.log2(fft_size))

        max_gain_control_stages = 10
        self.POST_GAIN_CONTROL = max(self.N_STAGES - max_gain_control_stages, 0)

        self.stages = [StageR2SDF(self.FFT_SIZE, i, twiddle_bits, inverse, input_ordering, allow_gain_control=i < max_gain_control_stages)
                       for i in range(self.N_STAGES)]

        self.output = DataValid(Complex(0, -self.POST_GAIN_CONTROL, -17 - self.POST_GAIN_CONTROL))

    def main(self, input):
        """
        Args:
            input (DataValid): -1.0 ... 1.0 range, up to 18 bits

        Returns:
            DataValid: 18 bits(-1.0 ... 1.0 range) if transform size is up to 1024 points.
                Transforms over 1024 points start emphasizing smaller numbers e.g. 2048 would return a result with 18 bits
                but in -0.5 ... 0.5 range (one extra bit for smaller numbers) etc...

        """
        var = input
        if self.INVERSE:
            var = DataValid(Complex(input.data.imag, input.data.real), input.valid)

        # execute stages
        for stage in self.stages:
            var = stage.main(var)

        if self.INVERSE:
            var = DataValid(Complex(var.data.imag, var.data.real), var.valid)

        # this part is active if transform is larger than 10 stages
        if self.POST_GAIN_CONTROL != 0:
            self.output.data = scalb(var.data, -self.POST_GAIN_CONTROL)
        else:
            self.output.data = var.data

        self.output.valid = var.valid
        return self.output

    def model(self, input_list):
        from pyha.simulation.tracer import Tracer
        if not Tracer.is_enabled():
            return numpy_model(input_list, self.FFT_SIZE, self.INPUT_ORDERING, self.INVERSE)
        else:
            if self.INVERSE:
                input_list = np.array(input_list.imag + input_list.real * 1j)

            var = input_list
            for stage in self.stages:
                var = stage.model(var)

            if self.INVERSE:
                var = np.array(var.imag + var.real * 1j)

            if self.POST_GAIN_CONTROL:
                var *= 2**-self.POST_GAIN_CONTROL
            return var


@pytest.mark.parametrize("fft_size", [2, 4, 8, 128])
@pytest.mark.parametrize("input_ordering", ['bitreversed', 'natural'])
@pytest.mark.parametrize("inverse", [True, False])
def test_all(fft_size, input_ordering, inverse):
    np.random.seed(0)
    input_signal = np.random.uniform(-1, 1, fft_size*3) + np.random.uniform(-1, 1, fft_size*3) * 1j

    if inverse:
        input_signal /= fft_size
    else:
        input_signal *= 0.125

    dut = R2SDF(fft_size, twiddle_bits=18, input_ordering=input_ordering, inverse=inverse)

    sims = simulate(dut, input_signal, pipeline_flush='auto')
    if inverse:
        assert sims_close(sims, rtol=1e-3, atol=1e-3)
    else:
        assert sims_close(sims, rtol=1e-4, atol=1e-4)