from pyha.common.context_managers import RegisterBehaviour
from pyha.common.fixed_point import Sfix
from pyha.common.hwsim import Hardware
from pyha.simulation.legacy import assert_sim_match


class TestBuiltins:
    class T0(Hardware):
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
        assert dut._pyha_next['i'] == 1
        assert dut.b == True
        assert dut._pyha_next['b'] == True

        dut.main(2, False)

        assert dut.i == 1
        assert dut._pyha_next['i'] == 2
        assert dut.b == True
        assert dut._pyha_next['b'] == False

        dut._pyha_update_self()

        assert dut.i == 2
        assert dut._pyha_next['i'] == 2
        assert dut.b == False
        assert dut._pyha_next['b'] == False

    def test_force_disable(self):
        with RegisterBehaviour.force_disable():
            dut = self.T0()
            dut._pyha_update_self()

            assert dut.i == 1
            assert dut._pyha_next['i'] == 1
            assert dut.b == True
            assert dut._pyha_next['b'] == True

            dut.main(2, False)

            assert dut.i == 2
            assert dut._pyha_next['i'] == 1
            assert dut.b == False
            assert dut._pyha_next['b'] == True

            dut._pyha_update_self()

            assert dut.i == 2
            assert dut._pyha_next['i'] == 1
            assert dut.b == False
            assert dut._pyha_next['b'] == True

    def test_simulate(self):
        x = [[5, 2, 3], [False, True, False]]
        expected = [[1, 5, 2], [True, False, True]]

        dut = self.T0()
        assert_sim_match(dut, expected, *x, simulations=[PYHA, RTL, GATE])


class TestBuiltinsList:
    class T1(Hardware):
        def __init__(self):
            self.i = [1, 2, 3]
            self.b = [True, False, True]

        def main(self, i, b):
            self.i[0] = i
            # self.i = [i] + self.i[:-1]

            self.b[1] = b
            self.b = [b] + self.b[:-1]
            return self.i[-1], self.b[-1]

    def test_basic(self):
        dut = self.T1()
        dut._pyha_update_self()

        assert dut.i == [1, 2, 3]
        assert dut.i._pyha_next == [1, 2, 3]
        assert not hasattr(dut._pyha_next, 'i')
        assert dut.b == [True, False, True]
        assert dut.b._pyha_next == [True, False, True]
        assert not hasattr(dut._pyha_next, 'b')

        dut.main(2, False)

        assert dut.i == [1, 2, 3]
        assert dut.i._pyha_next == [2, 2, 3]
        assert dut.b == [True, False, True]
        assert dut.b._pyha_next == [False, True, False]

        dut._pyha_update_self()

        assert dut.i == [2, 2, 3]
        assert dut.i._pyha_next == [2, 2, 3]
        assert dut.b == [False, True, False]
        assert dut.b._pyha_next == [False, True, False]

    def test_force_disable(self):
        with RegisterBehaviour.force_disable():
            dut = self.T1()
            dut._pyha_update_self()

            assert dut.i == [1, 2, 3]
            assert dut.b == [True, False, True]

            dut.main(2, False)

            assert dut.i == [2, 2, 3]
            assert dut.b == [False, True, False]

            dut._pyha_update_self()

            assert dut.i == [2, 2, 3]
            assert dut.b == [False, True, False]

    def test_simulate(self):
        x = [[5, 4, 3, 2, 1, 0], [False, True, False, False, True, False]]
        expected = [[3, 3, 3, 3, 3, 3], [True, False, True, False, True, False]]

        dut = self.T1()
        assert_sim_match(dut, expected, *x, simulations=[PYHA, RTL, GATE])


class TestSfix:
    class T2(Hardware):
        def __init__(self):
            self.i = Sfix(0.1, 0, -17)

        def main(self, i):
            self.i = i
            return self.i

    def test_basic(self):
        dut = self.T2()
        dut._pyha_update_self()

        assert dut.i == Sfix(0.1, 0, -17)
        assert dut._pyha_next['i'] == Sfix(0.1, 0, -17)

        dut.main(Sfix(0.5, 0, -17))

        assert dut.i == Sfix(0.1, 0, -17)
        assert dut._pyha_next['i'] == Sfix(0.5, 0, -17)

        dut._pyha_update_self()

        assert dut.i == Sfix(0.5, 0, -17)
        assert dut._pyha_next['i'] == Sfix(0.5, 0, -17)

    def test_simulate(self):
        x = [0.1, 0.2, 0.3]
        expected = [0.1, 0.1, 0.2]

        dut = self.T2()
        assert_sim_match(dut, expected, x, simulations=[PYHA, RTL, GATE])


