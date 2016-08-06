# import logging
from copy import copy

from redbaron import RedBaron, ClassNode, inspect, DefNode, NameNode, AssignmentNode, ReturnNode, \
    Node, \
    TupleNode

from common.sfix import Sfix
from common.util import tabber, get_iterable
from conversion.templates import PACKAGE_TEMPLATE, RECORD_TEMPLATE, PROCEDURE_TEMPLATE, PROCEDURE_PROTO_TEMPLATE, \
    RED_DEF_TEMPLATE
from misc.metaclass.hwsim import HW

# from register.model.hw_model import Register

import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class NameNodeConv:
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

    def __init__(self, root=None, red_node: NameNode = None, explicit_name=None):
        self.red_no = red_node
        self.root = root
        self.in_name = explicit_name or red_node.value
        self.valid_name = self.parse_name()

    def parse_name(self):
        # vhdl is case insensitive
        if self.in_name.lower() in self.vhdl_reserved_names \
                or self.in_name[0] == '_':
            return '\{}\\'.format(self.in_name)  # "escape" reserved name
        return self.in_name

    def __str__(self):
        return self.valid_name


class AtomtrailersNodeConv:
    def __init__(self, red_node: AssignmentNode, parent=None):
        # logger.info('Atomtrailers conversion of {}'. format(red_node))
        self.red_node = red_node
        self.parent = parent

        # is 'self.next' -> convert to single 'self_next' name
        tmpl = [copy(x) for x in red_node]
        if tmpl[0].value == 'self' and tmpl[1].value == 'next':
            tmpl[0].value = 'self_next'
            del tmpl[1]

        self.nodes = [red_to_conv_hub(x) for x in tmpl]

    def __str__(self):
        return '.'.join(str(x) for x in self.nodes)


class TupleNodeConv:
    def __init__(self, red_node: TupleNode, parent=None):
        self.red_node = red_node
        self.parent = parent
        self.nodes = [red_to_conv_hub(x) for x in self.red_node]

    def __iter__(self):
        return iter(self.nodes)

    def __str__(self):
        return ','.join(str(x) for x in self.nodes)


class AssignmentNodeConv:
    def __init__(self, red_node: AssignmentNode, parent: 'FuncConv' = None):
        self.red_node = red_node
        self.parent = parent

        self.target = red_to_conv_hub(self.red_node.target)
        self.value = red_to_conv_hub(self.red_node.value)

    def __str__(self):
        return '{} := {};'.format(self.target, self.value)


class FuncConv:
    def __init__(self, parent: 'ClassConv', red_node: DefNode):
        self.red_node = red_node

        # special case name
        if red_node.name == '__call__':
            self.name = 'call'
        else:
            self.name = NameNoneConv(explicit_name=red_node.name)

        self.parent = parent

        self.arguments = self.collect_arguments()
        self.code, self.variables = self.parse_body()

        ret_args = self.collect_return_arguments()
        if ret_args is not None:
            self.arguments.append(ret_args)

        pass

    def collect_arguments(self):
        arguments = []
        for arg in self.red_node.arguments:
            name = NameNoneConv(self, arg.target)
            if str(name) == 'self':
                arguments.append('{}: inout self_t'.format(name))
            else:
                # assume everything else is fixed-point type
                arguments.append('{}: sfixed'.format(name))

        return arguments

    def collect_return_arguments(self):
        rets = [x for x in self.code if isinstance(x, ReturnConv)]
        if len(rets) == 0:
            return None
        assert len(rets) <= 1
        ret_vars = len(rets[0].ret_names)

        tmpl = ['ret_{}'.format(i) for i in range(ret_vars)]
        # assume all outputs sfixed
        return ','.join(tmpl) + ': out sfixed'

    def parse_body(self):
        # always make the self_next variable
        variables = ['variable self_next: self_t;']

        first_cmd = 'self_next := self;'
        cmds = [first_cmd]
        for cmd in self.red_node.value:
            if isinstance(cmd, AssignmentNode):
                cmd = AssignmentConv(self, cmd)
            elif isinstance(cmd, ReturnNode):
                cmd = ReturnConv(self, cmd)
            cmds.append(cmd)

        last_cmd = 'self := self_next;'
        cmds.append(last_cmd)
        return cmds, variables

    def get_prototype(self):
        slots = dict()
        slots['NAME'] = self.name
        slots['ARGUMENTS'] = '; '.join(self.arguments)
        return PROCEDURE_PROTO_TEMPLATE.format(**slots)

    def __str__(self):
        slots = dict()
        slots['NAME'] = self.name
        slots['ARGUMENTS'] = '; '.join(self.arguments)
        slots['VARIABLES'] = '\n'.join(tabber(str(x)) for x in self.variables)
        slots['BODY'] = '\n'.join(tabber(str(x)) for x in self.code)
        return PROCEDURE_TEMPLATE.format(**slots)


class ReturnNodeConv:
    def __init__(self, red_node: AssignmentNode, parent: FuncConv = None):
        self.red_node = red_node
        self.parent = parent

        self.ret_names = get_iterable(red_to_conv_hub(self.red_node.value))

    def __str__(self):
        str = ['ret_{} := {};'.format(i, ret) for i, ret in enumerate(self.ret_names)]
        return '\n'.join(str)


