# TODO: This file is 100% mess, only works thanks to unit tests
from enum import Enum

from redbaron import GetitemNode, DefNode, AssignmentNode, IntNode, NameNode, CallArgumentNode
from redbaron.nodes import DefArgumentNode, AtomtrailersNode

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, ComplexSfix
from pyha.common.util import escape_for_vhdl
from pyha.conversion.extract_datamodel import DataModel


class ExceptionCoupling(Exception):
    pass


def pytype_to_vhdl(var):
    if type(var) is bool:
        return 'boolean'
    elif type(var) is int:
        return 'integer'
    elif type(var) is float:
        return 'real'
    elif type(var) is Sfix:
        return f'sfixed({var.left} downto {var.right})'
    elif type(var) is ComplexSfix:
        left, right = bounds_to_str(var)
        return f'complex_sfix{left}{right}'
    elif type(var) is list:
        arr_token = f'_list_t(0 to {len(var) - 1})'
        if type(var[0]) is bool:
            return 'boolean' + arr_token
        elif type(var[0]) is int:
            return 'integer' + arr_token
        elif type(var[0]) is float:
            return 'real' + arr_token
        elif type(var[0]) is Sfix:
            left, right = bounds_to_str(var[0])
            return f'sfixed{left}{right}{arr_token}'
        elif type(var[0]) is ComplexSfix:
            left, right = bounds_to_str(var[0])
            return f'complex_sfix{left}{right}{arr_token}'
        elif isinstance(var[0], HW):
            return pytype_to_vhdl(var[0]) + arr_token
        else:
            assert 0
    elif isinstance(var, HW):
        idstr = get_instance_vhdl_name(var)
        return idstr
    elif isinstance(var, Enum):
        return type(var).__name__
    else:
        assert 0


def bounds_to_str(var):
    left = var.left if var.left >= 0 else '_' + str(abs(var.left))
    right = var.right if var.right >= 0 else '_' + str(abs(var.right))
    return left, right


def reset_maker(self_data, recursion_depth=0):
    lines = []
    prefix = 'self' if recursion_depth == 0 else ''
    for var_name, var_value in self_data.items():
        if var_name == 'next':
            continue
        var_name = escape_for_vhdl(var_name)

        if isinstance(var_value, (Sfix, ComplexSfix)):
            lines.append(f'{prefix}.\\next\\.{var_name} := {var_value.vhdl_reset()};')

        elif isinstance(var_value, (Enum)):
            lines.append(f'{prefix}.\\next\\.{var_name} := {var_value.name};')

        # list of submodules
        elif isinstance(var_value, list) and isinstance(var_value[0], HW):
            for i, x in enumerate(var_value):
                dm = DataModel(x)
                resets = reset_maker(dm.self_data, recursion_depth + 1)  # recursion here
                vars = [f'{prefix}.{var_name}({i}){x}' for x in resets]
                lines.extend(vars)

        # some other list
        elif isinstance(var_value, list):
            lines.append(f'{prefix}.\\next\\.' + list_reset('', var_name, var_value))

        # submodule
        elif isinstance(var_value, HW):
            if recursion_depth == 0:
                lines.append(f'{get_instance_vhdl_name(var_value)}.\\_pyha_reset_self\\(self.{var_name});')
            else:
                # submodule of lists of submodules
                dm = DataModel(var_value)
                resets = reset_maker(dm.self_data, recursion_depth + 1)  # recursion here
                vars = [f'{prefix}.{var_name}{x}' for x in resets]
                lines.extend(vars)
        else:
            lines.append(f'{prefix}.\\next\\.{var_name} := {var_value};')

    return lines


def list_reset(prefix, key, value):
    if isinstance(value[0], (Sfix, ComplexSfix)):
        lstr = '(' + ', '.join(x.vhdl_reset() for x in value) + ')'
    else:
        lstr = '(' + ', '.join(str(x) for x in value) + ')'
    tmp = f'{prefix + key} := {lstr};'
    return tmp


