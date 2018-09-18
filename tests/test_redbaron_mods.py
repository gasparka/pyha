import textwrap

import pytest
from redbaron import RedBaron

from pyha.common.core import Hardware
from pyha.common.fixed_point import Sfix, resize
from pyha.conversion.conversion import get_conversion
from pyha.conversion.redbaron_transforms import convert


@pytest.fixture
def converter():
    class Conv:
        def __call__(self, code):
            red = RedBaron(code)
            return convert(red[0])

    return Conv()


def test_comment(converter):
    code = '# this is comment'
    conv = converter(code)
    assert str(conv) == '-- this is comment'


def test_name(converter):
    code = 'test'
    conv = converter(code)
    assert str(conv) == 'test'


def test_name2(converter):
    code = 'Register'
    conv = converter(code)
    str(conv)
    assert str(conv) == '\\Register\\'


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
    assert str(conv) == 'ret_0 := a;\nreturn;'


def test_return_multiple(converter):
    code = 'return a, b'
    conv = converter(code)
    assert str(conv) == 'ret_0 := a;\nret_1 := b;\nreturn;'


def test_return_self(converter):
    code = 'return self.a, self.next.b'
    conv = converter(code)
    assert str(conv) == 'ret_0 := self.a;\nret_1 := self.\\next\\.b;\nreturn;'


def test_return_self_arrayelem(converter):
    code = 'return self.a[2]'
    conv = converter(code)
    assert str(conv) == 'ret_0 := self.a(2);\nreturn;'


def test_return_call(converter):
    code = 'return a()'
    conv = converter(code)
    assert str(conv) == 'ret_0 := a();\nreturn;'


def test_return_expression(converter):
    code = 'return a < b'
    conv = converter(code)
    assert str(conv) == 'ret_0 := a < b;\nreturn;'


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


def test_bitand(converter):
    code = 'a & b'
    conv = converter(code)
    assert str(conv) == 'a and b'


def test_UnitaryOperatorNode(converter):
    code = 'not(a & b)'
    conv = converter(code)
    assert str(conv) == 'not (a and b)'


def test_UnitaryOperatorNode2(converter):
    code = 'not self.state'
    conv = converter(code)
    assert str(conv) == 'not self.state'


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
    assert expect == str(conv)


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
    assert expect == str(conv)


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
    assert expect == str(conv)


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
    assert expect == str(conv)


