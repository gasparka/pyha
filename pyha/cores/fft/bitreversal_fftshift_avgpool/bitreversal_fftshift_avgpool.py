import numpy as np
import pytest

from pyha import Hardware, Sfix, resize, scalb, simulate, sims_close
from pyha.common.ram import RAM
from pyha.cores import DownCounter
from pyha.common.datavalid import DataValid, NumpyToDataValid
from pyha.cores.util import toggle_bit_reverse


def build_lut(fft_size, freq_axis_decimation):
    """ This LUT fixes the bit-reversal and performs fftshift. It defines th RAM write addresses."""
    orig_inp = np.array(list(range(fft_size)))
    shift = np.fft.fftshift(orig_inp)
    rev = toggle_bit_reverse(shift)
    lut = rev // freq_axis_decimation
    return lut


class BitreversalFFTshiftAVGPool(Hardware):
    """
    Bitreversal, FFTShift and AveragePooling
    ----------------------------------------

    Fixes bitreversal, performs fftshift and applies average pooling, implemented with 2 BRAM blocks.
    Internal accumulator may overflow, in which case it is saturated.

    Args:
        fft_size:
        avg_freq_axis: Pooling in frequnecy domain, decimates the data rate and has major impact on resource usage.
            Large decimations use LESS memory.
            Example, if input is 1024 point fft and avg_freq_axis is 2, then output is 512 points.
        avg_time_axis: Pooling in time domain, decimates the data rate.

    TODO: this core should be unsigned...
    """
    def __init__(self, fft_size, avg_freq_axis, avg_time_axis):
        """

        Args:
            fft_size:
            avg_freq_axis:
            avg_time_axis:
        """
        self._pyha_simulation_input_callback = NumpyToDataValid(dtype=Sfix(0.0, 0, -35, overflow_style='saturate'))

        assert not (avg_freq_axis == 1 and avg_time_axis == 1)
        self.AVG_FREQ_AXIS = avg_freq_axis
        self.AVG_TIME_AXIS = avg_time_axis
        self.ACCUMULATION_BITS = int(np.log2(avg_freq_axis * avg_time_axis))
        self.FFT_SIZE = fft_size
        self.LUT = build_lut(fft_size, avg_freq_axis)

        self.time_axis_counter = self.AVG_TIME_AXIS
        self.state = True
        self.ram = [RAM([Sfix(0.0)] * (fft_size // avg_freq_axis)),
                    RAM([Sfix(0.0)] * (fft_size // avg_freq_axis))]
        self.out_valid = False
        self.control = 0

        self.output = DataValid(Sfix())
        self.final_counter = DownCounter(self.FFT_SIZE / self.AVG_FREQ_AXIS + 1)
        self.start_counter = DownCounter(fft_size + 1)

    def work_ram(self, data, write_ram, read_ram):
        # READ-MODIFY-WRITE
        write_index = self.LUT[self.control]
        write_index_future = self.LUT[(self.control + 1) % self.FFT_SIZE]
        read = self.ram[write_ram].delayed_read(write_index_future)
        new_value = resize(read + data, size_res=data, overflow_style='saturate')
        self.ram[write_ram].delayed_write(write_index, new_value)

        # output stage
        self.out_valid = False
        if self.control < self.FFT_SIZE / self.AVG_FREQ_AXIS and self.time_axis_counter == self.AVG_TIME_AXIS:
            _ = self.ram[read_ram].delayed_read(self.control)
            self.out_valid = True

            # clear memory
            self.ram[read_ram].delayed_write(self.control, Sfix(0.0, size_res=data))

    def main(self, input):
        """
        Args:
            input (DataValid): 36 bits, type not restricted

        Returns:
            DataValid: Output type shifted right by the bit-growth.

        """
        if not input.valid:
            return DataValid(self.output.data, valid=False)

        self.control = (self.control + 1) % self.FFT_SIZE
        if self.state:
            self.work_ram(input.data, 0, 1)
            read = self.ram[1].get_readregister()
        else:
            self.work_ram(input.data, 1, 0)
            read = self.ram[0].get_readregister()

        if self.control >= self.FFT_SIZE - 1:
            next_counter = self.time_axis_counter - 1
            if next_counter == 0:
                next_counter = self.AVG_TIME_AXIS
                self.state = not self.state

            self.time_axis_counter = next_counter

        self.output.data = scalb(read, -self.ACCUMULATION_BITS)
        self.start_counter.tick()
        self.output.valid = self.start_counter.is_over() and self.out_valid
        return self.output

    def model(self, inp):
        shaped = np.reshape(inp, (-1, self.FFT_SIZE))
        # apply bitreversal
        unrev = toggle_bit_reverse(shaped)

        # fftshift
        unshift = np.fft.fftshift(unrev, axes=1)

        # average in freq axis
        avg_y = np.split(unshift.T, len(unshift.T) // self.AVG_FREQ_AXIS)
        avg_y = np.mean(avg_y, axis=1)

        # average in time axis
        avg_x = np.split(avg_y.T, len(avg_y.T) // self.AVG_TIME_AXIS)
        avg_x = np.mean(avg_x, axis=1)
        return avg_x.flatten()


@pytest.mark.parametrize("avg_freq_axis", [2, 8, 16])
@pytest.mark.parametrize("avg_time_axis", [1, 4, 8])
@pytest.mark.parametrize("fft_size", [256, 128])
@pytest.mark.parametrize("input_power", [0.1, 0.001])
def test_all(fft_size, avg_freq_axis, avg_time_axis, input_power):
    np.random.seed(0)
    avg_time_axis = 1
    packets = avg_time_axis + 1
    orig_inp = np.random.uniform(-1, 1, packets * fft_size) * input_power

    orig_inp_quant = np.vectorize(lambda x: float(Sfix(x, 0, -35)))(orig_inp)

    dut = BitreversalFFTshiftAVGPool(fft_size, avg_freq_axis, avg_time_axis)
    sim_out = simulate(dut, orig_inp_quant, pipeline_flush='auto')
    assert sims_close(sim_out, rtol=1e-30, atol=1e-30)


@pytest.mark.parametrize("avg_freq_axis", [2])
@pytest.mark.parametrize("avg_time_axis", [1])
@pytest.mark.parametrize("fft_size", [128])
@pytest.mark.parametrize("input_power", [0.001])
def test_nonstandard_input_size(fft_size, avg_freq_axis, avg_time_axis, input_power):
    np.random.seed(0)
    avg_time_axis = 1
    packets = avg_time_axis + 1

    dtype = Sfix(0, -4, -40, round_style='round')

    dut = BitreversalFFTshiftAVGPool(fft_size, avg_freq_axis, avg_time_axis)
    dut._pyha_simulation_input_callback = NumpyToDataValid(dtype)

    inp = np.random.uniform(-1, 1, packets * fft_size) * input_power
    inp = [float(dtype(x)) for x in inp]
    sim_out = simulate(dut, inp, pipeline_flush='auto', simulations=['MODEL', 'HARDWARE', 'RTL'])
    assert sims_close(sim_out, rtol=1e-30, atol=1e-30)