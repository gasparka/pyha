import textwrap
from enum import Enum

import pytest
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.conversion.conversion import get_conversion
from pyha.conversion.converter import convert
from pyha.conversion.coupling import VHDLType, pytype_to_vhdl
from pyha.conversion.extract_datamodel import DataModel
from redbaron import RedBaron


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
    datamodel = DataModel(locals={'a': {'b': True, 'c': True}}, self_data={'c': True})
    expect = textwrap.dedent("""\

        procedure a(b: boolean) is

        begin
            self.\\next\\.c := b;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_variable_self_indexing(converter):
    # should not create variable
    code = textwrap.dedent("""\
        def a(b):
            self.c[0] = b""")
    datamodel = DataModel(locals={'a': {'b': True, 'c': True}}, self_data={'c': [True, False]})
    expect = textwrap.dedent("""\

        procedure a(b: boolean) is

        begin
            self.\\next\\.c(0) := b;
        end procedure;""")
    conv = converter(code, datamodel)
    assert expect == str(conv)


def test_typed_def_infer_variable_selfnext_indexing(converter):
    # should not create variable
    code = textwrap.dedent("""\
        def a(b):
            self.c[0] = b""")
    datamodel = DataModel(locals={'a': {'b': True, 'c': True}}, self_data={'c': [True, False]})
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
            self.c[0] = resize(b, size_res=self.x[i])""")
    datamodel = DataModel(locals={'a': {'b': True, 'c': True}}, self_data={'c': [True, False]})
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
            return a, self.b""")

    datamodel = DataModel(locals={'a': {
        'next': 1,
        'b': True,
        'a': Sfix(0, 0, -2),
        'l': True,
        'o': Sfix(12, 12, -12)
    }},
        self_data={'b': 12, 'a': True})

    expect = textwrap.dedent("""\

        procedure a(self:inout self_t; a: sfixed(0 downto -2); b: boolean:=\\next\\; ret_0:out sfixed(0 downto -2); ret_1:out integer) is
            variable o: sfixed(12 downto -12);
        begin
            o := h;
            self.\\next\\.a := l;
            ret_0 := a;
            ret_1 := self.b;
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


def test_class_infer_local_variable_list(converter):
    pytest.skip('TODO, local list typedef')
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
    assert expect == conv.build_typedefs()


