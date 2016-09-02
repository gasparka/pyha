import textwrap
from collections import OrderedDict

import pytest
from common.sfix import Sfix
from conversion.main import red_to_conv_hub
from redbaron import RedBaron


@pytest.fixture
def converter():
    class Conv:
        def __call__(self, code):
            red = RedBaron(code)
            return red_to_conv_hub(red[0], caller=self)

    return Conv()


def test_name(converter):
    code = 'test'
    conv = converter(code)
    assert str(conv) == 'test'


def test_reserved_name(converter):
    code = 'next'
    conv = converter(code)
    assert str(conv) == '\\next\\'


def test_reserver_name_upper(converter):
    code = 'NeXt'
    conv = converter(code)
    assert str(conv) == '\\NeXt\\'


def test_atomtrailers(converter):
    code = 'next.a'
    conv = converter(code)
    assert str(conv) == '\\next\\.a'


def test_atomtrailers_self_next(converter):
    code = 'self.next.a'
    conv = converter(code)
    assert str(conv) == 'self.\\next\\.a'


def test_assign(converter):
    code = 'a = b'
    conv = converter(code)
    assert str(conv) == 'a := b;'


def test_assign_trailers(converter):
    code = 'self.next.reg = self.reg'
    conv = converter(code)
    assert str(conv) == 'self.\\next\\.reg := self.reg;'


def test_return(converter):
    code = 'return a'
    conv = converter(code)
    assert str(conv) == 'ret_0 := a;'


def test_return_multiple(converter):
    code = 'return a, b'
    conv = converter(code)
    assert str(conv) == 'ret_0 := a;\nret_1 := b;'


def test_return_self(converter):
    code = 'return self.a, self.next.b'
    conv = converter(code)
    assert str(conv) == 'ret_0 := self.a;\nret_1 := self.\\next\\.b;'


def test_comp_greater(converter):
    code = 'a > next'
    conv = converter(code)
    assert str(conv) == 'a > \\next\\'


def test_comp_greater_equal(converter):
    code = 'next >= b'
    conv = converter(code)
    assert str(conv) == '\\next\\ >= b'


def test_comp_smaller(converter):
    code = 'a < b'
    conv = converter(code)
    assert str(conv) == 'a < b'


def test_comp_smaller_equal(converter):
    code = 'a <= b'
    conv = converter(code)
    assert str(conv) == 'a <= b'


def test_comp_equal(converter):
    code = 'a == b'
    conv = converter(code)
    assert str(conv) == 'a = b'


def test_comp_inequal(converter):
    code = 'a != next'
    conv = converter(code)
    assert str(conv) == 'a /= \\next\\'


def test_add(converter):
    code = 'self.counter + step'
    conv = converter(code)
    assert str(conv) == 'self.counter + step'


def test_sub(converter):
    code = 'self.counter - step'
    conv = converter(code)
    assert str(conv) == 'self.counter - step'


def test_mult(converter):
    code = 'a * self.next.step'
    conv = converter(code)
    assert str(conv) == 'a * self.\\next\\.step'


def test_assign_add(converter):
    code = 'val = self.counter + step'
    conv = converter(code)
    assert str(conv) == 'val := self.counter + step;'


def test_and(converter):
    code = 'a and b'
    conv = converter(code)
    assert str(conv) == 'a and b'


def test_or(converter):
    code = 'a or b'
    conv = converter(code)
    assert str(conv) == 'a or b'


def test_assign_boolean(converter):
    code = 'a = val < b or val > a'
    conv = converter(code)
    assert str(conv) == 'a := val < b or val > a;'


def test_assign_associative_boolean(converter):
    code = 'a = b == c and (val < b or val > a)'
    conv = converter(code)
    assert str(conv) == 'a := b = c and (val < b or val > a);'


def test_if_single_body(converter):
    code = """if a:
        a = b"""
    expect = """\
        if a then
            a := b;
        end if;"""
    expect = textwrap.dedent(expect)
    conv = converter(code)
    assert str(conv) == expect


