import numpy as np

from pyha import Hardware, Complex, simulate
from pyha.common.complex import default_complex
from pyha.common.context_managers import SimulationRunning
from pyha.common.fixed_point import default_sfix, resize, Sfix
from pyha.common.shift_register import ShiftRegister
from pyha.conversion.conversion import get_conversion
from pyha.simulation.simulation_interface import get_last_trained_object


class OldShiftRegister:
    def setup(self):
        class ShiftReg(Hardware):
            def __init__(self):
                self.shr_sub = [Complex()] * 2 ** 10

            def main(self, new_sub):
                self.shr_sub = [new_sub] + self.shr_sub[:-1]
                return self.shr_sub[-1]

        self.dut = ShiftReg()
        n = 2 ** 10
        self.inp = np.random.uniform(-1, 1, n) + np.random.uniform(-1, 1, n) * 1j

    def time_complex_shiftreg(self):
        simulate(self.dut, self.inp, simulations=['PYHA'])

class NewShiftRegister:
    def setup(self):
        class ShiftReg(Hardware):
            def __init__(self):
                self.shr_sub = ShiftRegister([Complex()] * 2 ** 10)

            def main(self, new_sub):
                self.shr_sub.push_next(new_sub)
                return self.shr_sub.peek()

        self.dut = ShiftReg()
        n = 2 ** 10
        self.inp = np.random.uniform(-1, 1, n) + np.random.uniform(-1, 1, n) * 1j

    def time_complex_shiftreg(self):
        simulate(self.dut, self.inp, simulations=['PYHA'])


# class TimeSuite2:
#     def setup(self):
#         class ShiftReg(Hardware):
#             def __init__(self):
#                 self.shr_sub = [Complex()] * 1
#
#             def main(self, new_sub):
#                 self.shr_sub = [new_sub] + self.shr_sub[:-1]
#                 return self.shr_sub[-1]
#
#         self.dut = ShiftReg()
#         n = 2 ** 13
#         self.inp = np.random.uniform(-1, 1, n) + np.random.uniform(-1, 1, n) * 1j
#
#     def time_new_complex_shiftreg(self):
#         simulate(self.dut, self.inp, simulations=['PYHA'])


# class ConversionsFloat:
#     """ Turning Python floats values into Sfix object, involves quantization etc.."""
#
#     def setup(self):
#         n = 2 ** 13
#         self.inp = np.random.uniform(-1, 1, n)
#
#     def time_float_to_sfix(self):
#         ret = [default_sfix(x) for x in self.inp]
#
#
# class ConversionComplex:
#     """ Turning Python complex values into Complex object, involves quantization etc.."""
#
#     def setup(self):
#         n = 2 ** 13
#         self.inp = np.random.uniform(-1, 1, n) + np.random.uniform(-1, 1, n) * 1j
#
#     def time_float_to_sfix(self):
#         with SimulationRunning.enable():  # turns all objects to 'locals'
#             ret = [default_complex(x) for x in self.inp]
#
#
def W(k, N):
    """ e^-j*2*PI*k*n/N, argument k = k * n """
    return np.exp(-1j * (2 * np.pi / N) * k)