class TestClassNodeConv:
    def test_build_data_structs(self):
        class A(HW):
            def __init__(self):
                self.sub = 0

        class TestEnum(Enum):
            ENUM0, ENUM1, ENUM2, ENUM3 = range(4)

        class T(HW):
            def __init__(self):
                self.a = Sfix(1.0, 0, -27)
                self.out = Sfix(1.0, 0, -27)  # reserved name
                self.c = 25
                self.d = True
                self.mode = TestEnum.ENUM1
                self.al = [0] * 12
                self.bl = [False] * 2
                self.cl = [Sfix(0.1, 2, -15), Sfix(1.5, 2, -15)]
                self.sub = A()
                self.subl = [self.sub] * 2

        expect = textwrap.dedent("""\
                type next_t is record
                    a: sfixed(0 downto -27);
                    \\out\\: sfixed(0 downto -27);
                    c: integer;
                    d: boolean;
                    mode: TestEnum;
                    al: integer_list_t(0 to 11);
                    bl: boolean_list_t(0 to 1);
                    cl: sfixed2downto_15_list_t(0 to 1);
                    sub: A_0.self_t;
                    subl: A_0_self_t_list_t(0 to 1);
                end record;

                type self_t is record
                    a: sfixed(0 downto -27);
                    \\out\\: sfixed(0 downto -27);
                    c: integer;
                    d: boolean;
                    mode: TestEnum;
                    al: integer_list_t(0 to 11);
                    bl: boolean_list_t(0 to 1);
                    cl: sfixed2downto_15_list_t(0 to 1);
                    sub: A_0.self_t;
                    subl: A_0_self_t_list_t(0 to 1);
                    \\next\\: next_t;
                end record;""")

        c = get_conversion(T()).build_data_structs()
        assert expect == str(c)

    def test_build_typedefs(self):
        class A(HW):
            def __init__(self):
                self.sub = 0

        class T(HW):
            def __init__(self):
                self.al = [0] * 12
                self.al2 = [0] * 12  # duplicate list
                self.bl = [False] * 2
                self.cl = [Sfix(0.1, 2, -15), Sfix(1.5, 2, -15)]
                self.subl = [A()] * 2

        expect = textwrap.dedent("""\
            type integer_list_t is array (natural range <>) of integer;
            type boolean_list_t is array (natural range <>) of boolean;
            type sfixed2downto_15_list_t is array (natural range <>) of sfixed(2 downto -15);
            type A_0_self_t_list_t is array (natural range <>) of A_0.self_t;""")

        c = get_conversion(T()).build_typedefs()
        assert expect == str(c)


    def test_build_init(self):
        class A(HW):
            def __init__(self):
                self.sub = 0

        class T(HW):
            def __init__(self):
                self.a = 0
                self.al = [0, 0]
                self.sub = A()
                self.subl = [self.sub] * 2

        expect = textwrap.dedent("""\
            procedure \\_pyha_init\\(self: inout self_t) is
            begin
                self.\\next\\.a := self.a;
                self.\\next\\.al := self.al;
                A_0.\\_pyha_init\\(self.sub);
                A_0.\\_pyha_init\\(self.subl(0));
                A_0.\\_pyha_init\\(self.subl(1));
                \\_pyha_reset_constants\\(self);
            end procedure;""")

        dut = get_conversion(T())
        assert expect == str(dut.build_init())

        expect = 'procedure \\_pyha_init\\(self: inout self_t);'
        assert expect == str(dut.build_init(prototype_only=True))

    def test_build_update_self(self):
        class A(HW):
            def __init__(self):
                self.sub = 0

        class T(HW):
            def __init__(self):
                self.a = 0
                self.al = [0, 0]
                self.sub = A()
                self.subl = [self.sub] * 2

        expect = textwrap.dedent("""\
            procedure \\_pyha_update_registers\\(self: inout self_t) is
            begin
                self.a := self.\\next\\.a;
                self.al := self.\\next\\.al;
                A_0.\\_pyha_update_registers\\(self.sub);
                A_0.\\_pyha_update_registers\\(self.subl(0));
                A_0.\\_pyha_update_registers\\(self.subl(1));
                \\_pyha_reset_constants\\(self);
            end procedure;""")

        dut = get_conversion(T())
        assert expect == str(dut.build_update_registers())

        expect = 'procedure \\_pyha_update_registers\\(self: inout self_t);'
        assert expect == str(dut.build_update_registers(prototype_only=True))

    def test_build_reset(self):
        class A(HW):
            def __init__(self):
                self.r = 123

        class T(HW):
            def __init__(self):
                self.a = 0
                self.al = [0, 1]
                self.sub = A()
                self.subl = [self.sub] * 2

        expect = textwrap.dedent("""\
            procedure \\_pyha_reset\\(self: inout self_t) is
            begin
                self.\\next\\.a := 0;
                self.\\next\\.al := (0, 1);
                self.sub.\\next\\.r := 123;
                self.subl(0).\\next\\.r := 123;
                self.subl(1).\\next\\.r := 123;
                \\_pyha_update_registers\\(self);
            end procedure;""")

        dut = get_conversion(T())
        assert expect == str(dut.build_reset())

        expect = 'procedure \\_pyha_reset\\(self: inout self_t);'
        assert expect == str(dut.build_reset(prototype_only=True))

    def test_build_reset_constants(self):
        class T(HW):
            def __init__(self):
                self.A = 0
                self.a = 0
                self.b = [1, 2]
                self.AL = [0, 1]

        expect = textwrap.dedent("""\
            procedure \\_pyha_reset_constants\\(self: inout self_t) is
            begin
                self.A := 0;
                self.AL := (0, 1);
            end procedure;""")

        dut = get_conversion(T())
        assert expect == str(dut.build_reset_constants())

        expect = 'procedure \\_pyha_reset_constants\\(self: inout self_t);'
        assert expect == str(dut.build_reset_constants(prototype_only=True))
