from redbaron import RedBaron


# @pytest.mark.skip
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
