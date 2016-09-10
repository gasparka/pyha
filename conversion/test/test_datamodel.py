import textwrap

import pytest
from common.hwsim import HW
from common.sfix import Sfix
from conversion.extract_datamodel import initial_values, extract_locals, VariableNotConvertable, FunctionNotSimulated, \
    TypeNotConsistent, AssignToSelf


def test_initial_value_sfix():
    class A:
        def __init__(self):
            self.a = Sfix(0.56, 0, -10)

    expect = {'a': Sfix(0.56, 0, -10)}
    result = initial_values(A())
    assert result == expect


def test_initial_value_sfix2():
    class A:
        def __init__(self):
            self.a = Sfix(0.56, 0, -10)
            self.b = Sfix(-10, 8, -10)

    expect = {'a': Sfix(0.56, 0, -10),
              'b': Sfix(-10, 8, -10)}
    result = initial_values(A())
    assert result == expect


def test_initial_value_int():
    class A:
        def __init__(self):
            self.a = 20

    expect = {'a': 20}
    result = initial_values(A())
    assert result == expect


def test_initial_value_sfix_int():
    class A:
        def __init__(self):
            self.a = 20
            self.b = Sfix(-10, 8, -10)

    expect = {'a': 20,
              'b': Sfix(-10, 8, -10)}
    result = initial_values(A())
    assert result == expect


def test_initial_value_sfix_list():
    class A:
        def __init__(self):
            self.b = [Sfix(-10, 8, -10)] * 10

    expect = {'b': [Sfix(-10, 8, -10)] * 10}
    result = initial_values(A())
    assert result == expect


def test_initial_value_int_list():
    class A:
        def __init__(self):
            self.b = [0] * 10

    expect = {'b': [0] * 10}
    result = initial_values(A())
    assert result == expect


def test_initial_value_bool():
    class A:
        def __init__(self):
            self.b = True

    expect = {'b': True}
    result = initial_values(A())
    assert result == expect


def test_initial_value_bool_list():
    class A:
        def __init__(self):
            self.b = [False] * 10

    expect = {'b': [False] * 10}
    result = initial_values(A())
    assert result == expect


def test_initial_value_reject_flaot():
    class A:
        def __init__(self):
            self.b = 0.5

    expect = {}
    result = initial_values(A())
    assert result == expect


def test_initial_value_reject_numpy():
    import numpy as np
    class A:
        def __init__(self):
            self.b = np.array([1, 2, 3])

    expect = {}
    result = initial_values(A())
    assert result == expect


def test_initial_value_mixed():
    import numpy as np
    class A:
        def __init__(self):
            self.inte = 20
            self.fix = [Sfix(-10, 8, -10)] * 10
            self.a = {'a': 'tere', 25: 'tore'}
            self.lol = 0.5
            self.b = np.array([1, 2, 3])

    expect = {'inte': 20, 'fix': [Sfix(-10, 8, -10)] * 10}
    result = initial_values(A())
    assert result == expect


def test_locals():
    class A(HW):
        def tst(self):
            b = 20

    expect = {
        'tst':
            {
                'b': 20,
            }
    }
    dut = A()
    dut.tst()
    result = extract_locals(dut)
    assert result == expect


def test_locals_special():
    class A(HW):
        def __call__(self):
            b = 20

    expect = {
        '__call__':
            {
                'b': 20
            }
    }
    dut = A()
    dut()
    result = extract_locals(dut)
    assert result == expect


def test_locals_skips_init():
    class A(HW):
        def __init__(self):
            self.a = 15

        def __call__(self):
            b = 1

    expect = {
        '__call__':
            {
                'b': 1
            }
    }
    dut = A()
    dut()

    result = extract_locals(dut)
    assert result == expect


def test_locals_special_clock_tick():
    class A(HW):
        def __init__(self):
            self.a = 15

        def __call__(self, b):
            self.next.a = b

    expect = {
        '__call__':
            {
                'b': 2
            }
    }
    dut = A()
    dut(1)
    assert dut.a == 15
    assert dut.next.a == 1

    dut(2)
    assert dut.a == 1
    assert dut.next.a == 2

    result = extract_locals(dut)
    assert result == expect


def test_locals_call_nosim_raises():
    class A(HW):
        def __call__(self):
            b = 20

    dut = A()
    with pytest.raises(FunctionNotSimulated):
        extract_locals(dut)


def test_locals_call_bad_type_raises():
    class A(HW):
        def __call__(self):
            b = 20.5

    expect = textwrap.dedent("""\
            Variable not convertable!
            Class: A
            Function: __call__
            Variable: b
            Value: <class 'float'>:20.5""")
    dut = A()
    dut()
    with pytest.raises(VariableNotConvertable) as e:
        result = extract_locals(dut)

    assert str(e.value) == expect



