import textwrap

import pytest
from common.hwsim import HW, TypeNotConsistent
from common.sfix import Sfix
from conversion.extract_datamodel import extract_datamodel, extract_locals, VariableNotConvertable, FunctionNotSimulated


def test_datamodel_sfix():
    class A(HW):
        def __init__(self):
            self.a = Sfix(0.56, 0, -10)

    expect = {'a': Sfix(0.56, 0, -10)}
    result = extract_datamodel(A())
    assert result == expect


def test_datamodel_sfix_lazy():
    class A(HW):
        def __init__(self):
            self.a = Sfix(0.56)

        def __call__(self):
            self.next.a = Sfix(0.0, 0, -10)

    expect = {'a': Sfix(0.56, 0, -10)}
    dut = A()
    dut()
    result = extract_datamodel(dut)
    assert result == expect


def test_datamodel_sfix2():
    class A(HW):
        def __init__(self):
            self.a = Sfix(0.56, 0, -10)
            self.b = Sfix(-10, 8, -10)

        def __call__(self):
            pass

    expect = {'a': Sfix(0.56, 0, -10),
              'b': Sfix(-10, 8, -10)}
    dut = A()
    dut()
    result = extract_datamodel(dut)
    assert result == expect


def test_datamodel_sfix_list():
    class A(HW):
        def __init__(self):
            self.b = [Sfix(-10, 8, -10)] * 10

    expect = {'b': [Sfix(-10, 8, -10)] * 10}
    result = extract_datamodel(A())
    assert result == expect


def test_datamodel_sfix_list_lazy():
    class A(HW):
        def __init__(self):
            self.b = [Sfix(-1.4), Sfix(2.5), Sfix(-0.52)]

        def __call__(self):
            self.next.b = [Sfix(0.0, 2, -18), Sfix(0.0, 2, -18), Sfix(0.0, 2, -18)]

    expect = {'b': [Sfix(-1.4, 2, -18), Sfix(2.5, 2, -18), Sfix(-0.52, 2, -18)]}

    dut = A()
    dut()
    result = extract_datamodel(dut)
    assert result == expect


def test_datamodel_int():
    class A(HW):
        def __init__(self):
            self.a = 20

        def __call__(self):
            self.next.a = 162

    expect = {'a': 20}

    dut = A()
    dut()
    dut()
    result = extract_datamodel(dut)
    assert result == expect


def test_datamodel_int_list():
    class A(HW):
        def __init__(self):
            self.b = [0] * 10

        def __call__(self):
            self.next.b = [25] * 10

    expect = {'b': [0] * 10}
    dut = A()
    dut()
    result = extract_datamodel(dut)
    assert result == expect


def test_datamodel_bool():
    class A(HW):
        def __init__(self):
            self.b = True

        def __call__(self):
            self.next.b = False

    expect = {'b': True}
    dut = A()
    dut()
    result = extract_datamodel(dut)
    assert result == expect


def test_datamodel_bool_list():
    class A(HW):
        def __init__(self):
            self.b = [True, False]

        def __call__(self):
            self.next.b = [False, False]

    expect = {'b': [True, False]}
    dut = A()
    dut()
    result = extract_datamodel(dut)
    assert result == expect


def test_datamodel_reject_flaot():
    class A(HW):
        def __init__(self):
            self.b = 0.5

        def __call__(self):
            pass

    expect = {}
    dut = A()
    dut()
    result = extract_datamodel(dut)
    assert result == expect


def test_datamodel_reject_numpy():
    import numpy as np
    class A(HW):
        def __init__(self):
            self.b = np.array([1, 2, 3])

        def __call__(self):
            pass

    expect = {}
    dut = A()
    dut()
    result = extract_datamodel(dut)
    assert result == expect


def test_datamodel_mixed():
    import numpy as np
    class A(HW):
        def __init__(self):
            self.inte = 20
            self.fix = [Sfix(-10, 8, -10)] * 10
            self.a = {'a': 'tere', 25: 'tore'}
            self.lol = 0.5
            self.b = np.array([1, 2, 3])
            self.c = self.b.tolist()

        def __call__(self, *args, **kwargs):
            self.next.c = [3, 3, 3]

    expect = {'inte': 20, 'fix': [Sfix(-10, 8, -10)] * 10, 'c': [1, 2, 3]}
    dut = A()
    dut()
    result = extract_datamodel(dut)
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
