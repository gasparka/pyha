from enum import Enum

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, ComplexSfix
from pyha.conversion.conversion_types import escape_reserved_vhdl


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


def get_instance_vhdl_name(variable=None, name: str = '', id: int = 0):
    if variable is not None:
        name = type(variable).__name__
        id = variable._pyha_instance_id
    return escape_reserved_vhdl(f'{name}_{id}')