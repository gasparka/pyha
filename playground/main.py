from pyha.common.hwsim import HW


class A(HW):
    def __init__(self):
        self.sum = 0

    def main(self, x):
        self.next.sum = x
        return self.sum

class B(HW):
    def __init__(self):
        self.sub = A()
        self.sub2 = A()

    def local(self):
        return 1

    def main(self, x):
        print(self)
        r = self.sub.main(x)
        r2 = self.next.sub2.main(x)
        print(self)
        pass
        # self.next.sub2.sum = 5
        # r3= self.local()
        # r4=self.next.local()
        # return r


def test_sub():
    dut = B()
    dut.main(1)
    dut.main(2)
    assert dut.next.sub2 == dut.sub2
    pass