def test_locals_calls():
    class A(HW):
        def __call__(self):
            b = Sfix(0.1, 2, -3)
            return 123, 0.4

    dut = A()
    dut()
    assert dut.__call__.fdict['calls'] == 1
    dut()
    assert dut.__call__.fdict['calls'] == 2


def test_locals_sfix():
    class A(HW):
        def __call__(self):
            b = Sfix(0.1, 2, -3)

    expect = {
        '__call__':
            {
                'b': Sfix(0.1, 2, -3)
            }
    }
    dut = A()
    dut()
    result = extract_locals(dut)
    assert result == expect


def test_locals_boolean():
    class A(HW):
        def __call__(self):
            b = True

    expect = {
        '__call__':
            {
                'b': True
            }
    }
    dut = A()
    dut()
    result = extract_locals(dut)
    assert result == expect


def test_locals_arguments():
    class A(HW):
        def __call__(self, a, c):
            b = Sfix(0.1, 2, -3)

    expect = {
        '__call__':
            {
                'a': 15,
                'b': Sfix(0.1, 2, -3),
                'c': Sfix(0.1, 2, -3),
            }
    }
    dut = A()
    dut(15, Sfix(0.1, 2, -3))
    result = extract_locals(dut)
    assert result == expect


def test_locals_conditional():
    class A(HW):
        def __call__(self, condition):
            if condition:
                iflocal = 128

    expect = {
        '__call__':
            {
                'condition': False,
                'iflocal': 128
            }
    }
    dut = A()
    dut(True)
    dut(False)
    result = extract_locals(dut)
    assert result == expect


def test_locals_call_multitype_raises():
    # var should always be same type
    class A(HW):
        def __call__(self, condition):
            if condition:
                iflocal = 128
            else:
                iflocal = True


    dut = A()
    dut(True)
    with pytest.raises(TypeNotConsistent) as e:
        dut(False)

        # cant test text cause locals discovery order can vary

def test_locals_multitype_sfix():
    # valid if bounds are the same
    class A(HW):
        def __call__(self, condition):
            if condition:
                iflocal = Sfix(1.2, 12, -15)
            else:
                iflocal = Sfix(0.0, 12, -15)

    expect = {
        '__call__':
            {
                'condition': False,
                'iflocal': Sfix(0.0, 12, -15)
            }
    }
    dut = A()
    dut(True)
    dut(False)
    result = extract_locals(dut)
    assert result == expect


def test_locals_multitype_sfix_raises():
    class A(HW):
        def __call__(self, condition):
            if condition:
                iflocal = Sfix(1.2, 1, -15)
            else:
                iflocal = Sfix(0.0, 12, -1)

    dut = A()
    dut(True)

    with pytest.raises(TypeNotConsistent):
        dut(False)


def test_locals_multifunc():
    class A(HW):
        def func2(self, o):
            loom = Sfix(o, 10, -10)
            return 12

        def __call__(self, a, c):
            b = Sfix(0.1, 2, -3)

    expect = {
        '__call__':
            {
                'a': 15,
                'b': Sfix(0.1, 2, -3),
                'c': Sfix(0.1, 2, -3),
            },
        'func2':
            {
                'o': 1,
                'loom': Sfix(1, 10, -10),
            }
    }
    dut = A()
    dut(15, Sfix(0.1, 2, -3))
    dut.func2(1)
    result = extract_locals(dut)
    assert result == expect


def test_locals_multifunc_nested():
    class A(HW):
        def func2(self, o):
            loom = Sfix(o, 10, -10)
            return 12

        def __call__(self, a, c):
            ret = self.func2(a)
            b = Sfix(0.1, 2, -3)

    expect = {
        '__call__':
            {
                'a': 15,
                'b': Sfix(0.1, 2, -3),
                'c': Sfix(0.1, 2, -3),
                'ret': 12
            },
        'func2':
            {
                'o': 15,
                'loom': Sfix(15, 10, -10),
            }
    }
    dut = A()
    dut(15, Sfix(0.1, 2, -3))
    result = extract_locals(dut)
    assert result == expect


def test_locals_multifunc_nested_complex():
    class A(HW):
        def func4(self, o):
            return o

        def func3(self):
            return True

        def func2(self, o):
            return self.func4(Sfix(o, 10, -10))

        def __call__(self, a, c):
            ret = self.func2(a)
            ret2 = self.func3()
            b = Sfix(0.1, 2, -3)

    expect = {
        '__call__':
            {
                'a': 15,
                'b': Sfix(0.1, 2, -3),
                'c': Sfix(0.1, 2, -3),
                'ret': Sfix(15, 10, -10),
                'ret2': True
            },
        'func2':
            {
                'o': 15,
            },
        'func3':
            {

            },
        'func4':
            {
                'o': Sfix(15, 10, -10),
            }
    }
    dut = A()
    dut(1, Sfix(0.1, 2, -3))
    dut(2, Sfix(1.1, 2, -3))
    dut(15, Sfix(0.1, 2, -3))
    result = extract_locals(dut)
    assert result == expect


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
