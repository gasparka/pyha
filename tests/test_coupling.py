import textwrap
from enum import Enum

import pytest
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, resize
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


def test_typed_argument_default_value(converter):
    pytest.skip('wontfix?')
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


def test_def_for_return(converter):
    pytest.skip('for test?')
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


class TestDefNodeConv:
    def setup(self):
        class T(HW):
            def a(self, i, b, f):
                return 1, 1 < 2, resize(f, 0, -17)

        self.dut = T()
        self.dut.a(1, False, Sfix(0.5, 1, -2))


    def test_build_arguments(self):
        class T(HW):
            def __init__(self):
                self.reg = 1

            def a(self, i, b, f, l):
                return 1, 1 < 2, resize(f, 0, -17), Sfix(0.1, 0, -5), l[0], self.reg

        dut = T()
        dut.a(1, False, Sfix(0.5, 1, -2), [1, 2])

        expect = 'self:inout T_0.self_t; ' \
                 'i:inout integer; ' \
                 'b:inout boolean; ' \
                 'f:inout sfixed(1 downto -2); ' \
                 'l:inout integer_list_t(0 to 1); ' \
                 'ret_0:inout integer; ' \
                 'ret_1:inout boolean; ' \
                 'ret_2:inout sfixed(0 downto -17); ' \
                 'ret_3:inout sfixed(0 downto -5); ' \
                 'ret_4:inout integer; ' \
                 'ret_5:inout integer'

        conv = get_conversion(dut)
        func = conv.get_function('a')
        assert expect == func.build_arguments()

    def test_build_variables(self):
        class T(HW):
            def a(self, arg):
                b = False
                i = 1
                i = 2
                arg = 2
                l = [1, 2]

        dut = T()
        dut.a(1)

        expect = 'variable l: integer_list_t(0 to 1);\n' \
                 'variable i: integer;\n' \
                 'variable b: boolean;'

        conv = get_conversion(dut)
        func = conv.get_function('a')
        assert expect == func.build_variables()

    def test_build_function(self):
        expect = textwrap.dedent("""\
            procedure a(self:inout T_0.self_t; i:inout integer; b:inout boolean; f:inout sfixed(1 downto -2); ret_0:inout integer; ret_1:inout boolean; ret_2:inout sfixed(0 downto -17)) is

            
            begin
                ret_0 := 1;
                ret_1 := 1 < 2;
                ret_2 := resize(f, 0, -17);
                return;
            end procedure;""")

        conv = get_conversion(self.dut)
        func = conv.get_function('a')
        assert expect == func.build_function()


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

    def test_multiline_comments(self):
        class B0(HW):
            """ class
            doc """

            def main(self, a):
                """ func
                doc
                """
                # normal doc
                return a

            def func2(self):
                """ very useless function """
                pass

        dut = B0()
        dut.main(0)
        dut.func2()
        dut = get_conversion(dut)

        expect = textwrap.dedent("""\
            -- func
            -- doc
            procedure main(self:inout self_t; a: integer; ret_0:out integer) is

            begin
                -- normal doc
                ret_0 := a;
                return;
            end procedure;""")

        assert expect == dut.build_function_by_name('main')

        expect = textwrap.dedent("""\
            -- class
            -- doc
            package B0_0 is


                type next_t is record
                    much_dummy_very_wow: integer;
                end record;

                type self_t is record
                    much_dummy_very_wow: integer;
                    \\next\\: next_t;
                end record;

                procedure \_pyha_init\(self: inout self_t);

                procedure \_pyha_reset_constants\(self: inout self_t);

                procedure \_pyha_reset\(self: inout self_t);

                procedure \_pyha_update_registers\(self: inout self_t);

                -- func
                -- doc
                procedure main(self:inout self_t; a: integer; ret_0:out integer);

                -- very useless function
                procedure func2(self:inout self_t);
            end package;""")

        assert expect == dut.build_package_header()
