import collections


def escape_for_vhdl(x: str) -> str:
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


def is_power2(num):
    # Author: A.Polino
    'states if a number is a power of two'
    return num != 0 and ((num & (num - 1)) == 0)


def get_iterable(x):
    if isinstance(x, collections.Iterable):
        return x
    else:
        return [x]


def tabber(str):
    TAB = '    '
    """ Add tab infront of every line """
    return '\n'.join(['{}{}'.format(TAB, x) for x in str.splitlines() if x != ''])
