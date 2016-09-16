import textwrap

import pytest
from redbaron import RedBaron

from common.sfix import Sfix
from conversion.converter import convert
from conversion.extract_datamodel import DataModel


@pytest.fixture
def converter():
    class Conv:
        def __call__(self, code, datamodel=None):
            red = RedBaron(code)
            return convert(red[0], self, datamodel)

    return Conv()


def test_typed_def_argument(converter):
    code = textwrap.dedent("""\
        def a(b):
            pass""")

    datamodel = DataModel(locals={'a': {'b': 12}})
    expect = textwrap.dedent("""\
        procedure a(b: integer) is

        begin

        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_argument_self(converter):
    code = textwrap.dedent("""\
        def a(self):
            pass""")

    datamodel = DataModel(locals={'a': {'b': 12}})
    expect = textwrap.dedent("""\
        procedure a(self: self_t) is

        begin

        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_argument_notlocal_raises0(converter):
    code = textwrap.dedent("""\
        def a(b):
            pass""")

    datamodel = DataModel(locals={'a': {'rand': 123}})
    expect = textwrap.dedent("""\
        procedure a(b: integer) is

        begin

        end procedure;""")

    with pytest.raises(KeyError):
        conv = converter(code, datamodel)


def test_typed_def_argument_notlocal_raises1(converter):
    code = textwrap.dedent("""\
        def a(b):
            pass""")

    datamodel = DataModel(locals={'a': {'rand': 123}})
    expect = textwrap.dedent("""\
        procedure a(b: integer) is

        begin

        end procedure;""")
    with pytest.raises(KeyError):
        conv = converter(code, datamodel)


def test_typed_def_argument_notlocal_raises2(converter):
    code = textwrap.dedent("""\
        def a(b):
            pass""")

    datamodel = DataModel(locals={})
    expect = textwrap.dedent("""\
        procedure a(b: integer) is

        begin

        end procedure;""")
    with pytest.raises(KeyError):
        conv = converter(code, datamodel)


def test_typed_def_argument_sfix(converter):
    code = textwrap.dedent("""\
        def a(b):
            pass""")

    datamodel = DataModel(locals={'a': {'b': Sfix(0.5, 2, -12)}})
    expect = textwrap.dedent("""\
        procedure a(b: sfixed(2 downto -12)) is

        begin

        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_argument_default_value(converter):
    code = textwrap.dedent("""\
        def a(b=c):
            pass""")

    datamodel = DataModel(locals={'a': {'b': True}})
    expect = textwrap.dedent("""\
        procedure a(b: boolean:=c) is

        begin

        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_argument_multiple(converter):
    code = textwrap.dedent("""\
        def a(b, c, d):
            pass""")

    datamodel = DataModel(locals=
    {'a': {
        'b': 12,
        'c': Sfix(0.5, 2, -12),
        'd': True}})
    expect = textwrap.dedent("""\
        procedure a(b: integer; c: sfixed(2 downto -12); d: boolean) is

        begin

        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_argument_return_local(converter):
    code = textwrap.dedent("""\
        def a():
            return b""")

    datamodel = DataModel(locals={'a': {'b': True}})
    expect = textwrap.dedent("""\
        procedure a(ret_0:out boolean) is

        begin
            ret_0 := b;
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_argument_return_local_indexing(converter):
    code = textwrap.dedent("""\
        def a():
            return b[1]""")

    datamodel = DataModel(locals={'a': {'b': [True, False]}})
    expect = textwrap.dedent("""\
        procedure a(ret_0:out boolean) is

        begin
            ret_0 := b(1);
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_argument_return_local_notinlocal_raises(converter):
    code = textwrap.dedent("""\
        def a():
            return lol""")

    datamodel = DataModel(locals={'a': {'b': True}})

    with pytest.raises(KeyError):
        conv = converter(code, datamodel)


def test_typed_def_argument_return_self(converter):
    code = textwrap.dedent("""\
        def a():
            return self.b""")

    datamodel = DataModel(self_data={'b': True})
    expect = textwrap.dedent("""\
        procedure a(ret_0:out boolean) is

        begin
            ret_0 := self.b;
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_argument_return_self_indexing(converter):
    code = textwrap.dedent("""\
        def a():
            return self.b[4]""")

    datamodel = DataModel(self_data={'b': [1, 2, 3, 4, 5]})
    expect = textwrap.dedent("""\
        procedure a(ret_0:out integer) is

        begin
            ret_0 := self.b(4);
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_argument_return_self_subindexing(converter):
    code = textwrap.dedent("""\
        def a():
            return self.l.b[4]""")

    datamodel = DataModel(self_data={'l': {
        'b': [1, 2, 3, 4, 5]
    }
    })
    expect = textwrap.dedent("""\
        procedure a(ret_0:out integer) is

        begin
            ret_0 := self.l.b(4);
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_argument_return_self_notinself_raises(converter):
    code = textwrap.dedent("""\
        def a():
            return self.lol""")

    datamodel = DataModel(self_data={'b': True})
    with pytest.raises(KeyError):
        conv = converter(code, datamodel)


def test_typed_def_argument_return_self_nested(converter):
    code = textwrap.dedent("""\
        def a():
            return self.obj.b""")

    datamodel = DataModel(self_data={'obj': {'b': Sfix(0.0, 1, -1)}})
    expect = textwrap.dedent("""\
        procedure a(ret_0:out sfixed(1 downto -1)) is

        begin
            ret_0 := self.obj.b;
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_argument_return_multiple(converter):
    code = textwrap.dedent("""\
        def a():
            return self.b, c, self.d""")
    datamodel = DataModel(self_data={'b': Sfix(0.0, 1, -1), 'd': 12},
                          locals={'a': {'c': True}})
    expect = textwrap.dedent("""\
        procedure a(ret_0:out sfixed(1 downto -1); ret_1:out boolean; ret_2:out integer) is

        begin
            ret_0 := self.b;
            ret_1 := c;
            ret_2 := self.d;
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_infer_variable(converter):
    code = textwrap.dedent("""\
        def a(b):
            c = b""")
    datamodel = DataModel(locals={'a': {'b': True, 'c': True}})
    expect = textwrap.dedent("""\
        procedure a(b: boolean) is
            variable c: boolean;
        begin
            c := b;
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_infer_variable_self_reject(converter):
    # should not create variable
    code = textwrap.dedent("""\
        def a(b):
            self.c = b""")
    datamodel = DataModel(locals={'a': {'b': True, 'c': True}})
    expect = textwrap.dedent("""\
        procedure a(b: boolean) is

        begin
            self.c := b;
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_infer_variable_argument_reject(converter):
    # no variable infered because assignment is to argument
    code = textwrap.dedent("""\
        def a(b):
            b = l""")

    datamodel = DataModel(locals={'a': {'b': 12}})
    expect = textwrap.dedent("""\
        procedure a(b: integer) is

        begin
            b := l;
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_infer_variable_argument_reject_reserved(converter):
    # no variable infered because assignment is to argument
    code = textwrap.dedent("""\
        def a(next):
            next = l""")

    datamodel = DataModel(locals={'a': {'next': 12}})
    expect = textwrap.dedent("""\
        procedure a(\\next\\: integer) is

        begin
            \\next\\ := l;
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_infer_variable_sfix(converter):
    code = textwrap.dedent("""\
        def a(b):
            next = Sfix(12, 5, 0)""")

    datamodel = DataModel(locals={'a': {'next': Sfix(0, 5, 0), 'b': Sfix(0, 0, -5)}})
    expect = textwrap.dedent("""\
        procedure a(b: sfixed(0 downto -5)) is
            variable \\next\\: sfixed(5 downto 0);
        begin
            \\next\\ := Sfix(12, 5, 0);
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_infer_variable_return(converter):
    code = textwrap.dedent("""\
        def a(b):
            return l""")

    datamodel = DataModel(locals={'a': {'b': 1, 'l': 2}})
    expect = textwrap.dedent("""\
        procedure a(b: integer; ret_0:out integer) is

        begin
            ret_0 := l;
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_infer_variable_dublicate(converter):
    code = textwrap.dedent("""\
        def a(b):
            x = l
            x = b""")
    datamodel = DataModel(locals={'a': {'x': 1, 'b': True}})
    expect = textwrap.dedent("""\
        procedure a(b: boolean) is
            variable x: integer;
        begin
            x := l;
            x := b;
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_infer_variable_multiple(converter):
    code = textwrap.dedent("""\
        def a(b):
            next = l
            a = c
            l = h""")

    datamodel = DataModel(locals={'a': {
        'next': 1,
        'b': True,
        'a': Sfix(0, 0, -2),
        'l': True,
    }})
    expect = textwrap.dedent("""\
        procedure a(b: boolean) is
            variable \\next\\: integer;
            variable a: sfixed(0 downto -2);
            variable l: boolean;
        begin
            \\next\\ := l;
            a := c;
            l := h;
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect


def test_typed_def_complex(converter):
    code = textwrap.dedent("""\
        def a(self, a, b=next):
            o = h
            self.a = l
            return a, self.next.b""")

    datamodel = DataModel(locals={'a': {
        'next': 1,
        'b': True,
        'a': Sfix(0, 0, -2),
        'l': True,
        'o': Sfix(12, 12, -12)
    }},
        self_data={'next': {'b': 12}})

    expect = textwrap.dedent("""\
        procedure a(self: self_t; a: sfixed(0 downto -2); b: boolean:=\\next\\; ret_0:out sfixed(0 downto -2); ret_1:out integer) is
            variable o: sfixed(12 downto -12);
        begin
            o := h;
            self.a := l;
            ret_0 := a;
            ret_1 := self.\\next\\.b;
        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect
