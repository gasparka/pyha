from common.hwsim import HW, Meta, clock_tick


def test_metaclass_assigned():
    class A(HW):
        pass

    assert type(A) == Meta


def test_call_decorated():
    class A(HW):
        def __call__(self, *args, **kwargs):
            pass

    assert A.__call__.__wrapped__ == clock_tick


def test_next_init():
    class A(HW):
        def __init__(self):
            self.a = 1

    dut = A()
    assert dut.a == dut.next.a

    dut.a = 2
    assert dut.next.a != dut.a

    dut.next.a = 3
    assert dut.a == 2
    assert dut.next.a == 3


def test_float_register():
    class A(HW):
        def __init__(self):
            self.a = 1.0

        def __call__(self, next):
            self.next.a = next

    dut = A()
    assert dut.a == 1.0
    dut(2.0)
    assert dut.a == 1.0
    dut(3.0)
    assert dut.a == 2.0


def test_list_register():
    class A(HW):
        def __init__(self):
            self.a = [1.0, 2.0, 3.0]

        def __call__(self, next):
            self.next.a = [next] + self.a[:-1]

    dut = A()
    assert dut.a == [1.0, 2.0, 3.0]
    dut(4.0)
    assert dut.a == [1.0, 2.0, 3.0]
    dut(3.0)
    assert dut.a == [4.0, 1.0, 2.0]


def test_list_cascade_register():
    class A(HW):
        def __init__(self):
            self.a = [1.0, 2.0, 3.0]

        def __call__(self, next):
            self.next.a = [next] + self.a[:-1]
            return self.a[-1]

    class B(HW):
        def __init__(self):
            self.a = A()
            self.l = [0.0, 0.0]

        def __call__(self, next):
            last = self.a(next)
            self.next.l = [last] + self.l[:-1]

    dut = B()
    assert dut.l == [0.0, 0.0]
    dut(4.0)
    assert dut.l == [0.0, 0.0]
    dut(3.0)
    assert dut.l == [3.0, 0.0]
    dut(2.0)
    assert dut.l == [2.0, 3.0]
    assert dut.a.a == [3.0, 4.0, 1.0]
