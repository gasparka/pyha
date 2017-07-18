from pathlib import Path

import pytest
from pyha.common.hwsim import HW
from pyha.conversion.conversion import Conversion, get_objects_rednode
from pyha.simulation.simulation_interface import assert_sim_match


class T:
    pass


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


def test_get_objects_rednode(dut):
    red = get_objects_rednode(dut.obj)
    assert red.name == 'Dummy'


def test_get_objects_rednode_global():
    red = get_objects_rednode(T())
    assert red.name == 'T'


def test_get_objects_rednode_local():
    class T0:
        def b(self):
            pass

    red = get_objects_rednode(T0())
    assert red.dumps() == 'class T0:\n    def b(self):\n        pass\n'


def test_get_objects_rednode_local2():
    class T0:
        def a(self):
            pass

    red = get_objects_rednode(T0())
    assert red.dumps() == 'class T0:\n    def a(self):\n        pass\n'


def test_get_objects_rednode_local_two():
    class Dummy(HW):
        def main(self, a):
            return a

    class Dummy2(HW):
        def main(self, a):
            return a

    red = get_objects_rednode(Dummy())
    assert red.name == 'Dummy'

    red = get_objects_rednode(Dummy2())
    assert red.name == 'Dummy2'


def test_get_objects_rednode_selective():
    pytest.xfail('Will not work, since locals cannot be walked')

    def f0():
        class T0:
            def b(self):
                pass

        return T0()

    def f1():
        class T0:
            def a(self):
                pass

        return T0()

    red = get_objects_rednode(f0())
    assert red.dumps() == 'class T0:\n    def b(self):\n        pass\n'

    red = get_objects_rednode(f1())
    assert red.dumps() == 'class T0:\n    def a(self):\n        pass\n'


def test_write_vhdl_files(dut, tmpdir):
    tmpdir = Path(str(tmpdir))
    files = dut.write_vhdl_files(tmpdir)
    # 0 is complex support file
    assert files[1] == tmpdir / 'Dummy_0.vhd' and files[0].is_file()
    assert files[2] == tmpdir / 'top.vhd' and files[0].is_file()


def test_inputs(dut):
    assert len(dut.inputs) == 1 and type(dut.inputs[0]) == int


def test_outputs(dut):
    assert len(dut.outputs) == 1 and type(dut.outputs[0]) == int


def test_convert_submodule():
    class Aa(HW):
        def __init__(self):
            self.reg = 0

        def main(self, a):
            self.reg = a
            return self.reg

    class B(HW):
        def __init__(self):
            self.sub = Aa()
            self.DELAY = 1

        def main(self, a):
            ret = self.sub.main(a)
            return ret

    x = list(range(16))
    expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    dut = B()

    assert_sim_match(dut, expected, x)


def test_convert_submodule_name_conflict():
    class A2(HW):
        def __init__(self):
            self.reg = 0

        def main(self, a):
            self.reg = a
            return self.reg

    class B2(HW):
        def __init__(self):
            self.sub = A2()
            self.sub2 = A2()

        def main(self, a):
            ret = self.sub.main(a)
            ret2 = self.sub2.main(ret)
            return ret2

    dut = B2()
    # train object
    dut.main(1)
    dut.main(2)
    conv = Conversion(dut)
    paths = conv.write_vhdl_files(Path('/tmp'))
    names = [x.name for x in paths]
    assert names[1:] == ['A2_0.vhd', 'A2_1.vhd', 'B2_0.vhd', 'top.vhd']
    # x = list(range(16))
    # expected = [0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
    # dut = B()
    #
    # assert_sim_match(dut, [int], expected, x,
    #                  simulations=[SIM_HW_MODEL, SIM_RTL])
