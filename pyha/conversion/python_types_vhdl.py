import copy
import logging
from enum import Enum
from math import isclose
from typing import List

import numpy as np
from pyha.common.core import PyhaFunc, Hardware, PyhaList
from pyha.common.fixed_point import Sfix

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


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
        return '\\{}\\'.format(x)  # "escape" reserved name
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
    def __init__(self, var_name, current, initial=None):
        initial = initial if initial is not None else current
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
        return 'self.\\next\\.{} := self.{};'.format(name, name)

    def _pyha_update_registers(self):
        # for constants (UPPERCASE NAME) dont update
        tmp = self._name.replace('_', '')
        if tmp.isupper():
            return ''

        name = self._pyha_name()
        return 'self.{} := self.\\next\\.{};'.format(name, name)

    def _pyha_reset_value(self):
        return self.initial

    def _pyha_reset(self, prefix='self') -> str:
        name = self._pyha_name()
        return '{}.\\next\\.{} := {};\n'.format(prefix, name, self._pyha_reset_value())

    def _pyha_deepcopy(self, prefix='self') -> str:
        name = self._pyha_name()
        return '{}.\\next\\.{} := {}.{};\n'.format(prefix, name, prefix.replace("self", "other"), name)

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

    def _pyha_convert_from_stdlogic(self, out_var_name, in_var_name, in_index_offset=0) -> str:
        raise NotImplementedError()

    def _pyha_convert_to_stdlogic(self, out_name, in_name, out_index_offset=0) -> str:
        raise NotImplementedError()

    def _pyha_type_is_compatible(self, other) -> bool:
        """ Test if ``other`` (same type as ``self``) is compatible in VHDL domain. Meaning that
        all array types shall have same [start,end]. Recursive."""
        raise NotImplementedError()

    def _pyha_to_python_value(self):
        raise NotImplementedError()

    def _pyha_is_equal(self, other, name='', rtol=1e-7, atol=0):
        if type(self.current) != type(other.current):
            return False
        eq = isclose(float(self.current), float(other.current), rel_tol=rtol, abs_tol=atol)
        if not eq:
            logger.error('{} {:.5f} != {:.5f} ({:.5f})'.format(name, self.current, other.current, abs(self.current - other.current)))
        return eq


class VHDLInt(BaseVHDLType):
    def _pyha_type(self):
        return 'integer'

    def _pyha_bitwidth(self) -> int:
        return 32

    def _pyha_stdlogic_type(self) -> str:
        return 'std_logic_vector(31 downto 0)'

    def _pyha_convert_from_stdlogic(self, out_var_name, in_var_name, in_index_offset=0) -> str:
        in_name = '{}({} downto {})'.format(in_var_name, in_index_offset+self._pyha_bitwidth()-1, in_index_offset)
        return '{} := to_integer(signed({}));\n'.format(out_var_name, in_name)

    def _pyha_convert_to_stdlogic(self, out_name, in_name, out_index_offset=0) -> str:
        return '{}({} downto {}) <= std_logic_vector(to_signed({}, 32));\n'.format(out_name, 31 + out_index_offset, 0 + out_index_offset, in_name)

    def _pyha_type_is_compatible(self, other) -> bool:
        if type(self.current) != type(other.current):
            return False
        return True

    def _pyha_to_python_value(self):
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

    def _pyha_convert_from_stdlogic(self, out_var_name, in_var_name, in_index_offset=0) -> str:
        in_name = '{}({} downto {})'.format(in_var_name, in_index_offset+self._pyha_bitwidth()-1, in_index_offset)
        return '{} := logic_to_bool({});\n'.format(out_var_name, in_name)

    def _pyha_convert_to_stdlogic(self, out_name, in_name, out_index_offset=0) -> str:
        return '{}({} downto {}) <= bool_to_logic({});\n'.format(out_name, 0 + out_index_offset, 0 + out_index_offset, in_name)

    def _pyha_type_is_compatible(self, other) -> bool:
        if type(self.current) != type(other.current):
            return False
        return True

    def _pyha_to_python_value(self):
        return self.current

    def _pyha_serialize(self):
        return '1' if self.current else '0'

    def _pyha_deserialize(self, serial):
        return bool(int(serial))


