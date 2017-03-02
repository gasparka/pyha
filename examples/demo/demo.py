from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, resize, fixed_truncate
from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL, SIM_RTL, SIM_GATE


class Demo(HW):
    """ Demo class, multiply and add coef to input """

    def __init__(self, coef):
        self.coef = coef

        # registers
        self.mult = Sfix()
        self.add = Sfix()

        # constants
        self.coef_f = Sfix(coef, 0, -17)

        self._delay = 1

    def multiply(self, input):
        """ Mulitply 'input' with self.coef """
        self.next.mult = resize(input * self.coef_f, size_res=input,
                                       round_style=fixed_truncate)
        return self.mult

    def adder(self, input):
        """ Add 'input' and self.coef """
        self.next.add = resize(input + self.coef_f, size_res=input)
        return self.add

    def main(self, input):
        mult = self.multiply(input)
        add = self.adder(input)
        return mult, add


def test_demo():
    dut = Demo(coef=0.1)
    inputs = [0.1, 0.2, 0.3, 0.2, 0.1]

    assert_sim_match(dut,
                     [Sfix(left=0, right=-17)],
                     None, inputs,
                     simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                     rtol=1e-4,
                     dir_path='/home/gaspar/git/pyha/examples/demo/conversion')