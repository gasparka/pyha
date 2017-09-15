from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.simulation.simulation_interface import SIM_HW_MODEL, SIM_RTL, simulate


class Unit(HW):
    def __init__(self):
        self.coef = Sfix(0.324, 0, -17)
        self.mac = Sfix(0.0, left=0)

    def main(self, input):
        self.mac = self.mac + input * self.coef
        return self.mac


def test_basic():
    class Dut(HW):
        def __init__(self):
            self.a = [Unit(), Unit()]
            self.state = 0

        def main(self, input):
            res = self.a[self.state].main(input)

            if self.state == 1:
                self.state = 0
            else:
                self.state = 1

            return res

    dut = Dut()
    inputs = [0.1, 0.2, 0.3, 0.4]
    ret = simulate(dut, inputs, simulations=[SIM_HW_MODEL, SIM_RTL], dir_path='/home/gaspar/git/pyha/playground')