from enum import Enum
from typing import List

import numpy as np

from pyha.common.hwsim import PyhaFunc, HW, PyhaList
from pyha.common.sfix import Sfix


def escape_reserved_vhdl(x: str) -> str:
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

    if x.lower() in vhdl_reserved_names or x[0] == '_':
        return f'\\{x}\\'  # "escape" reserved name
    return x


def to_signed_int(number, bit_length):
    # http://stackoverflow.com/questions/1375897/how-to-get-the-signed-integer-value-of-a-long-in-python
    mask = (2 ** bit_length) - 1
    if number & (1 << (bit_length - 1)):
        return number | ~mask
    else:
        return number & mask


def to_twoscomplement(bits, value):
    # https: // stackoverflow.com / questions / 21871829 / twos - complement - of - numbers - in -python
    if value < 0:
        value = (1 << bits) + value
    formatstring = '{:0%ib}' % bits
    return formatstring.format(value)


class BaseVHDLType:
    def __init__(self, var_name, current, initial):
        self._name = var_name
        self.initial = initial
        self.current = current

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False

    def _pyha_name(self) -> str:
        return escape_reserved_vhdl(self._name)

    def _pyha_type(self) -> str:
        raise NotImplementedError()

    def _pyha_typedef(self) -> str:
        pass

    def _pyha_init(self) -> str:
        name = self._pyha_name()
        return f'self.\\next\\.{name} := self.{name};'

    def _pyha_update_registers(self):
        # for constants (UPPERCASE NAME) dont update
        tmp = self._name.replace('_', '')
        if tmp.isupper():
            return ''

        name = self._pyha_name()
        return f'self.{name} := self.\\next\\.{name};'

    def _pyha_reset_value(self):
        return self.initial

    def _pyha_reset(self, prefix='self') -> str:
        name = self._pyha_name()
        return f'{prefix}.\\next\\.{name} := {self._pyha_reset_value()};\n'

    def _pyha_reset_constants(self) -> str:
        r = self._pyha_reset()

        ret = []
        # filter out CONSTANTS (some name is fully uppercase)
        for line in r.splitlines():
            line_target = line[:line.find(':=')]
            for part in line_target.split('.'):
                if part.find('(') != -1:  # cut out array indexing
                    part = part[:part.find('(')]
                if part[0] == '\\':
                    part = part[1:-1]  # cut out VHDL escaping
                part = part.replace('_', '')
                if part.isupper():
                    ret.append(line.replace('.\\next\\', ''))

        return '\n'.join(ret)

    def _pyha_bitwidth(self) -> int:
        raise NotImplementedError()

    def _pyha_stdlogic_type(self) -> str:
        raise NotImplementedError()

    def _pyha_convert_from_stdlogic(self, out_var_name, in_var_name) -> str:
        raise NotImplementedError()

    def _pyha_convert_to_stdlogic(self, out_name, in_name, out_index_offset=0) -> str:
        raise NotImplementedError()

    def _pyha_type_is_compatible(self, other) -> bool:
        """ Test is ``other`` (same type as ``self``) is compatible in VHDL domain. Meaning that
        all array types shall have same [start,end]. Recursive."""
        raise NotImplementedError()

    def _pyha_to_python_value(self) -> str:
        raise NotImplementedError()


class VHDLInt(BaseVHDLType):
    def _pyha_type(self):
        return 'integer'

    def _pyha_bitwidth(self) -> int:
        return 32

    def _pyha_stdlogic_type(self) -> str:
        return 'std_logic_vector(31 downto 0)'

    def _pyha_convert_from_stdlogic(self, out_var_name, in_var_name) -> str:
        return f'{out_var_name} := to_integer(signed({in_var_name}));\n'

    def _pyha_convert_to_stdlogic(self, out_name, in_name, out_index_offset=0) -> str:
        return f'{out_name}({31 + out_index_offset} downto {0 + out_index_offset}) <= std_logic_vector(to_signed({in_name}, 32));\n'

    def _pyha_type_is_compatible(self, other) -> bool:
        if type(self.current) != type(other.current):
            return False
        return True

    def _pyha_to_python_value(self) -> str:
        return self.current

    def _pyha_serialize(self):
        return to_twoscomplement(32, self.current)

    def _pyha_deserialize(self, serial):
        return to_signed_int(int(serial, 2), 32)


class VHDLBool(BaseVHDLType):
    def _pyha_type(self):
        return 'boolean'

    def _pyha_bitwidth(self) -> int:
        return 1

    def _pyha_stdlogic_type(self) -> str:
        return 'std_logic_vector(0 downto 0)'

    def _pyha_convert_from_stdlogic(self, out_var_name, in_var_name) -> str:
        return f'{out_var_name} := logic_to_bool({in_var_name});\n'

    def _pyha_convert_to_stdlogic(self, out_name, in_name, out_index_offset=0) -> str:
        return f'{out_name}({0 + out_index_offset} downto {0 + out_index_offset}) <= bool_to_logic({in_name});\n'

    def _pyha_type_is_compatible(self, other) -> bool:
        if type(self.current) != type(other.current):
            return False
        return True

    def _pyha_to_python_value(self) -> str:
        return self.current

    def _pyha_serialize(self):
        return '1' if self.current else '0'

    def _pyha_deserialize(self, serial):
        return bool(int(serial))


