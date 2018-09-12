import numpy as np
import pytest

from pyha import Hardware, Sfix, resize, Simulator
from pyha.common.ram import RAM
from pyha.cores import NumpyToDataValid, DataValidToNumpy, DataValid, DownCounter
from pyha.cores.util import toggle_bit_reverse, snr


def build_lut(fft_size, freq_axis_decimation):
    """ This LUT fixes the bit-reversal and performs fftshift. It defines th RAM write addresses."""
    orig_inp = np.array(list(range(fft_size)))
    shift = np.fft.fftshift(orig_inp)
    rev = toggle_bit_reverse(shift)
    lut = rev // freq_axis_decimation
    return lut


class BitreversalFFTshiftAVGPool(Hardware):
    """ Performs bitreversal, fftshift and average pooling by using 2 BRAM blocks. """
    def __init__(self, fft_size, avg_freq_axis, avg_time_axis):
        self._pyha_simulation_input_callback = NumpyToDataValid(dtype=Sfix(0.0, 0, -35, overflow_style='saturate'))
        self._pyha_simulation_output_callback = DataValidToNumpy()

        assert not (avg_freq_axis == 1 and avg_time_axis == 1)
        self.AVG_FREQ_AXIS = avg_freq_axis
        self.AVG_TIME_AXIS = avg_time_axis
        self.ACCUMULATION_BITS = int(np.log2(avg_freq_axis * avg_time_axis))
        self.FFT_SIZE = fft_size
        self.LUT = build_lut(fft_size, avg_freq_axis)

        self.time_axis_counter = self.AVG_TIME_AXIS
        self.state = True
        self.ram = [RAM([Sfix(0.0, 0, -35)] * (fft_size // avg_freq_axis)),
                    RAM([Sfix(0.0, 0, -35)] * (fft_size // avg_freq_axis))]
        self.out_valid = False
        self.control = 0

        self.out = DataValid(Sfix(0, 0, -35), valid=False) # first self.ACCUMULATION_BITS actually not used
        self.final_counter = DownCounter(self.FFT_SIZE / self.AVG_FREQ_AXIS + 1)
        self.start_counter = DownCounter(fft_size + 1)

    def work_ram(self, data, write_ram, read_ram):
        # READ-MODIFY-WRITE
        write_index = self.LUT[self.control]
        write_index_future = self.LUT[(self.control + 1) % self.FFT_SIZE]
        read = self.ram[write_ram].delayed_read(write_index_future)
        res = resize(read + data, 0, -35)
        self.ram[write_ram].delayed_write(write_index, res)

        # output stage
        self.out_valid = False
        if self.control < self.FFT_SIZE / self.AVG_FREQ_AXIS and self.time_axis_counter == self.AVG_TIME_AXIS:
            _ = self.ram[read_ram].delayed_read(self.control)
            self.out_valid = True

            # clear memory
            self.ram[read_ram].delayed_write(self.control, Sfix(0.0, 0, -35))

    def main(self, inp):
        if not inp.valid:
            return DataValid(self.out.data, valid=False)

        self.control = (self.control + 1) % self.FFT_SIZE
        if self.state:
            self.work_ram(inp.data, 0, 1)
            read = self.ram[1].get_readregister()
        else:
            self.work_ram(inp.data, 1, 0)
            read = self.ram[0].get_readregister()

        if self.control >= self.FFT_SIZE - 1:
            next_counter = self.time_axis_counter - 1
            if next_counter == 0:
                next_counter = self.AVG_TIME_AXIS
                self.state = not self.state

            self.time_axis_counter = next_counter

        self.out.data = read >> self.ACCUMULATION_BITS
        self.start_counter.tick()
        self.out.valid = self.start_counter.is_over() and self.out_valid
        return self.out

    def model_main(self, inp):
        shaped = np.reshape(inp, (-1, self.FFT_SIZE))
        # apply bitreversal
        unrev = toggle_bit_reverse(shaped)

        # fftshift
        unshift = np.fft.fftshift(unrev, axes=1)

        # average in freq axis
        avg_y = np.split(unshift.T, len(unshift.T) // self.AVG_FREQ_AXIS)
        avg_y = np.average(avg_y, axis=1)

        # average in time axis
        avg_x = np.split(avg_y.T, len(avg_y.T) // self.AVG_TIME_AXIS)
        avg_x = np.average(avg_x, axis=1)
        return avg_x.flatten()


@pytest.mark.parametrize("avg_freq_axis", [2, 4, 8, 16, 32])
@pytest.mark.parametrize("avg_time_axis", [1, 2, 4, 8, 16])
@pytest.mark.parametrize("fft_size", [512, 256, 128])
@pytest.mark.parametrize("input_power", [0.1, 0.001])
def test_all(fft_size, avg_freq_axis, avg_time_axis, input_power):
    np.random.seed(0)
    avg_time_axis = 1
    packets = avg_time_axis + 1
    orig_inp = np.random.uniform(-1, 1, packets * fft_size) * input_power

    orig_inp_quant = np.vectorize(lambda x: float(Sfix(x, 0, -35)))(orig_inp)

    dut = BitreversalFFTshiftAVGPool(fft_size, avg_freq_axis, avg_time_axis)
    Simulator(dut).run(orig_inp_quant).assert_equal(rtol=5e-11, atol=5e-11)