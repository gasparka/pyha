from common.sfix import Sfix
from conversion.converter import VHDLType
from conversion.extract_datamodel import DataModel


class Coupling:
    _datamodel = None

    @classmethod
    def set_datamodel(cls, dm: DataModel):
        cls._datamodel = dm

    @classmethod
    def type_from_datamodel(cls, var: VHDLType):
        if cls._datamodel is None: #support converter tests
            return var.var_type
        dm_locals = cls._datamodel.locals[function_name_defined(var)]
        name = str(var.name)
        if name in dm_locals:
            return pytype_to_vhdl(dm_locals[name])


def pytype_to_vhdl(var):
    if type(var) is bool:
        return 'boolean'
    elif type(var) is int:
        return 'integer'
    elif type(var) is Sfix:
        return 'sfixed({} downto {})'.format(var.left, var.right)
    else:
        raise Exception('WTF type')
        # elif type(var) is list:
        #     return self.type_string(var[0])


def function_name_defined(var: VHDLType):
    return var.red_node.parent.name