class VHDLSfix(BaseVHDLType):
    def _pyha_type(self):
        return 'sfixed({} downto {})'.format(self.current.left, self.current.right)

    def _pyha_bitwidth(self) -> int:
        return len(self.current)

    def _pyha_reset_value(self):
        return 'Sfix({}, {}, {})'.format(self.initial.val, self.current.left, self.current.right)

    def _pyha_stdlogic_type(self) -> str:
        return 'std_logic_vector({} downto 0)'.format(self.current.left + abs(self.current.right))

    def _pyha_convert_from_stdlogic(self, out_var_name, in_var_name, in_index_offset=0) -> str:
        in_name = '{}({} downto {})'.format(in_var_name, in_index_offset+self._pyha_bitwidth()-1, in_index_offset)
        return '{} := Sfix({}, {}, {});\n'.format(out_var_name, in_name, self.current.left, self.current.right)

    def _pyha_convert_to_stdlogic(self, out_name, in_name, out_index_offset=0) -> str:
        return '{}({} downto {}) <= to_slv({});\n'.format(out_name, self._pyha_bitwidth() -1 + out_index_offset, 0 + out_index_offset, in_name)

    def _pyha_type_is_compatible(self, other) -> bool:
        if type(self.current) != type(other.current):
            return False
        return self.current.left == other.current.left and self.current.right == other.current.right

    def _pyha_to_python_value(self):
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
        return 'type {} is range 0 to {}; -- enum converted to range due to Quartus "bug", see #154'.format(name, len(type(self.current))-1)

    def _pyha_reset_value(self):
        return self.initial.value

    def _pyha_convert_from_stdlogic(self, var_name, in_index_offset=0) -> str:
        raise NotImplementedError  # old solution interpeted as ints?

    def _pyha_convert_to_stdlogic(self, var_name) -> str:
        raise NotImplementedError  # old solution interpeted as ints?

    def _pyha_type_is_compatible(self, other) -> bool:
        if type(self.current) != type(other.current):
            return False
        return True

    def _pyha_to_python_value(self):
        return self.current.value


