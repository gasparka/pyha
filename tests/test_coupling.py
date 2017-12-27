import textwrap
from enum import Enum

from redbaron import RedBaron

from pyha.common.complex_fixed_point import ComplexSfix
from pyha.common.core import Hardware
from pyha.common.fixed_point import Sfix, resize
from pyha.conversion.conversion import get_objects_rednode, get_conversion
from pyha.conversion.redbaron_mods import AutoResize, ImplicitNext, ForModification, set_convert_obj


class TestDefNodeConv:
    def test_build_arguments(self):
        class T(Hardware):
            def __init__(self):
                self.reg = 1

            def a(self, i, b, f, l):
                return 1, 1 < 2, resize(f, 0, -17), Sfix(0.1, 0, -5), l[0], self.reg

        dut = T()
        dut.a(1, False, Sfix(0.5, 1, -2), [1, 2])

        expect = 'self:inout self_t; ' \
                 'i: integer; ' \
                 'b: boolean; ' \
                 'f: sfixed(1 downto -2); ' \
                 'l: Typedefs.integer_list_t(0 to 1); ' \
                 'ret_0:out integer; ' \
                 'ret_1:out boolean; ' \
                 'ret_2:out sfixed(0 downto -17); ' \
                 'ret_3:out sfixed(0 downto -5); ' \
                 'ret_4:out integer; ' \
                 'ret_5:out integer'

        conv = get_conversion(dut)
        func = conv.get_function('a')
        assert expect == func.build_arguments()

    def test_build_variables(self):
        class T(Hardware):
            def a(self, arg):
                b = False
                i = 1
                i = 2
                arg = 2
                l = [1, 2]

        dut = T()
        dut.a(1)

        expect = 'variable l: Typedefs.integer_list_t(0 to 1);\n' \
                 'variable i: integer;\n' \
                 'variable b: boolean;'

        conv = get_conversion(dut)
        func = conv.get_function('a')
        assert expect == func.build_variables()

    def test_build_function(self):
        class T(Hardware):
            def out(self, i):
                if i:
                    return 1
                return 2

        dut = T()
        dut.out(1)

        expect = textwrap.dedent("""\
            procedure \\out\\(self:inout self_t; i: integer; ret_0:out integer) is

            
            begin
                if i then
                    ret_0 := 1;
                    return;
                end if;
                ret_0 := 2;
                return;
            end procedure;""")

        conv = get_conversion(dut)
        func = conv.get_function('\\out\\')
        assert expect == func.build_function()


