import logging
import textwrap

from pyha.common.sfix import Sfix
from pyha.common.util import get_iterable, tabber
from pyha.conversion.coupling import VHDLType, VHDLVariable
from redbaron import NameNode, Node, EndlNode
from redbaron.nodes import AtomtrailersNode

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class ExceptionReturnFunctionCall(Exception):
    def __init__(self, red_node: Node):
        message = 'Trying to return something that is not an variable!\nLine: {}'.format(red_node)
        super().__init__(message)


# class ExceptionUnknownReturnVariable(Exception):
#     def __init__(self, datamodel: DataModel, red_node: Node):
#         message = textwrap.dedent("""\
#         Did not find returned variable in datamodel:
#         Line: {}
#         Datamodel:
#             {}
#         """).format(red_node, datamodel)
#         super().__init__(message)

class NodeConv:
    def __init__(self, red_node, parent=None):
        self.red_node = red_node
        self.parent = parent
        self.target = None
        self.value = None
        self.first = None
        self.second = None
        self.test = None
        self.arguments = None
        self.name = None
        self.iterator = None

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

    @classmethod
    def parse(cls, name: str):
        if name.lower() in cls.vhdl_reserved_names \
                or name[0] == '_':
            return '\{}\\'.format(name)  # "escape" reserved name
        return name

    def __str__(self):
        return NameNodeConv.parse(self.red_node.value)