class VHDLList(BaseVHDLType):
    def __init__(self, var_name, current, initial):
        super().__init__(var_name, current, initial)

        self.elems = [init_vhdl_type('-', c, i) for c, i in zip(self.current, self.initial)]
        self.elems = [x for x in self.elems if x is not None]
        self.not_submodules_list = not isinstance(self.elems[0], VHDLModule)

    def _pyha_arr_type_name(self):
        elem_type = self.elems[0]._pyha_type()
        # some type may contain illegal chars for name..replace them
        elem_type = elem_type.replace('(', '').replace(')', '').replace(' ', '').replace('-', '_').replace('.', '_')
        return '{}_list_t'.format(elem_type)

    def _pyha_type(self):
        lib = 'Typedefs'
        if not self.not_submodules_list:
            lib = self.elems[0]._pyha_module_name()

        return '{}.{}(0 to {})'.format(lib, self._pyha_arr_type_name(), len(self.current) - 1)

    def _pyha_typedef(self):
        if self.not_submodules_list:
            return 'type {} is array (natural range <>) of {};'.format(self._pyha_arr_type_name(), self.elems[0]._pyha_type())
        return None  # arrays of submodules are already defined in each submodule package!

    def _pyha_init(self):
        if self.not_submodules_list:
            return super()._pyha_init()

        inits = ['{}.\\_pyha_init\\(self.{}({}));'.format(self.elems[0]._pyha_module_name(), self._pyha_name(), i)
                 for i in range(len(self.current))]
        return '\n'.join(inits)

    def _pyha_update_registers(self):
        if self.not_submodules_list:
            return super()._pyha_update_registers()

        inits = ['{}.\\_pyha_update_registers\\(self.{}({}));'.format(self.elems[0]._pyha_module_name(), self._pyha_name(), i)
                 for i in range(len(self.current))]
        return '\n'.join(inits)

    def _pyha_reset(self, prefix='self') -> str:
        name = self._pyha_name()
        if self.not_submodules_list:
            data = ', '.join(str(x._pyha_reset_value()) for x in self.elems)
            return '{}.\\next\\.{} := ({});\n'.format(prefix, name, data)

        ret = ''
        for i, sub in enumerate(self.elems):
            tmp_prefix = '{}.{}({})'.format(prefix, name, i)
            ret += sub._pyha_reset(tmp_prefix)  # recursive
        return ret

    def _pyha_deepcopy(self, prefix='self') -> str:
        name = self._pyha_name()
        if self.not_submodules_list:
            return '{}.\\next\\.{} := {}.{};\n'.format(prefix, name, prefix.replace("self", "other"), name)

        ret = ''
        for i, sub in enumerate(self.elems):
            tmp_prefix = '{}.{}({})'.format(prefix, name, i)
            ret += sub._pyha_deepcopy(tmp_prefix)  # recursive
        return ret

    def _pyha_type_is_compatible(self, other) -> bool:
        if type(self.current) != type(other.current):
            return False
        if len(self.current) != len(other.current):
            return False

        return self.elems[0]._pyha_type_is_compatible(other.elems[0])

    def _pyha_to_python_value(self):
        return [x._pyha_to_python_value() for x in self.elems]

    def _pyha_bitwidth(self) -> int:
        return sum([x._pyha_bitwidth() for x in self.elems])

    def _pyha_stdlogic_type(self) -> str:
        return 'std_logic_vector({} downto 0)'.format(self._pyha_bitwidth()-1)

    def _pyha_convert_from_stdlogic(self, out_var_name, in_var_name, in_index_offset=0) -> str:
        ret = ''
        total_width = self._pyha_bitwidth()
        elem_width = total_width // len(self.elems)
        for i, sub in enumerate(self.elems):
            prefix = '{}({})'.format(out_var_name, len(self.elems) - i -1)
            ret += sub._pyha_convert_from_stdlogic(prefix, in_var_name, in_index_offset)  # recursive
            in_index_offset += elem_width
        return ret

    def _pyha_convert_to_stdlogic(self, out_name, in_name, out_index_offset=0) -> str:
        ret = ''
        total_width = self._pyha_bitwidth()
        elem_width = total_width // len(self.elems)
        for i, sub in enumerate(self.elems):
            prefix = '{}'.format(out_name)
            tmp_in_name = '{}({})'.format(in_name, len(self.elems) - i -1)
            ret += sub._pyha_convert_to_stdlogic(prefix, tmp_in_name, out_index_offset + elem_width * i)  # recursive
        return ret

    def _pyha_serialize(self):
        return ''.join(x._pyha_serialize() for x in self.elems)

    def _pyha_deserialize(self, serial):
        ret = []
        for i, elem in enumerate(self.elems):
            offset = i * elem._pyha_bitwidth()
            e = elem._pyha_deserialize(serial[offset: offset + elem._pyha_bitwidth()])
            ret.append(e)
        return ret

    def _pyha_is_equal(self, other, name='', rtol=1e-7, atol=0):
        if type(self.current) != type(other.current):
            return False

        if len(self.elems) != len(other.elems):
            logger.error('{} -> Fail, lists have different lengths: {} vs {}'.format(name, len(self.elems), len(other.elems)))
            return False

        r = []
        for i, (self_elem, other_elem) in enumerate(zip(self.elems, other.elems)):
            ret = self_elem._pyha_is_equal(other_elem, '{}({})'.format(name, i), rtol, atol)
            r.append(ret)

        return all(r)


