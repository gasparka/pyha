""" Conversion tests that mostly base on redbaron preprocessing """
import textwrap
from enum import Enum

import pytest
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, fixed_truncate, fixed_wrap, fixed_round, fixed_saturate, ComplexSfix
from pyha.conversion.conversion import get_objects_rednode
from pyha.conversion.converter import redbaron_pycall_to_vhdl, redbaron_pycall_returns_to_vhdl, redbaron_pyfor_to_vhdl, \
    convert, AutoResize, ImplicitNext
from pyha.conversion.coupling import VHDLType
from pyha.conversion.extract_datamodel import DataModel
from redbaron import RedBaron


def test_redbaron_call_simple():
    x = 'a(a)'
    expect = 'a(a)'
    y = redbaron_pycall_to_vhdl(RedBaron(x)[0])
    assert expect == y.dumps()

    x = 'self.d(a)'
    expect = 'd(self, a)'
    y = redbaron_pycall_to_vhdl(RedBaron(x)[0])
    assert expect == y.dumps()

    x = 'self.moving_average.main(x)'
    expect = 'unknown_type.main(self.moving_average, x)'
    y = redbaron_pycall_to_vhdl(RedBaron(x)[0])
    assert expect == y.dumps()


def test_redbaron_call_returns():
    # this is redbadon based transform
    x = 'b = self.a(a)'
    expect = 'self.a(a, ret_0=b)'
    y = redbaron_pycall_returns_to_vhdl(RedBaron(x)[0])
    assert expect == y.dumps()

    x = 'b = resize(a)'
    expect = 'b = resize(a)'
    y = redbaron_pycall_returns_to_vhdl(RedBaron(x)[0])
    assert expect == y.dumps()

    x = 'b = self.a(self.a)'
    expect = 'self.a(self.a, ret_0=b)'
    y = redbaron_pycall_returns_to_vhdl(RedBaron(x)[0])
    assert expect == y.dumps()

    x = 'self.b = self.a(self.a)'
    expect = 'self.a(self.a, ret_0=self.b)'
    y = redbaron_pycall_returns_to_vhdl(RedBaron(x)[0])
    assert expect == y.dumps()

    x = 'self.b = self.a(self.a)'
    expect = 'self.a(self.a, ret_0=self.b)'
    y = redbaron_pycall_returns_to_vhdl(RedBaron(x)[0])
    assert expect == y.dumps()

    x = 'self.b[0], self.b[1] = self.a(self.a)'
    expect = 'self.a(self.a, ret_0=self.b[0], ret_1=self.b[1])'
    y = redbaron_pycall_returns_to_vhdl(RedBaron(x)[0])
    assert expect == y.dumps()


def test_redbaron_for():
    code = textwrap.dedent("""\
            for x in arr:
                x.main()""")
    expect = textwrap.dedent("""\
            for _i_ in arr:
                arr[_i_].main()
                """)

    y = redbaron_pyfor_to_vhdl(RedBaron(code)[0])
    assert expect == y.dumps()


def test_redbaron_for2():
    code = textwrap.dedent("""\
            for itm in lol:
                l = a + itm
                caller(itm)""")

    expect = textwrap.dedent("""\
            for _i_ in lol:
                l = a + lol[_i_]
                caller(lol[_i_])
                """)

    y = redbaron_pyfor_to_vhdl(RedBaron(code)[0])
    assert expect == y.dumps()


@pytest.fixture
def converter():
    class Conv:
        def __call__(self, code, datamodel=None):
            red = RedBaron(code)
            return convert(red[0], self, datamodel)

    return Conv()


def test_convert_call(converter):
    code = textwrap.dedent("""\
            def a():
                self.moving_average.main(x)
                """)
    expect = textwrap.dedent("""\

        procedure a is

        begin
            unknown_type.main(self.moving_average, x);
        end procedure;""")

    conv = converter(code)
    assert expect == str(conv)


def test_convert_call2(converter):
    code = textwrap.dedent("""\
            self.d()
            """)

    expect = textwrap.dedent("""\
            d(self);""")

    conv = converter(code)
    assert expect == str(conv)


def test_convert_call_returns(converter):
    code = textwrap.dedent("""\
                b = self.d()
                """)

    expect = textwrap.dedent("""\
            d(self, ret_0=>b);""")

    conv = converter(code)
    assert expect == str(conv)


def test_convert_call_returns_multi(converter):
    code = textwrap.dedent("""\
                b, self.a = self.d()
                """)

    expect = textwrap.dedent("""\
            d(self, ret_0=>b, ret_1=>self.a);""")

    conv = converter(code)
    assert expect == str(conv)