class RedBaronTimes:
    class DataWithIndex(Hardware):
        def __init__(self, data, index=0, valid=True):
            self.data = data
            self.index = index
            self.valid = valid

    @staticmethod
    def package(data):
        ret = []
        for row in data:
            ret += [RedBaronTimes.DataWithIndex(elem, i) for i, elem in enumerate(row)]

        return ret

    class StageR2SDF(Hardware):
        def __init__(self, fft_size):
            self.FFT_SIZE = fft_size
            self.FFT_HALF = fft_size // 2

            self.CONTROL_MASK = (self.FFT_HALF - 1)
            self.shr = ShiftRegister([Complex() for _ in range(self.FFT_HALF)])

            # self.TWIDDLES = [Complex(W(i, self.FFT_SIZE), 0, -8, overflow_style='saturate', round_style='round') for i in range(self.FFT_HALF)]

            self.TWIDDLES = [W(i, self.FFT_SIZE) for i in range(self.FFT_HALF)]

        def butterfly(self, in_up, in_down, twiddle):
            up_real = resize(in_up.real + in_down.real, 0, -17)
            up_imag = resize(in_up.imag + in_down.imag, 0, -17)
            up = Complex(up_real, up_imag)

            # down sub
            down_sub_real = resize(in_up.real - in_down.real, 0, -17)
            down_sub_imag = resize(in_up.imag - in_down.imag, 0, -17)

            down_real = resize((down_sub_real * twiddle.real) - (down_sub_imag * twiddle.imag), 0, -17)
            down_imag = resize((down_sub_real * twiddle.imag) + (down_sub_imag * twiddle.real), 0, -17)
            down = Complex(down_real, down_imag)
            return up, down

        def main(self, x, control):
            up, down = self.butterfly(self.shr.peek(), x, self.TWIDDLES[control & self.CONTROL_MASK])

            if self.FFT_HALF > 4:
                down.real = down.real >> 1
                down.imag = down.imag >> 1
                up.real = up.real >> 1
                up.imag = up.imag >> 1

            if not (control & self.FFT_HALF):
                self.shr.push_next(x)
                return self.shr.peek()
            else:
                self.shr.push_next(down)
                return up

    class R2SDF(Hardware):
        def __init__(self, fft_size):
            self.FFT_SIZE = fft_size

            self.n_bits = int(np.log2(fft_size))
            self.stages = [RedBaronTimes.StageR2SDF(2 ** (pow + 1)) for pow in reversed(range(self.n_bits))]

            # Note: it is NOT correct to use this gain after the magnitude/abs operation, it has to be applied to complex values
            self.GAIN_CORRECTION = 2 ** (0 if self.n_bits - 3 < 0 else -(self.n_bits - 3))
            self.DELAY = (fft_size - 1) + 1  # +1 is output register

            self.out = RedBaronTimes.DataWithIndex(Complex(0.0, 0, -17), 0)

        def main(self, x):
            # #execute stages
            out = x.data
            for stage in self.stages:
                out = stage.main(out, x.index)

            self.out.data = out
            self.out.index = (x.index + self.DELAY + 1) % self.FFT_SIZE
            self.out.valid = x.valid
            return self.out

        def model_main(self, x):
            ffts = np.fft.fft(x)

            # apply bit reversing ie. mess up the output order to match radix-2 algorithm
            # from under_construction.fft.bit_reversal import bit_reversed_indexes
            def bit_reverse(x, n_bits):
                return int(np.binary_repr(x, n_bits)[::-1], 2)

            def bit_reversed_indexes(N):
                return [bit_reverse(i, int(np.log2(N))) for i in range(N)]

            rev_index = bit_reversed_indexes(self.FFT_SIZE)
            for i, _ in enumerate(ffts):
                ffts[i] = ffts[i][rev_index]

            # apply gain control (to avoid overflows in hardware)
            ffts *= self.GAIN_CORRECTION

            return ffts

    def setup(self):
        fft_size = 512
        np.random.seed(0)
        dut = RedBaronTimes.R2SDF(fft_size)
        inp = np.random.uniform(-1, 1, size=(2, fft_size)) + np.random.uniform(-1, 1, size=(2, fft_size)) * 1j
        inp *= 0.25

        self.dut = dut
        self.inp = inp
        sims = simulate(dut, inp, simulations=['MODEL', 'PYHA',
                                               # 'RTL',
                                               # 'GATE'
                                               ],
                        # conversion_path='/home/gaspar/git/pyhacores/playground',
                        # output_callback=unpackage,
                        input_callback=RedBaronTimes.package)

        self.model = get_last_trained_object()
        # assert sims_close(sims, rtol=1e-1, atol=1e-4)

    def time_pyha_simulation(self):
        sims = simulate(self.dut, self.inp, simulations=['PYHA'], input_callback=RedBaronTimes.package)

    def time_conversion_r2sdf(self):
        """ First stage, 1 element """
        conv = get_conversion(self.model)

    def time_conversion_r2sdfstage(self):
        """ Last stage, largest arrays """
        conv = get_conversion(self.model.stages[0])
#
# if __name__ == '__main__':
#     # asv profile --gui=snakeviz benchmarks.TimeQuadratureDemod.time_demod_phantom2_signal speed
#     d = RedBaronTimes()
#     d.setup()
#     d.time_conversion_r2sdfstage()
