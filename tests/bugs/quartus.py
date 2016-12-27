import numpy as np

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, left_index, right_index
from pyha.common.sfix import resize
from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL, SIM_RTL


class ResizeBoundNotConstant(HW):
    def __init__(self, window_len):
        self.window_len = window_len
        self.window_pow_const = int(np.log2(window_len))

        # registers
        self.out = Sfix()

    def main(self, x):
        self.next.out = resize(x,
                               left_index=self.window_pow_const + left_index(x),
                               right_index=right_index(x))
        return self.out


def test_bug():
    mov = ResizeBoundNotConstant(window_len=2)
    x = [0., 1., 2., 3., 4.]
    expected = [0., 0., 1., 2., 3.]
    assert_sim_match(mov, [Sfix(left=4, right=-18)], expected, x,
                     simulations=[SIM_HW_MODEL, SIM_RTL])