class AtomtrailersNodeConv(NodeConv):
    def is_function_call(self):
        return any(isinstance(x, CallNodeConv) for x in self.value)

    def __str__(self):

        # remove 'self.' from function calls
        if self.is_function_call() and str(self.value[0]) == 'self':
            del self.value[0]

        # basically on some occasions, dont separate nodes with '.'
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
        for x in get_iterable(self.value):
            if isinstance(x, AtomtrailersNodeConv) and x.is_function_call():
                raise ExceptionReturnFunctionCall(self.red_node)
            elif not isinstance(x, (NameNodeConv, AtomtrailersNodeConv, IntNodeConv)):
                raise ExceptionReturnFunctionCall(self.red_node)

        str_ret = ['ret_{} := {};'.format(i, ret) for i, ret in enumerate(get_iterable(self.value))]
        return '\n'.join(str_ret)


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
    def function_calls_transform(self, red_node):
        # find all assignment nodes, check if they contain 'self' function call
        # -> transform
        assigns = red_node.find_all('assign')
        for i, x in enumerate(assigns):
            if isinstance(x.value, AtomtrailersNode) and str(x.value[0]) == 'self':
                call = x('call')
                if len(call) == 1:  # some function is called
                    call = call[0]
                    if len(x.target) == 1:
                        call.append(str(x.target))
                        call.value[-1].target = 'ret_0'
                    else:
                        for j, argx in enumerate(x.target):
                            call.append(str(argx))
                            call.value[-1].target = 'ret_{}'.format(j)

                    x.replace(x.value)

    def __init__(self, red_node, parent=None):
        self.function_calls_transform(red_node)

        super().__init__(red_node, parent)
        self.name = NameNodeConv.parse(self.name)
        self.arguments.extend(self.infer_return_arguments())
        self.variables = self.infer_variables()

    def infer_return_arguments(self):
        try:
            rets = self.red_node('return')[0]
        except IndexError:
            return []

        def get_type(i: int, red):
            name = NameNodeConv.parse('ret_' + str(i))
            return VHDLType(name, port_direction='out', red_node=red)

        # atomtrailers return len() > 1 for one return element
        if isinstance(rets.value, AtomtrailersNode) or len(rets.value) == 1:
            return [get_type(0, rets.value)]

        return [get_type(i, x) for i, x in enumerate(rets.value)]

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

    def get_prototype(self):
        sockets = {'NAME': self.name}
        sockets['ARGUMENTS'] = ''
        if len(self.arguments):
            sockets['ARGUMENTS'] = '(' + '; '.join(str(x) for x in self.arguments) + ')'

        return 'procedure {NAME}{ARGUMENTS};'.format(**sockets)

    def __str__(self):
        template = textwrap.dedent("""\
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
        return template.format(**sockets)


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
    def __str__(self):
        return ''


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
        template = textwrap.dedent("""\
                for {ITERATOR} in {RANGE} loop
                {BODY}
                end loop;""")
        sockets = {'ITERATOR': str(self.iterator)}
        sockets['RANGE'] = str(self.target)
        sockets['BODY'] = '\n'.join(tabber(str(x)) for x in self.value)
        return template.format(**sockets)


class ClassNodeConv(NodeConv):
    """ This relies heavily on datamodel """

    def __init__(self, red_node, parent=None):

        # see def test_class_call_modifications(converter):
        defn = red_node.find('defnode', name='__call__')
        if defn is not None:
            defn.arguments[0].target = 'self_reg'
            defn.value.insert(0, 'make_self(self_reg, self)')
            defn.value.append('self_reg = self.next')

        super().__init__(red_node, parent)

        self.callf = [x for x in self.value if str(x.name) == '\\__call__\\']
        if len(self.callf):
            self.callf = self.callf[0]
            self.callf.variables.append(VHDLVariable(name='self', var_type='self_t', red_node=None))
            # self.callf.arguments[0].target.var_type = 'register_t'
            # self.callf.arguments[0].target.port_direction = 'inout'

        self.data = {}

    def get_call_str(self):
        return str(self.callf)

    def get_imports(self):
        return textwrap.dedent("""\
            library ieee;
                use ieee.std_logic_1164.all;
                use ieee.numeric_std.all;
                use ieee.fixed_float_types.all;
                use ieee.fixed_pkg.all;
                use ieee.math_real.all;

            library work;
                use work.all;""")

    def get_reset_prototype(self):
        return 'procedure reset(self_reg: inout register_t);'

    def get_reset_str(self):
        template = textwrap.dedent("""\
        procedure reset(self_reg: inout register_t) is
        begin
        {DATA}
        end procedure;""")

        variables = []
        for key, val in VHDLType._datamodel.self_data.items():
            if key == 'next': continue
            if isinstance(val, Sfix):
                tmp = 'self_reg.{} := to_sfixed({}, {}, {});'.format(key, val.init_val, val.left, val.right)
            else:
                tmp = 'self_reg.{} := {};'.format(key, val)
            variables.append(tmp)

        sockets = {'DATA': ''}
        sockets['DATA'] += ('\n'.join(tabber(x) for x in variables))
        return template.format(**sockets)

    def get_makeself_str(self):
        template = textwrap.dedent("""\
        procedure make_self(self_reg: register_t; self: out self_t) is
        begin
        {DATA}
            self.\\next\\ := self_reg;
        end procedure;""")

        variables = ['self.{KEY} := self_reg.{KEY};'.format(KEY=key)
                     for key in VHDLType._datamodel.self_data
                     if str(key) != 'next']
        sockets = {'DATA': ''}
        sockets['DATA'] += ('\n'.join(tabber(x) for x in variables))
        return template.format(**sockets)

    def get_datamodel(self):
        template = textwrap.dedent("""\
            type register_t is record
            {DATA}
            end record;

            type self_t is record
            {DATA}
                \\next\\: register_t;
            end record;""")
        sockets = {'DATA': ''}
        sockets['DATA'] += ('\n'.join(tabber(str(x) + ';') for x in VHDLType.get_self()))
        return template.format(**sockets)

    def __str__(self):
        template = textwrap.dedent("""\
            {IMPORTS}

            package {NAME} is
            {SELF_T}

            {FUNC_HEADERS}
            end package;

            package body {NAME} is
            {RESET_FUNCTION}

            {MAKE_SELF_FUNCTION}

            {OTHER_FUNCTIONS}
            end package body;""")

        sockets = {}
        sockets['NAME'] = NameNodeConv.parse(self.name)
        sockets['IMPORTS'] = self.get_imports()
        sockets['SELF_T'] = tabber(self.get_datamodel())

        sockets['FUNC_HEADERS'] = tabber(self.get_reset_prototype()) + '\n'
        sockets['FUNC_HEADERS'] += '\n'.join(tabber(x.get_prototype()) for x in self.value)

        sockets['RESET_FUNCTION'] = tabber(self.get_reset_str())
        sockets['MAKE_SELF_FUNCTION'] = tabber(self.get_makeself_str())
        sockets['OTHER_FUNCTIONS'] = '\n\n'.join(tabber(str(x)) for x in self.value)

        return template.format(**sockets)


def red_to_conv_hub(red: Node, caller):
    """ Convert RedBaron class to conversion class
    For example: red:NameNode returns NameNodeConv class
    """
    import sys

    red_type = red.__class__.__name__
    try:
        cls = getattr(sys.modules[__name__], red_type + 'Conv')
    except AttributeError:
        if red_type == 'NoneType':
            return None
        raise

    return cls(red_node=red, parent=caller)


def convert(red: Node, caller=None, datamodel=None):
    from pyha.conversion.extract_datamodel import DataModel
    assert type(caller) is not DataModel
    VHDLType.set_datamodel(datamodel)
    conv = red_to_conv_hub(red, caller)

    return conv
