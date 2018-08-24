import logging

import numpy as np
import pytest
from scipy import signal
from scipy.signal import get_window

from pyha import Hardware, simulate, sims_close, Complex
from pyha.cores import DCRemoval, Packager, Windower, R2SDF, FFTPower, BitreversalFFTshiftAVGPool, \
    DataIndexValidDePackager

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('spectrogram')


# class SpectrogramInputShaper:
#     """ Makes sure input is divisible to perform avg pooling! """
#
#     def __init__(self, nfft, avg_time_axis):
#         self.avg_time_axis = avg_time_axis
#         self.nfft = nfft
#
#     def __call__(self, input_signal):
#         input_signal = input_signal[0]
#         orig_len = len(input_signal)
#         new_end = np.floor(orig_len / self.nfft / self.avg_time_axis) * self.nfft * self.avg_time_axis
#         print(new_end, orig_len)
#         input_signal = input_signal[:new_end]
#
#         if orig_len != len(input_signal):
#             logger.warning(f'Throw away {orig_len - len(input_signal)} input samples to force divisability!')
#
#         return [Complex(x, 0, -17, overflow_style='saturate') for x in input_signal]


class Spectrogram(Hardware):
    def __init__(self, fft_size, avg_freq_axis=2, avg_time_axis=1, window_type='hanning', fft_twiddle_bits=18,
                 window_bits=18):
        self._pyha_simulation_output_callback = DataIndexValidDePackager()
        self.AVG_FREQ_AXIS = avg_freq_axis
        self.AVG_TIME_AXIS = avg_time_axis
        self.FFT_SIZE = fft_size
        self.WINDOW_TYPE = window_type

        # components
        self.dc_removal = DCRemoval(256, dtype=Complex)
        self.pack = Packager(self.FFT_SIZE)
        self.windower = Windower(fft_size, self.WINDOW_TYPE, coefficient_bits=window_bits)
        self.fft = R2SDF(fft_size, twiddle_bits=fft_twiddle_bits)
        self.power = FFTPower()
        self.dec = BitreversalFFTshiftAVGPool(fft_size, avg_freq_axis, avg_time_axis)

        # Note: Delay from DC-removal is not included, because it occurs before the 'packaging' making it irrelevant!
        self.DELAY = self.pack.DELAY + self.fft.DELAY + self.windower.DELAY + self.power.DELAY + self.dec.DELAY

    def main(self, x):
        # dc_out = self.dc_removal.main(x)
        pack_out = self.pack.main(x)
        window_out = self.windower.main(pack_out)
        fft_out = self.fft.main(window_out)
        power_out = self.power.main(fft_out)
        dec_out = self.dec.main(power_out)
        return dec_out

    def model_main(self, x):
        no_dc = x - np.mean(x)
        no_dc = x
        resh = np.reshape(no_dc, (-1, self.FFT_SIZE))
        windowed = resh * get_window(self.WINDOW_TYPE, self.FFT_SIZE)
        transform = np.fft.fft(windowed) / self.FFT_SIZE
        power = (transform * np.conj(transform)).real

        unshift = np.fft.fftshift(power, axes=1)

        # average in freq axis
        avg_y = np.split(unshift.T, len(unshift.T) // self.AVG_FREQ_AXIS)
        avg_y = np.average(avg_y, axis=1)

        # average in time axis
        avg_x = np.split(avg_y.T, len(avg_y.T) // self.AVG_TIME_AXIS)
        avg_x = np.average(avg_x, axis=1)
        return avg_x


@pytest.mark.parametrize("avg_freq_axis", [2, 4, 8])
@pytest.mark.parametrize("avg_time_axis", [1, 2, 4])
@pytest.mark.parametrize("fft_size", [256, 128])
@pytest.mark.parametrize("input_power", [0.25, 0.001])
def test_all(fft_size, avg_freq_axis, avg_time_axis, input_power):
    np.random.seed(0)
    input_size = avg_time_axis * fft_size
    orig_inp = (np.random.uniform(-1, 1, size=input_size) + np.random.uniform(-1, 1, size=input_size) * 1j) * input_power
    dut = Spectrogram(fft_size, avg_freq_axis, avg_time_axis)

    orig_inp_quant = np.vectorize(lambda x: complex(Complex(x, 0, -17)))(orig_inp)
    sims = simulate(dut, orig_inp_quant, simulations=['MODEL', 'PYHA'])
    assert sims_close(sims, rtol=1e-2, atol=1e-3)

def test_shit():
    pytest.skip()
    fft_size = 1024
    file = '/home/gaspar/git/pyhacores/data/f2404_fs16.896_one_hop.iq'
    orig_inp = load_iq(file)[10000:10000 + fft_size * 2]
    orig_inp -= np.mean(orig_inp)
    _, _, spectro_out = signal.spectrogram(orig_inp, 1, nperseg=fft_size, return_onesided=False, detrend=False,
                                           noverlap=0, window='hann')

    dut = Spectrogram(fft_size, avg_freq_axis=2, avg_time_axis=1)
    sims = simulate(dut, orig_inp.T, simulations=['MODEL', 'PYHA'])
    assert sims_close(sims)


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
