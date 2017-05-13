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


class TestSubmodule:
    class T4Sub(HW):
        def __init__(self):
            self.i = 1
            self.i2 = 2

        def main(self, i):
            self.i = i
            return self.i

    class T4(HW):
        def __init__(self):
            self.sub = TestSubmodule.T4Sub()
            self.i = 0

        def main(self, i):
            self.sub.i2 = i
            self.i = self.sub.main(i)
            return self.i, self.sub.i2, self.sub.i

    def test_basic(self):
        dut = self.T4()
        dut._pyha_update_self()

        assert dut.i == 0
        assert dut.sub.i2 == 2
        assert dut.sub.i == 1
        assert dut._next['i'] == 0
        assert dut.sub._next['i'] == 1
        assert dut.sub._next['i2'] == 2

        dut.main(5)

        assert dut.i == 0
        assert dut.sub.i2 == 2
        assert dut.sub.i == 1
        assert dut._next['i'] == 1
        assert dut.sub._next['i'] == 5
        assert dut.sub._next['i2'] == 5

        dut._pyha_update_self()

        assert dut.i == 1
        assert dut.sub.i2 == 5
        assert dut.sub.i == 5
        assert dut._next['i'] == 1
        assert dut.sub._next['i'] == 5
        assert dut.sub._next['i2'] == 5

    def test_simulate(self):
        x = [1, 2, 3]

        dut = self.T4()
        assert_sim_match(dut, None, x)


class TestSubmoduleList:
    class T5Sub(HW):
        def __init__(self):
            self.i = 1
            self.i2 = 2

        def main(self, i):
            self.i = i
            return self.i

    class T5(HW):
        def __init__(self):
            self.sub = [TestSubmoduleList.T5Sub(), TestSubmoduleList.T5Sub()]
            self.i = 0

        def main(self, i):
            self.i = self.sub[0].main(i)
            self.sub[0].i2 = i
            self.sub[1].i2 = i
            return self.i, self.sub[0].i, self.sub[1].i, self.sub[0].i2, self.sub[1].i2

    def test_basic(self):
        dut = self.T5()
        dut._pyha_update_self()

        assert dut.i == 0
        assert dut._next['i'] == 0
        assert dut.sub[0].i2 == 2
        assert dut.sub[0].i == 1
        assert dut.sub[0]._next['i'] == 1
        assert dut.sub[0]._next['i2'] == 2
        assert dut.sub[1].i2 == 2
        assert dut.sub[1].i == 1
        assert dut.sub[1]._next['i'] == 1
        assert dut.sub[1]._next['i2'] == 2


        dut.main(15)

        assert dut.i == 0
        assert dut._next['i'] == 1
        assert dut.sub[0].i2 == 2
        assert dut.sub[0].i == 1
        assert dut.sub[0]._next['i'] == 15
        assert dut.sub[0]._next['i2'] == 15
        assert dut.sub[1].i2 == 2
        assert dut.sub[1].i == 1
        assert dut.sub[1]._next['i'] == 1
        assert dut.sub[1]._next['i2'] == 15

        dut._pyha_update_self()

        assert dut.i == 1
        assert dut._next['i'] == 1
        assert dut.sub[0].i2 == 15
        assert dut.sub[0].i == 15
        assert dut.sub[0]._next['i'] == 15
        assert dut.sub[0]._next['i2'] == 15
        assert dut.sub[1].i2 == 15
        assert dut.sub[1].i == 1
        assert dut.sub[1]._next['i'] == 1
        assert dut.sub[1]._next['i2'] == 15

    def test_simulate(self):
        x = [1, 2, 3]

        dut = self.T5()
        assert_sim_match(dut, None, x, dir_path='/home/gaspar/git/pyha/playground')