def get_instance_vhdl_name(variable=None, name: str = '', id: int = 0):
    if variable is not None:
        name = type(variable).__name__
        id = variable._pyha_instance_id
    return escape_for_vhdl(f'{name}_{id}')


class VHDLType:
    """ This merges converter and datamodel code. Converter provides a variable,
    datamodel provides a type, this finds a type fof variable"""

    _datamodel = None

    @classmethod
    def set_datamodel(cls, dm: DataModel):
        cls._datamodel = dm

    @classmethod
    def get_reset(cls):
        return reset_maker(cls._datamodel.self_data)

    @classmethod
    def get_self_vhdl_name(cls):
        if cls._datamodel.obj is None:
            return 'unknown_name'
        return get_instance_vhdl_name(cls._datamodel.obj)

    @classmethod
    def get_constants(cls):
        if cls._datamodel is None:
            return []
        ret = []
        for k, v in cls._datamodel.constants.items():
            t = VHDLType(tuple_init=(k, v))
            ret.append(t)
        return ret

    @classmethod
    def get_self(cls):
        if cls._datamodel is None:
            return []
        ret = []
        for k, v in cls._datamodel.self_data.items():
            if k == 'next':
                continue
            t = VHDLType(tuple_init=(k, v))

            # todo remove this hack
            if isinstance(v, HW):
                t.var_type += '.self_t'
            ret.append(t)
        return ret

    @classmethod
    def get_complex_vars(cls):
        typedefs = cls._get_vars_by_type(ComplexSfix)
        return typedefs

    @classmethod
    def _get_vars_by_type(cls, find_type):
        def scan_arr(arr, find_type):
            ret = []
            for var in arr:
                if isinstance(var, find_type):
                    ret.append(var)
                elif isinstance(var, list) and isinstance(var[0], find_type):
                    ret.append(var[0])
            return ret

        vars = []

        # from self.data
        vars.extend(scan_arr(cls._datamodel.self_data.values(), find_type))

        # from constants
        vars.extend(scan_arr(cls._datamodel.constants.values(), find_type))

        # from locals
        for func in cls._datamodel.locals.values():
            vars.extend(scan_arr(func.values(), find_type))

        return vars

    @classmethod
    def get_typedef_vars(cls):
        """ Return all variables that require new type definition in VHDL, for example arrays"""
        typedefs = cls._get_vars_by_type(list)

        # ignore boolean arrays, there is global definition for that
        typedefs = [x for x in typedefs if not isinstance(x[0], bool)]
        return typedefs

    @classmethod
    def get_enum_vars(cls):
        typedefs = cls._get_vars_by_type(Enum)
        return typedefs

    def __init__(self, name=None, red_node=None, var_type: str = None, port_direction: str = None, value=None,
                 tuple_init=None):
        from pyha.conversion.converter import NameNodeConv
        self.value = value
        self.red_node = red_node
        self.port_direction = port_direction
        self.variable = None
        if tuple_init is not None:
            self.name = escape_for_vhdl(tuple_init[0])
            self.variable = tuple_init[1]
            self.var_type = pytype_to_vhdl(self.variable)
            # self.var_typedef = self.deduce_typedef(tuple_init[1])
            return

            # hardcoded types
        self.var_type = var_type
        if isinstance(name, NameNodeConv):
            self.name = name
        else:
            assert isinstance(name, str)
            self.name = escape_for_vhdl(name)

        if str(name) == 'self':
            self.var_type = 'self_t'
            self.port_direction = 'inout'
            return

        # hack to make 'self.target.name' duck typing work
        class Hack:
            def __init__(self, name):
                self.name = name

        self.target = Hack(self.name)

        if self.var_type is None:
            self.var_type = self.deduce_type()

    def __str__(self):
        var_type = self.var_type or 'unknown_type'
        port_direction = self.port_direction or ''
        default_value = f':={self.value}' if self.value else ''
        tmp_str = f'{self.name}:{port_direction} {var_type}{default_value}'
        return tmp_str

    def __repr__(self):
        return self.__str__()

    def deduce_type(self):
        if self._datamodel is None:  # support converter tests
            return self.var_type or 'unknown_type'

        self.variable = self.get_var_datamodel()

        type = pytype_to_vhdl(self.variable)
        return type

    def get_var_datamodel(self):
        # is 'self.x' something
        if isinstance(self.red_node, AtomtrailersNode) and str(self.red_node[0]) == 'self':
            var = self.walk_self_data(self.red_node)
        elif isinstance(self.red_node, IntNode):  # integer constant
            var = int(self.red_node.value)
        # boolean constant
        elif isinstance(self.red_node, NameNode) and self.red_node.value in ['False', 'True']:
            var = bool(self.red_node.value)
        # Sfix constant
        elif isinstance(self.red_node, AtomtrailersNode) and self.red_node.value[0] == 'Sfix':
            raise Exception('Return Sfix constant? Not allowed because too hard to implement :O')
        else:  # dealing with locals (includes all arguments!)
            name = self._real_name()
            var = self._datamodel.locals[self._defined_in_function()][name]
            try:
                if isinstance(self.red_node[1], GetitemNode):
                    try:
                        index = int(self.red_node.value[1].value.value)
                    except AttributeError:
                        index = int(self.red_node.value[1].value)
                    var = var[index]
            except:
                pass
        return var

    def walk_self_data(self, atom_trailer):
        """ atom_trailer is something like this: self.a.b.c.d
            This finds type of such nested variable
        """

        def find_from_self(atom_trailer):
            var = self._datamodel.self_data
            for x in atom_trailer[1:]:
                if str(x) == 'next': continue
                if not isinstance(x, GetitemNode):
                    var = var[str(x)]
                else:
                    # index is some variable -> just take first element
                    if isinstance(x.value, NameNode):
                        var = var[0]
                    else:
                        var = var[int(str(x.value))]
            return var

        def find_from_const(atom_trailer):
            var = self._datamodel.constants
            for x in atom_trailer[1:]:
                if str(x) == 'next': continue
                if not isinstance(x, GetitemNode):
                    var = var[str(x)]
                else:
                    # index is some variable -> just take first element
                    if isinstance(x.value, NameNode):
                        var = var[0]
                    else:
                        var = var[int(str(x.value))]
            return var

        try:
            var = find_from_self(atom_trailer)
        except KeyError:
            var = find_from_const(atom_trailer)
        return var

    def _defined_in_function(self):
        defn = self.red_node
        while type(defn) is not DefNode:
            defn = defn.parent
        return defn.name

    def _real_name(self):
        # VHDLType.name could be something else, like 'ret_0'
        if isinstance(self.red_node, DefArgumentNode):
            name = str(self.red_node.target)
        elif isinstance(self.red_node, AtomtrailersNode):
            # if len(self.red_node('call')):
            #     arr = self.red_node.find('getitem')
            #     if arr:
            #         return str(arr.previous)
            #     else:
            #         return self.name
            getitem = self.red_node.find('getitem')
            if getitem is not None:
                return str(getitem.previous)
            name = str(self.red_node)
        elif isinstance(self.red_node, AssignmentNode):
            name = str(self.red_node.target)
        elif isinstance(self.red_node, CallArgumentNode):
            getitem = self.red_node.find('getitem')
            if getitem is not None:
                return str(getitem.previous)
            name = str(self.red_node.value)
        else:
            name = str(self.red_node)

        return name


class VHDLVariable(VHDLType):
    def __str__(self):
        if self.name == 'self':
            # without this result would be 'variable self: inout self_t;'
            return 'variable self: self_t;'
        sup = super().__str__()
        return 'variable ' + sup + ';'