class VHDLModule(BaseVHDLType):
    def __init__(self, var_name, current, initial=None):
        if initial is None:
            initial = current._pyha_initial_self
        else:
            current._pyha_initial_self = initial._pyha_initial_self

        super().__init__(var_name, current, initial)

        self.elems = get_vars_as_vhdl_types(self.current)
        self.elems = [x for x in self.elems if x is not None]

    def _pyha_instance_id(self):
        for i, instance in enumerate(self.current.instances):
            mod = VHDLModule('-', instance)
            if self._pyha_type_is_compatible(mod):
                return i

        # types that get full bounds during simulation can end up here
        self.current.instances.append(self.current)
        return len(self.current.instances)

    def _pyha_module_name(self):
        return '{}_{}'.format(type(self.current).__name__, self._pyha_instance_id())

    def _pyha_type(self):
        return '{}.self_t'.format(self._pyha_module_name())

    def _pyha_arr_type_name(self):
        elem_type = self._pyha_type()
        # some type may contain illegal chars for name..replace them
        elem_type = elem_type.replace('(', '').replace(')', '').replace(' ', '').replace('-', '_').replace('.', '_')
        return '{}_list_t'.format(elem_type)

    def _pyha_init(self) -> str:
        return '{}.\\_pyha_init\\(self.{});'.format(self._pyha_module_name(), self._pyha_name())

    def _pyha_update_registers(self):
        return '{}.\\_pyha_update_registers\\(self.{});'.format(self._pyha_module_name(), self._pyha_name())

    def _pyha_reset(self, prefix='self'):
        ret = ''
        for i, sub in enumerate(self.elems):
            tmp_prefix = prefix
            if self._name != '-':
                tmp_prefix = '{}.{}'.format(prefix, self._pyha_name())
            ret += sub._pyha_reset(tmp_prefix)  # recursive
        return ret

    def _pyha_deepcopy(self, prefix='self'):
        ret = ''
        for i, sub in enumerate(self.elems):
            tmp_prefix = prefix
            if self._name != '-':
                tmp_prefix = '{}.{}'.format(prefix, self._pyha_name())
            ret += sub._pyha_deepcopy(tmp_prefix)  # recursive
        return ret

    def _pyha_type_is_compatible(self, other) -> bool:
        if type(self.current) != type(other.current):
            return False

        if len(self.elems) != len(other.elems):
            # actually object with more elements could match with the one with lesser elemems, but this is too specific atm.
            return False

        return all(self_elem._pyha_type_is_compatible(other_elem)
                   for self_elem, other_elem in zip(self.elems, other.elems))

    def _pyha_to_python_value(self):
        ret = copy.copy(self.current)
        for elem in self.elems:
            setattr(ret, elem._name, elem._pyha_to_python_value())

        return ret

    def _pyha_bitwidth(self) -> int:
        return sum([x._pyha_bitwidth() for x in self.elems])

    def _pyha_stdlogic_type(self) -> str:
        return 'std_logic_vector({} downto 0)'.format(self._pyha_bitwidth()-1)

    def _pyha_convert_from_stdlogic(self, out_var_name, in_var_name, in_index_offset=0) -> str:
        ret = ''
        for sub in self.elems:
            elem_width = sub._pyha_bitwidth()
            prefix = '{}.{}'.format(out_var_name, sub._pyha_name())
            ret += sub._pyha_convert_from_stdlogic(prefix, in_var_name, in_index_offset)  # recursive
            in_index_offset += elem_width
        return ret

    def _pyha_convert_to_stdlogic(self, out_name, in_name, out_index_offset=0) -> str:
        ret = ''
        for i, sub in enumerate(self.elems):
            elem_width = sub._pyha_bitwidth()
            prefix = '{}'.format(out_name)
            tmp_in_name = '{}.{}'.format(in_name, sub._pyha_name())
            ret += sub._pyha_convert_to_stdlogic(prefix, tmp_in_name, out_index_offset)  # recursive
            out_index_offset += elem_width
        return ret

    def _pyha_serialize(self):
        return ''.join(x._pyha_serialize() for x in reversed(self.elems))

    def _pyha_deserialize(self, serial):
        ret = copy.copy(self.current)
        offset = 0
        for elem in reversed(self.elems):
            e = elem._pyha_deserialize(serial[offset: offset + elem._pyha_bitwidth()])
            offset += elem._pyha_bitwidth()
            setattr(ret, elem._name, e)

        return ret

    def _pyha_is_equal(self, other, name='', rtol=1e-7, atol=0):
        if type(self.current) != type(other.current):
            return False

        if len(self.elems) != len(other.elems):
            return False

        if len(self.elems) != len(other.elems):
            logger.error('{} -> Fail, modules have different amount of elements: {} vs {}'.format(name, len(self.elems), len(other.elems)))
            return False

        r = []
        for self_elem, other_elem in zip(self.elems, other.elems):
            ret = self_elem._pyha_is_equal(other_elem, '{}.{}'.format(type(self.current).__name__, self_elem._name), rtol, atol)
            r.append(ret)

        return all(r)


