from pathlib import Path

import pytest

import pyha
from pyha.common.hwsim import HW
from pyha.conversion.conversion import Conversion, MultipleNodesError
from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL, SIM_RTL


@pytest.fixture
def dut():
    class Dummy(HW):
        def main(self, a):
            return a

    o = Dummy()
    # train object
    o.main(1)
    o.main(2)
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


def test_convert_submodule():
    class Aa(HW):
        def __init__(self):
            self.reg = 0

        def main(self, a):
            self.next.reg = a
            return self.reg

    class B(HW):
        def __init__(self):
            self.sub = Aa()

        def main(self, a):
            ret = self.next.sub.main(a)
            return ret

    x = list(range(16))
    expected = [0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
    dut = B()

    assert_sim_match(dut, [int], expected, x,
                     simulations=[SIM_HW_MODEL, SIM_RTL])

    # dut = B()
    # # train object
    # dut.main(1)
    # dut.main(2)
    # b_main = dut.main
    # a_main = dut.sub.main
    # conv = Conversion(dut)
    # paths = conv.write_vhdl_files(Path('/home/gaspar/git/pyha/playground/conv'))
    pass


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
    o.main(1)
    o.main(2)

    with pytest.raises(MultipleNodesError):
        d = Conversion(o)
