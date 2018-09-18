import scipy
import numpy as np


def get_data_file(name):
    return __file__[:-7] + name


def load_complex64_file(file: str):
    f = scipy.fromfile(open(file), dtype=scipy.complex64)
    return f


def save_complex64_file(file: str, iq: np.array):
    out = iq.astype(scipy.complex64)
    out.tofile(file)



#import inspect
# import os
# file = '/home/gaspar/git/pyha/pyha/common/data/dcspike_bladerf_20m.npy'
# input_signal = np.load(file) # IQ samples
# out = input_signal.astype(scipy.complex64)
# out.tofile(file + '.complex64')