class VHDLFloat(BaseVHDLType):
    def _pyha_to_python_value(self):
        return self.current


class VHDLComplex(BaseVHDLType):
    def _pyha_is_equal(self, other, name='', rtol=1e-7, atol=0):
        if not isinstance(other.current, type(self.current)):
            logger.error('Complex values not equal bacause types differ!= {}'.format(name, self.current, other.current))
            return False
        eq1 = isclose(self.current.real, other.current.real, rel_tol=rtol, abs_tol=atol)
        eq2 = isclose(self.current.imag, other.current.imag, rel_tol=rtol, abs_tol=atol)
        eq = eq1 and eq2
        if not eq:
            logger.error('{} {} != {}'.format(name, self.current, other.current))
        return eq


def init_vhdl_type(name, current_val, initial_val=None):
    from pyha.conversion.conversion import Conversion
    if type(current_val) == int or type(current_val) == np.int64:
        return VHDLInt(name, current_val, initial_val)
    elif type(current_val) == bool or type(current_val) == np.bool_:
        return VHDLBool(name, current_val, initial_val)
    elif type(current_val) == float:
        if Conversion.in_progress:
            return None

        return VHDLFloat(name, current_val, initial_val)

    elif isinstance(current_val, complex):
        return VHDLComplex(name, current_val, initial_val)
    elif type(current_val) == Sfix:
        return VHDLSfix(name, current_val, initial_val)
    elif type(current_val) == PyhaList:
        if Conversion.in_progress and isinstance(current_val[0], float):
            return None

        return VHDLList(name, current_val, initial_val)
    elif isinstance(current_val, Hardware):
        try:
            return current_val._pyha_converter(name, current_val, initial_val)
        except:
            return VHDLModule(name, current_val, initial_val)

    elif isinstance(current_val, Enum):
        return VHDLEnum(name, current_val, initial_val)
    elif isinstance(current_val, list):  # this may happen for local variables or arguments
        return init_vhdl_type(name, PyhaList(current_val), PyhaList(initial_val))

    print(type(current_val))
    assert 0


def get_vars_as_vhdl_types(obj: Hardware) -> List[BaseVHDLType]:
    def filter_junk(x):
        return {k: v for k, v in x.items()
                if not k.startswith('_pyha') and not k.startswith('__')
                and not isinstance(v, PyhaFunc)}

    current_vars = filter_junk(vars(obj))
    initial_vars = filter_junk(vars(obj._pyha_initial_self))

    # convert to conversion classes
    ret = [init_vhdl_type(name, current_val, initial_val) for name, current_val, initial_val in
           zip(current_vars.keys(), current_vars.values(), initial_vars.values())]

    if ret == []:
        ret = [VHDLInt('much_dummy_very_wow', 0, 0)]

    return ret
