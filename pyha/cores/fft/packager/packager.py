import numpy as np
import pytest

from pyha import Hardware, simulate, sims_close, Complex


class DataIndexValid(Hardware):
    def __init__(self, data, index=0, valid=True):
        self.data = data
        self.index = index
        self.valid = valid


class DataIndexValidPackager:
    def __init__(self, dtype=None, package_size=None):
        assert package_size is None # not implemented
        self.package_size = package_size
        self.dtype = dtype

    def __call__(self, inputs):
        if isinstance(inputs, tuple):
            inputs = inputs[0]
        if self.package_size is None:
            self.package_size = np.array(inputs).shape[-1]

        # TODO: throw away samples to fit package_size?

        ret = []
        if isinstance(inputs[0], (list, np.ndarray)):
            for row in inputs:
                ret += [DataIndexValid(self.dtype(elem), i) for i, elem in enumerate(row)]
        else:
            ret += [DataIndexValid(self.dtype(elem), i) for i, elem in enumerate(inputs)]

        return ret


class DataIndexValidDePackager:
    """ Discards invalid samples and turns the stream into 2D array, each row is one package """
    def __call__(self, outputs):
        ret = []
        sublist = []
        for elem in outputs:
            if not elem.valid:  # discard all invalid samples
                continue

            if int(elem.index) == 0:
                if len(sublist):
                    ret.append(sublist)
                sublist = [elem.data]
            else:
                sublist.append(elem.data)

        ret.append(sublist)
        ret = np.array(ret).squeeze()
        return ret


class Packager(Hardware):
    """ Takes a stream of samples and packages them by adding index to each sample.
    In simulation this looks like a
    """
    def __init__(self, packet_size, dtype=Complex()):
        self._pyha_simulation_output_callback = DataIndexValidDePackager()
        self.PACKET_SIZE = packet_size
        self.DELAY = 1

        self.out = DataIndexValid(dtype, index=self.PACKET_SIZE - 1)

    def main(self, data):
        """
        :type data: Complex
        :rtype: DataIndexValid
        """

        index = (self.out.index + 1) % self.PACKET_SIZE
        self.out = DataIndexValid(data, index, valid=True)

        return self.out

    def model_main(self, inp_list):
        out = np.array(inp_list).reshape((-1, self.PACKET_SIZE))
        return out


@pytest.mark.parametrize("M", [4, 8, 16, 32, 64, 128, 256])
@pytest.mark.parametrize("packets", [1, 2, 3, 4])
def test_packager(M, packets):
    dut = Packager(M)
    inp = np.random.uniform(-1, 1, M * packets) + np.random.uniform(-1, 1, M * packets) * 1j
    sims = simulate(dut, inp)
    assert sims_close(sims, rtol=1e-2)
