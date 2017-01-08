# TODO: some nodes make changes to AST by using redbaron, it would be good to refactor all these modifications into one step that runs before actual conversion.
# currently some tests must use 'def a(): x' just because DefNodeConv makes some AST conversions.
import logging
import textwrap
from contextlib import suppress

from parse import parse
from redbaron import NameNode, Node, EndlNode, DefNode, AssignmentNode, TupleNode, CommentNode
from redbaron.base_nodes import DotProxyList
from redbaron.nodes import AtomtrailersNode

from pyha.common.hwsim import SKIP_FUNCTIONS, HW
from pyha.common.util import get_iterable, tabber, escape_for_vhdl
from pyha.conversion.coupling import VHDLType, VHDLVariable, pytype_to_vhdl

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
                    if isinstance(xj, DefNode) and xj.name in SKIP_FUNCTIONS:
                        continue
                    self.__dict__[x].append(red_to_conv_hub(xj, caller=self))

        # FIXME: possible bug, need to process strings?
        for x in red_node._str_keys:
            self.__dict__[x] = red_node.__dict__[x]

    # def __iter__(self):
    #     return iter(self.nodes)

    def __str__(self):
        return str(self.red_node)


class NameNodeConv(NodeConv):
    def __str__(self):
        return escape_for_vhdl(self.red_node.value)


class AtomtrailersNodeConv(NodeConv):
    def is_function_call(self):
        return any(isinstance(x, CallNodeConv) for x in self.value)

    def __str__(self):
        ret = ''
        for i, x in enumerate(self.value):
            # add '.' infront if NameNode
            new = '.{}' if isinstance(x, NameNodeConv) and i != 0 else '{}'
            ret += new.format(x)

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
    def __str__(self):

        # test if we are dealing with array appending ([a] + b)
        if self.value == '+':
            if isinstance(self.first, ListNodeConv) or isinstance(self.second, ListNodeConv):
                self.value = '&'
        elif self.value == '>>':
            return '\>>\({}, {})'.format(self.first, self.second)
        return '{} {} {}'.format(self.first, self.value, self.second)


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
        self.name = escape_for_vhdl(self.name)
        self.arguments.extend(self.infer_return_arguments())
        self.variables = self.infer_variables()

    def infer_return_arguments(self):
        try:
            rets = self.red_node('return')[0]
        except IndexError:
            return []

        def get_type(i: int, red):
            name = escape_for_vhdl('ret_' + str(i))
            return VHDLType(name, port_direction='out', red_node=red)

        # atomtrailers return len() > 1 for one return element
        if isinstance(rets.value, AtomtrailersNode) or len(rets.value) == 1:
            return [get_type(0, rets.value)]

        return [get_type(i, x) for i, x in enumerate(rets.value)]

    def infer_variables(self):
        assigns = self.red_node.value('assign')

        variables = []
        for x in assigns:
            if isinstance(x.target, NameNode):
                variables.append(VHDLVariable(NameNodeConv(red_node=x.target), red_node=x))
            elif isinstance(x.target, TupleNode):
                for node in x.target:
                    variables.append(VHDLVariable(NameNodeConv(red_node=node), red_node=x))

        call_args = self.red_node.value('call_argument')
        call_args = [x for x in call_args if str(x)[:4] == 'ret_']
        for x in call_args:
            if isinstance(x.value, AtomtrailersNode) and str(x.value[0]) == 'self':
                continue
            getitem = x.value.getitem
            if getitem is not None:
                variables.append(VHDLVariable(escape_for_vhdl(str(getitem.previous)), red_node=x.value))
            else:
                variables.append(VHDLVariable(escape_for_vhdl(str(x.value)), red_node=x.value))

        # this will work in python 3.6
        # remove_duplicates = {str(x.name):x for x in variables}
        # variables = remove_duplicates.values()
        # retarded code to eliminate duplicate names (using dict sucks cause random order)
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
    def __str__(self):
        base = '(' + ', '.join(str(x) for x in self.value) + ')'
        if str(self.red_node.parent) == 'make_self(self_reg, self)':
            return base + ';'  # fixes some random bug

        is_assign = self.red_node.parent_find('assign')
        if not is_assign and isinstance(self.red_node.next_recursive, EndlNode):
            base += ';'
        return base


class CallArgumentNodeConv(NodeConv):
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


class ListNodeConv(NodeConv):
    def __str__(self):
        if len(self.value) == 1:
            return str(self.value[0])  # [a] -> a
        else:
            ret = '({})'.format(', '.join(str(x) for x in self.value))
            return ret


class EndlNodeConv(NodeConv):
    def __str__(self):
        if isinstance(self.red_node.previous_rendered, CommentNode):
            return '--' + str(self.red_node.previous_rendered)[1:]
        return ''


