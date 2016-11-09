from pathlib import Path

import pyha
import pytest
from pyha.common.hwsim import HW
from pyha.conversion.conversion import Conversion


@pytest.fixture
def dut():
    class Dummy(HW):
        def main(self, a):
            return a

    o = Dummy()
    # train object
    o(1)
    o(2)
    return Conversion(o)


def test_get_objects_source_path(dut):
    path = dut.get_objects_source_path(dut)
    assert path == pyha.__path__[0] + '/conversion/conversion.py'


def test_get_objects_rednode(dut):
    red = dut.get_objects_rednode(dut.main_obj)
    assert red.name == 'Dummy'


def test_get_objects_rednode_badtype(dut):
    with pytest.raises(Exception):
        dut.get_objects_rednode(0.2)


def test_write_vhdl_files(dut, tmpdir):
    tmpdir = Path(str(tmpdir))
    files = dut.write_vhdl_files(tmpdir)
    assert files[0] == tmpdir / 'main.vhd' and files[0].is_file()
    assert files[1] == tmpdir / 'top.vhd' and files[0].is_file()


def test_inputs(dut):
    assert len(dut.inputs) == 1 and type(dut.inputs[0]) == int

def test_outputs(dut):
    assert len(dut.outputs) == 1 and type(dut.outputs[0]) == int

##################################
# MISC
##################################
def test_get_objects_rednode_twonodes():
    class Dummy2(HW):
        def main(self, a):
            return a

    class Dummy2(HW):
        def main(self, a):
            return a

    o = Dummy2()
    o(1)
    o(2)

    with pytest.raises(Exception):
        d = Conversion(o)