class TestClassNodeConv:
    def test_build_data_structs(self):
        class A(Hardware):
            def __init__(self):
                self.sub = 0

        class TestEnum(Enum):
            ENUM0, ENUM1, ENUM2, ENUM3 = range(4)

        class T(Hardware):
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
                    al: Typedefs.integer_list_t(0 to 11);
                    bl: Typedefs.boolean_list_t(0 to 1);
                    cl: Typedefs.sfixed2downto_15_list_t(0 to 1);
                    sub: A_0.self_t;
                    subl: A_0.A_0_self_t_list_t(0 to 1);
                end record;

                type self_t is record
                    a: sfixed(0 downto -27);
                    \\out\\: sfixed(0 downto -27);
                    c: integer;
                    d: boolean;
                    mode: TestEnum;
                    al: Typedefs.integer_list_t(0 to 11);
                    bl: Typedefs.boolean_list_t(0 to 1);
                    cl: Typedefs.sfixed2downto_15_list_t(0 to 1);
                    sub: A_0.self_t;
                    subl: A_0.A_0_self_t_list_t(0 to 1);
                    \\next\\: next_t;
                end record;""")

        c = get_conversion(T()).build_data_structs()
        assert expect == str(c)

    def test_build_typedefs(self):
        class A(Hardware):
            def __init__(self):
                self.sub = 0

        class T(Hardware):
            def __init__(self):
                self.al = [0] * 12
                self.al2 = [0] * 12  # duplicate list
                self.bl = [False] * 2
                self.cl = [Sfix(0.1, 2, -15), Sfix(1.5, 2, -15)]
                self.subl = [A()] * 2

            def a(self):
                loc = [Sfix(0.1, 2, -1), Sfix(1.5, 2, -1)]

        dut = T()
        dut.a()

        expect = [
            'type integer_list_t is array (natural range <>) of integer;',
            'type boolean_list_t is array (natural range <>) of boolean;',
            'type sfixed2downto_15_list_t is array (natural range <>) of sfixed(2 downto -15);',
            'type sfixed2downto_1_list_t is array (natural range <>) of sfixed(2 downto -1);',
        ]

        c = get_conversion(dut).build_typedefs()
        assert expect == c

    def test_build_init(self):
        class A(Hardware):
            def __init__(self):
                self.sub = 0

        class T(Hardware):
            def __init__(self):
                self.a = 0
                self.al = [0, 0]
                self.sub = A()
                self.subl = [self.sub] * 2

        expect = textwrap.dedent("""\
            procedure pyha_init_next(self:inout self_t) is
                -- sets all .next's to current register values, executed before 'main'. 
                -- thanks to this, '.next' variables are always written before read, so they can never be registers
            begin
                self.\\next\\.a := self.a;
                self.\\next\\.al := self.al;
                A_0.pyha_init_next(self.sub);
                A_0.pyha_init_next(self.subl(0));
                A_0.pyha_init_next(self.subl(1));
            end procedure;""")

        dut = get_conversion(T())
        assert expect == str(dut.build_init())

        expect = 'procedure pyha_init_next(self:inout self_t);'
        assert expect == str(dut.build_init(prototype_only=True))

    def test_build_update_self(self):
        class A(Hardware):
            def __init__(self):
                self.sub = 0

        class T(Hardware):
            def __init__(self):
                self.a = 0
                self.al = [0, 0]
                self.sub = A()
                self.subl = [self.sub] * 2

        expect = textwrap.dedent("""\
            procedure pyha_update_registers(self:inout self_t) is
                -- loads 'next' values to registers, executed on clock rising edge
            begin
                self.a := self.\\next\\.a;
                self.al := self.\\next\\.al;
                A_0.pyha_update_registers(self.sub);
                A_0.pyha_update_registers(self.subl(0));
                A_0.pyha_update_registers(self.subl(1));
            end procedure;""")

        dut = get_conversion(T())
        assert expect == str(dut.build_update_registers())

        expect = 'procedure pyha_update_registers(self:inout self_t);'
        assert expect == str(dut.build_update_registers(prototype_only=True))

    def test_build_reset(self):
        class A(Hardware):
            def __init__(self):
                self.r = 123

        class T(Hardware):
            def __init__(self):
                self.a = 0
                self.al = [0, 1]
                self.sub = A()
                self.subl = [self.sub] * 2

        expect = textwrap.dedent("""\
            procedure pyha_reset(self:inout self_t) is
                -- executed on reset signal. Reset values are determined from initial values of Python variables.
            begin
                self.\\next\\.a := 0;
                self.\\next\\.al := (0, 1);
                self.sub.\\next\\.r := 123;
                self.subl(0).\\next\\.r := 123;
                self.subl(1).\\next\\.r := 123;
                pyha_update_registers(self);
            end procedure;""")

        dut = get_conversion(T())
        assert expect == str(dut.build_reset())

        expect = 'procedure pyha_reset(self:inout self_t);'
        assert expect == str(dut.build_reset(prototype_only=True))

    def test_build_reset_constants(self):
        class T(Hardware):
            def __init__(self):
                self.A = 0
                self.a = 0
                self.b = [1, 2]
                self.AL = [0, 1]

        expect = textwrap.dedent("""\
            procedure pyha_reset_constants(self:inout self_t) is
                -- reset CONSTANTS, executed before 'main'. Helps synthesis tools to determine constants.
            begin
                self.A := 0;
                self.AL := (0, 1);
            end procedure;""")

        dut = get_conversion(T())
        assert expect == str(dut.build_reset_constants())

        expect = 'procedure pyha_reset_constants(self:inout self_t);'
        assert expect == str(dut.build_reset_constants(prototype_only=True))

    def test_multiline_comments(self):
        class B0(Hardware):
            """ class
            doc """

            def main(self):
                """ func
                doc
                """
                # normal doc
                pass

            def func2(self):
                """ very useless function """
                pass

        dut = B0()
        dut.main()
        dut.func2()
        dut = get_conversion(dut)

        expect = textwrap.dedent("""\
            procedure main(self:inout self_t) is
            -- func
            -- doc

            begin
                -- normal doc
            end procedure;""")

        assert expect == str(dut.get_function('main'))

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
    type B0_0_self_t_list_t is array (natural range <>) of B0_0.self_t;

    procedure main(self:inout self_t);
    procedure func2(self:inout self_t);

    -- internal pyha functions
    procedure pyha_update_registers(self:inout self_t);
    procedure pyha_reset(self:inout self_t);
    procedure pyha_init_next(self:inout self_t);
    procedure pyha_reset_constants(self:inout self_t);
    procedure pyha_deepcopy(self:inout self_t; other: in self_t);
    procedure pyha_list_deepcopy(self:inout B0_0_self_t_list_t; other: in B0_0_self_t_list_t);
end package;""")

        assert expect == dut.build_package_header()


class TestForModification:
    def test_for(self):
        code = textwrap.dedent("""\
                for x in arr:
                    x.main()""")
        expect = textwrap.dedent("""\
                for _i_ in arr:
                    arr[_i_].main()
                    """)

        y = ForModification.apply(RedBaron(code)[0])
        assert expect == y.dumps()

    def test_for_self(self):
        class T(Hardware):
            def __init__(self):
                self.arr = [1, 2, 3]

            def a(self):
                for x in self.arr:
                    a = x

        dut = T()
        dut.a()
        expect = textwrap.dedent("""\
                for \\_i_\\ in self.arr'range loop
                    a := self.arr(\\_i_\\);
                end loop;""")

        conv = get_conversion(dut)
        func = conv.get_function('a')
        assert expect == func.build_body()