class CommentNodeConv(NodeConv):
    def __str__(self):
        return '--' + self.value[1:]


class StringNodeConv(NodeConv):
    def __str__(self):
        return '--' + self.value[1:]


# this is mostly array indexing
class GetitemNodeConv(NodeConv):
    # turn python [] indexing to () indexing

    def get_index_target(self):
        return '.'.join(str(x) for x in self.parent.value[:-1])

    def is_negative_indexing(self, obj):
        return isinstance(obj, UnitaryOperatorNodeConv) and int(str(obj)) < 0

    def __str__(self):
        if self.is_negative_indexing(self.value):
            target = self.get_index_target()
            return "({}'length{})".format(target, self.value)

        return '({})'.format(self.value)


class SliceNodeConv(GetitemNodeConv):
    def get_index_target(self):
        return '.'.join(str(x) for x in self.parent.parent.value[:-1])

    # Example: [0:5] -> (0 to 4)
    # x[0:-1] -> x(0 to x'high-1)
    def __str__(self):
        if self.upper is None:
            upper = "{}'high".format(self.get_index_target())
        else:
            # vhdl includes upper limit, subtract one to get same behaviour as in python
            upper = int(str(self.upper)) - 1

        if self.is_negative_indexing(self.upper):
            target = self.get_index_target()
            upper = "{}'high{}".format(target, self.upper)

        lower = 0 if self.lower is None else self.lower
        return '{} to {}'.format(lower, upper)


class ForNodeConv(NodeConv):
    def __str__(self):
        template = textwrap.dedent("""\
                for {ITERATOR} in {RANGE} loop
                {BODY}
                end loop;""")

        sockets = {'ITERATOR': str(self.iterator)}
        sockets['RANGE'] = self.range_to_vhdl(str(self.target))
        sockets['BODY'] = '\n'.join(tabber(str(x)) for x in self.value)
        return template.format(**sockets)

    def range_to_vhdl(self, pyrange):
        # this for was transforemed by 'redbaron_pyfor_to_vhdl'
        if str(self.iterator) == '\\_i_\\':
            return "{}'range".format(pyrange)

        range_len_pattern = parse('\\range\\(len({}))', pyrange)
        if range_len_pattern is not None:
            return range_len_pattern[0] + "'range"
        else:
            range_pattern = parse('\\range\\({})', pyrange)
            if range_pattern is not None:
                two_args = parse('{},{}', range_pattern[0])
                if two_args is not None:
                    return '{} to {}'.format(two_args[0].strip(), two_args[1].strip())
                else:
                    return '0 to {}'.format(range_pattern[0])

        # at this point range was not:
        # range(len(x))
        # range(x)
        # range(x, y)
        # assume
        assert 0


