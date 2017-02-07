import textwrap

import pytest
from redbaron import RedBaron

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.conversion.converter import convert
from pyha.conversion.coupling import VHDLType, pytype_to_vhdl
from pyha.conversion.extract_datamodel import DataModel


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

    datamodel = DataModel(locals={'a': {'b': 12}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(b: integer) is

        begin

        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_argument_self(converter):
    code = textwrap.dedent("""\
        def a(self):
            pass""")

    datamodel = DataModel(locals={'a': {'b': 12}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(self:inout self_t) is

        begin

        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_argument_notlocal_raises0(converter):
    code = textwrap.dedent("""\
        def a(b):
            pass""")

    datamodel = DataModel(locals={'a': {'rand': 123}}, self_data={})
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

    datamodel = DataModel(locals={'a': {'rand': 123}}, self_data={})
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

    datamodel = DataModel(locals={}, self_data={})
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

    datamodel = DataModel(locals={'a': {'b': Sfix(0.5, 2, -12)}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(b: sfixed(2 downto -12)) is

        begin

        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_argument_default_value(converter):
    code = textwrap.dedent("""\
        def a(b=c):
            pass""")

    datamodel = DataModel(locals={'a': {'b': True}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(b: boolean:=c) is

        begin

        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_argument_multiple(converter):
    code = textwrap.dedent("""\
        def a(b, c, d):
            pass""")

    datamodel = DataModel(locals=
    {'a': {
        'b': 12,
        'c': Sfix(0.5, 2, -12),
        'd': True}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(b: integer; c: sfixed(2 downto -12); d: boolean) is

        begin

        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_argument_return_local(converter):
    code = textwrap.dedent("""\
        def a():
            return b""")

    datamodel = DataModel(locals={'a': {'b': True}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(ret_0:out boolean) is

        begin
            ret_0 := b;
            return;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_argument_return_constant_int(converter):
    code = textwrap.dedent("""\
        def a():
            return 1""")

    datamodel = DataModel(locals={'a': {}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(ret_0:out integer) is

        begin
            ret_0 := 1;
            return;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_argument_return_constant_bool(converter):
    code = textwrap.dedent("""\
        def a():
            return False""")

    datamodel = DataModel(locals={'a': {}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(ret_0:out boolean) is

        begin
            ret_0 := False;
            return;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_argument_return_constant_sfix(converter):
    code = textwrap.dedent("""\
        def a():
            return Sfix(0.1, 0, -5)""")

    datamodel = DataModel(locals={'a': {}}, self_data={})

    # will not work because it was too hard to implement!
    with pytest.raises(Exception):
        converter(code, datamodel)


def test_typed_def_argument_return_local_indexing(converter):
    code = textwrap.dedent("""\
        def a():
            return b[1]""")

    datamodel = DataModel(locals={'a': {'b': [True, False]}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(ret_0:out boolean) is

        begin
            ret_0 := b(1);
            return;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_argument_return_local_notinlocal_raises(converter):
    code = textwrap.dedent("""\
        def a():
            return lol""")

    datamodel = DataModel(locals={'a': {'b': True}}, self_data={})

    with pytest.raises(KeyError):
        conv = converter(code, datamodel)


def test_typed_def_argument_return_self(converter):
    code = textwrap.dedent("""\
        def a():
            return self.b""")

    datamodel = DataModel(locals={}, self_data={'b': True})
    expect = textwrap.dedent("""\

        procedure a(ret_0:out boolean) is

        begin
            ret_0 := self.b;
            return;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_argument_return_self_indexing(converter):
    code = textwrap.dedent("""\
        def a():
            return self.b[4]""")

    datamodel = DataModel(locals={}, self_data={'b': [1, 2, 3, 4, 5]})
    expect = textwrap.dedent("""\

        procedure a(ret_0:out integer) is

        begin
            ret_0 := self.b(4);
            return;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_argument_return_self_indexing_negative(converter):
    code = textwrap.dedent("""\
        def a():
            return self.b[-1]""")

    datamodel = DataModel(locals={}, self_data={'b': [-1, -2]})
    expect = textwrap.dedent("""\

        procedure a(ret_0:out integer) is

        begin
            ret_0 := self.b(self.b'length-1);
            return;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_argument_return_self_subindexing(converter):
    code = textwrap.dedent("""\
        def a():
            return self.l.b[4]""")

    datamodel = DataModel(locals={}, self_data={'l': {
        'b': [1, 2, 3, 4, 5]
    }
    })
    expect = textwrap.dedent("""\

        procedure a(ret_0:out integer) is

        begin
            ret_0 := self.l.b(4);
            return;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_argument_return_self_notinself_raises(converter):
    code = textwrap.dedent("""\
        def a():
            return self.lol""")

    datamodel = DataModel(locals={}, self_data={'b': True})
    with pytest.raises(KeyError):
        conv = converter(code, datamodel)


def test_typed_def_argument_return_self_nested(converter):
    code = textwrap.dedent("""\
        def a():
            return self.obj.b""")

    datamodel = DataModel(locals={}, self_data={'obj': {'b': Sfix(0.0, 1, -1)}})
    expect = textwrap.dedent("""\

        procedure a(ret_0:out sfixed(1 downto -1)) is

        begin
            ret_0 := self.obj.b;
            return;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


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
            return;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_variable(converter):
    code = textwrap.dedent("""\
        def a(b):
            c = b""")
    datamodel = DataModel(locals={'a': {'b': True, 'c': True}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(b: boolean) is
            variable c: boolean;
        begin
            c := b;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_variable_self_reject(converter):
    # should not create variable
    code = textwrap.dedent("""\
        def a(b):
            self.c = b""")
    datamodel = DataModel(locals={'a': {'b': True, 'c': True}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(b: boolean) is

        begin
            self.c := b;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_variable_self_indexing(converter):
    # should not create variable
    code = textwrap.dedent("""\
        def a(b):
            self.c[0] = b""")
    datamodel = DataModel(locals={'a': {'b': True, 'c': True}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(b: boolean) is

        begin
            self.c(0) := b;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_variable_selfnext_indexing(converter):
    # should not create variable
    code = textwrap.dedent("""\
        def a(b):
            self.next.c[0] = b""")
    datamodel = DataModel(locals={'a': {'b': True, 'c': True}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(b: boolean) is

        begin
            self.\\next\\.c(0) := b;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_variable_selfnext_indexing_resize(converter):
    # should not create variable
    code = textwrap.dedent("""\
        def a(b):
            self.next.c[0] = resize(b, size_res=self.x[i])""")
    datamodel = DataModel(locals={'a': {'b': True, 'c': True}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(b: boolean) is

        begin
            self.\\next\\.c(0) := resize(b, size_res=>self.x(i));
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_variable_argument_reject(converter):
    # no variable infered because assignment is to argument
    code = textwrap.dedent("""\
        def a(b):
            b = l""")

    datamodel = DataModel(locals={'a': {'b': 12}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(b: integer) is

        begin
            b := l;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_variable_argument_reject_reserved(converter):
    # no variable infered because assignment is to argument
    code = textwrap.dedent("""\
        def a(next):
            next = l""")

    datamodel = DataModel(locals={'a': {'next': 12}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(\\next\\: integer) is

        begin
            \\next\\ := l;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_variable_sfix(converter):
    code = textwrap.dedent("""\
        def a(b):
            next = Sfix(12, 5, 0)""")

    datamodel = DataModel(locals={'a': {'next': Sfix(0, 5, 0), 'b': Sfix(0, 0, -5)}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(b: sfixed(0 downto -5)) is
            variable \\next\\: sfixed(5 downto 0);
        begin
            \\next\\ := Sfix(12, 5, 0);
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_variable_return(converter):
    code = textwrap.dedent("""\
        def a(b):
            return l""")

    datamodel = DataModel(locals={'a': {'b': 1, 'l': 2}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(b: integer; ret_0:out integer) is

        begin
            ret_0 := l;
            return;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_variable_dublicate(converter):
    code = textwrap.dedent("""\
        def a(b):
            x = l
            x = b""")
    datamodel = DataModel(locals={'a': {'x': 1, 'b': True}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(b: boolean) is
            variable x: integer;
        begin
            x := l;
            x := b;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


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
    }}, self_data={})
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
    assert expect == str(conv)


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
        self_data={'b': 12})

    expect = textwrap.dedent("""\

        procedure a(self:inout self_t; a: sfixed(0 downto -2); b: boolean:=\\next\\; ret_0:out sfixed(0 downto -2); ret_1:out integer) is
            variable o: sfixed(12 downto -12);
        begin
            o := h;
            self.a := l;
            ret_0 := a;
            ret_1 := self.\\next\\.b;
            return;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_variable_dublicate2(converter):
    code = textwrap.dedent("""\
        def a(b):
            x = l
            x = b""")

    datamodel = DataModel(locals={'a': {'x': 1, 'b': True}}, self_data={})
    expect = textwrap.dedent("""\

        procedure a(b: boolean) is
            variable x: integer;
        begin
            x := l;
            x := b;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_def_for_return(converter):
    code = textwrap.dedent("""\
        def b():
            outs = [0, 0, 0, 0]
            for i in range(len(list)):
                outs[i] = list[i]
            return outs[0]""")

    datamodel = DataModel(locals={'b': {'outs': [0, 0, 0, 0]}}, self_data={})
    expect = textwrap.dedent("""\

        procedure b(ret_0:out integer) is
            variable outs: integer_list_t(0 to 3);
        begin
            outs := (0, 0, 0, 0);
            for i in list'range loop
                outs(i) := list(i);
            end loop;
            ret_0 := outs(0);
            return;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_datamodel_to_self_ignore_next():
    datamodel = DataModel(locals={}, self_data={'a': Sfix(0.0, 0, -27), 'next': {'lol': 'loom'}})
    VHDLType.set_datamodel(datamodel)
    s = VHDLType.get_self()
    assert str(s) == '[a: sfixed(0 downto -27)]'


def test_datamodel_to_self1():
    datamodel = DataModel(locals={}, self_data={'a': Sfix(0.0, 0, -27)})
    VHDLType.set_datamodel(datamodel)
    s = VHDLType.get_self()
    assert str(s) == '[a: sfixed(0 downto -27)]'


def test_datamodel_to_self2():
    datamodel = DataModel(locals={}, self_data={
        'a': Sfix(1.0, 0, -27),
        'b': Sfix(4.0, 2, -27),
        'c': 25,
        'd': False
    })
    VHDLType.set_datamodel(datamodel)
    s = VHDLType.get_self()
    assert str(s) == '[a: sfixed(0 downto -27), b: sfixed(2 downto -27), c: integer, d: boolean]'


class Tc(HW):
    pass


Tcobj = Tc()


def test_class_name(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                pass""")

    datamodel = DataModel(obj=Tcobj, locals={}, self_data={'a': Sfix(0.0, 0, -27)})
    expect = textwrap.dedent("""\
            Tc_0""")

    conv = converter(code, datamodel)
    conv = conv.get_name()
    assert expect == str(conv)


def test_class_datamodel(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                pass""")

    datamodel = DataModel(locals={}, self_data={'a': Sfix(0.0, 0, -27)})
    expect = textwrap.dedent("""\
            type register_t is record
                a: sfixed(0 downto -27);
            end record;

            type self_t is record
                a: sfixed(0 downto -27);
                \\next\\: register_t;
            end record;""")

    conv = converter(code, datamodel)
    conv = conv.get_datamodel()
    assert expect == str(conv)


class A(HW):
    def __init__(self):
        self.reg = 0

    def main(self):
        pass


Aobj = A()


class Register(HW):
    def __init__(self):
        self.reg = 0

    def main(self):
        pass


def test_pytype_to_vhdl_l():
    inp = [0, 1, 2, 3]
    ret = pytype_to_vhdl(inp)

    assert ret == 'integer_list_t(0 to 3)'
    inp = [True, False]
    ret = pytype_to_vhdl(inp)

    assert ret == 'boolean_list_t(0 to 1)'
    inp = [Sfix(0.2, 1, -2)] * 5
    ret = pytype_to_vhdl(inp)

    assert ret == 'sfixed1_2_list_t(0 to 4)'
    ret = pytype_to_vhdl(Aobj)
    assert ret == 'A_0'


def test_class_datamodel_submodule(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                pass""")

    datamodel = DataModel(locals={}, self_data={'sub': Aobj})

    expect = textwrap.dedent("""\
            type register_t is record
                sub: A_0.register_t;
            end record;

            type self_t is record

                sub: A_0.register_t;
                \\next\\: register_t;
            end record;""")

    conv = converter(code, datamodel)
    assert expect == str(conv.get_datamodel())

    expect = textwrap.dedent("""\
        procedure reset(self_reg: inout register_t) is
        begin
            A_0.reset(self_reg.sub);
        end procedure;""")

    assert expect == str(conv.get_reset_str())

    expect = textwrap.dedent("""\
        procedure make_self(self_reg: register_t; self: out self_t) is
        begin

            self.sub := self_reg.sub;
            self.\\next\\ := self_reg;
        end procedure;""")
    conv = converter(code, datamodel)
    conv = conv.get_makeself_str()
    assert expect == str(conv)


def test_class_datamodel_submodule_reserved_name(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                pass""")

    datamodel = DataModel(locals={}, self_data={'sub': Register()})

    expect = textwrap.dedent("""\
            type register_t is record
                sub: Register_0.register_t;
            end record;

            type self_t is record

                sub: Register_0.register_t;
                \\next\\: register_t;
            end record;""")

    conv = converter(code, datamodel)
    assert expect == str(conv.get_datamodel())

    expect = textwrap.dedent("""\
        procedure reset(self_reg: inout register_t) is
        begin
            Register_0.reset(self_reg.sub);
        end procedure;""")

    assert expect == str(conv.get_reset_str())

    expect = textwrap.dedent("""\
        procedure make_self(self_reg: register_t; self: out self_t) is
        begin

            self.sub := self_reg.sub;
            self.\\next\\ := self_reg;
        end procedure;""")
    conv = converter(code, datamodel)
    conv = conv.get_makeself_str()
    assert expect == str(conv)


def test_class_infer_local_variable_list(converter):
    code = textwrap.dedent("""\
            def a():
                l = [1, 2, 3, 4]""")

    datamodel = DataModel(self_data={}, locals={'a': {
        'l': [1, 2, 3, 4],
    }})
    expect = textwrap.dedent("""\

        procedure a is
            variable l: integer_list_t(0 to 3);
        begin
            l := (1, 2, 3, 4);
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)

    code = textwrap.dedent("""\
        class Tc(HW):
            def a():
                l = [1, 2, 3, 4]""")

    datamodel = DataModel(self_data={}, locals={'a': {
        'l': [1, 2, 3, 4],
    }})

    conv = converter(code, datamodel)
    expect = ['type integer_list_t is array (natural range <>) of integer;']
    assert expect == conv.get_typedefs()


def test_typedefs_duplicate(converter):
    code = textwrap.dedent("""\
        class Tc(HW):
            def a():
                l = [1, 2, 3, 4]""")

    datamodel = DataModel(self_data={'b': [1, 2]}, locals={'a': {
        'l': [1, 2, 3, 4],
    }})

    conv = converter(code, datamodel)
    expect = ['type integer_list_t is array (natural range <>) of integer;']
    assert expect == conv.get_typedefs()


def test_datamodel_list_int(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                pass""")

    datamodel = DataModel(self_data={'a': [0] * 12}, locals={})

    expect = textwrap.dedent("""\
            type register_t is record
                a: integer_list_t(0 to 11);
            end record;

            type self_t is record

                a: integer_list_t(0 to 11);
                \\next\\: register_t;
            end record;""")

    conv = converter(code, datamodel)
    assert expect == str(conv.get_datamodel())

    expect = textwrap.dedent("""\
        procedure reset(self_reg: inout register_t) is
        begin
            self_reg.a := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        end procedure;""")

    assert expect == str(conv.get_reset_str())

    expect = ['type integer_list_t is array (natural range <>) of integer;']
    assert expect == conv.get_typedefs()


def test_datamodel_list_boolean(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                pass""")

    datamodel = DataModel(self_data={'a': [False, True, False, True]}, locals={})
    expect = textwrap.dedent("""\
            type register_t is record
                a: boolean_list_t(0 to 3);
            end record;

            type self_t is record

                a: boolean_list_t(0 to 3);
                \\next\\: register_t;
            end record;""")

    conv = converter(code, datamodel)
    assert expect == str(conv.get_datamodel())

    expect = textwrap.dedent("""\
        procedure reset(self_reg: inout register_t) is
        begin
            self_reg.a := (False, True, False, True);
        end procedure;""")

    assert expect == str(conv.get_reset_str())

    # NOTICE: there is global definition for boolean_list_t !
    expect = []
    assert expect == conv.get_typedefs()


def test_list_sfix(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                pass""")

    datamodel = DataModel(self_data={'a': [Sfix(0.1, 2, -15), Sfix(1.5, 2, -15)]}, locals={})
    expect = textwrap.dedent("""\
            type register_t is record
                a: sfixed2_15_list_t(0 to 1);
            end record;

            type self_t is record

                a: sfixed2_15_list_t(0 to 1);
                \\next\\: register_t;
            end record;""")

    conv = converter(code, datamodel)
    assert expect == str(conv.get_datamodel())

    expect = textwrap.dedent("""\
        procedure reset(self_reg: inout register_t) is
        begin
            self_reg.a := (Sfix(0.1, 2, -15), Sfix(1.5, 2, -15));
        end procedure;""")

    assert expect == str(conv.get_reset_str())

    expect = ['type sfixed2_15_list_t is array (natural range <>) of sfixed(2 downto -15);']
    assert expect == conv.get_typedefs()


def test_class_datamodel(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                pass""")

    datamodel = DataModel(locals={}, self_data={
        'a': Sfix(1.0, 0, -27),
        'b': Sfix(4.0, 2, -27),
        'c': 25,
        'd': False
    })

    expect = textwrap.dedent("""\
            type register_t is record
                a: sfixed(0 downto -27);
                b: sfixed(2 downto -27);
                c: integer;
                d: boolean;
            end record;

            type self_t is record

                a: sfixed(0 downto -27);
                b: sfixed(2 downto -27);
                c: integer;
                d: boolean;
                \\next\\: register_t;
            end record;""")

    conv = converter(code, datamodel)
    conv = conv.get_datamodel()
    assert expect == str(conv)


def test_class_datamodel_reserved_name(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                pass""")

    datamodel = DataModel(locals={}, self_data={
        'out': Sfix(1.0, 0, -27),
        'new': False,
    })

    expect = textwrap.dedent("""\
            type register_t is record
                \\new\\: boolean;
                \\out\\: sfixed(0 downto -27);
            end record;

            type self_t is record

                \\new\\: boolean;
                \\out\\: sfixed(0 downto -27);
                \\next\\: register_t;
            end record;""")

    conv = converter(code, datamodel)
    conv = conv.get_datamodel()
    assert expect == str(conv)


def test_class_datamodel_make_self(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                pass""")

    datamodel = DataModel(locals={}, self_data={'a': Sfix(0.0, 0, -27)})

    expect = textwrap.dedent("""\
        procedure make_self(self_reg: register_t; self: out self_t) is
        begin

            self.a := self_reg.a;
            self.\\next\\ := self_reg;
        end procedure;""")
    conv = converter(code, datamodel)
    conv = conv.get_makeself_str()
    assert expect == str(conv)


def test_class_datamodel_make_self_reserved_name(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                pass""")

    datamodel = DataModel(locals={}, self_data={
        'out': Sfix(1.0, 0, -27),
        'new': False,
    })

    expect = textwrap.dedent("""\
        procedure make_self(self_reg: register_t; self: out self_t) is
        begin

            self.\\new\\ := self_reg.\\new\\;
            self.\\out\\ := self_reg.\\out\\;
            self.\\next\\ := self_reg;
        end procedure;""")
    conv = converter(code, datamodel)
    conv = conv.get_makeself_str()
    assert expect == str(conv)


def test_class_datamodel_make_self_ignore_next(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                pass""")

    datamodel = DataModel(locals={}, self_data={'a': Sfix(0.0, 0, -27), 'next': {'a': None}})

    expect = textwrap.dedent("""\
        procedure make_self(self_reg: register_t; self: out self_t) is
        begin

            self.a := self_reg.a;
            self.\\next\\ := self_reg;
        end procedure;""")
    conv = converter(code, datamodel)
    conv = conv.get_makeself_str()
    assert expect == str(conv)


def test_class_datamodel_make_self2(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                    pass""")

    datamodel = DataModel(locals={}, self_data={
        'a': Sfix(1.0, 2, -27),
        'b': Sfix(4.0, 6, -27),
        'c': 25,
        'd': False
    })

    expect = textwrap.dedent("""\
        procedure make_self(self_reg: register_t; self: out self_t) is
        begin

            self.a := self_reg.a;
            self.b := self_reg.b;
            self.c := self_reg.c;
            self.d := self_reg.d;
            self.\\next\\ := self_reg;
        end procedure;""")
    conv = converter(code, datamodel)
    conv = conv.get_makeself_str()
    assert expect == str(conv)


def test_class_datamodel_reset(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                pass""")

    datamodel = DataModel(locals={}, self_data={
        'a': Sfix(1.0, 2, -27),
        'b': Sfix(4.0, 6, -27),
        'c': 25,
        'd': False,
        'next': {'lol': 'loom'}
    })

    expect = textwrap.dedent("""\
        procedure reset(self_reg: inout register_t) is
        begin
            self_reg.a := Sfix(1.0, 2, -27);
            self_reg.b := Sfix(4.0, 6, -27);
            self_reg.c := 25;
            self_reg.d := False;
        end procedure;""")
    conv = converter(code, datamodel)
    conv = conv.get_reset_str()
    assert expect == str(conv)


def test_class_datamodel_reset_reserved_name(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                pass""")

    datamodel = DataModel(locals={}, self_data={
        'out': Sfix(1.0, 0, -27),
        'new': False,
    })

    expect = textwrap.dedent("""\
        procedure reset(self_reg: inout register_t) is
        begin
            self_reg.\\new\\ := False;
            self_reg.\\out\\ := Sfix(1.0, 0, -27);
        end procedure;""")
    conv = converter(code, datamodel)
    conv = conv.get_reset_str()
    assert expect == str(conv)


def test_class_datamodel_reset_prototype(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                    pass""")

    expect = textwrap.dedent("""\
        procedure reset(self_reg: inout register_t);""")

    conv = converter(code)
    conv = conv.get_reset_prototype()
    assert expect == str(conv)