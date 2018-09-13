import textwrap
from pathlib import Path
import os
from unittest import mock
import pytest
from pyha import simulate
from pyha.common.core import Hardware
from pyha.common.fixed_point import Sfix
from pyha.conversion.conversion import RecursiveConverter, get_objects_rednode
from pyha.simulation import vhdl_simulation
from pyha.simulation.simulation_interface import assert_sim_match
from unittest.mock import MagicMock, patch


class T:
    pass


@pytest.fixture
def dut():
    class Dummy(Hardware):
        def main(self, a):
            return a

    o = Dummy()
    o._pyha_enable_function_profiling_for_types()
    # train object
    o.main(1)
    o.main(2)
    return RecursiveConverter(o)


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
    class Dummy(Hardware):
        def main(self, a):
            return a

    class Dummy2(Hardware):
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
    assert files[0] == tmpdir / 'Dummy_0.vhd' and files[0].is_file()
    assert files[1] == tmpdir / 'top.vhd' and files[0].is_file()


def test_convert_submodule():
    class Aa(Hardware):
        def __init__(self):
            self.reg = 0

        def main(self, a):
            self.reg = a
            return self.reg

    class B(Hardware):
        def __init__(self):
            self.sub = Aa()
            self.DELAY = 1

        def main(self, a):
            ret = self.sub.main(a)
            return ret

    x = list(range(16))
    expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    dut = B()

    assert_sim_match(dut, expected, x, dir_path='/home/gaspar/git/pyha/playground')


def test_convert_submodule_name_conflict():
    class A2(Hardware):
        def __init__(self):
            self.reg = 0

    class B2(Hardware):
        def __init__(self):
            self.sub = A2()
            self.sub2 = A2()

        def main(self, a):
            return a

    dut = B2()
    dut._pyha_enable_function_profiling_for_types()

    dut.main(1)
    conv = RecursiveConverter(dut)
    paths = conv.write_vhdl_files(Path('/tmp'))
    names = [x.name for x in paths]
    assert names == ['A2_0.vhd', 'B2_0.vhd', 'top.vhd']


def test_element_with_none_bound():
    class Child(Hardware):
        def __init__(self):
            self.reg = Sfix()

        def main(self, a):
            self.reg = a

    class DUT(Hardware):
        def __init__(self):
            self.child1 = Child()
            self.child2 = Child()

        def main(self, a):
            self.child1.main(a)
            return a

    dut = DUT()
    inp = [0.1, 0.2, 0.3]

    if 'PYHA_SKIP_RTL' in os.environ:
        pytest.skip()

    with patch('os._exit', MagicMock(return_value=0)):
        with pytest.raises(Exception):
            sims = simulate(dut, inp, simulations=['PYHA', 'RTL'])
