import textwrap

import pytest
from common.hwsim import HW, Meta, clock_tick, AssignToSelf, TypeNotConsistent
from common.sfix import Sfix


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


def test_forbid_self_assign_sfix():
    class A(HW):
        def __init__(self):
            self.a = Sfix(0.0)

        def __call__(self, condition):
            if condition:
                self.next.a = Sfix(1.2, 3, -18)
            else:
                self.a = Sfix(2.2, 3, -18)

    expect = textwrap.dedent("""\
            Assigment to self.a, did you mean self.next.a?
            Class: A""")

    dut = A()
    dut(True)
    with pytest.raises(AssignToSelf) as e:
        dut(False)

    assert str(e.value) == expect


def test_forbid_self_assign_list():
    class A(HW):
        def __init__(self):
            self.alist = Sfix(0.0)

        def __call__(self, condition):
            if condition:
                self.next.alist = [1, 2, 3]
            else:
                self.alist = [1, 2, 3, 4]

    expect = textwrap.dedent("""\
            Assigment to self.alist, did you mean self.next.alist?
            Class: A""")

    dut = A()
    dut(True)
    with pytest.raises(AssignToSelf) as e:
        dut(False)

    assert str(e.value) == expect


def test_self_type_consistent_raises():
    class A(HW):
        def __init__(self):
            self.a = 128

        def __call__(self, condition):
            if condition:
                self.next.a = 128
            else:
                self.next.a = True

    dut = A()
    dut(True)
    with pytest.raises(TypeNotConsistent):
        dut(False)


def test_self_type_consistent_initial_allowed_raises():
    class A(HW):
        def __init__(self):
            self.a = None

        def __call__(self, condition):
            if condition:
                self.next.a = 128
            else:
                self.next.a = True

    expect = textwrap.dedent("""\
            Self/local not consistent type!
            Class: A
            Function: __call__
            Variable: a
            Old: <class 'dict'>:{'a': 128}
            New: <class 'dict'>:{'a': True}""")
    dut = A()
    dut(True)  # This shall NOT throw even tho types are different (first time)
    with pytest.raises(TypeNotConsistent) as e:
        dut(False)

    assert str(e.value) == expect


def test_self_type_consistent_sfix_raises():
    class A(HW):
        def __init__(self):
            self.a = Sfix(0.0)

        def __call__(self, condition):
            if condition:
                self.next.a = Sfix(1.2, 3, -18)
            else:
                self.next.a = Sfix(2.2, 3, -32)

    expect = textwrap.dedent("""\
            Self/local not consistent type!
            Class: A
            Function: __call__
            Variable: a
            Old: <class 'dict'>:{'a': 1.20000076294 [3:-18]}
            New: <class 'dict'>:{'a': 2.19999999995 [3:-32]}""")
    dut = A()
    dut(True)  # This shall NOT throw even tho types are different (first time)
    with pytest.raises(TypeNotConsistent) as e:
        dut(False)

    assert str(e.value) == expect


def test_self_type_consistent_sfix():
    class A(HW):
        def __init__(self):
            self.a = Sfix(0.0)

        def __call__(self, condition):
            if condition:
                self.next.a = Sfix(1.2, 3, -18)
            else:
                self.next.a = Sfix(2.2, 3, -18)

    dut = A()
    dut(True)  # This shall NOT throw even tho types are different (first time)
    dut(False)
