from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix


class TestBasic:
    def setup_class(self):
        class A(HW):
            def __init__(self):
                self.a = Sfix(0, 0, -4)

                self._delay = 1

            def main(self, a):
                self.next.a = a
                return self.a

        self.dut = A()

    def test_simulate(self):

        x = [0.1, 0.2, 0.3, 0.4, 0.5]
        expected = [Sfix(xi, 0, -4).val for xi in x]

        assert_sim_match(self.dut, [Sfix(left=0, right=-17)], expected, x,
                         simulations=[SIM_HW_MODEL])
