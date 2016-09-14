from common.sfix import Sfix
from conversion.converter import VHDLType, NodeConv
from conversion.extract_datamodel import DataModel


class UndefinedVariables:
    """ Converter adds all undefined variables here """
    _variables = {}

    @classmethod
    def clear(cls):
        cls._variables.clear()

    @classmethod
    def add(cls, var: VHDLType):
        if str(var.name) in cls.get():
            raise Exception('WTF')
        cls._variables.update({str(var.name): var})

    @classmethod
    def get(cls):
        return cls._variables


def pytype_to_vhdl(var):
    if type(var) is bool:
        return 'boolean'
    elif type(var) is int:
        return 'integer'
    elif type(var) is Sfix:
        return 'sfixed({} downto {})'.format(var.left, var.right)
        # elif type(var) is list:
        #     return self.type_string(var[0])


def function_name_defined(var: VHDLType):
    return var.red_node.parent.name


def datamodel_to_conversion_coupling(conv: NodeConv, dm: DataModel):
    for key, val in UndefinedVariables.get().items():
        locals = dm.locals[function_name_defined(val)]
        if key in locals:
            val.var_type = pytype_to_vhdl(locals[key])