class VHDLSfix(BaseVHDLType):
    def _pyha_type(self):
        return f'sfixed({self.current.left} downto {self.current.right})'

    def _pyha_bitwidth(self) -> int:
        return len(self.current)

    def _pyha_reset_value(self):
        return f'Sfix({self.initial.init_val}, {self.current.left}, {self.current.right})'

    def _pyha_stdlogic_type(self) -> str:
        return f'std_logic_vector({self.current.left + abs(self.current.right)} downto 0)'

    def _pyha_convert_from_stdlogic(self, out_var_name, in_var_name) -> str:
        return f'{out_var_name} := Sfix({in_var_name}, {self.current.left}, {self.current.right});\n'

    def _pyha_convert_to_stdlogic(self, out_name, in_name, out_index_offset=0) -> str:
        return f'{out_name}({self._pyha_bitwidth() -1 + out_index_offset} downto {0 + out_index_offset}) <= to_slv({in_name});\n'

    def _pyha_type_is_compatible(self, other) -> bool:
        if type(self.current) != type(other.current):
            return False
        return self.current.left == other.current.left and self.current.right == other.current.right

    def _pyha_to_python_value(self) -> str:
        return float(self.current)

    def _pyha_serialize(self):
        val = self.current.fixed_value()
        return to_twoscomplement(len(self.current), val)

    def _pyha_deserialize(self, serial):
        val = to_signed_int(int(serial, 2), len(self.current))
        return val * 2 ** self.current.right


class VHDLEnum(BaseVHDLType):
    def _pyha_type(self):
        return type(self.current).__name__

    def _pyha_typedef(self):
        name = self._pyha_type()
        types = ','.join([x.name for x in type(self.current)])
        return f'type {name} is ({types});'

    def _pyha_reset_value(self):
        return self.initial.name

    def _pyha_convert_from_stdlogic(self, var_name) -> str:
        raise NotImplementedError  # old solution interpeted as ints?

    def _pyha_convert_to_stdlogic(self, var_name) -> str:
        raise NotImplementedError  # old solution interpeted as ints?

    def _pyha_type_is_compatible(self, other) -> bool:
        if type(self.current) != type(other.current):
            return False
        return True

    def _pyha_to_python_value(self) -> str:
        return self.current.value


class VHDLList(BaseVHDLType):
    def __init__(self, var_name, current, initial):
        super().__init__(var_name, current, initial)

        self.elems = [conv_class('-', c, i) for c, i in zip(self.current, self.initial)]
        self.not_submodules_list = not isinstance(self.elems[0], VHDLModule)

    def _pyha_type_name(self):
        elem_type = self.elems[0]._pyha_type()
        # some type may contain illegal chars for name..replace them
        elem_type = elem_type.replace('(', '').replace(')', '').replace(' ', '').replace('-', '_').replace('.', '_')
        return f'{elem_type}_list_t'

    def _pyha_type(self):
        return f'Typedefs.{self._pyha_type_name()}(0 to {len(self.current) - 1})'

    def _pyha_typedef(self):
        return f'type {self._pyha_type_name()} is array (natural range <>) of {self.elems[0]._pyha_type()};'

    def _pyha_init(self):
        if self.not_submodules_list:
            return super()._pyha_init()

        inits = [f'{self.elems[0]._pyha_module_name()}.\\_pyha_init\\(self.{self._pyha_name()}({i}));'
                 for i in range(len(self.current))]
        return '\n'.join(inits)

    def _pyha_update_registers(self):
        if self.not_submodules_list:
            return super()._pyha_update_registers()

        inits = [f'{self.elems[0]._pyha_module_name()}.\\_pyha_update_registers\\(self.{self._pyha_name()}({i}));'
                 for i in range(len(self.current))]
        return '\n'.join(inits)

    def _pyha_reset(self, prefix='self') -> str:
        name = self._pyha_name()
        if self.not_submodules_list:
            data = ', '.join(str(x._pyha_reset_value()) for x in self.elems)
            return f'{prefix}.\\next\\.{name} := ({data});\n'

        ret = ''
        for i, sub in enumerate(self.elems):
            tmp_prefix = f'{prefix}.{name}({i})'
            ret += sub._pyha_reset(tmp_prefix)  # recursive
        return ret

    def _pyha_type_is_compatible(self, other) -> bool:
        if type(self.current) != type(other.current):
            return False
        if len(self.current) != len(other.current):
            return False

        return self.elems[0]._pyha_type_is_compatible(other.elems[0])

    def _pyha_to_python_value(self) -> str:
        return [x._pyha_to_python_value() for x in self.elems]

    def _pyha_bitwidth(self) -> int:
        return sum([x._pyha_bitwidth() for x in self.elems])

    def _pyha_stdlogic_type(self) -> str:
        return f'std_logic_vector({self._pyha_bitwidth()-1} downto 0)'

    def _pyha_convert_from_stdlogic(self, out_var_name, in_var_name) -> str:
        ret = ''
        total_width = self._pyha_bitwidth()
        elem_width = total_width // len(self.elems)
        for i, sub in enumerate(self.elems):
            prefix = f'{out_var_name}({i})'
            base_bound = total_width - (elem_width * i)
            in_name = f'{in_var_name}({base_bound-1} downto {base_bound-elem_width})'
            ret += sub._pyha_convert_from_stdlogic(prefix, in_name)  # recursive
        return ret

    def _pyha_convert_to_stdlogic(self, out_name, in_name, out_index_offset=0) -> str:
        # return f'{out_name}({31 + out_index_offset} downto {0 + out_index_offset} := std_logic_vector(to_signed({in_name}, 32));\n'
        ret = ''
        total_width = self._pyha_bitwidth()
        elem_width = total_width // len(self.elems)
        for i, sub in enumerate(self.elems):
            prefix = f'{out_name}'
            tmp_in_name = f'{in_name}({i})'
            ret += sub._pyha_convert_to_stdlogic(prefix, tmp_in_name, out_index_offset + elem_width * i)  # recursive
        return ret



