import numpy as np
import pytest

from pyha import Hardware, simulate, sims_close, Complex


class DataValid(Hardware):
    def __init__(self, data, valid=False):
        self.data = data
        self.valid = valid


class DataValidToNumpy:
    def __call__(self, outputs):
        return np.array([x.data for x in outputs if x.valid])


class NumpyToDataValid:
    def __init__(self, dtype=None):
        self.dtype = dtype

    def __call__(self, inputs):
        if isinstance(inputs, tuple):
            inputs = inputs[0]

        ret = []
        if isinstance(inputs[0], (list, np.ndarray)):
            for row in inputs:
                ret += [DataValid(self.dtype(elem), valid=True) for elem in row]
        else:
            ret += [DataValid(self.dtype(elem), valid=True) for elem in inputs]

        return ret


class DataValidPackager(Hardware):
    def __init__(self, dtype=Complex()):
        self._pyha_simulation_output_callback = DataValidToNumpy()
        self.out = DataValid(dtype, valid=False)

    def main(self, data, valid):
        self.out = DataValid(data, valid)
        return self.out

    def model_main(self, inp_list):
        return inp_list


@pytest.mark.parametrize("M", [4, 8, 16, 32, 64, 128, 256])
@pytest.mark.parametrize("packets", [1, 2, 3, 4])
def test_packager(M, packets):
    dut = DataValidPackager(M)
    inp = np.random.uniform(-1, 1, M * packets) + np.random.uniform(-1, 1, M * packets) * 1j
    sims = simulate(dut, inp)
    assert sims_close(sims, rtol=1e-2)