class ClassConv:
    init_prefix = 'init_reset'

    def __init__(self, obj, ref_node: ClassNode):
        self.name = NameNoneConv(None, None, explicit_name=obj.__class__.__name__)
        # logger.info('Converting class: {}'.format(self.name))

        self.ref_node = ref_node
        self.obj = obj

        self.registers = self.collect_self_t()
        self.functions = self.convert_functions()

    def collect_self_t(self):
        regs = []
        for key, val in self.obj.__dict__.items():
            if isinstance(val, Sfix):
                name = NameNoneConv(self, red_node=None, explicit_name=key)
                type = 'sfixed({} downto {})'.format(val.left, val.right)
                regs.append('{}: {};'.format(name, type))
            elif key in ['next']:
                continue
            else:
                raise Exception()

        return regs

    def convert_functions(self):
        # rst_func = self.make_reset_function()
        # funcs = [rst_func]
        funcs = []
        for func in self.ref_node('def'):
            if func.name == '__call__':
                funcs += [FuncConv(self, func)]

        return funcs

    def self_t_str(self):
        slots = {}
        slots['NAME'] = 'self_t'
        slots['MEMBERS'] = '\n'.join(tabber(x) for x in self.registers)
        return RECORD_TEMPLATE.format(**slots)

    def make_reset_function(self):
        tmpl = []
        for key, val in self.obj.__dict__.items():
            if isinstance(val, Sfix):
                value = 'to_sfixed({}, {}, {})'.format(val, val.left, val.right)
                tmpl += ['self.{} = {}'.format(key, value)]
            elif key in ['next']:
                continue
            else:
                raise Exception()

        slots = {}
        slots['NAME'] = 'reset'
        slots['ARGUMENTS'] = 'self'
        slots['BODY'] = '\n'.join(tabber(x) for x in tmpl)
        pyfun = RED_DEF_TEMPLATE.format(**slots)
        red = RedBaron(pyfun)
        return FuncConv(self, red.defnode)

    def __str__(self):
        slots = dict()
        slots['NAME'] = self.name
        slots['SELF_T'] = tabber(self.self_t_str())
        slots['HEADER'] = '\n'.join(tabber(x.get_prototype()) for x in self.functions)
        slots['BODY'] = '\n\n'.join(tabber(str(x)) for x in self.functions) + '\n'
        return PACKAGE_TEMPLATE.format(**slots)


def main(root_obj):
    assert isinstance(root_obj, HW)  # must derive from HW

    name = root_obj.__class__.__name__
    source_path = inspect.getsourcefile(type(r))
    content = open(source_path).read()
    red = RedBaron(content)

    cls = red('classnode')
    assert len(cls) == 1  # more than 1 class in file
    cls = cls[0]

    cls = ClassConv(root_obj, cls)
    print(cls)
    with open('converted.vhd', 'w') as f:
        print(cls, file=f)

    # slots = dict()
    # slots['NAME'] = name
    # slots['HEADER'] = 'head'
    # slots['BODY'] = 'body'
    # print(PACKAGE_TEMPLATE.format(**slots))

    pass


# r = Register()
# main(r)
# path = '/home/gaspar/git/hwpy/components/register/model/hw_model.py'
# file_content = open(path).read()
#
# red = RedBaron(file_content)
#
# cls = red('classnode')
#
# ret = convert_classnode(cls[0])

class NodeConv:
    def __init__(self, red_node, parent=None):
        self.red_node = red_node
        self.parent = parent
        try:
            self.nodes = [red_to_conv_hub(x) for x in self.red_node]
        except TypeError:
            self.nodes = None

        for x in red_node._dict_keys:
            self.__dict__[x] = red_to_conv_hub(red_node.__dict__[x])

        for x in red_node._list_keys:
            if x == 'value':
                self.__dict__[x] = []
                for xj in red_node.__dict__[x]:
                    self.__dict__[x].append(red_to_conv_hub(xj))

        # FIXME: possible bug, need to process strgins?
        for x in red_node._str_keys:
            self.__dict__[x] = red_node.__dict__[x]

    def __iter__(self):
        return iter(self.nodes)

    def __str__(self):
        return str(self.red_node)


class ComparisonNodeConv(NodeConv):
    def __str__(self):
        return '{} {} {}'.format(self.first, self.value, self.second)


class BinaryOperatorNodeConv(ComparisonNodeConv):
    pass


class BooleanOperatorNodeConv(ComparisonNodeConv):
    pass


class ComparisonOperatorNodeConv(NodeConv):
    def __str__(self):
        # VHDL has  '=' for '=='
        if self.first == '==':
            return '='
        # VHDL has retarded '/=' for '!='
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


class DefNodeConv(NodeConv):
    pass


def red_to_conv_hub(red: Node):
    """ Convert RedBaron class to conversion class
    For example: red:NameNode returns NameNodeConv class
    """
    import sys

    red_type = red.__class__.__name__
    cls = getattr(sys.modules[__name__], red_type + 'Conv')
    # if cls is None:
    #     return NodeConv(red_node=red)

    return cls(red_node=red)
