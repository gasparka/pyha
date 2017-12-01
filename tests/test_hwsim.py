import time

from pyha.common.fixed_point import Sfix
from pyha.common.core import Hardware, Meta, PyhaFunc


def test_metaclass_assigned():
    class A(Hardware):
        pass

    assert type(A) == Meta


def test_locals_decorated():
    class A(Hardware):
        def main(self, *args, **kwargs):
            pass

        def func2(self):
            pass

    assert isinstance(A().main, PyhaFunc)
    assert isinstance(A().func2, PyhaFunc)


def test_objects_not_decorated():
    # had problem where LocalExtractor was applied to all CALLABLE objects
    class A(Hardware):
        def __init__(self):
            self.a = Sfix(0.0)

        def main(self, *args, **kwargs):
            pass

    assert not isinstance(A().a, PyhaFunc)


def test_next_init():
    class A(Hardware):
        def __init__(self):
            self.a = 1

    dut = A()
    assert dut.a == dut._pyha_next['a']

    dut.a = 2
    assert dut._pyha_next['a'] != dut.a

    dut._pyha_next['a'] = 3
    assert dut.a == 2
    assert dut._pyha_next['a'] == 3


def test_next_filter():
    """ Next should contain only convertible items, shall not contain any submodules """

    class B(Hardware):
        pass

    class A(Hardware):
        def __init__(self):
            self.a = 1
            self.b = Sfix()

            # these shall not make it to 'next'
            # self.bb = ComplexSfix()
            self.bbb = [1, 2, 3, 4]
            self.c = B()
            # self.e = np.array([1, 2, 3])
            self.f = [B(), B()]

    dut = A()
    assert dut._pyha_next == {'a': 1, 'b': Sfix()}


def test_float_register():
    class A(Hardware):
        def __init__(self):
            self.a = 1.0

        def main(self, next):
            self.a = next

    dut = A()
    assert dut.a == 1.0
    dut.main(2.0)
    assert dut.a == 1.0
    dut._pyha_update_self()
    assert dut.a == 2.0
    dut.main(3.0)
    dut._pyha_update_self()
    assert dut.a == 3.0


def test_submodule_float_register():
    class B(Hardware):
        def __init__(self):
            self.a = 1.0

        def main(self, next):
            self.a = next

    class A(Hardware):
        def __init__(self):
            self.b = B()

        def main(self, next):
            self.b.main(next)

    dut = A()
    assert dut.b.a == 1.0
    dut.main(2.0)
    dut._pyha_update_self()
    assert dut.b.a == 2.0
    dut.main(3.0)
    dut._pyha_update_self()
    assert dut.b.a == 3.0


def test_only_main_is_clocked():
    """ Only 'main' shall simulate clock! """

    class A(Hardware):
        def __init__(self):
            self.a = 1.0

        def some_non_main_function(self, next):
            self.a = next

    dut = A()
    assert dut.a == 1.0
    dut.some_non_main_function(2.0)
    assert dut.a == 1.0
    dut.some_non_main_function(3.0)
    assert dut.a == 1.0
    dut.some_non_main_function(3.0)
    assert dut.a == 1.0


def test_list_register():
    class A(Hardware):
        def __init__(self):
            self.a = [1.0, 2.0, 3.0]

        def main(self, next):
            self.a = [next] + self.a[:-1]

    dut = A()
    assert dut.a == [1.0, 2.0, 3.0]
    dut.main(4.0)
    assert dut.a == [1.0, 2.0, 3.0]
    dut._pyha_update_self()
    dut.main(3.0)
    assert dut.a == [4.0, 1.0, 2.0]
    dut._pyha_update_self()


def test_list_cascade_register():
    class A(Hardware):
        def __init__(self):
            self.a = [1.0, 2.0, 3.0]

        def main(self, next):
            self.a = [next] + self.a[:-1]
            return self.a[-1]

    class B(Hardware):
        def __init__(self):
            self.a = A()
            self.l = [0.0, 0.0]

        def main(self, next):
            last = self.a.main(next)
            self.l = [last] + self.l[:-1]

    dut = B()
    assert dut.l == [0.0, 0.0]
    dut.main(4.0)

    assert dut.l == [0.0, 0.0]
    dut._pyha_update_self()
    dut.main(3.0)

    assert dut.l == [3.0, 0.0]
    dut._pyha_update_self()

    dut.main(2.0)
    assert dut.l == [2.0, 3.0]
    assert dut.a.a == [3.0, 4.0, 1.0]
    dut._pyha_update_self()


def test_initial_self():
    class A(Hardware):
        def __init__(self):
            self.a = Sfix(0.0123)
            self.i = 25
            self.b = False

        def main(self):
            self.a = Sfix(1.2, 3, -18)
            self.i = 0
            self.b = True

    dut = A()
    assert dut.a == dut.__dict__['_pyha_initial_self'].a
    assert dut.b == dut.__dict__['_pyha_initial_self'].b
    assert dut.i == dut.__dict__['_pyha_initial_self'].i
    dut.main()
    dut.main()
    dut.main()
    assert dut.__dict__['_pyha_initial_self'].a.init_val == 0.0123
    assert dut.__dict__['_pyha_initial_self'].i == 25
    assert dut.__dict__['_pyha_initial_self'].b == False


def test_meta_deepcopy():
    """ this test used to run 4s, with exponential growth on each added level
    problem was in nested deepcopy() calls
    """

    class A(Hardware):
        def __init__(self):
            self.a = Sfix(0.592)

    class B(Hardware):
        def __init__(self):
            self.l = A()
            self.a = Sfix(0.592)

    class C(Hardware):
        def __init__(self):
            self.l = B()
            self.a = Sfix(0.592)

    class D(Hardware):
        def __init__(self):
            self.l = C()
            self.a = Sfix(0.592)

    class E(Hardware):
        def __init__(self):
            self.l = D()
            self.b = D()
            self.a = Sfix(0.592)

    start = time.time()
    dut = E()
    end = time.time()

    assert end - start < 0.1
    assert id(dut.l.a) != id(dut.l._pyha_next['a']) != id(dut.l.__dict__['_pyha_initial_self'].a)
    assert id(dut.l.l.a) != id(dut.l.l._pyha_next['a']) != id(dut.l.l.__dict__['_pyha_initial_self'].a)


def test_outputs():
    class A(Hardware):
        def main(self, a):
            return a

    dut = A()
    dut.main(1)
    dut.main(2)
    dut.main(3)
    dut.main(4)
    assert dut._pyha_outputs == [1, 2, 3, 4]


def test_setattr_assign_self():
    class A(Hardware):
        def __init__(self):
            self.a = 0

        def main(self, a):
            self.a = a
            self.a = a
            return self.a

    dut = A()
    dut.main(1)


def test_setattr_resize():
    class A(Hardware):
        def __init__(self):
            self.a = Sfix(0, 0, -2)

        def main(self, a):
            self.a = a
            return self.a

    dut = A()

    dut.main(Sfix(0.1234, 0, -24))
    assert dut._pyha_next['a'].left == 0
    assert dut._pyha_next['a'].right == -2
