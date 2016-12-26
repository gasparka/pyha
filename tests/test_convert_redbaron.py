""" Conversion tests that mostly base on redbaron preprocessing """
import textwrap

import pytest
from redbaron import RedBaron

from pyha.common.hwsim import HW
from pyha.conversion.converter import redbaron_pycall_to_vhdl, redbaron_pycall_returns_to_vhdl, redbaron_pyfor_to_vhdl, \
    convert
from pyha.conversion.extract_datamodel import DataModel


def test_redbaron_call_simple():
    # x = 'a(a)'
    # expect = 'a(a)'
    # y = redbaron_pycall_to_vhdl(RedBaron(x)[0])
    # assert expect == y.dumps()
    #
    # x = 'self.d(a)'
    # expect = 'd(self, a)'
    # y = redbaron_pycall_to_vhdl(RedBaron(x)[0])
    # assert expect == y.dumps()

    x = 'self.next.moving_average.main(x)'
    expect = 'unknown_type.main(self.next.moving_average, x)'
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

    x = 'self.next.b = self.a(self.a)'
    expect = 'self.a(self.a, ret_0=self.next.b)'
    y = redbaron_pycall_returns_to_vhdl(RedBaron(x)[0])
    assert expect == y.dumps()

    x = 'self.next.b[0], self.next.b[1] = self.a(self.a)'
    expect = 'self.a(self.a, ret_0=self.next.b[0], ret_1=self.next.b[1])'
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
                self.next.moving_average.main(x)
                """)
    expect = textwrap.dedent("""\
        procedure a is

        begin
            unknown_type.main(self.\\next\\.moving_average, x);
        end procedure;""")

    conv = converter(code)
    assert expect == str(conv)


def test_convert_call2(converter):
    code = textwrap.dedent("""\
            self.next.d()
            """)

    expect = textwrap.dedent("""\
            d(self.\\next\\);""")

    conv = converter(code)
    assert expect == str(conv)


def test_convert_call_returns(converter):
    code = textwrap.dedent("""\
                b = self.next.d()
                """)

    expect = textwrap.dedent("""\
            d(self.\\next\\, ret_0=>b);""")

    conv = converter(code)
    assert expect == str(conv)


def test_convert_call_returns_multi(converter):
    code = textwrap.dedent("""\
                b, self.next.a = self.next.d()
                """)

    expect = textwrap.dedent("""\
            d(self.\\next\\, ret_0=>b, ret_1=>self.\\next\\.a);""")

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
            self.next.submod.main(b)""")

    class D(HW):
        pass

    datamodel = DataModel(
        self_data={'submod': D()},
        locals={'a': {'b': True, 'c': True}})
    expect = textwrap.dedent("""\
        procedure a(b: boolean) is

        begin
            D_0.main(self.\\next\\.submod, b);
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
            D_0.main(self.submod, b, ret_0=>self.c);
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
                for x in self.next.arr:
                    x.call()""")

    class D(HW):
        pass

    datamodel = DataModel(locals={}, self_data={'arr': [D(), D()]})
    expect = textwrap.dedent("""\
        procedure f is

        begin
            for \\_i_\\ in self.\\next\\.arr'range loop
                D_0.call(self.\\next\\.arr(\\_i_\\));
            end loop;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)
