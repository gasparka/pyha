from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
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
        assert_sim_match(dut, expected, *x)


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
        x = [[5, 4, 3, 2, 1, 0], [False, True, False, False, True, False]]
        expected = [[3, 2, 1, 5, 4, 3], [True, False, True, False, True, False]]

        dut = self.T1()
        assert_sim_match(dut, expected, *x)


class TestSfix:
    class T2(HW):
        def __init__(self):
            self.i = Sfix(0.1, 0, -17)

        def main(self, i):
            self.i = i
            return self.i

    def test_basic(self):
        dut = self.T2()
        dut._pyha_update_self()

        assert dut.i == Sfix(0.1, 0, -17)
        assert dut._next['i'] == Sfix(0.1, 0, -17)

        with HW.implicit_next():
            dut.main(Sfix(0.5, 0, -17))

        assert dut.i == Sfix(0.1, 0, -17)
        assert dut._next['i'] == Sfix(0.5, 0, -17)

        dut._pyha_update_self()

        assert dut.i == Sfix(0.5, 0, -17)
        assert dut._next['i'] == Sfix(0.5, 0, -17)

    def test_simulate(self):
        x = [0.1, 0.2, 0.3]
        expected = [0.1, 0.1, 0.2]

        dut = self.T2()
        assert_sim_match(dut, expected, x)

class TestSfixList:
    class T3(HW):
        def __init__(self):
            self.i = [Sfix(0.1, 0, -17), Sfix(0.2, 0, -17)]

        def main(self, i):
            self.i[0] = i
            self.i = [i] + self.i[:-1]
            return self.i[-1]

    def test_basic(self):
        dut = self.T3()
        dut._pyha_update_self()

        init = [Sfix(0.1, 0, -17), Sfix(0.2, 0, -17)]
        assert dut.i == init
        assert dut.i._next == init
        assert not hasattr(dut._next, 'i')

        with HW.implicit_next():
            dut.main(Sfix(0.5, 0, -17))

        assert dut.i == init
        assert dut.i._next == [Sfix(0.5, 0, -17), Sfix(0.1, 0, -17)]

        dut._pyha_update_self()

        assert dut.i == [Sfix(0.5, 0, -17), Sfix(0.1, 0, -17)]
        assert dut.i._next == [Sfix(0.5, 0, -17), Sfix(0.1, 0, -17)]

    def test_simulate(self):
        x = [0.1, 0.2, 0.3]
        expected = [0.2, 0.1, 0.1]

        dut = self.T3()
        assert_sim_match(dut, expected, x)
