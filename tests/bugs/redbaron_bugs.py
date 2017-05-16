import pytest
from redbaron import RedBaron


def test_redbaron_insert():
    red_node = RedBaron('self.a.main(x)')[0]
    call_args = red_node.find('call')
    prefix = red_node[:call_args.previous.index_on_parent]  # expecting 'self.a'
    call_args.insert(0, prefix)
    assert str(call_args) == '(self.a, x)'


def test_redbaron_prefix_to_arg():
    def prefix_to_arg(red_node):
        call_args = red_node.find('call')
        i = call_args.previous.index_on_parent
        prefix = red_node.copy()
        del prefix[i:]
        del red_node[:i]
        call_args.insert(0, prefix)

    red_node = RedBaron('self.a.main(x)')[0]
    prefix_to_arg(red_node)
    assert str(red_node) == 'main(self.a, x)'

    red_node = RedBaron('self.a.b.c.main(x, c, d)')[0]
    prefix_to_arg(red_node)
    assert str(red_node) == 'main(self.a.b.c, x, c, d)'


# TODO class conversion
# TODO function calls

def test_redbaron_bug119():
    # https://github.com/PyCQA/redbaron/issues/119
    # is this fixed in 0.6.2??
    from redbaron import RedBaron
    import textwrap
    code = textwrap.dedent("""\
        def a():
            pass""")
    red = RedBaron(code)[0]
    red.value.insert(0, 'a')  # <- problem here


def test_redbaron_bug120(converter):
    # https: // github.com / PyCQA / redbaron / issues / 120
    # adding new argumetn breaks help()
    code = 'a(b)'
    red = RedBaron(code)[0]
    red.call.append('c')
    with pytest.raises(Exception):
        red.help(True)
