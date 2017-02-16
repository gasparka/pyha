from pyha.common.hwsim import HW
from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL, SIM_RTL


class Streaming(HW):
    def __init__(self, dtype):
        self.data = dtype
        self.valid = False

    def set_valid_data(self, data):
        self.next.data = data
        self.next.valid = True


class TestBasic:
    class A(HW):
        def __init__(self):
            self.a = Streaming(0)

        def main(self, b):
            self.a.set_valid_data(b)
            return b

    def setup(self):
        self.dut = self.A()

    def test_wtf(self):
        inputs = [1, 2, 3]

        assert_sim_match(self.dut, [int], None, inputs,
                         simulations=[SIM_HW_MODEL, SIM_RTL])
