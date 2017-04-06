from pyha.common.const import Const
from pyha.common.sfix import Sfix, resize, fixed_truncate
from pyha.common.hwsim import HW
import numpy as np
from pyha.simulation.simulation_interface import debug_assert_sim_match, SIM_GATE, plot_assert_sim_match


class Simple(HW):
    def __init__(self):
        self.a = 0

    def main(self, a):
        self.next.a = a
        return self.a


def test_basic():
    from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL, SIM_RTL
    dut = Simple()
    inputs = [1, 2, 3, 4, 5, 6, 7, 8]

    r = debug_assert_sim_match(dut, None, inputs,
                     simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                     rtol=1e-4,
                     dir_path='/home/gaspar/git/thesis/playground')

    print(r)

if __name__ == '__main__':
    test_basic()