def test_if_two_statements(converter):
    code = """\
        if a:
            a = b
            b = a"""
    expect = """\
        if a then
            a := b;
            b := a;
        end if;"""
    expect = textwrap.dedent(expect)
    conv = converter(code)
    assert str(conv) == expect


def test_if_single_nested(converter):
    code = """\
        if a:
            a = b
            if b:
                b = c"""
    expect = """\
        if a then
            a := b;
            if b then
                b := c;
            end if;
        end if;"""
    expect = textwrap.dedent(expect)
    conv = converter(code)
    assert str(conv) == expect


def test_if_else(converter):
    code = """\
        if a:
            a = b
        else:
            b = a"""

    expect = """\
        if a then
            a := b;
        else
            b := a;
        end if;"""
    expect = textwrap.dedent(expect)
    conv = converter(code)
    assert str(conv) == expect


def test_if_elif(converter):
    code = """\
        if a:
            a = b
        elif b:
            b = a"""

    expect = """\
        if a then
            a := b;
        elseif b then
            b := a;
        end if;"""
    expect = textwrap.dedent(expect)
    conv = converter(code)
    assert str(conv) == expect


def test_if_complex(converter):
    code = """\
        if a == b and c != self.next.b:
            if a != c:
                b = a
            elif next == c or a != b:
                a = b
            else:
                next = a
        else:
            b = a"""

    expect = """\
        if a = b and c /= self.\\next\\.b then
            if a /= c then
                b := a;
            elseif \\next\\ = c or a /= b then
                a := b;
            else
                \\next\\ := a;
            end if;
        else
            b := a;
        end if;"""
    expect = textwrap.dedent(expect)
    conv = converter(code)
    assert str(conv) == expect


