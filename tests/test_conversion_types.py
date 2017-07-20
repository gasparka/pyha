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

    def test_pyha_reset(self):
        dut = BaseVHDLType('out', 0, 0)
        expect = 'self.\\next\\.\\out\\ := 0;\n'
        assert expect == dut._pyha_reset()


class TestVHDLList:
    def setup(self):
        d = [Sfix(0, 1, -2)] * 2
        self.dut = VHDLList('out', d, d)

        class T(HW):
            pass

        self.dut_sub = VHDLList('out', [T()] * 2, [T()] * 2)

    def test_pyha_type_sfix(self):
        expect = 'sfixed1downto_2_list_t(0 to 1)'
        assert self.dut._pyha_type() == expect

    def test_pyha_typedef(self):
        expect = 'type sfixed1downto_2_list_t is array (natural range <>) of sfixed(1 downto -2);'
        assert self.dut._pyha_typedef() == expect

    def test_pyha_init(self):
        expect = 'self.\\next\\.\\out\\ := self.\\out\\;'
        assert expect == self.dut._pyha_init()

        expect = 'T_0.\\_pyha_init\\(self.\\out\\(0));\n' \
                 'T_0.\\_pyha_init\\(self.\\out\\(1));'
        assert expect == self.dut_sub._pyha_init()

    def test_pyha_update_registers(self):
        expect = 'self.\\out\\ := self.\\next\\.\\out\\;'
        assert expect == self.dut._pyha_update_registers()

        expect = 'T_0.\\_pyha_update_registers\\(self.\\out\\(0));\n' \
                 'T_0.\\_pyha_update_registers\\(self.\\out\\(1));'
        assert expect == self.dut_sub._pyha_update_registers()

    def test_pyha_reset(self):
        expect = 'self.\\next\\.\out\ := (Sfix(0.0, 1, -2), Sfix(0.0, 1, -2));\n'
        assert expect == self.dut._pyha_reset()

    def test_pyha_reset_ints(self):
        d = [1, 2]
        dut = VHDLList('out', d, d)
        expect = 'self.\\next\\.\out\ := (1, 2);\n'
        assert expect == dut._pyha_reset()

        expect = 'self.dummy.\\next\\.\out\ := (1, 2);\n'
        assert expect == dut._pyha_reset('self.dummy')

    def test_pyha_reset_submodules(self):
        class C2(HW):
            def __init__(self):
                self.regor = False

        class A2(HW):
            def __init__(self, reg_init):
                self.reg = reg_init
                self.submodule = C2()

        sublist = [A2(2), A2(128)]
        s = VHDLList('sublist', sublist, sublist)

        expect = 'self.sublist(0).\\next\\.reg := 2;\n' \
                 'self.sublist(0).submodule.\\next\\.regor := False;\n' \
                 'self.sublist(1).\\next\\.reg := 128;\n' \
                 'self.sublist(1).submodule.\\next\\.regor := False;\n'
        assert expect == s._pyha_reset()

    def test_pyha_type_is_compatible(self):
        a = VHDLList('name', [1, 2], [1, 2])
        b = VHDLList('name', [4, 5], [2, 2])
        c = VHDLList('name', [False, True], [False, True])
        d = VHDLList('name', [1, 2, 3], [1, 2, 3])
        assert a._pyha_type_is_compatible(a)
        assert a._pyha_type_is_compatible(b)
        assert not a._pyha_type_is_compatible(c)
        assert not d._pyha_type_is_compatible(c)


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

    def test_pyha_reset_value(self):
        dut = VHDLSfix('name', Sfix(0, 1, -17), initial=Sfix(0.3, 1, -17))
        expect = 'Sfix(0.3, 1, -17)'
        assert dut._pyha_reset_value() == expect

        dut = VHDLSfix('name', Sfix(0, 2, -8), initial=Sfix(0.3))
        expect = 'Sfix(0.3, 2, -8)'
        assert dut._pyha_reset_value() == expect

    def test_pyha_type_is_compatible(self):
        a = VHDLSfix('name', Sfix(0, 1, -17), Sfix(0.3, 1, -17))
        b = VHDLSfix('name', Sfix(0, 1, -1), Sfix(0.3, 1, -1))
        assert a._pyha_type_is_compatible(a)
        assert not a._pyha_type_is_compatible(b)