def test_if_elif(converter):
    code = """\
        if a:
            a = b
        elif b:
            b = a"""

    expect = """\
        if a then
            a := b;
        elsif b then
            b := a;
        end if;"""
    expect = textwrap.dedent(expect)
    conv = converter(code)
    assert expect == str(conv)


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
            elsif \\next\\ = c or a /= b then
                a := b;
            else
                \\next\\ := a;
            end if;
        else
            b := a;
        end if;"""
    expect = textwrap.dedent(expect)
    conv = converter(code)
    assert expect == str(conv)


def test_call_semicolon(converter):
    code = textwrap.dedent("""\
            if wtf:
                DataWithIndex_1.pyha_deepcopy(self.out, DataWithIndex(data, index=self.counter, valid=True))""")

    expect = textwrap.dedent("""\
            if wtf then
                DataWithIndex_1.pyha_deepcopy(self.\out\, DataWithIndex(data, index=>self.counter, valid=>True));
            end if;""")
    conv = converter(code)
    assert expect == str(conv)


def test_call_resize(converter):
    code = textwrap.dedent("""\
            resize(self.counter, 0, -17)""")

    expect = textwrap.dedent("""\
            resize(self.counter, 0, -17, overflow_style=>fixed_wrap, round_style=>fixed_truncate)""")
    conv = converter(code)
    assert expect == str(conv)


def test_call_resize_size_res(converter):
    code = textwrap.dedent("""\
            resize(self.counter, size_res=self.next.a)""")

    expect = textwrap.dedent("""\
            resize(self.counter, size_res=>self.\\next\\.a, overflow_style=>fixed_wrap, round_style=>fixed_truncate)""")
    conv = converter(code)
    assert expect == str(conv)


def test_call_resize_keyword_params(converter):
    code = textwrap.dedent("""\
            resize(self.counter, size_res=a, overflow_style='saturate', round_style='round')""")

    expect = textwrap.dedent("""\
            resize(self.counter, size_res=>a, overflow_style=>fixed_saturate, round_style=>fixed_round)""")
    conv = converter(code)
    assert expect == str(conv)


def test_call_resize_default_styles(converter):
    code = textwrap.dedent("""\
            resize(self.counter, size_res=a)""")

    expect = textwrap.dedent("""\
            resize(self.counter, size_res=>a, overflow_style=>fixed_wrap, round_style=>fixed_truncate)""")
    conv = converter(code)
    assert expect == str(conv)

    code = textwrap.dedent("""\
            resize(self.counter, 0, -17, 'wrap')""")

    expect = textwrap.dedent("""\
            resize(self.counter, 0, -17, overflow_style=>fixed_wrap, round_style=>fixed_truncate)""")
    conv = converter(code)
    assert expect == str(conv)

    code = textwrap.dedent("""\
            resize(self.counter, 0, -17, 'wrap', 'round')""")

    expect = textwrap.dedent("""\
            resize(self.counter, 0, -17, overflow_style=>fixed_wrap, round_style=>fixed_round)""")
    conv = converter(code)
    assert expect == str(conv)

    code = textwrap.dedent("""\
            resize(self.counter, 0, -17, 'wrap', round_style='round')""")

    expect = textwrap.dedent("""\
            resize(self.counter, 0, -17, overflow_style=>fixed_wrap, round_style=>fixed_round)""")
    conv = converter(code)
    assert expect == str(conv)


def test_call_sfix(converter):
    code = textwrap.dedent("""\
            Sfix(0.95, 0, -17)""")

    expect = textwrap.dedent("""\
            Sfix(0.95, 0, -17, overflow_style=>fixed_wrap, round_style=>fixed_truncate)""")
    conv = converter(code)
    assert expect == str(conv)


def test_call_sfix_one(converter):
    code = textwrap.dedent("""\
            Sfix(0.95, 0, -17, overflow_style='saturate')""")

    expect = textwrap.dedent("""\
            Sfix(0.95, 0, -17, overflow_style=>fixed_saturate, round_style=>fixed_truncate)""")
    conv = converter(code)
    assert expect == str(conv)


def test_call_sfix_one_assign(converter):
    code = textwrap.dedent("""\
            b = Sfix(1.0, 0, -17, overflow_style='saturate')""")

    expect = textwrap.dedent("""\
            b := Sfix(1.0, 0, -17, overflow_style=>fixed_saturate, round_style=>fixed_truncate);""")
    conv = converter(code)
    assert expect == str(conv)


def test_call_sfix_keyword_params(converter):
    code = textwrap.dedent("""\
            Sfix(0.95, size_res=a, overflow_style='wrap', round_style='truncate')""")

    expect = textwrap.dedent("""\
            Sfix(0.95, size_res=>a, overflow_style=>fixed_wrap, round_style=>fixed_truncate)""")
    conv = converter(code)
    assert expect == str(conv)


def test_call_resize_sfix_combined(converter):
    code = textwrap.dedent("""\
            counter_small = resize(Sfix(0, 0, -self.scalebits + 1), size_res=a)""")

    expect = textwrap.dedent("""\
            counter_small := resize(Sfix(0, 0, -self.scalebits + 1, overflow_style=>fixed_wrap, round_style=>fixed_truncate), size_res=>a, overflow_style=>fixed_wrap, round_style=>fixed_truncate);""")
    conv = converter(code)
    assert expect == str(conv)


def test_call_semicolon_assign(converter):
    code = textwrap.dedent("""\
            self.a = a()""")

    expect = textwrap.dedent("""\
            self.a := a();""")
    conv = converter(code)
    assert expect == str(conv)


def test_call_semicolon_if_condition(converter):
    code = textwrap.dedent("""\
        if a():
            pass""")

    expect = textwrap.dedent("""\
        if a() then

        end if;""")

    conv = converter(code)
    assert expect == str(conv)


def test_call_semicolon_if_body(converter):
    code = textwrap.dedent("""\
        if a():
            a()""")

    expect = textwrap.dedent("""\
        if a() then
            a();
        end if;""")

    conv = converter(code)
    assert expect == str(conv)


def test_call_semicolon_for(converter):
    code = textwrap.dedent("""\
        for i in range(len(a)):
            a()""")

    expect = textwrap.dedent("""\
            for i in a'range loop
                a();
            end loop;""")

    conv = converter(code)
    assert expect == str(conv)


def test_call_len(converter):
    code = 'len(x)'
    expect = "x'length"

    conv = converter(code)
    assert expect == str(conv)

    code = 'len(self.x)'
    expect = "self.x'length"

    conv = converter(code)
    assert expect == str(conv)


def test_indexing(converter):
    code = textwrap.dedent("""\
            a[1]""")

    expect = textwrap.dedent("""\
            a(1)""")
    conv = converter(code)
    assert expect == str(conv)


def test_indexing_inc(converter):
    code = textwrap.dedent("""\
            a[b + 1]""")

    expect = textwrap.dedent("""\
            a(b + 1)""")
    conv = converter(code)
    assert expect == str(conv)


def test_indexing_negative_index(converter):
    code = textwrap.dedent("""\
            a[-1]""")

    expect = textwrap.dedent("""\
            a(a'length-1)""")
    conv = converter(code)
    assert expect == str(conv)


def test_indexing_negative_index2(converter):
    code = textwrap.dedent("""\
            self.var[-4]""")

    expect = textwrap.dedent("""\
            self.var(self.var'length-4)""")
    conv = converter(code)
    assert expect == str(conv)


def test_indexing_negative_index3(converter):
    code = textwrap.dedent("""\
            self.next.var[-4]""")

    expect = textwrap.dedent("""\
            self.\\next\\.var(self.\\next\\.var'length-4)""")
    conv = converter(code)
    assert expect == str(conv)


def test_indexing_slice(converter):
    code = textwrap.dedent("""\
            a[0:5]""")

    expect = textwrap.dedent("""\
            a(0 to (5)-1)""")

    conv = converter(code)
    assert expect == str(conv)


def test_indexing_slice_no_lower(converter):
    code = textwrap.dedent("""\
            a[:2]""")

    expect = textwrap.dedent("""\
            a(0 to (2)-1)""")

    conv = converter(code)
    assert expect == str(conv)


def test_indexing_slice_no_lower_negative_upper(converter):
    code = textwrap.dedent("""\
            self.a[:-1]""")

    expect = textwrap.dedent("""\
            self.a(0 to self.a'high-1)""")

    conv = converter(code)
    assert expect == str(conv)


def test_indexing_slice_no_lower_negative_upper2(converter):
    code = textwrap.dedent("""\
            a[:-2]""")

    expect = textwrap.dedent("""\
            a(0 to a'high-2)""")

    conv = converter(code)
    assert expect == str(conv)


def test_indexing_slice_no_upper(converter):
    code = textwrap.dedent("""\
            a[1:]""")

    expect = textwrap.dedent("""\
            a(1 to a'high)""")

    conv = converter(code)
    assert expect == str(conv)


def test_indexing_slice_no_upper_no_lower(converter):
    code = textwrap.dedent("""\
            a[:]""")

    expect = textwrap.dedent("""\
            a(0 to a'high)""")

    conv = converter(code)
    assert expect == str(conv)


# def test_builtin_length(converter):
#     code = textwrap.dedent("""\
#             len(self.taps)""")
#
#     expect = textwrap.dedent("""\
#             len(self.taps)""")
#     conv = converter(code)
#     assert expect == str(conv)
#
#
# def test_builtin_range(converter):
#     code = textwrap.dedent("""\
#             range(self.taps)""")
#
#     expect = textwrap.dedent("""\
#             \\range\\(self.taps)""")
#     conv = converter(code)
#     assert expect == str(conv)


# def test_builtin_range_int(converter):
#     code = textwrap.dedent("""\
#             range(10)""")
#
#     expect = textwrap.dedent("""\
#             \\range\\(10)""")
#     conv = converter(code)
#     assert expect == str(conv)
#
#
# def test_builtin_range_int_start(converter):
#     code = textwrap.dedent("""\
#             range(2, 5)""")
#
#     expect = textwrap.dedent("""\
#             \\range\\(2, 5)""")
#     conv = converter(code)
#     assert expect == str(conv)
#
#
# def test_builtin_range_int_start_step(converter):
#     code = textwrap.dedent("""\
#             range(2, 5, 2)""")
#
#     expect = textwrap.dedent("""\
#             \\range\\(2, 5, 2)""")
#
#     conv = converter(code)
#     assert expect == str(conv)
#
#
# def test_builtin_range_int_start_step_unit(converter):
#     code = textwrap.dedent("""\
#             range(2, 5, 1)""")
#
#     expect = textwrap.dedent("""\
#             \\range\\(2, 5, 1)""")
#
#     conv = converter(code)
#     assert expect == str(conv)


# def test_builtin_range_length(converter):
#     code = textwrap.dedent("""\
#             range(len(self.taps))""")
#
#     expect = textwrap.dedent("""\
#             \\range\\(len(self.taps))""")
#     conv = converter(code)
#     assert expect == str(conv)
#
#
# def test_builtin_reverse_range_length(converter):
#     code = textwrap.dedent("""\
#             reverse(range(len(self.taps)))""")
#
#     expect = textwrap.dedent("""\
#             reverse(\\range\\(len(self.taps)))""")
#     conv = converter(code)
#     assert expect == str(conv)


def test_for_rl(converter):
    code = textwrap.dedent("""\
            for i in range(len(self.next.b)):
                pass""")

    expect = textwrap.dedent("""\
            for i in self.\\next\\.b'range loop

            end loop;""")
    conv = converter(code)
    assert expect == str(conv)


def test_for_rl_arith(converter):
    code = textwrap.dedent("""\
            for i in range(len(self.next.b) + 1):
                pass""")

    expect = textwrap.dedent("""\
            for i in 0 to (self.\\next\\.b'length + 1) - 1 loop

            end loop;""")
    conv = converter(code)
    assert expect == str(conv)


def test_for_rl_arith2(converter):
    code = textwrap.dedent("""\
            for i in range(len(self.next.b) - 10):
                pass""")

    expect = textwrap.dedent("""\
            for i in 0 to (self.\\next\\.b'length - 10) - 1 loop

            end loop;""")
    conv = converter(code)
    assert expect == str(conv)


def test_for_simple_range(converter):
    code = textwrap.dedent("""\
            for i in range(10):
                pass""")

    expect = textwrap.dedent("""\
            for i in 0 to (10) - 1 loop

            end loop;""")
    conv = converter(code)
    assert expect == str(conv)


def test_for_from_to(converter):
    code = textwrap.dedent("""\
            for ite in range(2, 5):
                pass""")

    expect = textwrap.dedent("""\
            for ite in 2 to (5) - 1 loop

            end loop;""")
    conv = converter(code)
    assert expect == str(conv)


def test_for_from_to_variables(converter):
    code = textwrap.dedent("""\
            for ite in range(var, self.var2):
                pass""")

    expect = textwrap.dedent("""\
            for ite in var to (self.var2) - 1 loop

            end loop;""")
    conv = converter(code)
    assert expect == str(conv)


def test_for_from_to_variables_whitespaces(converter):
    code = textwrap.dedent("""\
            for ite in range(var ,   self.var2  ):
                pass""")

    expect = textwrap.dedent("""\
            for ite in var to (self.var2) - 1 loop

            end loop;""")
    conv = converter(code)
    assert expect == str(conv)


def test_for_range_len(converter):
    code = textwrap.dedent("""\
            for i in range(1, len(self.shr)):
                pass""")

    expect = textwrap.dedent("""\
            for i in 1 to (self.shr'length) - 1 loop

            end loop;""")
    conv = converter(code)
    assert expect == str(conv)


def test_for_range_len_sub(converter):
    code = textwrap.dedent("""\
            for i in range(1, len(self.shr)-1):
                pass""")

    expect = textwrap.dedent("""\
            for i in 1 to (self.shr'length - 1) - 1 loop

            end loop;""")
    conv = converter(code)
    assert expect == str(conv)


def test_for_body(converter):
    code = textwrap.dedent("""\
            for i in range(len(a)):
                a[i] = b
                a[i + 1] = c""")

    expect = textwrap.dedent("""\
            for i in a'range loop
                a(i) := b;
                a(i + 1) := c;
            end loop;""")
    conv = converter(code)
    assert expect == str(conv)


def test_for_complex(converter):
    code = textwrap.dedent("""\
        for i in range(len(self.taps)):
            self.mul[i] = x * self.taps[i]
            if i == 0:
                self.sm[0] = self.mul[i]
            else:
                self.sm[i] = self.sm[i - 1] + self.mul[i]""")

    expect = textwrap.dedent("""\
            for i in self.taps'range loop
                self.mul(i) := x * self.taps(i);
                if i = 0 then
                    self.sm(0) := self.mul(i);
                else
                    self.sm(i) := self.sm(i - 1) + self.mul(i);
                end if;
            end loop;""")
    conv = converter(code)
    assert expect == str(conv)


def test_list(converter):
    code = textwrap.dedent("""\
            [a]""")

    expect = textwrap.dedent("""\
            a""")

    conv = converter(code)
    assert expect == str(conv)


def test_list_multiple(converter):
    code = textwrap.dedent("""\
            [1, 2, 3, 4]""")

    expect = textwrap.dedent("""\
            (1, 2, 3, 4)""")

    conv = converter(code)
    assert expect == str(conv)


def test_list_multiple_assign(converter):
    code = textwrap.dedent("""\
            a = [1, 2, 3, 4]
            """)

    expect = textwrap.dedent("""\
            a := (1, 2, 3, 4);""")

    conv = converter(code)
    assert expect == str(conv)


def test_list_append(converter):
    code = textwrap.dedent("""\
            [a] + b""")

    expect = textwrap.dedent("""\
            a & b""")

    conv = converter(code)
    assert expect == str(conv)


def test_list_post_append(converter):
    code = textwrap.dedent("""\
            a + [b]""")

    expect = textwrap.dedent("""\
            a & b""")

    conv = converter(code)
    assert expect == str(conv)


def test_binaryoperator_divide_int(converter):
    code = textwrap.dedent("""\
            a // 1""")

    expect = textwrap.dedent("""\
            integer(a / 1)""")

    conv = converter(code)
    assert expect == str(conv)


def test_binaryoperator_divide_int2(converter):
    code = textwrap.dedent("""\
            a // 1 + 1""")

    expect = textwrap.dedent("""\
            integer(a / 1) + 1""")

    conv = converter(code)
    assert expect == str(conv)


def test_binaryoperator_shift_right(converter):
    code = textwrap.dedent("""\
            a >> 1""")

    expect = textwrap.dedent("""\
            a sra 1""")

    conv = converter(code)
    assert expect == str(conv)


def test_binaryoperator_shift_right_priority(converter):
    code = textwrap.dedent("""\
            (a >> 1)""")

    expect = textwrap.dedent("""\
            (a sra 1)""")

    conv = converter(code)
    assert expect == str(conv)


def test_binaryoperator_shift_left(converter):
    code = textwrap.dedent("""\
            a << b""")

    expect = textwrap.dedent("""\
            a sla b""")

    conv = converter(code)
    assert expect == str(conv)


def test_print(converter):
    code = 'print(a)'
    expect = 'report to_string(a);'

    conv = converter(code)
    assert expect == str(conv)


def test_print_real(converter):
    code = 'print(to_real(self.mem[i]))'
    expect = 'report to_string(to_real(self.mem(i)));'

    conv = converter(code)
    assert expect == str(conv)


def test_print_real_block(converter):
    """ Had excess ; """
    code = """\
        if a:
            print(to_real(self.mem[i]))
        """

    expect = textwrap.dedent("""\
        if a then
            report to_string(to_real(self.mem(i)));
            
        end if;""")

    conv = converter(code)
    assert expect == str(conv)


def test_print_multiarg(converter):
    code = 'print(a, b)'
    expect = 'report to_string(to_real(a));'

    with pytest.raises(Exception):
        conv = converter(code)
        str(conv)


def test_hexanode(converter):
    code = '0xABC'
    expect = '16#ABC#'

    conv = converter(code)
    assert expect == str(conv)

    code = '0X0'
    expect = '16#0#'

    conv = converter(code)
    assert expect == str(conv)


class TestDefNodeConv:
    def test_build_arguments(self):
        class T(Hardware):
            def __init__(self):
                self.reg = 1

            def a(self, i, b, f, l):
                return 1, 1 < 2, resize(f, 0, -17), Sfix(0.1, 0, -5), l[0], self.reg

        dut = T()
        dut._pyha_enable_function_profiling_for_types()
        dut.a(1, False, Sfix(0.5, 1, -2), [1, 2])

        expect = 'self:in self_t; ' \
                 'self_next:inout self_t; ' \
                 'constant self_const: self_t_const; ' \
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
        pytest.skip('Has different ordering on Python 3.6/3.7')
        class T(Hardware):
            def a(self, arg):
                b = False
                i = 1
                i = 2
                arg = 2
                l = [1, 2]

        dut = T()
        dut.a(1)

        expect = 'variable b: boolean;\n' \
                 'variable i: integer;\n' \
                 'variable l: Typedefs.integer_list_t(0 to 1);'

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
        dut._pyha_enable_function_profiling_for_types()
        dut.out(1)

        expect = textwrap.dedent("""\
            procedure \\out\\(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; i: integer; ret_0:out integer) is


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
        dut._pyha_enable_function_profiling_for_types()
        dut.a()

        expect = [
            'type integer_list_t is array (natural range <>) of integer;',
            'type boolean_list_t is array (natural range <>) of boolean;',
            'type sfixed2downto_15_list_t is array (natural range <>) of sfixed(2 downto -15);',
            'type sfixed2downto_1_list_t is array (natural range <>) of sfixed(2 downto -1);',
        ]

        c = get_conversion(dut).build_typedefs()
        assert expect == c


class TestForModification:
    def test_for_self(self):
        class T(Hardware):
            def __init__(self):
                self.arr = [1, 2, 3]

            def a(self):
                for x in self.arr:
                    a = x

        dut = T()
        dut._pyha_enable_function_profiling_for_types()
        dut.a()
        expect = textwrap.dedent("""\
                for \\_i_\\ in self.arr'range loop
                    a := self.arr(\\_i_\\);
                end loop;""")

        conv = get_conversion(dut)
        func = conv.get_function('a')
        assert expect == func.build_body()
