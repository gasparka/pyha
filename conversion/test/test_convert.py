import textwrap

import pytest
from redbaron import RedBaron

from conversion.main import red_to_conv_hub


@pytest.fixture
def converter():
    class Conv:
        def __call__(self, code):
            red = RedBaron(code)
            return red_to_conv_hub(red[0])

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
    assert str(conv) == 'self_next.a'


def test_assign(converter):
    code = 'a = b'
    conv = converter(code)
    assert str(conv) == 'a := b;'


def test_assign_trailers(converter):
    code = 'self.next.reg = self.reg'
    conv = converter(code)
    assert str(conv) == 'self_next.reg := self.reg;'


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
    assert str(conv) == 'ret_0 := self.a;\nret_1 := self_next.b;'


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
    assert str(conv) == 'a * self_next.step'


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


def test_if_single_body(converter):
    code = """if a:
        a = b"""
    conv = converter(code)
    assert str(conv) == 'if a then\n\ta := b;\nend if;'


def test_if_two_statements(converter):
    code = """if a:
        a = b
        b = a"""
    conv = converter(code)
    assert str(conv) == 'if a then\n\ta := b;\n\tb := a;\nend if;'


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
