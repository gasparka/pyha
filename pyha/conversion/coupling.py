from pyha.common.sfix import Sfix
from pyha.conversion.extract_datamodel import DataModel
from redbaron import GetitemNode, DefNode, AssignmentNode, IntNode, NameNode
from redbaron.nodes import DefArgumentNode, AtomtrailersNode


class ExceptionCoupling(Exception):
    pass


def pytype_to_vhdl(var):
    if type(var) is bool:
        return 'boolean'
    elif type(var) is int:
        return 'integer'
    elif type(var) is Sfix:
        return 'sfixed({} downto {})'.format(var.left, var.right)
    elif type(var) is list:
        return pytype_to_vhdl(var[0])
    else:
        assert 0


class VHDLType:
    _datamodel = None

    @classmethod
    def set_datamodel(cls, dm: DataModel):
        cls._datamodel = dm

    @classmethod
    def get_self(cls):
        if cls._datamodel is None:
            return []
        return [VHDLType(tuple_init=(k, v)) for k, v in cls._datamodel.self_data.items() if k != 'next']

    def __init__(self, name=None, red_node=None, var_type: str = None, port_direction: str = None, value=None,
                 tuple_init=None):


        self.value = value
        self.red_node = red_node
        self.port_direction = port_direction
        self.var_type = var_type
        self.name = name

        if tuple_init is not None:
            self.name = tuple_init[0]
            self.var_type = pytype_to_vhdl(tuple_init[1])
            return

        # hardcoded types
        if str(name) == 'self_reg':
            self.var_type = 'register_t'
            self.port_direction = 'inout'
            return

        if str(name) == 'self':
            self.var_type = 'self_t'
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
        default_value = ':={}'.format(self.value) if self.value else ''
        tmp_str = '{}:{} {}{}'.format(self.name, port_direction, var_type, default_value)
        return tmp_str

    def __repr__(self):
        return self.__str__()

    def deduce_type(self):
        if self._datamodel is None:  # support converter tests
            return self.var_type

        # is 'self.x' something
        if isinstance(self.red_node, AtomtrailersNode) and str(self.red_node[0]) == 'self':
            var = self.walk_self_data(self.red_node)
        elif isinstance(self.red_node, IntNode): #integer constant
            var = int(self.red_node.value)
        # boolean constant
        elif isinstance(self.red_node, NameNode) and self.red_node.value in ['False', 'True']:
            var = bool(self.red_node.value)
        # Sfix constant
        elif isinstance(self.red_node, AtomtrailersNode) and self.red_node.value[0] == 'Sfix':
            raise Exception('Return Sfix constant? Not allowed because too hard to implement :O')
        else: # dealing with locals (includes all arguments!)
            name = self._real_name()
            var = self._datamodel.locals[self._defined_in_function()][name]

        return pytype_to_vhdl(var)

    def walk_self_data(self, atom_trailer):
        """ atom_trailer is something like this: self.a.b.c.d
            This finds type of such nested variable
        """
        var = self._datamodel.self_data
        for x in atom_trailer[1:]:
            if not isinstance(x, GetitemNode):
                var = var[str(x)]
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
            if len(self.red_node('getitem')):
                return str(self.red_node[0])
            name = str(self.red_node)
        elif isinstance(self.red_node, AssignmentNode):
            name = str(self.red_node.target)
        else:
            name = str(self.red_node)

        return name


class VHDLVariable(VHDLType):
    def __str__(self):
        sup = super().__str__()
        return 'variable ' + sup + ';'
