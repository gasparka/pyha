import textwrap

import numpy as np
import pytest
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, fixed_truncate, fixed_wrap
from pyha.conversion.extract_datamodel import extract_datamodel, extract_locals, FunctionNotSimulated, \
    VariableNotConvertible


class TestDatamodel:
    def test_new_instance_resets(self):
        class A(HW):
            def __init__(self):
                self.a = Sfix(0.56)

            def main(self):
                self.a = Sfix(0.0, 0, -10)

        expect = {'a': Sfix(0.56, 0, -10)}
        dut = A()
        dut.main()
        dut._pyha_update_self()
        result = extract_datamodel(dut)
        assert result == expect

        # new instance shall have empty datamodel
        dut2 = A()
        result = extract_datamodel(dut2)
        expect = {'a': Sfix(0.56)}
        assert result == expect

    def test_sfix(self):
        class A(HW):
            def __init__(self):
                self.a = Sfix(0.56, 0, -10)

        expect = {'a': Sfix(0.56, 0, -10)}
        result = extract_datamodel(A())
        assert result == expect

    def test_sfix_lazy(self):
        class A(HW):
            def __init__(self):
                self.a = Sfix(0.56)

            def main(self):
                self.a = Sfix(0.0, 0, -10)

        expect = {'a': Sfix(0.56, 0, -10)}
        dut = A()
        dut.main()
        dut._pyha_update_self()

        result = extract_datamodel(dut)
        assert result == expect

    def test_sfix2(self):
        class A(HW):
            def __init__(self):
                self.a = Sfix(0.56, 0, -10)
                self.b = Sfix(-10, 8, -10)

            def main(self):
                pass

        expect = {'a': Sfix(0.56, 0, -10),
                  'b': Sfix(-10, 8, -10)}
        dut = A()
        dut.main()
        dut._pyha_update_self()

        result = extract_datamodel(dut)
        assert result == expect

    def test_sfix_round_style(self):
        class A(HW):
            def __init__(self):
                self.a = Sfix(0.56, 0, -10, round_style=fixed_truncate)

        expect = {'a': Sfix(0.56, 0, -10, round_style=fixed_truncate)}
        result = extract_datamodel(A())
        assert result == expect


    def test_sfix_overflow_style(self):
        class A(HW):
            def __init__(self):
                self.a = Sfix(0.56, 0, -10, overflow_style=fixed_wrap)

        expect = {'a': Sfix(0.56, 0, -10, overflow_style=fixed_wrap)}
        result = extract_datamodel(A())
        assert result == expect


    def test_sfix_list(self):
        class A(HW):
            def __init__(self):
                self.b = [Sfix(-10, 8, -10)] * 10

        expect = {'b': [Sfix(-10, 8, -10)] * 10}
        result = extract_datamodel(A())
        assert result == expect

    def test_sfix_list_lazy(self):
        class A(HW):
            def __init__(self):
                self.b = [Sfix(-1.4), Sfix(2.5), Sfix(-0.52)]

            def main(self):
                self.b = [Sfix(0.0, 2, -18), Sfix(0.0, 2, -18), Sfix(0.0, 2, -18)]

        expect = {'b': [Sfix(-1.4, 2, -18), Sfix(2.5, 2, -18), Sfix(-0.52, 2, -18)]}

        dut = A()
        dut.main()
        dut._pyha_update_self()

        result = extract_datamodel(dut)
        assert result == expect

    def test_int(self):
        class A(HW):
            def __init__(self):
                self.a = 20

            def main(self):
                self.a = 162

        expect = {'a': 20}

        dut = A()
        dut.main()
        dut._pyha_update_self()

        result = extract_datamodel(dut)
        assert result == expect

    def test_int_list(self):
        class A(HW):
            def __init__(self):
                self.b = [0] * 10

            def main(self):
                self.b = [25] * 10

        expect = {'b': [0] * 10}
        dut = A()
        dut.main()
        dut._pyha_update_self()

        result = extract_datamodel(dut)
        assert result == expect

    def test_bool(self):
        class A(HW):
            def __init__(self):
                self.b = True

            def main(self):
                self.b = False

        expect = {'b': True}
        dut = A()
        dut.main()
        dut._pyha_update_self()

        result = extract_datamodel(dut)
        assert result == expect

    def test_bool_list(self):
        class A(HW):
            def __init__(self):
                self.b = [True, False]

            def main(self):
                self.b = [False, False]

        expect = {'b': [True, False]}
        dut = A()
        dut.main()
        dut._pyha_update_self()

        result = extract_datamodel(dut)
        assert result == expect

    def test_reject_float(self):
        class A(HW):
            def __init__(self):
                self.b = 0.5

            def main(self):
                pass

        expect = {}
        dut = A()
        dut.main()
        dut._pyha_update_self()

        result = extract_datamodel(dut)
        assert result == expect

    def test_reject_numpy(self):
        class A(HW):
            def __init__(self):
                self.b = np.array([1, 2, 3])

            def main(self):
                pass

        expect = {}
        dut = A()
        dut.main()
        dut._pyha_update_self()

        result = extract_datamodel(dut)
        assert result == expect

    def test_mixed(self):
        class A(HW):
            def __init__(self):
                self.inte = 20
                self.fix = [Sfix(-10, 8, -10)] * 10
                self.a = {'a': 'tere', 25: 'tore'}
                self.lol = 0.5
                self.b = np.array([1, 2, 3])
                self.c = self.b.tolist()

            def main(self, *args, **kwargs):
                self.c = [3, 3, 3]

        expect = {'inte': 20, 'fix': [Sfix(-10, 8, -10)] * 10, 'c': [1, 2, 3]}
        dut = A()
        dut.main()
        dut._pyha_update_self()

        result = extract_datamodel(dut)
        assert result == expect

    def test_submodule(self):
        class A(HW):
            def __init__(self):
                self.reg = 0

            def main(self, *args, **kwargs):
                pass

        class B(HW):
            def __init__(self):
                self.submodule = A()

            def main(self, *args, **kwargs):
                pass

        dut = B()
        dut.main()
        dut._pyha_update_self()

        result = extract_datamodel(dut)
        assert len(result) == 1
        assert type(result['submodule']) == A


