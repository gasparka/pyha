from contextlib import AbstractContextManager

from pyha.common.hwsim import HW
from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, SIM_HW_MODEL


class TestCounterInt:
    class T0(HW):
        def __init__(self):
            self.a = 0
            # self._delay = 1

        def main(self, a):
            self.a = a + 1
            return self.a

    def test_simulate(self):
        x = [1, 2, 3]

        dut = self.T0()
        assert_sim_match(dut, None, x, simulations=[SIM_MODEL, SIM_HW_MODEL])



class EnableRefCounted(AbstractContextManager):
    def __init__(self):
        self.enabled = 0

    def __enter__(self):
        self.enabled += 1

    def __exit__(self, type, value, traceback):
        self.enabled -= 1

def test_play():
    con = EnableRefCounted()

    with con:
        print(con.enabled)
        with con:
            print(con.enabled)