class ClassNodeConv(NodeConv):
    """ This relies heavily on datamodel """

    def __init__(self, red_node, parent=None):

        # see def test_class_call_modifications(converter):
        defn = red_node.find('defnode', name='main')
        if defn is not None:
            defn.arguments[0].target = 'self_reg'
            defn.value.insert(0, 'make_self(self_reg, self)')
            defn.value.append('self_reg = self.next')

        super().__init__(red_node, parent)

        # adds to vhdl main function:
        #         variable self: self_t;
        self.callf = [x for x in self.value if str(x.name) == 'main']
        if len(self.callf):
            self.callf = self.callf[0]
            self.callf.variables.append(VHDLVariable(name='self', var_type='self_t', red_node=None))

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
                use work.ComplexTypes.all;
                use work.PyhaUtil.all;
                use work.all;""")

    def get_reset_prototype(self):
        return 'procedure reset(self_reg: inout register_t);'

    def get_reset_str(self):
        template = textwrap.dedent("""\
        procedure reset(self_reg: inout register_t) is
        begin
        {DATA}
        end procedure;""")

        variables = VHDLType.get_reset()

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

        # variables = ['self.{KEY} := self_reg.{KEY};'.format(KEY=x.name)
        #              for x in VHDLType.get_self()]
        variables = []
        for var in VHDLType.get_self():
            # inital hack that turns variables ending with _const to 'constants'
            if var.name[-6:] == '_const':
                assert isinstance(var.variable, int)
                variables += ['self.{} := {};'.format(var.name, var.variable)]
            else:
                variables += ['self.{k} := self_reg.{k};'.format(k=var.name)]
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

    def get_typedefs(self):
        template = 'type {} is array (natural range <>) of {};'
        typedefs = []
        for val in VHDLType.get_typedef_vars():
            assert type(val) is list
            name = pytype_to_vhdl(val)
            name = name[:name.find('(')]  # cut array size

            type_name = pytype_to_vhdl(val[0])
            if isinstance(val[0], HW):
                type_name += '.register_t'
            new_tp = template.format(name, type_name)
            if new_tp not in typedefs:
                typedefs.append(template.format(name, type_name))

        return typedefs

    def get_name(self):
        return VHDLType.get_self_vhdl_name()

    def __str__(self):
        template = textwrap.dedent("""\
            {IMPORTS}

            package {NAME} is
            {TYPEDEFS}

            {SELF_T}

            {FUNC_HEADERS}
            end package;

            package body {NAME} is
            {RESET_FUNCTION}

            {MAKE_SELF_FUNCTION}

            {OTHER_FUNCTIONS}
            end package body;""")

        sockets = {}
        sockets['NAME'] = self.get_name()
        sockets['IMPORTS'] = self.get_imports()
        sockets['TYPEDEFS'] = '\n'.join(tabber(x) for x in self.get_typedefs())
        sockets['SELF_T'] = tabber(self.get_datamodel())

        sockets['FUNC_HEADERS'] = tabber(self.get_reset_prototype()) + '\n'
        sockets['FUNC_HEADERS'] += '\n'.join(
            tabber(x.get_prototype()) for x in self.value if isinstance(x, DefNodeConv))

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

    # delete __init__, not converting this
    with suppress(AttributeError):
        f = red.find('def', name='__init__')
        f.parent.remove(f)

    # delete model_main, not converting this
    with suppress(AttributeError):
        f = red.find('def', name='model_main')
        f.parent.remove(f)

    red = redbaron_pyfor_to_vhdl(red)
    red = redbaron_pycall_returns_to_vhdl(red)
    red = redbaron_pycall_to_vhdl(red)

    conv = red_to_conv_hub(red, caller)  # converts all nodes

    return conv


#################### FUNCTIONS THAT MODIFY REDBARON AST #############
#####################################################################
#####################################################################
#####################################################################
#####################################################################
#####################################################################


def redbaron_pycall_to_vhdl(red_node):
    """
    Main work is to add 'self' argument to function call
    self.d(a) -> d(self, a)

    If function owner is not exactly 'self' then 'unknown_type' is prepended.
    self.next.moving_average.main(x) -> unknown_type.main(self.next.moving_average, x)

    self.d(a) -> d(self, a)
    self.next.d(a) -> d(self.next, a)
    local.d() -> type.d(local)
    self.local.d() -> type.d(self.local)

    """

    def modify_call(red_node):
        call_args = red_node.find('call')
        i = call_args.previous.index_on_parent
        if i == 0:
            return red_node  # input is something like a()
        prefix = red_node.copy()
        del prefix[i:]
        del red_node[:i]

        # this happens when 'redbaron_pyfor_to_vhdl' does some node replacements
        if isinstance(prefix.value, DotProxyList) and len(prefix) == 1:
            prefix = prefix[0]

        call_args.insert(0, prefix)
        if prefix.dumps() not in ['self', 'self.next']:
            v = VHDLType(str(prefix[-1]), red_node=prefix)
            red_node.insert(0, v.var_type)

    atoms = red_node.find_all('atomtrailers')
    for i, x in enumerate(atoms):
        if x.call is not None:
            modify_call(x)

    return red_node


def redbaron_pycall_returns_to_vhdl(red_node):
    """
    Convert function calls, that return into variable into VHDL format.
    b = self.a(a) ->
        self.a(a, ret_0=b)

    self.next.b[0], self.next.b[1] = self.a(self.a) ->
        self.a(self.a, ret_0=self.next.b[0], ret_1=self.next.b[1])

    """

    def modify_call(x: AssignmentNode):
        if str(x.value[0]) != 'self':  # most likely call to 'resize' no operatons needed
            try:
                if str(x.value[0][0]) != 'self':  # this is some shit that happnes after 'for' transforms
                    return x
            except:
                return x

        call = x.call
        if len(x.target) == 1 or isinstance(x.target, AtomtrailersNode):
            call.append(str(x.target))
            call.value[-1].target = 'ret_0'
        else:
            for j, argx in enumerate(x.target):
                call.append(str(argx))
                call.value[-1].target = 'ret_{}'.format(j)
        return x.value

    assigns = red_node.find_all('assign')
    for x in assigns:
        if x.call is not None:
            new = modify_call(x.copy())
            x.replace(new)
    return red_node


def redbaron_pyfor_to_vhdl(red_node):
    def modify_for(red_node):
        # if for range contains call to 'range' -> skip
        with suppress(Exception):
            if red_node.target('call')[0].previous.value == 'range':
                return red_node

        range = red_node.target
        ite = red_node.iterator

        red_node(ite.__class__.__name__, value=ite.value) \
            .map(lambda x: x.replace('{}[_i_]'.format(range)))

        red_node.iterator = '_i_'
        return red_node

    fors = red_node.find_all('for')
    for x in fors:
        modify_for(x)

    return red_node
