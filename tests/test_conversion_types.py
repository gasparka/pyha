from enum import Enum

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.conversion.conversion_types import get_conversion_vars, VHDLInt, VHDLList, VHDLBool, VHDLSfix, VHDLModule, \
    VHDLEnum, BaseVHDLType


class TestBaseVHDLType:
    def test_pyha_init(self):
        dut = BaseVHDLType('out', 0, 0)
        expect = 'self.\\next\\.\\out\\ := self.\\out\\;'
        assert expect == dut._pyha_init()

    def test_pyha_update_registers(self):
        dut = BaseVHDLType('out', 0, 0)
        expect = 'self.\\out\\ := self.\\next\\.\\out\\;'
        assert expect == dut._pyha_update_registers()


class TestVHDLList:
    def test_pyha_type(self):
        d = [0, 1, 2]
        dut = VHDLList('name', d, d)
        expect = 'integer_list_t(0 to 2)'
        assert dut._pyha_type() == expect

    def test_pyha_type_sfix(self):
        d = [Sfix(0, 1, -2)] * 2
        dut = VHDLList('name', d, d)
        expect = 'sfixed1downto_2_list_t(0 to 1)'
        assert dut._pyha_type() == expect

    def test_pyha_typedef_sfix(self):
        d = [Sfix(0, 1, -2)] * 2
        dut = VHDLList('name', d, d)
        expect = 'type sfixed1downto_2_list_t is array (natural range <>) of sfixed(1 downto -2);'
        assert dut._pyha_typedef() == expect

    def test_pyha_init(self):
        d = [Sfix(0, 1, -2)] * 2
        dut = VHDLList('out', d, d)

        expect = 'self.\\next\\.\\out\\ := self.\\out\\;'
        assert expect == dut._pyha_init()

    def test_pyha_init_submodules(self):
        # special for submodules list
        class T(HW):
            pass

        d = [T()] * 2
        dut = VHDLList('out', d, d)

        expect = 'T_0.\\_pyha_init\\(self.\\out\\(0));\n' \
                 'T_0.\\_pyha_init\\(self.\\out\\(1));'
        assert expect == dut._pyha_init()


class TestVHDLInt:
    def test_pyha_type(self):
        dut = VHDLInt('name', 0, 0)
        expect = 'integer'
        assert dut._pyha_type() == expect


class TestVHDLBool:
    def test_pyha_type(self):
        dut = VHDLBool('name', False, True)
        expect = 'boolean'
        assert dut._pyha_type() == expect


class TestVHDLSfix:
    def test_pyha_type(self):
        dut = VHDLSfix('name', Sfix(0, 1, -17), Sfix(0.3, 1, -17))
        expect = 'sfixed(1 downto -17)'
        assert dut._pyha_type() == expect


class TestVHDLModule:

    def test_pyha_type(self):
        class T(HW):
            pass

        dut = VHDLModule('name', T(), T())
        expect = 'T_0.self_t'
        assert dut._pyha_type() == expect

    def test_pyha_init(self):
        class T(HW):
            pass

        dut = VHDLModule('name', T(), T())
        expect = 'T_0.\\_pyha_init\\(self.name);'
        assert dut._pyha_init() == expect



class TestVHDLEnum:
    class T(Enum):
        ENUM0, ENUM1, ENUM2, ENUM3 = range(4)

    def test_pyha_type(self):
        dut = VHDLEnum('name', self.T.ENUM0, self.T.ENUM0)
        expect = 'T'
        assert dut._pyha_type() == expect

    def test_pyha_typedef(self):
        d = self.T.ENUM0
        dut = VHDLEnum('name', d, d)
        expect = 'type T is (ENUM0,ENUM1,ENUM2,ENUM3);'
        assert dut._pyha_typedef() == expect


def test_get_conversion_vars_int():
    class T(HW):
        def __init__(self):
            self.i = 0

        def main(self, i):
            self.i = i

    dut = T()
    dut.main(1)
    dut._pyha_update_self()
    ret = get_conversion_vars(dut)

    expect = [VHDLInt('i', 1, 0)]

    assert ret == expect


def test_get_conversion_vars_int_list():
    class T(HW):
        def __init__(self):
            self.i = [0, 1, 2]

    dut = T()
    ret = get_conversion_vars(dut)

    expect = [VHDLList('i', [0, 1, 2], [0, 1, 2])]

    assert ret == expect