class EnumType(Enum):
    ENUMVALUE = 0


class TestEnumModifications:
    def test_basic(self):
        class T(Hardware):
            def __init__(self):
                self.r = EnumType.ENUMVALUE

            def a(self):
                self.r = EnumType.ENUMVALUE
                r = EnumType.ENUMVALUE
                if r == EnumType.ENUMVALUE:
                    pass

        dut = T()
        dut.a()

        expect = \
            'self.\\next\\.r := 0;\n' \
            'r := 0;\n' \
            'if r = 0 then\n' \
            '\n' \
            'end if;'
        conv = get_conversion(dut)
        func = conv.get_function('a')
        assert expect == func.build_body()


class TestCallModifications:
    def test_convert_call(self):
        class Sub(Hardware):
            def f(self):
                return False

        class T(Hardware):
            def __init__(self):
                self.sub = Sub()
                self.r = False
                self.arr = [1, 2]

            def b(self, x):
                return 1

            def multi(self, x):
                return 1, 2

            def a(self, x):
                self.b(x)
                self.sub.f()
                loc = self.b(x)
                self.r = self.sub.f()
                f = resize(Sfix(1, 1, -15), 0, -15)
                self.arr[0], self.arr[1] = self.multi(x)
                lol = self.arr[len(self.arr) - 1]

        dut = T()
        dut.a(1)

        expect = \
            'b(self, x, pyha_ret_0);\n' \
            'Sub_0.f(self.sub, pyha_ret_1);\n' \
            'b(self, x, pyha_ret_2);\n' \
            'loc := pyha_ret_2;\n' \
            'Sub_0.f(self.sub, pyha_ret_3);\n' \
            'self.\\next\\.r := pyha_ret_3;\n' \
            'f := resize(Sfix(1, 1, -15, overflow_style=>fixed_wrap, round_style=>fixed_truncate), 0, -15, overflow_style=>fixed_wrap, round_style=>fixed_truncate);\n' \
            'multi(self, x, pyha_ret_4, pyha_ret_5);\n' \
            'self.\\next\\.arr(0) := pyha_ret_4;\n' \
            'self.\\next\\.arr(1) := pyha_ret_5;\n' \
            "lol := self.arr(self.arr'length - 1);"
        conv = get_conversion(dut)
        func = conv.get_function('a')
        assert expect == func.build_body()


class TestAutoResize:
    def setup_class(self):
        class T1(Hardware):
            def __init__(self):
                self.int_reg = 0
                self.sfix_reg = Sfix(0.1, 2, -19, round_style='truncate')

        class T0(Hardware):
            def __init__(self):
                self.int_reg = 0
                self.complex_reg = ComplexSfix(2.5 + 2.5j, 5, -29, overflow_style='wrap')
                self.sfix_reg = Sfix(2.5, 5, -29, overflow_style='wrap')
                self.submod_reg = T1()

                self.sfix_list = [Sfix()] * 2
                self.int_list = [0] * 2

                self.submod_list = [T1(), T1()]

            def main(self, a):
                # not subjects to resize conversion
                # some may be rejected due to type
                self.int_reg = a
                self.complex_reg = self.complex_reg
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
        set_convert_obj(self.dut)

    def test_find(self):
        """ Test all assignments that could be potential subjects, has no type info """
        expect = [
            'self.int_reg = a',
            'self.complex_reg = self.complex_reg',
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

        expect_types = [Sfix(2.5, 5, -29, overflow_style='wrap', round_style='truncate'),
                        Sfix(0.1, 2, -19, overflow_style='wrap', round_style='truncate'),
                        Sfix(0, overflow_style='wrap', round_style='truncate'),
                        Sfix(0.1, 2, -19, overflow_style='wrap', round_style='truncate'),
                        Sfix(2.5, 5, -29, overflow_style='wrap'),
                        Sfix(2.5, 5, -29, overflow_style='wrap')]

        nodes = AutoResize.find(self.red_node)
        passed_nodes, passed_types = AutoResize.filter(nodes)

        assert expect_nodes == [str(x) for x in passed_nodes]
        assert expect_types == passed_types

    def test_apply(self):
        expect_nodes = ['self.sfix_reg = resize(a, 5, -29, fixed_wrap, fixed_truncate)',
                        'self.submod_reg.sfix_reg = resize(a, 2, -19, fixed_wrap, fixed_truncate)',
                        'self.sfix_list[0] = resize(a, None, None, fixed_wrap, fixed_truncate)',
                        'self.submod_list[1].sfix_reg = resize(a, 2, -19, fixed_wrap, fixed_truncate)',
                        'self.complex_reg.real = resize(a, 5, -29, fixed_wrap, fixed_truncate)',
                        'self.complex_reg.imag = resize(a, 5, -29, fixed_wrap, fixed_truncate)'
                        ]

        nodes = AutoResize.apply(self.red_node)
        assert expect_nodes == [str(x) for x in nodes]

        # todo:
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
