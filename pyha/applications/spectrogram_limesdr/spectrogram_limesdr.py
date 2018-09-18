import logging
import numpy as np
import pytest
from pyha import Hardware, simulate, sims_close, Complex, Sfix, load_complex64_file, get_data_file
from pyha.cores import NumpyToDataValid, DataValid, Spectrogram

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('spectrogram')


class SpectrogramLimeSDR(Hardware):
    def __init__(self):
        self._pyha_simulation_input_callback = NumpyToDataValid(
            dtype=Complex(0.0, 0, -11, overflow_style='saturate', round_style='round'))

        # components
        fft_size = 1024*8
        avg_freq_axis = 16
        avg_time_axis = 8
        window_type = 'hamming'
        fft_twiddle_bits = 8
        window_bits = 8
        dc_removal_len = 1024
        self.spect = Spectrogram(fft_size, avg_freq_axis, avg_time_axis, window_type, fft_twiddle_bits, window_bits, dc_removal_len)
        # TODO: could be unsigned!
        self.out = DataValid(Sfix(0.0, upper_bits=32)) # no need to round because result is positive i.e. truncation = rounding

    def main(self, inp):

        spect = self.spect.main(inp)

        self.out.data = spect.data
        self.out.valid = spect.valid

        return self.out

    def model_main(self, inp):
        return self.spect.model_main(inp)


def test_lol():
    l = 1024 * 8 * 2
    input_signal = load_complex64_file('/home/gaspar/Documents/limem_ph3weak_40m')
    print(len(input_signal))
    input_signal = input_signal[:len(input_signal) // (l) * (l)]
    print(len(input_signal))
    dut = SpectrogramLimeSDR()
    sims = simulate(dut, input_signal, pipeline_flush='auto', simulations=['MODEL', 'PYHA', 'RTL'], conversion_path='/tmp/pyha_output')


def test_all():
    np.random.seed(0)
    input_size = 1024*8*2
    # orig_inp = (np.random.uniform(-1, 1, size=input_size) + np.random.uniform(-1, 1,size=input_size) * 1j) * 0.1

    input_signal = load_complex64_file('/home/gaspar/Documents/slice')
    input_signal = input_signal[:len(input_signal) // (1024 * 8 * 8) * (1024 * 8 * 8)]

    dut = SpectrogramLimeSDR()

    orig_inp_quant = np.vectorize(lambda x: complex(Complex(x, 0, -17)))(input_signal)
    sim = Simulator(dut).run(orig_inp_quant)


def test_simple():
    pytest.skip()
    # TWID: 10b, WINDOW: 8b
    # Flow Status	Successful - Wed Jun 20 12:38:29 2018
    # Quartus Prime Version	17.1.0 Build 590 10/25/2017 SJ Lite Edition
    # Revision Name	quartus_project
    # Top-level Entity Name	top
    # Family	Cyclone IV E
    # Device	EP4CE40F23C8
    # Timing Models	Final
    # Total logic elements	11,729 / 39,600 ( 30 % )
    # Total registers	955
    # Total pins	107 / 329 ( 33 % )
    # Total virtual pins	0
    # Total memory bits	312,408 / 1,161,216 ( 27 % )
    # Embedded Multiplier 9-bit elements	104 / 232 ( 45 % )
    # Total PLLs	0 / 4 ( 0 % )

    # NO DC REMOVAL
    # TWID: 9b, WINDOW: 8b
    # Family	Cyclone IV E
    # Device	EP4CE40F23C8
    # Timing Models	Final
    # Total logic elements	10,146 / 39,600 ( 26 % )
    # Total registers	955
    # Total pins	107 / 329 ( 33 % )
    # Total virtual pins	0
    # Total memory bits	312,408 / 1,161,216 ( 27 % )
    # Embedded Multiplier 9-bit elements	104 / 232 ( 45 % )
    # Total PLLs	0 / 4 ( 0 % )

    # WITH DC REMOVAL + PIPELINED FFT, FMAX 80M
    # TWID: 9b, WINDOW: 8b
    # Device	EP4CE40F23C8
    # Timing Models	Final
    # Total logic elements	10,206 / 39,600 ( 26 % )
    # Total registers	2782
    # Total pins	107 / 329 ( 33 % )
    # Total virtual pins	0
    # Total memory bits	349,179 / 1,161,216 ( 30 % )
    # Embedded Multiplier 9-bit elements	104 / 232 ( 45 % )
    # Total PLLs	0 / 4 ( 0 % )

    np.random.seed(0)
    fft_size = 1024 * 8
    avg_time_axis = 2

    dut = Spectrogram(fft_size, avg_freq_axis=16, avg_time_axis=avg_time_axis, fft_twiddle_bits=9, window_bits=8)

    packets = avg_time_axis
    inp = np.random.uniform(-1, 1, fft_size * packets) + np.random.uniform(-1, 1, fft_size * packets) * 1j
    inp *= 0.5 * 0.001

    sims = simulate(dut, inp,
                    simulations=['MODEL', 'PYHA',
                                 'GATE',
                                 # 'RTL'
                                 ],
                    conversion_path='/home/gaspar/git/pyhacores/playground')

    # import matplotlib.pyplot as plt
    # plt.plot(np.hstack(sims['MODEL']))
    # plt.plot(np.hstack(sims['PYHA']))
    # plt.plot(np.hstack(sims['RTL']))
    # plt.show()

    sims['MODEL'] = np.array(sims['MODEL']) / np.array(sims['MODEL']).max()
    sims['PYHA'] = np.array(sims['PYHA']) / np.array(sims['PYHA']).max()
    # sims['RTL'] = np.array(sims['RTL']) / np.array(sims['RTL']).max()
    # sims['GATE'] = np.array(sims['GATE']) / np.array(sims['GATE']).max()
    assert sims_close(sims, rtol=1e-1, atol=1e-4)