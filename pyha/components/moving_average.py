import numpy as np

from pyha.common.const import Const
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, left_index, right_index
from pyha.common.sfix import resize
from pyha.common.util import is_power2


class MovingAverage(HW):
    def __init__(self, window_len):
        if window_len < 2:
            raise AttributeError('Window length must be power >= 2')

        if not is_power2(window_len):
            raise AttributeError('Window length must be power of 2')

        self.window_len = window_len
        self.window_pow = Const(int(np.log2(window_len)))

        # registers
        self.shift_register = [Sfix()] * self.window_len
        self.sum = Sfix()

        self._delay = 1

    def main(self, x):
        self.next.shift_register = [x] + self.shift_register[:-1]

        left = self.window_pow + left_index(x)
        right = right_index(x)
        last = self.shift_register[-1]
        self.next.sum = resize(self.sum + x - last,
                               left_index=left,
                               right_index=right)

        ret = resize(self.sum >> self.window_pow, size_res=x)
        return ret

    def model_main(self, inputs):
        # def ite_avg(i):
        #     return sum(inputs[0 + i:self.window_len + i]) / self.window_len
        #
        # return [ite_avg(i) for i in range(len(inputs) - self.window_len + 1)]
        # return result
        ret = np.convolve(inputs, np.ones((self.window_len,)) / self.window_len, mode='full')
        return ret[:-self.window_len + 1]
