import pytest
from common.sfix import Sfix
from conversion.extract_datamodel import initial_values, persistent_locals2, extract_locals, VariableMultipleTypes, \
    VariableNotConvertable, FunctionNotSimulated


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
            self.b = Sfix(-10, 2, -10)

    expect = {'a': Sfix(0.56, 0, -10),
              'b': Sfix(-10, 2, -10)}
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
            self.b = Sfix(-10, 2, -10)

    expect = {'a': 20,
              'b': Sfix(-10, 2, -10)}
    result = initial_values(A())
    assert result == expect


def test_initial_value_sfix_list():
    class A:
        def __init__(self):
            self.b = [Sfix(-10, 2, -10)] * 10

    expect = {'b': [Sfix(-10, 2, -10)] * 10}
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


class ExceptionHapy(Exception):
    pass


def test_initial_value_mixed():
    import numpy as np
    class A:
        def __init__(self):
            self.inte = 20
            self.fix = [Sfix(-10, 2, -10)] * 10
            self.a = {'a': 'tere', 25: 'tore'}
            self.lol = 0.5
            self.b = np.array([1, 2, 3])

    expect = {'inte': 20, 'fix': [Sfix(-10, 2, -10)] * 10}
    result = initial_values(A())
    assert result == expect


def test_function_local_call_nosim():
    class A:
        @persistent_locals2
        def __call__(self):
            b = 20

    dut = A()
    with pytest.raises(FunctionNotSimulated):
        extract_locals(dut)


def test_function_local_call_bad_type():
    class A:
        @persistent_locals2
        def __call__(self):
            b = 20.5

    dut = A()
    dut()
    with pytest.raises(VariableNotConvertable):
        result = extract_locals(dut)


def test_function_local_count():
    class A:
        @persistent_locals2
        def __call__(self):
            b = Sfix(0.1, 2, 3)
            return 123, 0.4

    dut = A()
    dut()
    assert dut.__call__._call_count == 1
    dut()
    assert dut.__call__._call_count == 2


def test_function_local_call():
    class A:
        @persistent_locals2
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


def test_function_local_call_sfix():
    class A:
        @persistent_locals2
        def __call__(self):
            b = Sfix(0.1, 2, 3)

    expect = {
        '__call__':
            {
                'b': Sfix(0.1, 2, 3)
            }
    }
    dut = A()
    dut()
    result = extract_locals(dut)
    assert result == expect


def test_function_local_call_boolean():
    class A:
        @persistent_locals2
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


def test_function_local_call_arguments():
    class A:
        @persistent_locals2
        def __call__(self, a, c):
            b = Sfix(0.1, 2, 3)

    expect = {
        '__call__':
            {
                'a': 15,
                'b': Sfix(0.1, 2, 3),
                'c': Sfix(0.1, 2, 3),
            }
    }
    dut = A()
    dut(15, Sfix(0.1, 2, 3))
    result = extract_locals(dut)
    assert result == expect


def test_function_local_call_iflocal():
    class A:
        @persistent_locals2
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


def test_function_local_call_twotype():
    # var should always be same type
    class A:
        @persistent_locals2
        def __call__(self, condition):
            if condition:
                iflocal = 128
            else:
                iflocal = True

    dut = A()
    dut(True)
    dut(False)
    with pytest.raises(VariableMultipleTypes):
        result = extract_locals(dut)


def test_function_multifunc():
    class A:
        @persistent_locals2
        def func2(self, o):
            loom = Sfix(o, 10, -10)
            return 12

        @persistent_locals2
        def __call__(self, a, c):
            b = Sfix(0.1, 2, 3)

    expect = {
        '__call__':
            {
                'a': 15,
                'b': Sfix(0.1, 2, 3),
                'c': Sfix(0.1, 2, 3),
            },
        'func2':
            {
                'o': 1,
                'loom': Sfix(1, 10, -10),
            }
    }
    dut = A()
    dut(15, Sfix(0.1, 2, 3))
    dut.func2(1)
    result = extract_locals(dut)
    assert result == expect
