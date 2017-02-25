import matplotlib.pyplot as plt

from pyha.components.fsk_modulator import FSKModulator
from pyha.simulation.simulation_interface import plot_assert_sim_match, SIM_MODEL, \
    SIM_HW_MODEL, SIM_RTL


def test_basic():
    samples_per_symbol = 4  # this is so high to make stuff plottable
    fs = 300e3
    deviation = 70e3  # deviation from center frequency

    symbols = [1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0]
    # symbols = [0,0,0,0]
    # # symbols = [1,1,1,1]

    # apply SPS
    data = []
    for x in symbols:
        data.extend([x] * samples_per_symbol)

    dut = FSKModulator(deviation, fs)

    # r = debug_assert_sim_match(dut, [bool],
    plot_assert_sim_match(dut, [bool],
                          None, data,
                          rtol=1e-4,
                          simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL]
                          )

    Pxx, freqs, bins, im = plt.specgram(r[1], Fs=fs, NFFT=64, noverlap=0)
    plt.show()

    Pxx, freqs, bins, im = plt.specgram(r[0], Fs=fs, NFFT=64, noverlap=0)
    plt.show()
