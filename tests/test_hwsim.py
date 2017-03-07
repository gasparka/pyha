import numpy as np

from pyha.common.hwsim import HW, Meta, PyhaFunc
from pyha.common.sfix import Sfix, ComplexSfix


def test_metaclass_assigned():
    class A(HW):
        pass

    assert type(A) == Meta


def test_locals_decorated():
    class A(HW):
        def main(self, *args, **kwargs):
            pass

        def func2(self):
            pass

    assert isinstance(A().main, PyhaFunc)
    assert isinstance(A().func2, PyhaFunc)


def test_objects_not_decorated():
    # had problem where LocalExtractor was applied to all CALLABLE objects
    class A(HW):
        def __init__(self):
            self.a = Sfix(0.0)

        def main(self, *args, **kwargs):
            pass

    assert not isinstance(A().a, PyhaFunc)


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


def test_next_ids():
    class A(HW):
        def __init__(self):
            self.a = 1
            self.b = Sfix()

    dut = A()

    dut.next.a = 3
    assert id(dut.a) != id(dut.next.a)

    assert id(dut.b) != id(dut.next.b)


def test_next_filter():
    """ Next should contain only convertible items, shall not contain any submodules """
    class Ob:
        pass

    class B(HW):
        pass

    class A(HW):
        def __init__(self):
            self.a = 1
            self.b = Sfix()
            self.bb = ComplexSfix()
            self.bbb = [1, 2, 3, 4]

            # these shall not make it to 'next'
            self.c = B()
            self.d = Ob()
            self.e = np.array([1, 2, 3])
            self.f = [B(), B()]

    dut = A()

    assert hasattr(dut.next, 'a')
    assert hasattr(dut.next, 'b')
    assert hasattr(dut.next, 'bb')
    assert hasattr(dut.next, 'bbb')

    assert not hasattr(dut.next, 'c')
    assert not hasattr(dut.next, 'd')
    assert not hasattr(dut.next, 'e')
    assert not hasattr(dut.next, 'f')


def test_submodules_discovery():
    class B(HW):
        pass

    class A(HW):
        def __init__(self):
            self.c = B()
            self.f = [B(), B()]

    dut = A()
    assert len(dut._pyha_submodules) == 2
    assert dut._pyha_submodules[0] == dut.c
    assert dut._pyha_submodules[1] == dut.f


def test_float_register():
    class A(HW):
        def __init__(self):
            self.a = 1.0

        def main(self, next):
            self.next.a = next

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
    class B(HW):
        def __init__(self):
            self.a = 1.0

        def main(self, next):
            self.next.a = next

    class A(HW):
        def __init__(self):
            self.b = B()

        def main(self, next):
            self.b.main(next)


    dut = A()
    assert id(dut.b) == id(dut._pyha_submodules[0])
    assert dut.b.a == 1.0
    dut.main(2.0)
    dut._pyha_update_self()
    assert dut.b.a == 2.0
    dut.main(3.0)
    dut._pyha_update_self()
    assert dut.b.a == 3.0


def test_only_main_is_clocked():
    """ Only 'main' shall simulate clock! """

    class A(HW):
        def __init__(self):
            self.a = 1.0

        def some_non_main_function(self, next):
            self.next.a = next

    dut = A()
    assert dut.a == 1.0
    dut.some_non_main_function(2.0)
    assert dut.a == 1.0
    dut.some_non_main_function(3.0)
    assert dut.a == 1.0
    dut.some_non_main_function(3.0)
    assert dut.a == 1.0


def test_list_register():
    class A(HW):
        def __init__(self):
            self.a = [1.0, 2.0, 3.0]

        def main(self, next):
            self.next.a = [next] + self.a[:-1]

    dut = A()
    assert dut.a == [1.0, 2.0, 3.0]
    dut.main(4.0)
    assert dut.a == [1.0, 2.0, 3.0]
    dut._pyha_update_self()
    dut.main(3.0)
    assert dut.a == [4.0, 1.0, 2.0]
    dut._pyha_update_self()


def test_list_cascade_register():
    class A(HW):
        def __init__(self):
            self.a = [1.0, 2.0, 3.0]

        def main(self, next):
            self.next.a = [next] + self.a[:-1]
            return self.a[-1]

    class B(HW):
        def __init__(self):
            self.a = A()
            self.l = [0.0, 0.0]

        def main(self, next):
            last = self.a.main(next)
            self.next.l = [last] + self.l[:-1]

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
    class A(HW):
        def __init__(self):
            self.a = Sfix(0.0123)
            self.i = 25
            self.b = False

        def main(self):
            self.next.a = Sfix(1.2, 3, -18)
            self.next.i = 0
            self.next.b = True

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
    class A(HW):
        def __init__(self):
            self.a = Sfix(0.592)

    class B(HW):
        def __init__(self):
            self.l = A()
            self.a = Sfix(0.592)

    class C(HW):
        def __init__(self):
            self.l = B()
            self.a = Sfix(0.592)

    class D(HW):
        def __init__(self):
            self.l = C()
            self.a = Sfix(0.592)

    class E(HW):
        def __init__(self):
            self.l = D()
            self.b = D()
            self.a = Sfix(0.592)

    dut = E()

    assert id(dut.l.a) != id(dut.l.next.a) != id(dut.l.__dict__['_pyha_initial_self'].a)
    assert id(dut.l.l.a) != id(dut.l.l.next.a) != id(dut.l.l.__dict__['_pyha_initial_self'].a)

def test_outputs():
    class A(HW):
        def main(self, a):
            return a

    dut = A()
    dut.main(1)
    dut.main(2)
    dut.main(3)
    dut.main(4)
    assert dut._outputs == [1, 2, 3, 4]





