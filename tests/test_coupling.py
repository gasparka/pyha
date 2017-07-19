import textwrap
from enum import Enum

from redbaron import RedBaron

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, fixed_truncate, fixed_wrap, fixed_round, fixed_saturate, ComplexSfix, resize
from pyha.conversion.conversion import get_objects_rednode, get_conversion
from pyha.conversion.converter import AutoResize, ImplicitNext, ForModification, set_convert_obj


class TestDefNodeConv:
    def test_build_arguments(self):
        class T(HW):
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
                 'l: integer_list_t(0 to 1); ' \
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
        class T(HW):
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

            def a(self):
                loc = [Sfix(0.1, 2, -1), Sfix(1.5, 2, -1)]

        dut = T()
        dut.a()

        expect = textwrap.dedent("""\
            type integer_list_t is array (natural range <>) of integer;
            type boolean_list_t is array (natural range <>) of boolean;
            type sfixed2downto_15_list_t is array (natural range <>) of sfixed(2 downto -15);
            type A_0_self_t_list_t is array (natural range <>) of A_0.self_t;
            type sfixed2downto_1_list_t is array (natural range <>) of sfixed(2 downto -1);""")

        c = get_conversion(dut).build_typedefs()
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
            procedure \\_pyha_init\\(self:inout self_t) is
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

        expect = 'procedure \\_pyha_init\\(self:inout self_t);'
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
            procedure \\_pyha_update_registers\\(self:inout self_t) is
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

        expect = 'procedure \\_pyha_update_registers\\(self:inout self_t);'
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
            procedure \\_pyha_reset\\(self:inout self_t) is
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

        expect = 'procedure \\_pyha_reset\\(self:inout self_t);'
        assert expect == str(dut.build_reset(prototype_only=True))

    def test_build_reset_constants(self):
        class T(HW):
            def __init__(self):
                self.A = 0
                self.a = 0
                self.b = [1, 2]
                self.AL = [0, 1]

        expect = textwrap.dedent("""\
            procedure \\_pyha_reset_constants\\(self:inout self_t) is
            begin
                self.A := 0;
                self.AL := (0, 1);
            end procedure;""")

        dut = get_conversion(T())
        assert expect == str(dut.build_reset_constants())

        expect = 'procedure \\_pyha_reset_constants\\(self:inout self_t);'
        assert expect == str(dut.build_reset_constants(prototype_only=True))

    def test_multiline_comments(self):
        class B0(HW):
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

                procedure \_pyha_init\(self:inout self_t);

                procedure \_pyha_reset_constants\(self:inout self_t);

                procedure \_pyha_reset\(self:inout self_t);

                procedure \_pyha_update_registers\(self:inout self_t);

                procedure main(self:inout self_t);

                procedure func2(self:inout self_t);
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
        class T(HW):
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
        class T(HW):
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
            'self.\\next\\.r := ENUMVALUE;\n' \
            'r := ENUMVALUE;\n' \
            'if r = ENUMVALUE then\n' \
            '\n' \
            'end if;'
        conv = get_conversion(dut)
        func = conv.get_function('a')
        assert expect == func.build_body()


class TestCallModifications:
    def test_convert_call(self):
        class Sub(HW):
            def f(self):
                return False

        class T(HW):
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

        dut = T()
        dut.a(1)

        expect = 'b(self, x);\n' \
                 'Sub_0.f(self.sub);\n' \
                 'b(self, x, ret_0=>loc);\n' \
                 'Sub_0.f(self.sub, ret_0=>self.\\next\\.r);\n' \
                 'f := resize(Sfix(1, 1, -15), 0, -15);\n' \
                 'multi(self, x, ret_0=>self.\\next\\.arr(0), ret_1=>self.\\next\\.arr(1));'
        conv = get_conversion(dut)
        func = conv.get_function('a')
        assert expect == func.build_body()


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
        set_convert_obj(self.dut)

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