class TestSfixList:
    class T3(Hardware):
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
        assert dut.i._pyha_next == init
        assert not hasattr(dut._pyha_next, 'i')

        dut.main(Sfix(0.5, 0, -17))

        assert dut.i == init
        assert dut.i._pyha_next == [Sfix(0.5, 0, -17), Sfix(0.1, 0, -17)]

        dut._pyha_update_self()

        assert dut.i == [Sfix(0.5, 0, -17), Sfix(0.1, 0, -17)]
        assert dut.i._pyha_next == [Sfix(0.5, 0, -17), Sfix(0.1, 0, -17)]

    def test_simulate(self):
        x = [0.1, 0.2, 0.3]
        expected = [0.2, 0.1, 0.1]

        dut = self.T3()
        assert_sim_match(dut, expected, x, simulations=[PYHA, RTL, GATE])


class TestSubmodule:
    class T4Sub(Hardware):
        def __init__(self):
            self.i = 1
            self.i2 = 2

        def main(self, i):
            self.i = i
            return self.i

    class T4(Hardware):
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
        assert dut._pyha_next['i'] == 0
        assert dut.sub._pyha_next['i'] == 1
        assert dut.sub._pyha_next['i2'] == 2

        dut.main(5)

        assert dut.i == 0
        assert dut.sub.i2 == 2
        assert dut.sub.i == 1
        assert dut._pyha_next['i'] == 1
        assert dut.sub._pyha_next['i'] == 5
        assert dut.sub._pyha_next['i2'] == 5

        dut._pyha_update_self()

        assert dut.i == 1
        assert dut.sub.i2 == 5
        assert dut.sub.i == 5
        assert dut._pyha_next['i'] == 1
        assert dut.sub._pyha_next['i'] == 5
        assert dut.sub._pyha_next['i2'] == 5

    def test_simulate(self):
        x = [1, 2, 3]

        dut = self.T4()
        assert_sim_match(dut, None, x, simulations=[PYHA, RTL, GATE])


class TestSubmoduleList:
    class T5Sub(Hardware):
        def __init__(self):
            self.i = 1
            self.i2 = 2

        def main(self, i):
            self.i = i
            return self.i

    class T5(Hardware):
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
        assert dut._pyha_next['i'] == 0
        assert dut.sub[0].i2 == 2
        assert dut.sub[0].i == 1
        assert dut.sub[0]._pyha_next['i'] == 1
        assert dut.sub[0]._pyha_next['i2'] == 2
        assert dut.sub[1].i2 == 2
        assert dut.sub[1].i == 1
        assert dut.sub[1]._pyha_next['i'] == 1
        assert dut.sub[1]._pyha_next['i2'] == 2

        dut.main(15)

        assert dut.i == 0
        assert dut._pyha_next['i'] == 1
        assert dut.sub[0].i2 == 2
        assert dut.sub[0].i == 1
        assert dut.sub[0]._pyha_next['i'] == 15
        assert dut.sub[0]._pyha_next['i2'] == 15
        assert dut.sub[1].i2 == 2
        assert dut.sub[1].i == 1
        assert dut.sub[1]._pyha_next['i'] == 1
        assert dut.sub[1]._pyha_next['i2'] == 15

        dut._pyha_update_self()

        assert dut.i == 1
        assert dut._pyha_next['i'] == 1
        assert dut.sub[0].i2 == 15
        assert dut.sub[0].i == 15
        assert dut.sub[0]._pyha_next['i'] == 15
        assert dut.sub[0]._pyha_next['i2'] == 15
        assert dut.sub[1].i2 == 15
        assert dut.sub[1].i == 1
        assert dut.sub[1]._pyha_next['i'] == 1
        assert dut.sub[1]._pyha_next['i2'] == 15

    def test_simulate(self):
        x = [1, 2, 3]

        dut = self.T5()
        assert_sim_match(dut, None, x, simulations=[PYHA, RTL, GATE])
