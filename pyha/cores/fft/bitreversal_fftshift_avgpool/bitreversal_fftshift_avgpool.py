import numpy as np
import pytest

from pyha import Hardware, simulate, sims_close, Sfix, resize, scalb
from pyha.common.ram import RAM
from pyha.cores import DataIndexValidPackager, DataIndexValidDePackager, DataIndexValid
from pyha.cores.util import toggle_bit_reverse


def build_lut(fft_size, freq_axis_decimation):
    """ This LUT fixes the bit-reversal and performs fftshift. It defines th RAM write addresses."""
    orig_inp = np.array(list(range(fft_size)))
    shift = np.fft.fftshift(orig_inp)
    rev = toggle_bit_reverse(shift)
    lut = rev // freq_axis_decimation
    return lut


class BitreversalFFTshiftAVGPool(Hardware):
    """ This core is meant to be used in spectrogram applications.
    It performs bitreversal, fftshift and average pooling in one memory.
    """
    def __init__(self, fft_size, avg_freq_axis, avg_time_axis):
        self._pyha_simulation_input_callback = DataIndexValidPackager(dtype=Sfix(0.0, 0, -35, overflow_style='saturate'))
        self._pyha_simulation_output_callback = DataIndexValidDePackager()

        assert not (avg_freq_axis == 1 and avg_time_axis == 1)
        self.AVG_FREQ_AXIS = avg_freq_axis
        self.AVG_TIME_AXIS = avg_time_axis
        self.ACCUMULATION_BITS = int(np.log2(avg_freq_axis * avg_time_axis))
        self.FFT_SIZE = fft_size
        self.LUT = build_lut(fft_size, avg_freq_axis)
        self.DELAY = fft_size + 1

        self.time_axis_counter = self.AVG_TIME_AXIS
        self.state = True
        self.ram = [RAM([Sfix(0.0, 0, -35)] * (fft_size // avg_freq_axis)),
                    RAM([Sfix(0.0, 0, -35)] * (fft_size // avg_freq_axis))]
        self.out_index = 0
        self.out_valid = False

    def work_ram(self, inp, write_ram, read_ram):
        # READ-MODIFY-WRITE
        write_index = self.LUT[inp.index]
        write_index_future = self.LUT[(inp.index + 1) % self.FFT_SIZE]
        read = self.ram[write_ram].delayed_read(write_index_future)
        res = resize(read + scalb(inp.data, -self.ACCUMULATION_BITS), 0, -35)
        self.ram[write_ram].delayed_write(write_index, res)

        # output stage
        self.out_valid = False
        if inp.index < self.FFT_SIZE / self.AVG_FREQ_AXIS and self.time_axis_counter == self.AVG_TIME_AXIS:
            _ = self.ram[read_ram].delayed_read(inp.index)
            self.out_index = inp.index
            self.out_valid = True

            # clear memory
            self.ram[read_ram].delayed_write(inp.index, Sfix(0.0, 0, -35))

    def main(self, inp):
        # Quartus wants this IF to infer RAM...
        if self.state:
            self.work_ram(inp, 0, 1)
            read = self.ram[1].get_readregister()
        else:
            self.work_ram(inp, 1, 0)
            read = self.ram[0].get_readregister()

        if inp.index >= self.FFT_SIZE - 1:
            next_counter = self.time_axis_counter - 1
            if next_counter == 0:
                next_counter = self.AVG_TIME_AXIS
                self.state = not self.state

            self.time_axis_counter = next_counter

        out = DataIndexValid(read, index=self.out_index, valid=self.out_valid)
        return out

    def model_main(self, inp):
        # apply bitreversal
        unrev = toggle_bit_reverse(inp)

        # fftshift
        unshift = np.fft.fftshift(unrev, axes=1)

        # average in freq axis
        avg_y = np.split(unshift.T, len(unshift.T) // self.AVG_FREQ_AXIS)
        avg_y = np.average(avg_y, axis=1)

        # average in time axis
        avg_x = np.split(avg_y.T, len(avg_y.T) // self.AVG_TIME_AXIS)
        avg_x = np.average(avg_x, axis=1)
        return avg_x


@pytest.mark.parametrize("avg_freq_axis", [2, 4, 8, 16, 32])
@pytest.mark.parametrize("avg_time_axis", [1, 2, 4, 8])
@pytest.mark.parametrize("fft_size", [512, 256, 128])
@pytest.mark.parametrize("input_power", [0.1, 0.001])
def test_all(fft_size, avg_freq_axis, avg_time_axis, input_power):
    packets = avg_time_axis * 2
    orig_inp = np.random.uniform(-1, 1, size=(packets, fft_size)) * input_power

    orig_inp_quant = np.vectorize(lambda x: float(Sfix(x, 0, -35)))(orig_inp)

    dut = BitreversalFFTshiftAVGPool(fft_size, avg_freq_axis, avg_time_axis)
    sims = simulate(dut, orig_inp_quant, simulations=['MODEL', 'PYHA'])
    assert sims_close(sims, rtol=1e-8, atol=1e-8)