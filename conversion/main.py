import logging
import textwrap

from common.sfix import Sfix
from common.util import tabber, get_iterable
from redbaron import NameNode, Node, EndlNode

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
                    if xj.name != '__init__':  # init functions are ignored!
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

    def get_call(self):
        return self.value[1]

    def get_argument_pos(self, pos):
        return self.get_call().value[pos].value

    def get_argument_count(self):
        return len(self.get_call().value)

    def __str__(self):
        if str(self.value[0]) == 'self' and str(self.value[1]) == '\\next\\':
            self.value[0] = NameNodeConv(explicit_name='self_next', red_node=self.red_node)
            del self.value[1]

        # TODO: good idea?
        # idea: instead of transforming to vhdl style, create corresponding function mapping in vhdl.
        # that is for range(0) just create vhdl function range(int)... problems with types.
        if self.is_function_call():

            if self.value[0].in_name == 'Sfix':
                self.value[0].in_name = 'to_sfixed'
            elif self.value[0].in_name == 'len':
                return "{}'length".format('.'.join(str(x) for x in self.value[1:]))


            elif self.value[0].in_name == 'range':
                args = self.get_argument_count()
                first_arg = self.get_argument_pos(0)
                if args == 3 and self.get_argument_pos(2).value != '1':
                    # could support, when implement in VHDL
                    raise NotImplementedError('Range function not supported when step is not 1')
                elif args == 3 or args == 2:
                    second_arg = self.get_argument_pos(1)
                    return '({} to {})'.format(first_arg, second_arg)
                elif isinstance(first_arg, IntNodeConv):
                    return '(0 to {})'.format(first_arg)
                    # return True
                elif self.get_argument_pos(0).value[0].value == 'len':  # hitler wrote this
                    inner_atomtrailers = self.get_argument_pos(0)
                    return "{}'range".format('.'.join(str(x) for x in inner_atomtrailers.value[1:]))
                else:
                    return "{}'range".format('.'.join(str(x) for x in self.value[1:]))

        ret = str()
        for x in self.value:
            if isinstance(x, NameNodeConv):
                ret += '.'
            ret += str(x)
        if ret[0] == '.':
            ret = ret[1:]

        # add semicolon for function calls
        if self.is_function_call() and isinstance(self.red_node.previous_rendered, EndlNode):
            ret += ';'

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
        self.name = NameNodeConv(red_node, explicit_name=self.name)
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
        # TODO: maybe this is better to do after simulation?
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

    def get_prototype(self):
        sockets = {'NAME': self.name}
        sockets['ARGUMENTS'] = ''
        if len(self.arguments):
            sockets['ARGUMENTS'] = '(' + '; '.join(str(x) for x in self.arguments) + ')'

        return 'procedure {NAME}{ARGUMENTS};'.format(**sockets)

    def __str__(self):
        PROCEDURE_TEMPLATE = textwrap.dedent("""\
            procedure {NAME}{ARGUMENTS} is
            {VARIABLES}
            begin
            {BODY}
            end procedure;""")
        sockets = {'NAME': self.name}

        sockets['ARGUMENTS'] = ''
        if len(self.arguments):
            sockets['ARGUMENTS'] = '(' + '; '.join(str(x) for x in self.arguments) + ')'

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
    # def function_name(self):
    #     if isinstance(self.parent, AtomtrailersNodeConv):
    #         return self.parent.value[0].value
    #     assert 0

    def __str__(self):
        # if self.function_name() == 'len':
        #     return '(' + ', '.join(str(x) for x in self.value) + ')'
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


class EndlNodeConv(NodeConv):
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


class ForNodeConv(NodeConv):
    def __str__(self):
        FOR_TEMPLATE = textwrap.dedent("""\
                for {ITERATOR} in {RANGE} loop
                {BODY}
                end loop;""")
        sockets = {'ITERATOR': str(self.iterator)}
        sockets['RANGE'] = str(self.target)
        sockets['BODY'] = '\n'.join(tabber(str(x)) for x in self.value)
        return FOR_TEMPLATE.format(**sockets)


class ClassNodeConv(NodeConv):
    def __init__(self, red_node, parent=None):
        try:
            # see def test_class_call_modifications(converter):
            defn = red_node.find('defnode', name='__call__')
            defn.arguments[0].target = 'reg'
            defn.value.insert(0, 'make_self(reg, self)')
        except:
            pass

        super().__init__(red_node, parent)

        # find /__call__/ function and add some stuff
        self.callf = [x for x in self.value if str(x.name) == '\\__call__\\'][0]
        self.callf.variables.append(VHDLVariable(name='self', type='self_t', red_node=None))
        self.callf.arguments[0].target.type = 'register_t'
        self.callf.arguments[0].target.dir = 'inout'

        self.data = []

    def get_call_str(self):
        return str(self.callf)
        # callf = self.value[0]
        #
        # # def __init__(self, name: NameNodeConv, red_node, type: str = None, dir: str = None, value=None):
        # #     self.value = value
        # callf.variables.append(VHDLVariable(name='self', type='self_t', red_node=None))
        # callf.arguments[0].target.type = 'register_t'
        # callf.arguments[0].target.dir = 'inout'
        # return self.value[0]

    def get_reset_str(self):
        template = textwrap.dedent("""\
        procedure reset(reg: inout register_t) is
        begin
        {DATA}
        end procedure;""")

        vars = ['reg.{} := to_sfixed({}, {}, {});'.format(key, val.init_val, val.left, val.right)
                for key, val in self.data.items() if isinstance(val, Sfix)]
        sockets = {'DATA': ''}
        sockets['DATA'] += ('\n'.join(tabber(x) for x in vars))
        return template.format(**sockets)

    def get_makeself_str(self):
        MAKE_TEMPLATE = textwrap.dedent("""\
        procedure make_self(reg: register_t; self: out self_t) is
        begin
        {DATA}
            self.\\next\\ := reg;
        end procedure;""")

        vars = ['self.{KEY} := reg.{KEY};'.format(KEY=key) for key in self.data]
        sockets = {'DATA': ''}
        sockets['DATA'] += ('\n'.join(tabber(x) for x in vars))
        return MAKE_TEMPLATE.format(**sockets)

    def get_datamodel_str(self):
        DATA_TEMPLATE = textwrap.dedent("""\
            type register_t is record
            {DATA}
            end record;

            type self_t is record
            {DATA}
                \\next\\: register_t;
            end record;""")
        sockets = {'DATA': ''}
        sfix_data = ['{}: sfixed({} downto {});'.format(key, val.left, val.right)
                     for key, val in self.data.items() if isinstance(val, Sfix)]
        sockets['DATA'] += ('\n'.join(tabber(x) for x in sfix_data))
        return DATA_TEMPLATE.format(**sockets)

    def __str__(self):
        self.name = NameNodeConv(self.red_node, explicit_name=self.name)
        CLASS_TEMPLATE = textwrap.dedent("""\
            package {NAME} is
            {SELF_T}
            {FUNC_HEADERS}
            end package;

            package body {NAME} is
            {BODY}
            end package body;""")

        sockets = {}
        sockets['NAME'] = str(self.name)
        sockets['SELF_T'] = ''
        sockets['FUNC_HEADERS'] = '\n'.join(tabber(x.get_prototype()) for x in self.value)

        sockets['BODY'] = '\n'.join(tabber(str(x)) for x in self.value)
        return CLASS_TEMPLATE.format(**sockets)


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
