import collections

import numpy as np


def is_power2(num):
    # Author: A.Polino
    'states if a number is a power of two'
    return num != 0 and ((num & (num - 1)) == 0)


def get_iterable(x):
    if isinstance(x, collections.Iterable):
        return x
    else:
        return [x]


def tabber(str):
    TAB = '    '
    """ Add tab infront of every line """
    # if x is '' then dont add tabs, because much used textwrap.dedent deletes empty tabs...so unit tests will be unhappy
    return '\n'.join([f'{TAB}{x}' if x != '' else x for x in str.splitlines()])


def formatter(xl):
    return '\n'.join(tabber(x) for x in xl if x != '')

def load_gnuradio_file(file: str):
    import scipy
    return scipy.fromfile(open(file), dtype=scipy.complex64)


def resample_gnuradio(file: str, ratio: float):
    """ ratio is current_fs / desired_fs """
    f = load_gnuradio_file(file)
    from scipy import signal
    resampled = signal.resample(f, len(f) * ratio)
    return resampled


def save_gnuradio_file(file: str, arr):
    conv = np.array(arr).astype(scipy.complex64)
    conv.tofile(file)


def hex_to_bitstr(hstr):
    """ http://stackoverflow.com/questions/1425493/convert-hex-to-binary """
    if isinstance(hstr, int):
        hstr = hex(hstr)
    if hstr[0:2] in ('0x', '0X'):
        hstr = hstr[2:]
    my_hexdata = hstr
    scale = 16  ## equals to hexadecimal
    num_of_bits = int(len(my_hexdata) * np.log2(scale))
    return bin(int(my_hexdata, scale))[2:].zfill(num_of_bits)


def hex_to_bool_list(hstr):
    return [bool(int(x)) for x in hex_to_bitstr(hstr)]


def int_to_bool_list(hstr):
    return [bool(int(x)) for x in hex_to_bitstr(hstr)]


def test_hex_to_bits():
    assert hex_to_bitstr('FF') == '11111111'
    assert hex_to_bitstr('0xFF') == '11111111'
    assert hex_to_bitstr('0XFF') == '11111111'
    assert hex_to_bitstr('0F') == '00001111'

    assert hex_to_bool_list('F') == [True, True, True, True]
    assert hex_to_bool_list('0F') == [False, False, False, False, True, True, True, True]

    assert hex_to_bool_list(0xF) == [True, True, True, True]
    assert hex_to_bool_list(0xFFFF) == [True] * 16


def bools_to_hex(bl):
    bitstr = bools_to_bitstr(bl)
    return hex(int(bitstr, 2))


def bools_to_bitstr(bl):
    return ''.join(str(int(x)) for x in bl)


def test_bools_to_hex():
    assert bools_to_hex([True, True, True, True]) == '0xf'
    assert bools_to_hex([True, True]) == '0x3'
    assert bools_to_hex([False, True, True, True, True, False, True, True]) == '0x7b'
    assert bools_to_hex([0, 1, 1, 1, 1, 0, 1, 1]) == '0x7b'


def plot_freqz(b):
    import matplotlib.pyplot as plt
    from scipy import signal
    w, h = signal.freqz(b)

    fig = plt.figure()
    plt.title('Digital filter frequency response')
    ax1 = fig.add_subplot(111)

    plt.plot(w / np.pi / 2, 20 * np.log10(abs(h)), 'b')
    plt.ylabel('Amplitude [dB]', color='b')
    plt.xlabel('Frequency')

    ax2 = ax1.twinx()
    angles = np.unwrap(np.angle(h))
    plt.plot(w / np.pi / 2, angles, 'g')
    plt.ylabel('Angle (radians)', color='g')
    plt.grid()
    plt.axis('tight')
    plt.show()





    # # https://se.mathworks.com/matlabcentral/newsreader/view_thread/154499
    # from scipy.fftpack import fft, fftshift
    #
    #
    # def estimate_frequency_phase_response(input, output):
    #     sum_h = None
    #     H1 = np.array([0 + 0 * 1j] * len(input[0]))
    #     for i, o in zip(input, output):
    #         I = fft(i)
    #         O = fft(o)
    #         new_h = I * O / I ** 2
    #         new_h /= len(input)  # average
    #         H1 += new_h
    #
    #     H1 = fftshift(H1)
    #     magnitude = 20 * np.log10(abs(H1))
    #     phase = np.angle(H1) * 180 / np.pi
    #
    #     return magnitude, phase
    #
    #
    # u = [np.random.uniform(-1, 1, 1024 * 2) for _ in range(1024)]
    # av = CascadeAverage(9, 2)
    # y = [av.abstract2(x) for x in u]
    # # y = [x for x in u]
    # mag, phase = estimate_frequency_phase_response(u, y)
    #
    # plt.plot(mag)
    # plt.show()
    #
    # plt.plot(phase)
    # plt.show()
