from pyha.common.util import hex_to_bitstr, bools_to_hex, hex_to_bool_list


def test_bools_to_hex():
    assert bools_to_hex([True, True, True, True]) == '0xf'
    assert bools_to_hex([True, True]) == '0x3'
    assert bools_to_hex([False, True, True, True, True, False, True, True]) == '0x7b'
    assert bools_to_hex([0, 1, 1, 1, 1, 0, 1, 1]) == '0x7b'


def test_hex_to_bits():
    assert hex_to_bitstr('FF') == '11111111'
    assert hex_to_bitstr('0xFF') == '11111111'
    assert hex_to_bitstr('0XFF') == '11111111'
    assert hex_to_bitstr('0F') == '00001111'

    assert hex_to_bool_list('F') == [True, True, True, True]
    assert hex_to_bool_list('0F') == [False, False, False, False, True, True, True, True]

    assert hex_to_bool_list(0xF) == [True, True, True, True]
    assert hex_to_bool_list(0xFFFF) == [True] * 16