def test_def(converter):
    code = textwrap.dedent("""\
        def a():
            pass""")

    expect = textwrap.dedent("""\
        procedure a is

        begin

        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_reserver_name(converter):
    code = textwrap.dedent("""\
        def label():
            pass""")

    expect = textwrap.dedent("""\
        procedure \\label\\ is

        begin

        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_statements(converter):
    code = textwrap.dedent("""\
        def a():
            b
            if a == b:
                b""")

    expect = textwrap.dedent("""\
        procedure a is

        begin
            b
            if a = b then
                b
            end if;
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_argument(converter):
    code = textwrap.dedent("""\
        def a(b):
            pass""")

    expect = textwrap.dedent("""\
        procedure a(b: unknown_type) is

        begin

        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_argument_default_value(converter):
    code = textwrap.dedent("""\
        def a(b=c):
            pass""")

    expect = textwrap.dedent("""\
        procedure a(b: unknown_type:=c) is

        begin

        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_argument_multiple(converter):
    code = textwrap.dedent("""\
        def a(b, c, d):
            pass""")

    expect = textwrap.dedent("""\
        procedure a(b: unknown_type; c: unknown_type; d: unknown_type) is

        begin

        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_argument_return(converter):
    code = textwrap.dedent("""\
        def a():
            return b""")

    expect = textwrap.dedent("""\
        procedure a(ret_0:out unknown_type) is

        begin
            ret_0 := b;
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_argument_return_multiple(converter):
    code = textwrap.dedent("""\
        def a():
            return b, c, l < g""")

    expect = textwrap.dedent("""\
        procedure a(ret_0:out unknown_type; ret_1:out unknown_type; ret_2:out unknown_type) is

        begin
            ret_0 := b;
            ret_1 := c;
            ret_2 := l < g;
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_infer_variable(converter):
    code = textwrap.dedent("""\
        def a(b):
            a = b""")

    expect = textwrap.dedent("""\
        procedure a(b: unknown_type) is
            variable a: unknown_type;
        begin
            a := b;
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_infer_variable_reject_because_argument(converter):
    # no variable infered because assignment is to argument
    code = textwrap.dedent("""\
        def a(b):
            b = l""")

    expect = textwrap.dedent("""\
        procedure a(b: unknown_type) is

        begin
            b := l;
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_infer_variable_reject_because_argument_reserved(converter):
    # no variable infered because assignment is to argument
    code = textwrap.dedent("""\
        def a(next):
            next = l""")

    expect = textwrap.dedent("""\
        procedure a(\\next\\: unknown_type) is

        begin
            \\next\\ := l;
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_infer_variable_reserved_name(converter):
    code = textwrap.dedent("""\
        def a(b):
            next = l""")

    expect = textwrap.dedent("""\
        procedure a(b: unknown_type) is
            variable \\next\\: unknown_type;
        begin
            \\next\\ := l;
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_infer_variable_return(converter):
    # make sure return is not infered as variable
    code = textwrap.dedent("""\
        def a(b):
            return l""")

    expect = textwrap.dedent("""\
        procedure a(b: unknown_type; ret_0:out unknown_type) is

        begin
            ret_0 := l;
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_infer_variable_dublicate(converter):
    code = textwrap.dedent("""\
        def a(b):
            x = l
            x = b""")

    expect = textwrap.dedent("""\
        procedure a(b: unknown_type) is
            variable x: unknown_type;
        begin
            x := l;
            x := b;
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_infer_variable_multiple(converter):
    code = textwrap.dedent("""\
        def a(b):
            next = l
            a = c
            l = h""")

    expect = textwrap.dedent("""\
        procedure a(b: unknown_type) is
            variable \\next\\: unknown_type;
            variable a: unknown_type;
            variable l: unknown_type;
        begin
            \\next\\ := l;
            a := c;
            l := h;
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_infer_variable_atomtrailer(converter):
    # NOTE: trailered assigns are not converted to variables
    # because the base unit should already exist
    code = textwrap.dedent("""\
        def a(b):
            c.d = l""")

    expect = textwrap.dedent("""\
        procedure a(b: unknown_type) is

        begin
            c.d := l;
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_infer_variable_atomtrailer_argument(converter):
    # NOTE: trailered assigns are not converted to variables
    # because the base unit should already exist
    code = textwrap.dedent("""\
        def a(self):
            self.d = l""")

    expect = textwrap.dedent("""\
        procedure a(self: unknown_type) is

        begin
            self.d := l;
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_def_complex(converter):
    code = textwrap.dedent("""\
        def a(self, a, b=next):
            o = h
            self.a = l
            return a, self.next.b""")

    expect = textwrap.dedent("""\
        procedure a(self: unknown_type; a: unknown_type; b: unknown_type:=\\next\\; ret_0:out unknown_type; ret_1:out unknown_type) is
            variable o: unknown_type;
        begin
            o := h;
            self.a := l;
            ret_0 := a;
            ret_1 := self.\\next\\.b;
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_call_resize(converter):
    code = textwrap.dedent("""\
            resize(self.counter, 0, -17)""")

    expect = textwrap.dedent("""\
            resize(self.counter, 0, -17)""")
    conv = converter(code)
    assert str(conv) == expect


def test_call_resize_size_res(converter):
    code = textwrap.dedent("""\
            resize(self.counter, size_res=self.next.a)""")

    expect = textwrap.dedent("""\
            resize(self.counter, size_res=>self.\\next\\.a)""")
    conv = converter(code)
    assert str(conv) == expect


def test_call_resize_keyword_params(converter):
    code = textwrap.dedent("""\
            resize(self.counter, size_res=a, overflow_style=fixed_saturate, round_style=fixed_round)""")

    expect = textwrap.dedent("""\
            resize(self.counter, size_res=>a, overflow_style=>fixed_saturate, round_style=>fixed_round)""")
    conv = converter(code)
    assert str(conv) == expect


def test_call_sfix(converter):
    code = textwrap.dedent("""\
            Sfix(0.95, 0, -17)""")

    expect = textwrap.dedent("""\
            to_sfixed(0.95, 0, -17)""")
    conv = converter(code)
    assert str(conv) == expect


def test_call_sfix_keyword_params(converter):
    code = textwrap.dedent("""\
            Sfix(0.95, size_res=a, overflow_style=fixed_saturate, round_style=fixed_round)""")

    expect = textwrap.dedent("""\
            to_sfixed(0.95, size_res=>a, overflow_style=>fixed_saturate, round_style=>fixed_round)""")
    conv = converter(code)
    assert str(conv) == expect


def test_call_resize_sfix_combined(converter):
    code = textwrap.dedent("""\
            counter_small = resize(Sfix(0, 0, -self.scalebits + 1), size_res=a)""")

    expect = textwrap.dedent("""\
            counter_small := resize(to_sfixed(0, 0, -self.scalebits + 1), size_res=>a);""")
    conv = converter(code)
    assert str(conv) == expect


def test_call_semicolon_def(converter):
    code = textwrap.dedent("""\
        def a():
            a()""")

    expect = textwrap.dedent("""\
        procedure a is

        begin
            a();
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_call_semicolon_def2(converter):
    code = textwrap.dedent("""\
        def a():
            b
            a()
            c""")

    expect = textwrap.dedent("""\
        procedure a is

        begin
            b
            a();
            c
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect


def test_call_semicolon_if_condition(converter):
    code = textwrap.dedent("""\
        if a():
            pass""")

    expect = textwrap.dedent("""\
        if a() then

        end if;""")

    conv = converter(code)
    assert str(conv) == expect


def test_call_semicolon_if_body(converter):
    code = textwrap.dedent("""\
        if a():
            a()""")

    expect = textwrap.dedent("""\
        if a() then
            a();
        end if;""")

    conv = converter(code)
    assert str(conv) == expect


def test_call_semicolon_for(converter):
    code = textwrap.dedent("""\
        for i in a():
            a()""")

    expect = textwrap.dedent("""\
            for i in a() loop
                a();
            end loop;""")

    conv = converter(code)
    assert str(conv) == expect


def test_call_semicolon_multi(converter):
    code = textwrap.dedent("""\
        def a():
            a()
            o = a()
            if a():
                a()
                for x in a():
                    a()
            else:
                a()
            self.lol = lol.a()""")

    expect = textwrap.dedent("""\
        procedure a is
            variable o: unknown_type;
        begin
            a();
            o := a();
            if a() then
                a();
                for x in a() loop
                    a();
                end loop;
            else
                a();
            end if;
            self.lol := lol.a();
        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect

def test_indexing(converter):
    code = textwrap.dedent("""\
            a[1]""")

    expect = textwrap.dedent("""\
            a(1)""")
    conv = converter(code)
    assert str(conv) == expect


def test_indexing_inc(converter):
    code = textwrap.dedent("""\
            a[b + 1]""")

    expect = textwrap.dedent("""\
            a(b + 1)""")
    conv = converter(code)
    assert str(conv) == expect


def test_indexing_negative_index(converter):
    code = textwrap.dedent("""\
            a[-1]""")

    expect = textwrap.dedent("""\
            a(a'length-1)""")
    conv = converter(code)
    assert str(conv) == expect


def test_indexing_negative_index2(converter):
    code = textwrap.dedent("""\
            self.var[-4]""")

    expect = textwrap.dedent("""\
            self.var(self.var'length-4)""")
    conv = converter(code)
    assert str(conv) == expect


def test_indexing_negative_index3(converter):
    code = textwrap.dedent("""\
            self.next.var[-4]""")

    expect = textwrap.dedent("""\
            self.\\next\\.var(self.\\next\\.var'length-4)""")
    conv = converter(code)
    assert str(conv) == expect


def test_builtin_length(converter):
    code = textwrap.dedent("""\
            len(self.taps)""")

    expect = textwrap.dedent("""\
            (self.taps)'length""")
    conv = converter(code)
    assert str(conv) == expect


def test_builtin_range(converter):
    code = textwrap.dedent("""\
            range(self.taps)""")

    expect = textwrap.dedent("""\
            (self.taps)'range""")
    conv = converter(code)
    assert str(conv) == expect


def test_builtin_range_int(converter):
    code = textwrap.dedent("""\
            range(10)""")

    expect = textwrap.dedent("""\
            (0 to 10)""")
    conv = converter(code)
    assert str(conv) == expect


def test_builtin_range_int_start(converter):
    code = textwrap.dedent("""\
            range(2, 5)""")

    expect = textwrap.dedent("""\
            (2 to 5)""")
    conv = converter(code)
    assert str(conv) == expect


def test_builtin_range_int_start_step(converter):
    code = textwrap.dedent("""\
            range(2, 5, 2)""")

    with pytest.raises(NotImplementedError):
        conv = converter(code)
        str(conv)


def test_builtin_range_int_start_step_unit(converter):
    code = textwrap.dedent("""\
            range(2, 5, 1)""")

    expect = textwrap.dedent("""\
            (2 to 5)""")

    conv = converter(code)
    assert str(conv) == expect


def test_builtin_range_length(converter):
    code = textwrap.dedent("""\
            range(len(self.taps))""")

    expect = textwrap.dedent("""\
            (self.taps)'range""")
    conv = converter(code)
    assert str(conv) == expect


# TODO: reverse range stuffs
def test_builtin_reverse_range_length(converter):
    pytest.xfail('Not implemented')
    code = textwrap.dedent("""\
            reverse(range(len(self.taps)))""")

    expect = textwrap.dedent("""\
            (self.taps)'rrange""")
    conv = converter(code)
    assert str(conv) == expect


def test_for(converter):
    code = textwrap.dedent("""\
            for i in range(10):
                pass""")

    expect = textwrap.dedent("""\
            for i in (0 to 10) loop

            end loop;""")
    conv = converter(code)
    assert str(conv) == expect


def test_for2(converter):
    code = textwrap.dedent("""\
            for ite in range(2, 5):
                pass""")

    expect = textwrap.dedent("""\
            for ite in (2 to 5) loop

            end loop;""")
    conv = converter(code)
    assert str(conv) == expect


def test_for_body(converter):
    code = textwrap.dedent("""\
            for i in range(len(a)):
                a[i] = b
                a[i + 1] = c""")

    expect = textwrap.dedent("""\
            for i in (a)'range loop
                a(i) := b;
                a(i + 1) := c;
            end loop;""")
    conv = converter(code)
    assert str(conv) == expect


def test_for_complex(converter):
    code = textwrap.dedent("""\
        for i in range(len(self.taps)):
            self.mul[i] = x * self.taps[i]
            if i == 0:
                self.sm[0] = self.mul[i]
            else:
                self.sm[i] = self.sm[i - 1] + self.mul[i]""")

    expect = textwrap.dedent("""\
            for i in (self.taps)'range loop
                self.mul(i) := x * self.taps(i);
                if i = 0 then
                    self.sm(0) := self.mul(i);
                else
                    self.sm(i) := self.sm(i - 1) + self.mul(i);
                end if;
            end loop;""")
    conv = converter(code)
    assert str(conv) == expect


def test_class_datamodel_sfixed(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
               def __call__(self):
                    pass""")

    data = {'a': Sfix(0.0, 0, -27)}
    expect = textwrap.dedent("""\
            type register_t is record
                a: sfixed(0 downto -27);
            end record;

            type self_t is record
                a: sfixed(0 downto -27);
                \\next\\: register_t;
            end record;""")

    conv = converter(code)
    conv.data = data
    conv = conv.get_datamodel_str()
    assert str(conv) == expect


def test_class_datamodel_sfixed2(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
               def __call__(self):
                    pass""")

    data = OrderedDict()
    data['a'] = Sfix(0.0, 0, -27)
    data['b'] = Sfix(1.0, 3, -8)

    expect = textwrap.dedent("""\
            type register_t is record
                a: sfixed(0 downto -27);
                b: sfixed(3 downto -8);
            end record;

            type self_t is record
                a: sfixed(0 downto -27);
                b: sfixed(3 downto -8);
                \\next\\: register_t;
            end record;""")

    conv = converter(code)
    conv.data = data
    conv = conv.get_datamodel_str()
    assert str(conv) == expect


def test_class_datamodel_sfixed_make_self(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
               def __call__(self):
                    pass""")

    data = OrderedDict()
    data['a'] = Sfix(0.0, 0, -27)

    expect = textwrap.dedent("""\
        procedure make_self(reg: register_t; self: out self_t) is
        begin
            self.a := reg.a;
            self.\\next\\ := reg;
        end procedure;""")
    conv = converter(code)
    conv.data = data
    conv = conv.get_makeself_str()
    assert str(conv) == expect


def test_class_datamodel_sfixed2_make_self(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
               def __call__(self):
                    pass""")

    data = OrderedDict()
    data['a'] = Sfix(0.0, 0, -27)
    data['b'] = Sfix(1.0, 3, -8)

    expect = textwrap.dedent("""\
        procedure make_self(reg: register_t; self: out self_t) is
        begin
            self.a := reg.a;
            self.b := reg.b;
            self.\\next\\ := reg;
        end procedure;""")
    conv = converter(code)
    conv.data = data
    conv = conv.get_makeself_str()
    assert str(conv) == expect


def test_class_datamodel_sfixed_reset(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
               def __call__(self):
                    pass""")

    data = OrderedDict()
    data['a'] = Sfix(0.0, 0, -27)

    expect = textwrap.dedent("""\
        procedure reset(reg: inout register_t) is
        begin
            reg.a := to_sfixed(0.0, 0, -27);
        end procedure;""")
    conv = converter(code)
    conv.data = data
    conv = conv.get_reset_str()
    assert str(conv) == expect


def test_class_datamodel_sfixed2_reset(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
               def __call__(self):
                    pass""")

    data = OrderedDict()
    data['a'] = Sfix(0.0, 0, -27)
    data['b'] = Sfix(3.14, 3, -8)

    expect = textwrap.dedent("""\
        procedure reset(reg: inout register_t) is
        begin
            reg.a := to_sfixed(0.0, 0, -27);
            reg.b := to_sfixed(3.14, 3, -8);
        end procedure;""")
    conv = converter(code)
    conv.data = data
    conv = conv.get_reset_str()
    assert str(conv) == expect


def test_class_call_modifications(converter):
    code = textwrap.dedent("""\
            class Register(HW):
                def __call__(self):
                    pass""")

    expect = textwrap.dedent("""\
        procedure \\__call__\\(reg:inout register_t) is
            variable self: self_t;
        begin
            make_self(reg, self);

            reg := self.\\next\\;
        end procedure;""")
    conv = converter(code)
    conv = conv.get_call_str()
    assert str(conv) == expect


def test_class(converter):
    code = textwrap.dedent("""\
            class Tc(HW):
                def __call__(self):
                    pass""")

    expect = textwrap.dedent("""\
        package Tc is

            procedure \\__call__\\(reg:inout register_t);
        end package;

        package body Tc is
            procedure \\__call__\\(reg:inout register_t) is
                variable self: self_t;
            begin
                make_self(reg, self);
                reg := self.\\next\\;
            end procedure;
        end package body;""")
    conv = converter(code)
    assert str(conv) == expect


def test_class_reserved_name(converter):
    code = textwrap.dedent("""\
            class Register(HW):
                def __call__(self):
                    pass""")

    expect = textwrap.dedent("""\
        package \\Register\\ is

            procedure \\__call__\\(reg:inout register_t);
        end package;

        package body \\Register\\ is
            procedure \\__call__\\(reg:inout register_t) is
                variable self: self_t;
            begin
                make_self(reg, self);
                reg := self.\\next\\;
            end procedure;
        end package body;""")
    conv = converter(code)
    assert str(conv) == expect


def test_class_with_init(converter):
    # init function shall be ignored
    code = textwrap.dedent("""\
            class Tc(HW):
                def __init__(self):
                    loll = loom

                def __call__(self):
                    pass""")

    expect = textwrap.dedent("""\
        package Tc is

            procedure \\__call__\\(reg:inout register_t);
        end package;

        package body Tc is
            procedure \\__call__\\(reg:inout register_t) is
                variable self: self_t;
            begin
                make_self(reg, self);
                reg := self.\\next\\;
            end procedure;
        end package body;""")
    conv = converter(code)
    assert str(conv) == expect

# TODO class conversion
# TODO function calls