def test_setattr_assign_self():
    class A(HW):
        def __init__(self):
            self.a = 0

        def main(self, a):
            self.next.a = a
            self.a = a
            return self.a

    dut = A()
    HW.is_hw_simulation = True
    dut.main(1)


def test_setattr_resize():
    class A(HW):
        def __init__(self):
            self.a = Sfix(0, 0, -2)

        def main(self, a):
            self.next.a = a
            return self.a

    dut = A()
    HW.is_hw_simulation = True
    dut.main(Sfix(0.1234, 0, -24))
    assert dut.next.a.left == 0
    assert dut.next.a.right == -2
    print(dut.next.a)


# def test_two_calls():



    #
# def test_forbid_self_assign_sfix_raises():
#     class A(HW):
#         def __init__(self):
#             self.a = Sfix(0.0)
#
#         def main(self, condition):
#             if condition:
#                 self.next.a = Sfix(1.2, 3, -18)
#             else:
#                 self.a = Sfix(2.2, 3, -18)
#
#     dut = A()
#     HW.is_hw_simulation = True
#     dut.main(True)
#     with pytest.raises(Exception) as e:
#         dut.main(False)

    #
    #
    # def test_forbid_self_assign_list_raises():
    #     class A(HW):
    #         def __init__(self):
    #             self.alist = [1, 2, 3]
    #
    #         def main(self, condition):
    #             if condition:
    #                 self.next.alist = [1, 2, 3]
    #             else:
    #                 self.alist = [1, 2, 3, 4]
    #
    #     expect = textwrap.dedent("""\
    #             Assigment to self.alist, did you mean self.next.alist?
    #             Class: A""")
    #
    #     dut = A()
    #     dut.main(True)
    #     with pytest.raises(AssignToSelf) as e:
    #         dut.main(False)
    #
    #     assert str(e.value) == expect
    #
    #
    # def test_forbid_self_assign_numpy():
    #     # numpy used to crash this check
    #     import numpy as np
    #     class A(HW):
    #         def __init__(self):
    #             self.b = np.array([1, 2, 3])
    #
    #         def main(self):
    #             pass
    #
    #     expect = {}
    #     dut = A()
    #     dut.main()
    #
    #
    # def test_self_type_consistent_raises():
    #     class A(HW):
    #         def __init__(self):
    #             self.a = 128
    #
    #         def main(self, condition):
    #             if condition:
    #                 self.next.a = 128
    #             else:
    #                 self.next.a = True
    #
    #     dut = A()
    #     dut.main(True)
    #     with pytest.raises(TypeNotConsistent):
    #         dut.main(False)
    #
    #
    # def test_self_type_consistent_initial_allowed_raises():
    #     class A(HW):
    #         def __init__(self):
    #             self.a = 128
    #
    #         def main(self, condition):
    #             if condition:
    #                 self.next.a = 128
    #             else:
    #                 self.next.a = True
    #
    #     expect = textwrap.dedent("""\
    #             Self/local not consistent type!
    #             Class: A
    #             Function: main
    #             Variable: a
#             Old: <class 'dict'>:{'_pyha_instance_id': 0, 'a': 128}
#             New: <class 'dict'>:{'_pyha_instance_id': 0, 'a': True}""")
    #     dut = A()
    #     dut.main(True)
    #     with pytest.raises(TypeNotConsistent) as e:
    #         dut.main(False)
    #
    #         # assert str(e.value) == expect
    #
    #
    # def test_self_type_consistent_sfix_raises():
    #     class A(HW):
    #         def __init__(self):
    #             self.a = Sfix(0.0)
    #
    #         def main(self, condition):
    #             if condition:
    #                 self.next.a = Sfix(1.2, 3, -18)
    #             else:
    #                 self.next.a = Sfix(2.2, 3, -32)
    #
    #     expect = textwrap.dedent("""\
    #             Self/local not consistent type!
    #             Class: A
    #             Function: main
    #             Variable: a
    #             Old: <class 'dict'>:{'a': 1.20000076294 [3:-18]}
    #             New: <class 'dict'>:{'a': 2.19999999995 [3:-32]}""")
    #     dut = A()
    #     dut.main(True)
    #     with pytest.raises(TypeNotConsistent) as e:
    #         dut.main(False)
    #
    #         # assert str(e.value) == expect
    #
    #
    # def test_self_type_consistent_sfix():
    #     class A(HW):
    #         def __init__(self):
    #             self.a = Sfix(0.0)
    #
    #         def main(self, condition):
    #             if condition:
    #                 self.next.a = Sfix(1.2, 3, -18)
    #             else:
    #                 self.next.a = Sfix(2.2, 3, -18)
    #
    #     dut = A()
    #     dut.main(True)
    #     dut.main(False)
    #
    #
    # def test_self_type_consistent_list():
    #     class A(HW):
    #         def __init__(self):
    #             self.a = [1] * 5
    #
    #         def main(self):
    #             self.next.a = [3] * 5
    #
    #     dut = A()
    #     dut.main()
    #     dut.main()
    #
    #
    # def test_self_type_consistent_list_raises():
    #     class A(HW):
    #         def __init__(self):
    #             self.a = [1] * 5
    #
    #         def main(self):
    #             self.next.a = [3] * 2
    #
    #     expect = textwrap.dedent("""\
    #             Self/local not consistent type!
    #             Class: A
    #             Function: main
    #             Variable: a
    #             Old: <class 'dict'>:{'a': [1, 1, 1, 1, 1]}
    #             New: <class 'dict'>:{'a': [3, 3]}""")
    #
    #     dut = A()
    #     with pytest.raises(TypeNotConsistent) as e:
    #         dut.main()
    #
    #         # assert str(e.value) == expect
