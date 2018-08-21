import logging
import pickle

import numpy as np
from data import load_iq

from pyha import Hardware, simulate, hardware_sims_equal, sims_close, Complex

from pyhacores.fft import Packager, Windower, R2SDF, FFTPower, BitreversalFFTshiftAVGPool, DataIndexValidDePackager
from pyhacores.filter import DCRemoval
from scipy import signal

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('spectrogram')


class SpectrogramInputShaper:
    """ Makes sure input is divisible to perform avg pooling! """

    def __init__(self, nfft, avg_time_axis):
        self.avg_time_axis = avg_time_axis
        self.nfft = nfft

    def __call__(self, input_signal):
        input_signal = input_signal[0]
        orig_len = len(input_signal)
        new_end = np.floor(orig_len / self.nfft / self.avg_time_axis) * self.nfft * self.avg_time_axis
        print(new_end, orig_len)
        input_signal = input_signal[:new_end]

        if orig_len != len(input_signal):
            logger.warning(f'Throw away {orig_len - len(input_signal)} input samples to force divisability!')

        return [Complex(x, 0, -17, overflow_style='saturate') for x in input_signal]


class Spectrogram(Hardware):
    def __init__(self, nfft, avg_freq_axis=2, avg_time_axis=1, window_type='hanning', fft_twiddle_bits=18,
                 window_bits=18):
        self._pyha_simulation_input_callback = SpectrogramInputShaper(nfft, avg_time_axis)
        self._pyha_simulation_output_callback = DataIndexValidDePackager()
        self.DECIMATE_BY = avg_freq_axis
        self.NFFT = nfft
        self.WINDOW_TYPE = window_type

        # components
        self.dc_removal = DCRemoval(256, dtype=Complex)
        self.pack = Packager(self.NFFT)
        self.windower = Windower(nfft, self.WINDOW_TYPE, coefficient_bits=window_bits)
        self.fft = R2SDF(nfft, twiddle_bits=fft_twiddle_bits)
        self.power = FFTPower()
        self.dec = BitreversalFFTshiftAVGPool(nfft, avg_freq_axis, avg_time_axis)

        # Note: Delay from DC-removal is not included, because it occurs before the 'packaging' making it irrelevant!
        self.DELAY = self.pack.DELAY + self.fft.DELAY + self.windower.DELAY + self.power.DELAY + self.dec.DELAY

    def main(self, x):
        dc_out = self.dc_removal.main(x)
        pack_out = self.pack.main(dc_out)
        window_out = self.windower.main(pack_out)
        fft_out = self.fft.main(window_out)
        power_out = self.power.main(fft_out)
        dec_out = self.dec.main(power_out)
        return dec_out

    def model_main(self, x):
        dc_out = self.dc_removal.model_main(x)
        pack_out = self.pack.model_main(dc_out)
        window_out = self.windower.model_main(pack_out)
        fft_out = self.fft.model_main(window_out)
        power_out = self.power.model_main(fft_out)
        dec_out = self.dec.model_main(power_out)
        return dec_out
        _, _, spectro_out = signal.spectrogram(x, 1, nperseg=self.NFFT, return_onesided=False, detrend=False,
                                               noverlap=0, window='hanning')

        # apply hardware style gain
        # spectro_out /= self.NFFT

        # fftshift
        shifted = np.roll(spectro_out, self.NFFT // 2, axis=0)

        # # avg decimation
        l = np.split(shifted, len(shifted) // self.DECIMATE_BY)
        golden_output = np.average(l, axis=1).T

        return golden_output


def test_shit():
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


def test_realsig():
    # file = '/run/media/gaspar/maxtor/measurement 13.03.2018/mavic_tele/qdetector_20180313122024455464_far_10m_regular/1520936452.2426_fs=20000000.0_bw=20000000.0_fc=2431000000.0_d=0_g=033000.raw'
    file = '/home/gaspar/Documents/low_power_ph3.raw'
    fft_size = 1024 * 2 * 2 * 2
    decimation = 32
    print(file)

    iq = load_iq(file)
    iq = iq[:len(iq) // 8]

    dut = Spectrogram(fft_size, decimation)
    sims = simulate(dut, iq, simulations=['MODEL', 'PYHA'],
                    output_callback=unpackage)

    with open(f'{file}_spectro_TST.pickle', 'wb') as f:
        # Pickle the 'data' dictionary using the highest protocol available.
        pickle.dump(sims, f, pickle.HIGHEST_PROTOCOL)


def test_realsig2():
    file = '/run/media/gaspar/maxtor/measurement 13.03.2018/mavic_tele/qdetector_20180313120601081997_noremote_medium_10m/1520935599.0396_fs=20000000.0_bw=20000000.0_fc=2410000000.0_d=3_g=063015.raw'

    fft_size = 1024 * 2 * 2 * 2
    decimation = 32
    print(file)

    iq = load_iq(file)
    # iq = iq[:len(iq) // 8]

    dut = Spectrogram(fft_size, decimation)
    sims = simulate(dut, iq, simulations=['MODEL', 'PYHA'],
                    output_callback=unpackage)

    with open(f'{file}_spectro.pickle', 'wb') as f:
        # Pickle the 'data' dictionary using the highest protocol available.
        pickle.dump(sims, f, pickle.HIGHEST_PROTOCOL)


def test_real_life():
    fft_size = 1024 * 8
    decimation = 32
    dut = Spectrogram(fft_size, decimation)

    file = '/run/media/gaspar/maxtor/measurement 13.03.2018/mavic_tele/qdetector_20180313122024455464_far_10m_regular/1520936452.2426_fs=20000000.0_bw=20000000.0_fc=2431000000.0_d=0_g=033000.raw'

    orig_inp = load_iq(file)

    orig_inp = orig_inp[:len(orig_inp) // (1024 * 4)]
    # orig_inp /= orig_inp.max() * 2

    # orig_inp = np.random.uniform(-1, 1, fft_size * 1) + np.random.uniform(-1, 1, fft_size * 1) * 1j
    # orig_inp *= 0.5

    sims = simulate(dut, orig_inp,
                    output_callback=unpackage,
                    simulations=['MODEL', 'PYHA',
                                 # 'RTL',
                                 # 'GATE'
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
    assert hardware_sims_equal(sims)
    assert sims_close(sims, rtol=1e-1, atol=1e-4)