class TestVHDLModule:
    def setup(self):
        class T(HW):
            def __init__(self):
                self.a = 0
                self.b = Sfix(0, 0, -17)

        self.dut = VHDLModule('name', T(), T())

    def test_pyha_module_name(self):
        class T(HW):
            def __init__(self):
                self.a = 0
                self.b = Sfix(0, 0, -17)

        class Root(HW):
            def __init__(self):
                self.a = T()
                self.b = T()

        dut = VHDLModule('name', Root(), Root())
        expect = 'T_0'
        assert dut.elems[0]._pyha_module_name() == expect
        assert dut.elems[1]._pyha_module_name() == expect

    def test_pyha_module_name_not_compatible(self):
        class T(HW):
            def __init__(self, n):
                self.a = [1] * n
                self.b = Sfix(0, 0, -17)

        class Root(HW):
            def __init__(self):
                self.a = T(2)
                self.b = T(3)

        dut = VHDLModule('name', Root(), Root())
        assert dut.elems[0]._pyha_module_name() == 'T_0'
        assert dut.elems[1]._pyha_module_name() == 'T_1'

    def test_pyha_type(self):
        expect = 'T_0.self_t'
        assert self.dut._pyha_type() == expect

    def test_pyha_init(self):
        expect = 'T_0.\\_pyha_init\\(self.name);'
        assert self.dut._pyha_init() == expect

    def test_pyha_update_registers(self):
        expect = 'T_0.\\_pyha_update_registers\\(self.name);'
        assert self.dut._pyha_update_registers() == expect

    def test_pyha_reset(self):
        expect = 'self.name.\\next\\.a := 0;\n' \
                 'self.name.\\next\\.b := Sfix(0.0, 0, -17);\n'
        assert self.dut._pyha_reset() == expect

    def test_pyha_reset_recursive(self):
        class Label(HW):
            def __init__(self):
                self.register = Sfix(0.563, 0, -18)

        class C3(HW):
            def __init__(self):
                self.nested_list = [Label(), Label()]
                self.regor = False

        class A3(HW):
            def __init__(self, reg_init):
                self.reg = reg_init
                self.submodule = C3()

        class B3(HW):
            def __init__(self):
                self.ror = 554
                self.sublist = [A3(2), A3(128)]

        dut = VHDLModule('name', B3(), B3())
        expect = 'self.name.\\next\\.\\ror\\ := 554;\n' \
                 'self.name.sublist(0).\\next\\.reg := 2;\n' \
                 'self.name.sublist(0).submodule.nested_list(0).\\next\\.\\register\\ := Sfix(0.563, 0, -18);\n' \
                 'self.name.sublist(0).submodule.nested_list(1).\\next\\.\\register\\ := Sfix(0.563, 0, -18);\n' \
                 'self.name.sublist(0).submodule.\\next\\.regor := False;\n' \
                 'self.name.sublist(1).\\next\\.reg := 128;\n' \
                 'self.name.sublist(1).submodule.nested_list(0).\\next\\.\\register\\ := Sfix(0.563, 0, -18);\n' \
                 'self.name.sublist(1).submodule.nested_list(1).\\next\\.\\register\\ := Sfix(0.563, 0, -18);\n' \
                 'self.name.sublist(1).submodule.\\next\\.regor := False;\n'
        assert dut._pyha_reset() == expect

    def test_pyha_reset_lazy_sfix(self):
        """ Test that lazy Sfix values will take correct bound after 'main' execution"""

        class A4(HW):
            def __init__(self):
                self.a = [Sfix()] * 2
                self.b = [Sfix(left=1)] * 2
                self.c = [Sfix(right=-4)] * 2

            def main(self, a):
                self.a[0] = a
                self.b[0] = a
                self.c[0] = a
                return self.a[0], self.b[0], self.c[0]

        dut = A4()
        dut.main(Sfix(0.1, 0, -17))
        dut._pyha_update_self()

        dut = VHDLModule('name', dut, dut)

        expect = 'self.name.\\next\\.a := (Sfix(0.0, 0, -17), Sfix(0.0, 0, -17));\n' \
                 'self.name.\\next\\.b := (Sfix(0.0, 1, -17), Sfix(0.0, 1, -17));\n' \
                 'self.name.\\next\\.c := (Sfix(0.0, 0, -4), Sfix(0.0, 0, -4));\n'

        assert expect == dut._pyha_reset()

    def test_pyha_reset_constants(self):
        class A(HW):
            def __init__(self):
                self.REG = 1

        class T(HW):
            def __init__(self):
                self.A = 0
                self.c = 2
                self.REGISTER = 3
                self.ARR = [4, 5]
                self.arrr = [4, 5]
                self.m = A()
                self.out = [A(), A()]

        dut = VHDLModule('name', T(), T())

        expect = 'self.name.A := 0;\n' \
                 'self.name.\\REGISTER\\ := 3;\n' \
                 'self.name.ARR := (4, 5);\n' \
                 'self.name.m.REG := 1;\n' \
                 'self.name.\\out\\(0).REG := 1;\n' \
                 'self.name.\\out\\(1).REG := 1;'

        assert dut._pyha_reset_constants() == expect

    def test_pyha_type_is_compatible(self):
        class A(HW):
            def __init__(self, init):
                self.REG = init

        class B(HW):
            def __init__(self):
                self.REG = 1
                self.lol = False

        class C(HW):
            def __init__(self):
                self.a = A(1)
                self.b = B()

        a = VHDLModule('name', A(1), A(2))
        b = VHDLModule('name', B(), B())
        c = VHDLModule('name', C(), C())
        assert a._pyha_type_is_compatible(a)
        assert not a._pyha_type_is_compatible(b)
        assert c._pyha_type_is_compatible(c)
        assert not c._pyha_type_is_compatible(a)
        assert not c._pyha_type_is_compatible(b)


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

    def test_pyha_reset_value(self):
        dut = VHDLEnum('name', self.T.ENUM0, self.T.ENUM1)
        expect = 'ENUM1'
        assert dut._pyha_reset_value() == expect

    def test_pyha_reset(self):
        dut = VHDLEnum('name', self.T.ENUM0, self.T.ENUM1)
        expect = 'self.\\next\\.name := ENUM1;\n'
        assert dut._pyha_reset() == expect


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
