import numpy as np
import pytest

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, resize, left_index, right_index
from pyha.common.util import is_power2
from pyha.simulation.simulation_interface import Simulation, SIM_HW_MODEL, SIM_RTL


# @pytest.fixture(scope='module', params=[SIM_MODEL, SIM_HW_MODEL])
@pytest.fixture(scope='module', params=[SIM_HW_MODEL, SIM_RTL])
def dut(request):
    return Simulation(request.param)


class MovingAverage(HW):
    def __init__(self, window_len):
        if window_len < 2:
            raise Exception('Window length must be power >= 2')

        if not is_power2(window_len):
            raise Exception('Window length must be power of 2')

        self.window_len = window_len
        self.window_pow = int(np.log2(window_len))

        # registers
        self.shift_register = [Sfix()] * self.window_len
        self.sum = Sfix()

    def main(self, x):
        self.next.shift_register = [x] + self.shift_register[:-1]

        self.next.sum = resize(self.sum + x - self.shift_register[-1],
                               left_index=self.window_pow + left_index(x),
                               right_index=right_index(x))

        ret = resize(self.sum >> self.window_pow, size_res=x)
        # ret = resize(self.sum, size_res=x)
        return ret

    # def get_delay(self):
    #     return 1

    def model_main(self, inputs):
        # def ite_avg(i):
        #     return sum(inputs[0 + i:self.window_len + i]) / self.window_len
        #
        # return [ite_avg(i) for i in range(len(inputs) - self.window_len + 1)]
        # return result
        return np.convolve(inputs, np.ones((self.window_len,)) / self.window_len, mode='full')


def test_window1(dut):
    mov = MovingAverage(window_len=1)
    dut.init(mov, input_types=[Sfix(left=4, right=-18)])

    x = [0., 1., 2., 3., 4.]
    expected = [0., 1., 2., 3., 4.]
    y = dut.main(x)

    assert expected == y.tolist()


def test_window2(dut):
    mov = MovingAverage(window_len=2)
    dut.init(mov, input_types=[Sfix(left=4, right=-18)])

    x = [0., 1., 2., 3., 4.]
    # expected = [0., 0.5, 1.5, 2.5, 3.5, 2.]
    expected = [0.5, 1.5, 2.5, 3.5]
    y = dut.main(x)
    print(y)
    # assert expected == y.tolist()


def test_window3(dut):
    mov = MovingAverage(window_len=3)
    dut.init(mov, input_types=[Sfix(left=4, right=-18)])

    x = [-0.2, 1.05, 2., -3.1, 4.]
    expected = [-0.2 / 3, 0.85 / 3, 2.85 / 3, -0.05 / 3, 2.9 / 3, 0.9 / 3, 4 / 3]
    y = dut.main(x)

    assert np.allclose(expected, y)

# def test_basic(dut):
#     inp = np.random.uniform(-1, 1, 128)
#     outp = dut.main(inp)
#
#     # outp2 = tst(inp.tolist())
#
#     plt.plot(inp)
#     plt.plot(outp)
#     # plt.plot(outp2)
#     plt.show()
