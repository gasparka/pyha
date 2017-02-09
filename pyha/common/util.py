import collections

import numpy as np
import scipy
from scipy import signal


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
        return f'\\{x}\\'  # "escape" reserved name
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
    # if x is '' then dont add tabs, because much used textwrap.dedent deletes empty tabs...so unit tests will be unhappy
    return '\n'.join([f'{TAB}{x}' if x != '' else x for x in str.splitlines()])


def load_gnuradio_file(file: str):
    return scipy.fromfile(open(file), dtype=scipy.complex64)


def resample_gnuradio(file: str, ratio: float):
    """ ratio is current_fs / desired_fs """
    f = load_gnuradio_file(file)
    resampled = signal.resample(f, len(f) * ratio)
    return resampled


def save_gnuradio_file(file: str, arr):
    conv = np.array(arr).astype(scipy.complex64)
    conv.tofile(file)


def hex_to_bitstr(hstr):
    """ http://stackoverflow.com/questions/1425493/convert-hex-to-binary """
    if isinstance(hstr, int):
        hstr = hex(hstr)
    if hstr[0:2] in ('0x', '0X'):
        hstr = hstr[2:]
    my_hexdata = hstr
    scale = 16  ## equals to hexadecimal
    num_of_bits = int(len(my_hexdata) * np.log2(scale))
    return bin(int(my_hexdata, scale))[2:].zfill(num_of_bits)


def hex_to_bool_list(hstr):
    return [bool(int(x)) for x in hex_to_bitstr(hstr)]

def int_to_bool_list(hstr):
    return [bool(int(x)) for x in hex_to_bitstr(hstr)]


def test_hex_to_bits():
    assert hex_to_bitstr('FF') == '11111111'
    assert hex_to_bitstr('0xFF') == '11111111'
    assert hex_to_bitstr('0XFF') == '11111111'
    assert hex_to_bitstr('0F') == '00001111'

    assert hex_to_bool_list('F') == [True, True, True, True]
    assert hex_to_bool_list('0F') == [False, False, False, False, True, True, True, True]

    assert hex_to_bool_list(0xF) == [True, True, True, True]
    assert hex_to_bool_list(0xFFFF) == [True] * 16


def bools_to_hex(bl):
    bitstr = bools_to_bitstr(bl)
    return hex(int(bitstr, 2))

def bools_to_bitstr(bl):
    return ''.join(str(int(x)) for x in bl)

def test_bools_to_hex():
    assert bools_to_hex([True, True, True, True]) == '0xf'
    assert bools_to_hex([True, True]) == '0x3'
    assert bools_to_hex([False, True, True, True, True, False, True, True]) == '0x7b'
    assert bools_to_hex([0, 1, 1, 1, 1, 0, 1, 1]) == '0x7b'
