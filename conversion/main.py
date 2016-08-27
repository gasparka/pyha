import logging
import textwrap

from common.util import tabber, get_iterable
from redbaron import NameNode, Node

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class NodeConv:
    def __init__(self, red_node, parent=None):
        self.red_node = red_node
        self.parent = parent

        for x in red_node._dict_keys:
            self.__dict__[x] = red_to_conv_hub(red_node.__dict__[x], caller=self)

        for x in red_node._list_keys:
            if 'format' not in x:
                self.__dict__[x] = []
                for xj in red_node.__dict__[x]:
                    self.__dict__[x].append(red_to_conv_hub(xj, caller=self))

        # FIXME: possible bug, need to process strings?
        for x in red_node._str_keys:
            self.__dict__[x] = red_node.__dict__[x]

    # def __iter__(self):
    #     return iter(self.nodes)

    def __str__(self):
        return str(self.red_node)


class NameNodeConv(NodeConv):
    vhdl_reserved_names = ['abs', 'after', 'alias', 'all', 'and', 'architecture',
                           'array', 'assert', 'attribute', 'begin', 'block', 'body',
                           'buffer', 'bus', 'case', 'component', 'configuration',
                           'constant', 'disconnect', 'downto', 'else', 'elsif', 'end',
                           'entity', 'exit', 'file', 'for', 'function', 'generate', 'generic',
                           'group', 'guarded', 'if', 'impure', 'in', 'inertial', 'inout', 'is',
                           'label', 'library', 'linkage', 'literal', 'loop', 'map', 'mod',
                           'nand', 'new', 'next', 'nor', 'not', 'null', 'of', 'on', 'open', 'or',
                           'others', 'out', 'package', 'port', 'postponed', 'procedure',
                           'process', 'pure', 'range', 'record', 'register', 'reject', 'rem',
                           'report', 'return', 'rol', 'ror', 'select', 'severity', 'signal',
                           'shared', 'sla', 'sll', 'sra', 'srl', 'subtype', 'then', 'to',
                           'transport', 'type', 'unaffected', 'units', 'until', 'use',
                           'variable', 'wait', 'when', 'while', 'with', 'xnor', 'xor']

    def __init__(self, red_node, parent=None, explicit_name=None):
        super().__init__(red_node, parent)
        self.in_name = explicit_name or red_node.value

    def __str__(self):
        # vhdl is case insensitive
        if self.in_name.lower() in self.vhdl_reserved_names \
                or self.in_name[0] == '_':
            return '\{}\\'.format(self.in_name)  # "escape" reserved name
        return self.in_name


class AtomtrailersNodeConv(NodeConv):
    def is_function_call(self):
        return any(isinstance(x, CallNodeConv) for x in self.value)

    def is_indexing(self):
        return any(isinstance(x, GetitemNodeConv) for x in self.value)

    def __str__(self):
        # is 'self.next' -> convert to single 'self_next' name
        # tmpl = [copy(x) for x in self.value]
        # if str(tmpl[0]) == 'self' and str(tmpl[1]) == '\\next\\':
        #     tmpl[0] = NameNodeConv(explicit_name='self_next', red_node=self.red_node)
        #     del tmpl[1]
        #
        # if self.is_function_call():
        #     if tmpl[0].in_name == 'Sfix':
        #         tmpl[0].in_name = 'to_sfixed'
        #     # return ''.join(str(x) for x in tmpl)
        #
        # ret = str()
        # for x in tmpl:
        #     if isinstance(x, NameNodeConv):
        #         ret += '.'
        #     ret += str(x)
        # if ret[0] == '.':
        #     ret = ret[1:]

        if str(self.value[0]) == 'self' and str(self.value[1]) == '\\next\\':
            self.value[0] = NameNodeConv(explicit_name='self_next', red_node=self.red_node)
            del self.value[1]

        if self.is_function_call():
            if self.value[0].in_name == 'Sfix':
                self.value[0].in_name = 'to_sfixed'
                # return ''.join(str(x) for x in tmpl)

        ret = str()
        for x in self.value:
            if isinstance(x, NameNodeConv):
                ret += '.'
            ret += str(x)
        if ret[0] == '.':
            ret = ret[1:]

        return ret


class TupleNodeConv(NodeConv):
    def __iter__(self):
        return iter(self.value)

    def __str__(self):
        return ','.join(str(x) for x in self.value)


class AssignmentNodeConv(NodeConv):
    def __str__(self):
        return '{} := {};'.format(self.target, self.value)


class ReturnNodeConv(NodeConv):
    def __str__(self):
        str = ['ret_{} := {};'.format(i, ret) for i, ret in enumerate(get_iterable(self.value))]
        return '\n'.join(str)


class ComparisonNodeConv(NodeConv):
    def __str__(self):
        return '{} {} {}'.format(self.first, self.value, self.second)


class BinaryOperatorNodeConv(ComparisonNodeConv):
    pass


class BooleanOperatorNodeConv(ComparisonNodeConv):
    pass


class AssociativeParenthesisNodeConv(NodeConv):
    def __str__(self):
        return '({})'.format(self.value)


class ComparisonOperatorNodeConv(NodeConv):
    def __str__(self):
        if self.first == '==':
            return '='
        elif self.first == '!=':
            return '/='
        else:
            return super().__str__()


