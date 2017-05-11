from pyha.common.hwsim import HW


class TestBasic:
    class A(HW):
        def __init__(self):
            self.a = 1

        def main(self, a):
            self.a = a
            return self.a

    def test_basic(self):
        dut = self.A()

        assert dut.a == 1
        assert dut._next['a'] == 1

        with HW.implicit_next():
            dut.main(2)

        assert dut.a == 1
        assert dut._next['a'] == 2

        dut._pyha_update_self()

        assert dut.a == 2
        assert dut._next['a'] == 2
