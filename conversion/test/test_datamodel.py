import pytest
from common.sfix import Sfix
from conversion.extract_datamodel import initial_values, persistent_locals2, extract_locals


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
    with pytest.raises(Exception):
        extract_locals(dut)


def test_function_local_call_bad_type():
    class A:
        @persistent_locals2
        def __call__(self):
            b = 20.5

    dut = A()
    dut()
    with pytest.raises(Exception):
        result = extract_locals(dut)


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
