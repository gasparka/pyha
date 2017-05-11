from pyha.common.hwsim import HW
from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL, SIM_RTL


class TestBuiltins:
    class A(HW):
        def __init__(self):
            self.i = 1
            self.b = True

        def main(self, i, b):
            self.i = i
            self.b = b
            return self.i, self.b

    def test_basic(self):
        dut = self.A()

        assert dut.i == 1
        assert dut._next['i'] == 1
        assert dut.b == True
        assert dut._next['b'] == True

        with HW.implicit_next():
            dut.main(2, False)

        assert dut.i == 1
        assert dut._next['i'] == 2
        assert dut.b == True
        assert dut._next['b'] == False

        dut._pyha_update_self()

        assert dut.i == 2
        assert dut._next['i'] == 2
        assert dut.b == False
        assert dut._next['b'] == False

    def test_simulate(self):
        x = [[5, 2, 3], [False, True, False]]
        expected = [[1, 5, 2], [True, False, True]]

        dut = self.A()
        assert_sim_match(dut, expected, *x, simulations=[SIM_HW_MODEL, SIM_RTL])