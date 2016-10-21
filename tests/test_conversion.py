import pytest

from pyha.conversion.conversion import Conversion


def test_get_objects_source_path():
    dut = Conversion(None)
    path = dut.get_objects_source_path(dut)
    assert path == '/home/gaspar/git/pyha/pyha/conversion/conversion.py'

def test_get_objects_rednode():
    dut = Conversion(None)
    red = dut.get_objects_rednode(dut)
    assert red.name == 'Conversion'

def test_get_objects_rednode_badtype():
    bad = 0.2
    dut = Conversion(None)
    with pytest.raises(Exception):
        red = dut.get_objects_rednode(bad)

def test_get_objects_rednode_twonodes():
    class Dummy:
        pass
    class Dummy:
        pass

    bad = Dummy()
    dut = Conversion(None)
    with pytest.raises(Exception):
        red = dut.get_objects_rednode(bad)
