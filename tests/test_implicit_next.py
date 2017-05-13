from pyha.common.hwsim import HW
from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL, SIM_RTL


class TestBuiltins:
    class T0(HW):
        def __init__(self):
            self.i = 1
            self.b = True

        def main(self, i, b):
            self.i = i
            self.b = b
            return self.i, self.b

    def test_basic(self):
        dut = self.T0()
        dut._pyha_update_self()

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

        dut = self.T0()
        assert_sim_match(dut, expected, *x, simulations=[SIM_HW_MODEL, SIM_RTL])


class TestBuiltinsList:
    class T1(HW):
        def __init__(self):
            self.i = [1, 2, 3]
            self.b = [True, False, True]

        def main(self, i, b):
            self.i[0] = i
            self.i = [i] + self.i[:-1]

            self.b[1] = b
            self.b = [b] + self.b[:-1]
            return self.i[-1], self.b[-1]

    def test_basic(self):
        dut = self.T1()
        dut._pyha_update_self()

        assert dut.i == [1, 2, 3]
        assert dut.i._next == [1, 2, 3]
        assert not hasattr(dut._next, 'i')
        assert dut.b == [True, False, True]
        assert dut.b._next == [True, False, True]
        assert not hasattr(dut._next, 'b')

        with HW.implicit_next():
            dut.main(2, False)

        assert dut.i == [1, 2, 3]
        assert dut.i._next == [2, 1, 2]
        assert dut.b == [True, False, True]
        assert dut.b._next == [False, True, False]

        dut._pyha_update_self()

        assert dut.i == [2, 1, 2]
        assert dut.i._next == [2, 1, 2]
        assert dut.b == [False, True, False]
        assert dut.b._next == [False, True, False]

    def test_simulate(self):
        x = [[5,4,3,2,1,0], [False, True, False, False, True, False]]
        expected = [[3, 2, 1, 5, 4, 3], [True, False, True, False, True, False]]

        dut = self.T1()
        assert_sim_match(dut, expected, *x, simulations=[SIM_HW_MODEL, SIM_RTL])