class TestLocals:
    def test_(self):
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
        dut._pyha_update_self()

        result = extract_locals(dut)
        assert result == expect

    def test_new_instance_resets(self):
        class A(HW):
            def main(self, v):
                b = v

        expect = {
            'main':
                {
                    'b': 20,
                    'v': 20
                }
        }
        dut = A()
        dut.main(20)
        dut._pyha_update_self()

        result = extract_locals(dut)
        assert result == expect

        dut2 = A()
        with pytest.raises(FunctionNotSimulated):
            extract_locals(dut2)

    def test_special(self):
        class A(HW):
            def main(self):
                b = 20

        expect = {
            'main':
                {
                    'b': 20
                }
        }
        dut = A()
        dut.main()
        dut._pyha_update_self()

        result = extract_locals(dut)
        assert result == expect

    def test_skips_init(self):
        class A(HW):
            def __init__(self):
                self.a = 15

            def main(self):
                b = 1

        expect = {
            'main':
                {
                    'b': 1
                }
        }
        dut = A()
        dut.main()
        dut._pyha_update_self()

        result = extract_locals(dut)
        assert result == expect

    def test_special_clock_tick(self):
        class A(HW):
            def __init__(self):
                self.a = 15

            def main(self, b):
                self.a = b

        expect = {
            'main':
                {
                    'b': 2
                }
        }
        dut = A()
        dut.main(1)
        assert dut.a == 15
        assert dut.next.a == 1
        dut._pyha_update_self()

        dut.main(2)
        assert dut.a == 1
        assert dut.next.a == 2
        dut._pyha_update_self()

        result = extract_locals(dut)
        assert result == expect

    def test_call_nosim_raises(self):
        class A(HW):
            def main(self):
                b = 20

        dut = A()
        with pytest.raises(FunctionNotSimulated):
            extract_locals(dut)

    def test_call_bad_type_raises(self):
        class A(HW):
            def main(self):
                b = 20.5

        expect = textwrap.dedent("""\
                Variable not convertable!
                Class: A
                Function: main
                Variable: b
                Value: <class 'float'>:20.5""")
        dut = A()
        dut.main()
        dut._pyha_update_self()

        with pytest.raises(VariableNotConvertible) as e:
            result = extract_locals(dut)

        assert str(e.value) == expect

    def test_calls(self):
        class A(HW):
            def main(self):
                b = Sfix(0.1, 2, -3)
                return 123, 0.4

        dut = A()
        dut.main()
        dut._pyha_update_self()

        assert dut.main.calls == 1
        dut.main()
        dut._pyha_update_self()

        assert dut.main.calls == 2

    def test_sfix(self):
        class A(HW):
            def main(self):
                b = Sfix(0.1, 2, -3)

        expect = {
            'main':
                {
                    'b': Sfix(0.1, 2, -3)
                }
        }
        dut = A()
        dut.main()
        dut._pyha_update_self()

        result = extract_locals(dut)
        assert result == expect

    def test_boolean(self):
        class A(HW):
            def main(self):
                b = True

        expect = {
            'main':
                {
                    'b': True
                }
        }
        dut = A()
        dut.main()
        dut._pyha_update_self()

        result = extract_locals(dut)
        assert result == expect

    def test_arguments(self):
        class A(HW):
            def main(self, a, c):
                b = Sfix(0.1, 2, -3)

        expect = {
            'main':
                {
                    'a': 15,
                    'b': Sfix(0.1, 2, -3),
                    'c': Sfix(0.1, 2, -3),
                }
        }
        dut = A()
        dut.main(15, Sfix(0.1, 2, -3))
        dut._pyha_update_self()

        result = extract_locals(dut)
        assert result == expect

    def test_conditional(self):
        class A(HW):
            def main(self, condition):
                if condition:
                    iflocal = 128

        expect = {
            'main':
                {
                    'condition': False,
                    'iflocal': 128
                }
        }
        dut = A()
        dut.main(True)
        dut.main(False)
        dut._pyha_update_self()

        result = extract_locals(dut)
        assert result == expect

    # def test_consistent_call_multitype_raises(self):
    #     # var should always be same type
    #     class A(HW):
    #         def main(self, condition):
    #             if condition:
    #                 iflocal = 128
    #             else:
    #                 iflocal = True
    #
    #     dut = A()
    #     dut.main(True)
    #     dut._pyha_update_self()
    #
    #     with pytest.raises(TypeNotConsistent) as e:
    #         dut.main(False)
    #
    #         # cant test text cause locals discovery order can vary

    def test_multitype_sfix(self):
        # valid if bounds are the same
        class A(HW):
            def main(self, condition):
                if condition:
                    iflocal = Sfix(1.2, 12, -15)
                else:
                    iflocal = Sfix(0.0, 12, -15)

        expect = {
            'main':
                {
                    'condition': False,
                    'iflocal': Sfix(0.0, 12, -15)
                }
        }
        dut = A()
        dut.main(True)
        dut.main(False)
        dut._pyha_update_self()

        result = extract_locals(dut)
        assert result == expect

    # def test_consistent_multitype_sfix_raises(self):
    #     class A(HW):
    #         def main(self, condition):
    #             if condition:
    #                 iflocal = Sfix(1.2, 1, -15)
    #             else:
    #                 iflocal = Sfix(0.0, 12, -1)
    #
    #     dut = A()
    #     dut.main(True)
    #     dut._pyha_update_self()
    #
    #     with pytest.raises(TypeNotConsistent):
    #         dut.main(False)

    def test_multifunc(self):
        class A(HW):
            def func2(self, o):
                loom = Sfix(o, 10, -10)
                return 12

            def main(self, a, c):
                b = Sfix(0.1, 2, -3)

        expect = {
            'main':
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
        dut.main(15, Sfix(0.1, 2, -3))
        dut.func2(1)
        dut._pyha_update_self()

        result = extract_locals(dut)
        assert result == expect

    def test_multifunc_nested(self):
        class A(HW):
            def func2(self, o):
                loom = Sfix(o, 10, -10)
                return 12

            def main(self, a, c):
                ret = self.func2(a)
                b = Sfix(0.1, 2, -3)

        expect = {
            'main':
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
        dut.main(15, Sfix(0.1, 2, -3))
        dut._pyha_update_self()

        result = extract_locals(dut)
        assert result == expect

    def test_multifunc_nested_complex(self):
        class A(HW):
            def func4(self, o):
                return o

            def func3(self):
                return True

            def func2(self, o):
                return self.func4(Sfix(o, 10, -10))

            def main(self, a, c):
                ret = self.func2(a)
                ret2 = self.func3()
                b = Sfix(0.1, 2, -3)

        expect = {
            'main':
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
        dut.main(1, Sfix(0.1, 2, -3))
        dut.main(2, Sfix(1.1, 2, -3))
        dut.main(15, Sfix(0.1, 2, -3))
        dut._pyha_update_self()

        result = extract_locals(dut)
        assert result == expect