def test_typed_def_call_submod_self(converter):
    code = textwrap.dedent("""\
        def a(b):
            self.submod.main(b)""")

    class D(HW):
        pass

    datamodel = DataModel(
        self_data={'submod': D()},
        locals={'a': {'b': True, 'c': True}})
    expect = textwrap.dedent("""\

        procedure a(b: boolean) is

        begin
            D_0.main(self.submod, b);
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_call_submod_self_next(converter):
    code = textwrap.dedent("""\
        def a(b):
            self.submod.main(b)""")

    class D(HW):
        pass

    datamodel = DataModel(
        self_data={'submod': D()},
        locals={'a': {'b': True, 'c': True}})
    expect = textwrap.dedent("""\

        procedure a(b: boolean) is

        begin
            D_0.main(self.submod, b);
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_call_submod_returns_local(converter):
    code = textwrap.dedent("""\
        def a(b):
            c = self.submod.main(b)""")

    class D(HW):
        pass

    datamodel = DataModel(
        self_data={'submod': D()},
        locals={'a': {'b': True, 'c': True}})
    expect = textwrap.dedent("""\

        procedure a(b: boolean) is
            variable c: boolean;
        begin
            D_0.main(self.submod, b, ret_0=>c);
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_call_submod_returns_self(converter):
    code = textwrap.dedent("""\
        def a(b):
            self.c = self.submod.main(b)""")

    class D(HW):
        pass

    datamodel = DataModel(
        self_data={'submod': D()},
        locals={'a': {'b': True, 'c': True}})
    expect = textwrap.dedent("""\

        procedure a(b: boolean) is

        begin
            D_0.main(self.submod, b, ret_0=>self.\\next\\.c);
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_convert_for(converter):
    code = textwrap.dedent("""\
            for item in cool_array:
                b = a + item
                self.func(item)""")

    expect = textwrap.dedent("""\
            for \\_i_\\ in cool_array'range loop
                b := a + cool_array(\\_i_\\);
                func(self, cool_array(\\_i_\\));
            end loop;""")
    conv = converter(code)
    assert expect == str(conv)


def test_for_redbaron_self(converter):
    code = textwrap.dedent("""\
            def f():
                for x in self.arr:
                    a = x""")

    datamodel = DataModel(locals={'f': {'a': 1}},
                          self_data={'arr': [1, 2, 3]})
    expect = textwrap.dedent("""\

        procedure f is
            variable a: integer;
        begin
            for \\_i_\\ in self.arr'range loop
                a := self.arr(\\_i_\\);
            end loop;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_for_call(converter):
    code = textwrap.dedent("""\
            def f():
                for x in self.arr:
                    x.call()""")

    class D(HW):
        pass

    datamodel = DataModel(locals={}, self_data={'arr': [D(), D()]})
    expect = textwrap.dedent("""\

        procedure f is

        begin
            for \\_i_\\ in self.arr'range loop
                D_0.call(self.arr(\\_i_\\));
            end loop;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_for_call_return(converter):
    code = textwrap.dedent("""\
            def f():
                for x in self.arr:
                    a = x.call()""")

    class D(HW):
        pass

    datamodel = DataModel(locals={'f': {'a': 1}}, self_data={'arr': [D(), D()]})
    expect = textwrap.dedent("""\

        procedure f is
            variable a: integer;
        begin
            for \\_i_\\ in self.arr'range loop
                D_0.call(self.arr(\\_i_\\), ret_0=>a);
            end loop;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_for_call_return_multi(converter):
    code = textwrap.dedent("""\
            def f():
                for x in self.arr:
                    a, b = x.call()""")

    class D(HW):
        pass

    datamodel = DataModel(locals={'f': {'a': 1, 'b': False}}, self_data={'arr': [D(), D()]})
    expect = textwrap.dedent("""\

        procedure f is
            variable a: integer;
            variable b: boolean;
        begin
            for \\_i_\\ in self.arr'range loop
                D_0.call(self.arr(\\_i_\\), ret_0=>a, ret_1=>b);
            end loop;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_var(converter):
    code = textwrap.dedent("""\
        def b():
            outs = [0, 0, 0, 0]
            outs[i] = 1""")

    class D(HW):
        pass

    datamodel = DataModel(locals={'b': {'outs': [0, 0, 0, 0]}},
                          self_data={'arr': [D(), D()]})
    expect = textwrap.dedent("""\

        procedure b is
            variable outs: integer_list_t(0 to 3);
        begin
            outs := (0, 0, 0, 0);
            outs(i) := 1;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_var_call(converter):
    code = textwrap.dedent("""\
        def b():
            outs = [0, 0, 0, 0]
            outs[i] = self.arr[i].main()""")

    class D(HW):
        pass

    datamodel = DataModel(locals={'b': {'outs': [0, 0, 0, 0]}},
                          self_data={'arr': [D(), D()]})
    expect = textwrap.dedent("""\

        procedure b is
            variable outs: integer_list_t(0 to 3);
        begin
            outs := (0, 0, 0, 0);
            D_0.main(self.arr(i), ret_0=>outs(i));
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_var_call_tuple(converter):
    code = textwrap.dedent("""\
        def b():
            outs = [0, 0, 0, 0]
            outs[i], outs[i+1], b = self.arr[i].main()""")

    class D(HW):
        pass

    datamodel = DataModel(locals={'b': {'outs': [0, 0, 0, 0], 'b': False}},
                          self_data={'arr': [D(), D()]})
    expect = textwrap.dedent("""\

        procedure b is
            variable outs: integer_list_t(0 to 3);
            variable b: boolean;
        begin
            outs := (0, 0, 0, 0);
            D_0.main(self.arr(i), ret_0=>outs(i), ret_1=>outs(i + 1), ret_2=>b);
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_for_combined(converter):
    code = textwrap.dedent("""\
        def b():
            outs = [0, 0, 0, 0]
            for i in range(len(self.arr)):
                outs[i] = self.arr[i].main(x)

            return outs[0]""")

    class D(HW):
        pass

    datamodel = DataModel(locals={'b': {'outs': [0, 0, 0, 0]}},
                          self_data={'arr': [D(), D()]})
    expect = textwrap.dedent("""\

        procedure b(ret_0:out integer) is
            variable outs: integer_list_t(0 to 3);
        begin
            outs := (0, 0, 0, 0);
            for i in self.arr'range loop
                D_0.main(self.arr(i), x, ret_0=>outs(i));

            end loop;
            ret_0 := outs(0);
            return;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_enum_local_var_assign(converter):
    class EnumType(Enum):
        ENUMVALUE = 0

    code = textwrap.dedent("""\
        def f():
            a = EnumType.ENUMVALUE""")

    datamodel = DataModel(locals={'f': {'a': EnumType.ENUMVALUE}},
                          self_data={})

    expect = textwrap.dedent("""\

        procedure f is
            variable a: EnumType;
        begin
            a := ENUMVALUE;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_enum_self_var_assign(converter):
    class EnumType(Enum):
        ENUMVALUE = 0

    code = textwrap.dedent("""\
        def f():
            self.a = EnumType.ENUMVALUE""")

    datamodel = DataModel(locals={},
                          self_data={'a': EnumType.ENUMVALUE})

    expect = textwrap.dedent("""\

        procedure f is

        begin
            self.\\next\\.a := ENUMVALUE;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_enum_in_if(converter):
    class EnumType(Enum):
        ENUMVALUE = 0

    code = textwrap.dedent("""\
        def f():
            if a == EnumType.ENUMVALUE:
                b""")

    datamodel = DataModel(locals={'f': {'c': EnumType.ENUMVALUE}},
                          self_data={})

    expect = textwrap.dedent("""\

        procedure f is

        begin
            if a = ENUMVALUE then
                b
            end if;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


class TestAutoResize:
    def setup_class(self):
        class T1(HW):
            def __init__(self):
                self.int_reg = 0
                self.sfix_reg = Sfix(0.1, 2, -19, round_style=fixed_truncate)

        class T0(HW):
            def __init__(self):
                self.int_reg = 0
                self.complex_reg = ComplexSfix(2.5 + 2.5j, 5, -29, overflow_style=fixed_wrap)
                self.sfix_reg = Sfix(2.5, 5, -29, overflow_style=fixed_wrap)
                self.submod_reg = T1()

                self.sfix_list = [Sfix()] * 2
                self.int_list = [0] * 2

                self.submod_list = [T1(), T1()]

            def main(self, a):
                # not subjects to resize conversion
                # some may be rejected due to type
                self.int_reg = a
                self.complex_reg = ComplexSfix(0.45 + 0.88j)
                b = self.sfix_reg
                self.submod_reg.int_reg = a
                self.int_list[0] = a
                self.submod_list[1].int_reg = a
                c = self.submod_list[1].sfix_reg

                # subjects
                self.sfix_reg = a
                self.submod_reg.sfix_reg = a
                self.sfix_list[0] = a
                self.submod_list[1].sfix_reg = a
                self.complex_reg.real = a
                self.complex_reg.imag = a

        self.dut = T0()
        self.dut.main(Sfix(0))
        self.red_node = get_objects_rednode(self.dut)
        f = self.red_node.find('def', name='__init__')
        f.parent.remove(f)
        self.datamodel = DataModel(self.dut)
        VHDLType.set_datamodel(self.datamodel)

    def test_find(self):
        """ Test all assignments that could be potential subjects, has no type info """
        expect = [
                  'self.int_reg = a',
                 'self.complex_reg = ComplexSfix(0.45 + 0.88j)',
                  'self.submod_reg.int_reg = a',
                  'self.int_list[0] = a',
                  'self.submod_list[1].int_reg = a',
                  'self.sfix_reg = a',
                  'self.submod_reg.sfix_reg = a',
                  'self.sfix_list[0] = a',
                  'self.submod_list[1].sfix_reg = a',
                  'self.complex_reg.real = a',
                  'self.complex_reg.imag = a']

        out = [str(x) for x in AutoResize.find(self.red_node)]
        assert out == expect

    def test_filter(self):
        """ Subjects shall be of Sfix type """
        expect_nodes = ['self.sfix_reg = a',
                        'self.submod_reg.sfix_reg = a',
                        'self.sfix_list[0] = a',
                        'self.submod_list[1].sfix_reg = a',
                        'self.complex_reg.real = a',
                        'self.complex_reg.imag = a'
                        ]

        expect_types = [Sfix(2.5, 5, -29, overflow_style=fixed_wrap, round_style=fixed_round),
                        Sfix(0.1, 2, -19, overflow_style=fixed_saturate, round_style=fixed_truncate),
                        Sfix(0, overflow_style=fixed_saturate, round_style=fixed_round),
                        Sfix(0.1, 2, -19, overflow_style=fixed_saturate, round_style=fixed_truncate),
                        Sfix(2.5, 5, -29, overflow_style=fixed_wrap),
                        Sfix(2.5, 5, -29, overflow_style=fixed_wrap)]

        nodes = AutoResize.find(self.red_node)
        passed_nodes, passed_types = AutoResize.filter(nodes)

        assert expect_nodes == [str(x) for x in passed_nodes]
        assert expect_types == passed_types

    def test_apply(self):
        expect_nodes = ['self.sfix_reg = resize(a, 5, -29, fixed_wrap, fixed_round)',
                        'self.submod_reg.sfix_reg = resize(a, 2, -19, fixed_saturate, fixed_truncate)',
                        'self.sfix_list[0] = resize(a, None, None, fixed_saturate, fixed_round)',
                        'self.submod_list[1].sfix_reg = resize(a, 2, -19, fixed_saturate, fixed_truncate)',
                        'self.complex_reg.real = resize(a, 5, -29, fixed_wrap, fixed_round)',
                        'self.complex_reg.imag = resize(a, 5, -29, fixed_wrap, fixed_round)'
                        ]

        nodes = AutoResize.apply(self.red_node)
        assert expect_nodes == [str(x) for x in nodes]


# todo:
# * Default round style to truncate -> what to do with initial values??
# * auto resize on function calls that return to self.next ??
# * what if is already resized??



class TestImplicitNext:
    def test_basic(self):
        code = 'self.a = 1'
        expect = 'self.next.a = 1'

        red = RedBaron(code)
        ImplicitNext.apply(red)
        assert red.dumps() == expect

    def test_list(self):
        code = 'self.a[i] = 1'
        expect = 'self.next.a[i] = 1'

        red = RedBaron(code)
        ImplicitNext.apply(red)
        assert red.dumps() == expect

    def test_submod(self):
        code = 'self.submod.a = 1'
        expect = 'self.submod.next.a = 1'

        red = RedBaron(code)
        ImplicitNext.apply(red)
        assert red.dumps() == expect

    def test_submod_list(self):
        code = 'self.submod.a[i].b = 1'
        expect = 'self.submod.a[i].next.b = 1'

        red = RedBaron(code)
        ImplicitNext.apply(red)
        assert red.dumps() == expect

    def test_call(self):
        code = 'self.a = self.call()'
        expect = 'self.next.a = self.call()'

        red = RedBaron(code)
        ImplicitNext.apply(red)
        assert red.dumps() == expect


    def test_call_multi_return(self):
        code = 'self.a, self.b[i], local = self.call()'
        expect = 'self.next.a, self.next.b[i], local = self.call()'

        red = RedBaron(code)
        ImplicitNext.apply(red)
        assert red.dumps() == expect

    def test_non_target(self):
        code = 'b.self.a = 1'
        expect = 'b.self.a = 1'

        red = RedBaron(code)
        ImplicitNext.apply(red)
        assert red.dumps() == expect
