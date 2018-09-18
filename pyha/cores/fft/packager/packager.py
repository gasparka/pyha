import numpy as np
import pytest

from pyha import Hardware, simulate, sims_close, Complex


class DataValid(Hardware):
    def __init__(self, data, valid=False):
        self.data = data
        self.valid = valid

    def _pyha_to_python_value(self):
        if self.valid:
            try:
                return self.data._pyha_to_python_value() # carries some Pyha type?
            except AttributeError:
                return self.data
        else:
            return None


class DataValidToNumpy:
    def __call__(self, outputs):
        return np.array([x.data for x in outputs if x.valid])


class GenericFixed:
    def __init__(self, dtype=None):
        self.dtype = dtype

    def __call__(self, inputs):
        if isinstance(inputs, tuple):
            # multiple arguments, run this function for each!
            ret = []
            for arg in inputs:
                ret.append(self(arg))
            return np.array(np.array(ret).T)

        ret = []
        if isinstance(inputs[0], (list, np.ndarray)):
            for row in inputs:
                ret += [self.dtype(elem) for elem in row]
        else:
            ret += [self.dtype(elem) for elem in inputs]

        return np.array(ret)


class NumpyToDataValid:
    def __init__(self, dtype=None):
        self.dtype = dtype

    def __call__(self, inputs):
        if isinstance(inputs, tuple):
            # multiple arguments, run this function for each!
            ret = []
            for arg in inputs:
                ret.append(self(arg))
            return np.array(ret).T

        ret = []
        if isinstance(inputs[0], (list, np.ndarray)):
            for row in inputs:
                ret += [DataValid(self.dtype(elem), valid=True) for elem in row]
        else:
            ret += [DataValid(self.dtype(elem), valid=True) for elem in inputs]

        return np.array(ret)