class IfelseblockNodeConv(NodeConv):
    def __str__(self):
        body = '\n'.join(str(x) for x in self.value)
        return body + '\nend if;'


class IfNodeConv(NodeConv):
    def __str__(self):
        body = '\n'.join(tabber(str(x)) for x in self.value)
        return 'if {TEST} then\n{BODY}'.format(TEST=self.test, BODY=body)


class ElseNodeConv(NodeConv):
    def __str__(self):
        body = '\n'.join(tabber(str(x)) for x in self.value)
        return 'else\n{BODY}'.format(BODY=body)


class ElifNodeConv(NodeConv):
    def __str__(self):
        body = '\n'.join(tabber(str(x)) for x in self.value)
        return 'elseif {TEST} then\n{BODY}'.format(TEST=self.test, BODY=body)


class DefNodeConv(NodeConv):
    def __init__(self, red_node, parent=None):
        super().__init__(red_node, parent)
        self.arguments.extend(self.infer_return_arguments())
        self.variables = self.infer_variables()

    def infer_return_arguments(self):
        try:
            rets = self.red_node('return')[0]
        except IndexError:
            return []

        def get_type(i: int):
            return VHDLType(NameNodeConv(explicit_name='ret_' + str(i), red_node=rets), dir='out', red_node=rets)

        try:
            return [get_type(i) for i, x in enumerate(rets.value)]
        except TypeError:
            # only one return
            return [get_type(0)]

    def infer_variables(self):
        assigns = self.red_node.value('assign')
        variables = [VHDLVariable(NameNodeConv(red_node=x.target), red_node=x) for x in assigns if
                     isinstance(x.target, NameNode)]

        # retarded code to eliminate duplicate names
        tmp = []
        for x in variables:
            names = [str(x.name) for x in tmp]
            if str(x.name) not in names:
                tmp.append(x)
        variables = tmp

        # remove variables that are actually arguments
        args = [str(x.target.name) for x in self.arguments]
        return [x for x in variables if str(x.name) not in args]

    def __str__(self):
        PROCEDURE_TEMPLATE = textwrap.dedent("""\
            procedure {NAME}{ARGUMENTS} is
            {VARIABLES}
            begin
            {BODY}
            end procedure;""")
        sockets = {'NAME': self.name}

        self.infer_return_arguments()
        sockets['ARGUMENTS'] = ''
        if len(self.arguments):
            sockets['ARGUMENTS'] = '(' + '; '.join(str(x) for x in self.arguments) + ')'

        self.infer_variables()
        sockets['VARIABLES'] = ''
        if len(self.variables):
            sockets['VARIABLES'] = '\n'.join(tabber(str(x)) for x in self.variables)

        sockets['BODY'] = '\n'.join(tabber(str(x)) for x in self.value)
        return PROCEDURE_TEMPLATE.format(**sockets)


class VHDLType:
    # TODO: All instances must be recorded for later type recovery
    def __init__(self, name: NameNodeConv, red_node, type: str = None, dir: str = None, value=None):
        self.value = value
        self.red_node = red_node
        self.dir = dir
        self.type = type
        self.name = name

        # hack to make 'self.target.name' duck typing work
        class Hack:
            def __init__(self, name):
                self.name = name

        self.target = Hack(self.name)

    def __str__(self):
        type = self.type or 'unknown_type'
        dir = self.dir or ''
        default_value = ':={}'.format(self.value) if self.value else ''
        str = '{}:{} {}{}'.format(self.name, dir, type, default_value)
        return str


class VHDLVariable(VHDLType):
    def __str__(self):
        sup = super().__str__()
        return 'variable ' + sup + ';'


class DefArgumentNodeConv(NodeConv):
    def __init__(self, red_node, parent=None):
        super().__init__(red_node, parent)
        self.target = VHDLType(name=self.target, red_node=red_node, value=self.value)

    def __str__(self):
        return str(self.target)


class PassNodeConv(NodeConv):
    def __str__(self):
        return ''


class CallNodeConv(NodeConv):
    def __str__(self):
        return '(' + ', '.join(str(x) for x in self.value) + ')'


class CallArgumentNodeConv(NodeConv):
    # def function_name(self):
    #     return self.red_node.parent.parent.value[0].value

    def __str__(self):
        # transform keyword arguments
        # change = to =>
        if self.target is not None:
            return '{}=>{}'.format(self.target, self.value)

        return str(self.value)

    pass


class IntNodeConv(NodeConv):
    pass


class FloatNodeConv(NodeConv):
    pass


class UnitaryOperatorNodeConv(NodeConv):
    pass


# this is mostly array indexing
class GetitemNodeConv(NodeConv):
    # turn python [] indexing to () indexing

    def get_index_target(self):
        return '.'.join(str(x) for x in self.parent.value[:-1])

    def __str__(self):
        if isinstance(self.value, UnitaryOperatorNodeConv) and int(str(self.value)) < 0:
            target = self.get_index_target()
            return "({}'length{})".format(target, self.value)

        return '({})'.format(self.value)


def red_to_conv_hub(red: Node, caller):
    """ Convert RedBaron class to conversion class
    For example: red:NameNode returns NameNodeConv class
    """
    import sys

    try:
        red_type = red.__class__.__name__
        cls = getattr(sys.modules[__name__], red_type + 'Conv')
    except AttributeError:
        if red_type == 'NoneType':
            return None
        raise

    return cls(red_node=red, parent=caller)
