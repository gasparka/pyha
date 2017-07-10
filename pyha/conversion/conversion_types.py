from enum import Enum
from typing import List

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
        name = self._pyha_name()
        return f'self.{name} := self.\\next\\.{name};'

    def _pyha_reset_value(self):
        return self.initial

    def _pyha_reset(self, prefix='self') -> str:
        name = self._pyha_name()
        tail = '' if prefix == 'self' else '\n'  # if recursive, this is leaf node -> end with \n
        return f'{prefix}.\\next\\.{name} := {self._pyha_reset_value()};{tail}'

    def _pyha_reset_constants(self) -> str:
        r = self._pyha_reset()

        ret = []
        # filter out CONSTANTS (some name is fully uppercase)
        for line in r.splitlines():
            line_target = line[:line.find(':=')]
            for part in line_target.split('.'):
                part = part[:part.find('(')]  # cut out array indexing
                if part[0] == '\\':
                    part = part[1:-1]  # cut out VHDL escaping
                if part.isupper():
                    ret.append(line.replace('.\\next\\', ''))

        return '\n'.join(ret)


class VHDLList(BaseVHDLType):
    def __init__(self, var_name, current, initial):
        super().__init__(var_name, current, initial)

        self.elems = [conv_class('-', c, i) for c, i in zip(self.current, self.initial)]
        self.not_submodules_list = not isinstance(self.elems[0], VHDLModule)

    def _pyha_type(self):
        elem_type = self.elems[0]._pyha_type()
        # some type may contain illegal chars for name..replace them
        elem_type = elem_type.replace('(', '').replace(')', '').replace(' ', '').replace('-', '_').replace('.', '_')
        return f'{elem_type}_list_t(0 to {len(self.current) - 1})'

    def _pyha_typedef(self):
        t = self._pyha_type()
        t_name = t[:t.find('(')]  # cut out the (x to x) part
        return f'type {t_name} is array (natural range <>) of {self.elems[0]._pyha_type()};'

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


class VHDLInt(BaseVHDLType):
    def _pyha_type(self):
        return 'integer'


class VHDLBool(BaseVHDLType):
    def _pyha_type(self):
        return 'boolean'


class VHDLSfix(BaseVHDLType):
    def _pyha_type(self):
        return f'sfixed({self.current.left} downto {self.current.right})'

    def _pyha_reset_value(self):
        return f'Sfix({self.initial.init_val}, {self.current.left}, {self.current.right})'


class VHDLModule(BaseVHDLType):
    def __init__(self, var_name, current, initial):
        super().__init__(var_name, current, initial)

        self.elems = get_conversion_vars(self.current)

    def _pyha_module_name(self):
        return f'{type(self.current).__name__}_{self.current._pyha_instance_id}'

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


class VHDLEnum(BaseVHDLType):
    def _pyha_type(self):
        return type(self.current).__name__

    def _pyha_typedef(self):
        name = self._pyha_type()
        types = ','.join([x.name for x in type(self.current)])
        return f'type {name} is ({types});'

    def _pyha_reset_value(self):
        return self.initial.name


def conv_class(name, current_val, initial_val=None):
    if type(current_val) == int:
        return VHDLInt(name, current_val, initial_val)
    elif type(current_val) == bool:
        return VHDLBool(name, current_val, initial_val)
    elif type(current_val) == Sfix:
        return VHDLSfix(name, current_val, initial_val)
    elif type(current_val) == PyhaList:
        return VHDLList(name, current_val, initial_val)
    elif isinstance(current_val, HW):
        return VHDLModule(name, current_val, initial_val)
    elif isinstance(current_val, Enum):
        return VHDLEnum(name, current_val, initial_val)
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
