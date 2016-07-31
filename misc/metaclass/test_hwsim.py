from misc.metaclass.hwsim import HW, Meta, clock_tick


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


def test_int_register():
    class A(HW):
        def __init__(self):
            self.a = 1

        def __call__(self, next):
            self.next.a = next