class VHDLModule(BaseVHDLType):
    def __init__(self, var_name, current, initial=None):
        initial = initial or current._pyha_initial_self
        super().__init__(var_name, current, initial)

        self.elems = get_conversion_vars(self.current)

    def _pyha_instance_id(self):
        for i, instance in enumerate(self.current.instances):
            mod = VHDLModule('-', instance)
            if self._pyha_type_is_compatible(mod):
                return i

    def _pyha_module_name(self):
        return f'{type(self.current).__name__}_{self._pyha_instance_id()}'

    def _pyha_type(self):
        return f'{self._pyha_module_name()}.self_t'

    def _pyha_init(self) -> str:
        return f'{self._pyha_module_name()}.\\_pyha_init\\(self.{self._pyha_name()});'

    def _pyha_update_registers(self):
        return f'{self._pyha_module_name()}.\\_pyha_update_registers\\(self.{self._pyha_name()});'

    def _pyha_reset(self, prefix='self'):
        ret = ''
        for i, sub in enumerate(self.elems):
            tmp_prefix = prefix
            if self._name != '-':
                tmp_prefix = f'{prefix}.{self._pyha_name()}'
            ret += sub._pyha_reset(tmp_prefix)  # recursive
        return ret

    def _pyha_type_is_compatible(self, other) -> bool:
        if type(self.current) != type(other.current):
            return False

        if len(self.elems) != len(other.elems):
            # actually object with more elements could match with the one with lesser elemems, but this is too specific atm.
            return False

        return all(self_elem._pyha_type_is_compatible(other_elem)
                   for self_elem, other_elem in zip(self.elems, other.elems))



def conv_class(name, current_val, initial_val=None):
    if type(current_val) == int or type(current_val) == np.int64:
        return VHDLInt(name, current_val, initial_val)
    elif type(current_val) == bool or type(current_val) == np.bool_:
        return VHDLBool(name, current_val, initial_val)
    elif type(current_val) == Sfix:
        return VHDLSfix(name, current_val, initial_val)
    elif type(current_val) == PyhaList:
        return VHDLList(name, current_val, initial_val)
    elif isinstance(current_val, HW):
        return VHDLModule(name, current_val, initial_val)
    elif isinstance(current_val, Enum):
        return VHDLEnum(name, current_val, initial_val)
    elif isinstance(current_val, list):  # this may happen for local variables or arguments
        return conv_class(name, PyhaList(current_val), PyhaList(initial_val))
    assert 0


def get_conversion_vars(obj: HW) -> List[BaseVHDLType]:
    def filter_junk(x):
        return {k: v for k, v in x.items()
                if not k.startswith('_pyha') and not k.startswith('__')
                and not isinstance(v, PyhaFunc)}

    current_vars = filter_junk(vars(obj))
    initial_vars = filter_junk(vars(obj._pyha_initial_self))

    # convert to conversion classes
    ret = [conv_class(name, current_val, initial_val) for name, current_val, initial_val in
           zip(current_vars.keys(), current_vars.values(), initial_vars.values())]

    if ret == []:
        ret = [VHDLInt('much_dummy_very_wow', 0, 0)]

    return ret
