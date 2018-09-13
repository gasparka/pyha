from enum import Enum

from pyha.common.core import Hardware
from pyha.common.fixed_point import Sfix
from pyha.conversion.type_transforms import get_vars_as_vhdl_types, VHDLInt, VHDLList, VHDLBool, VHDLSfix, VHDLModule, \
    VHDLEnum, BaseVHDLType


class TestVHDLList:
    def setup(self):
        d = [Sfix(0, 1, -2)] * 2
        self.dut = VHDLList('out', d, d)

        class T(Hardware):
            pass

        self.dut_sub = VHDLList('out', [T()] * 2, [T()] * 2)

    def test_pyha_type_sfix(self):
        expect = 'Typedefs.sfixed1downto_2_list_t(0 to 1)'
        assert self.dut._pyha_type() == expect

    def test_pyha_typedef(self):
        expect = 'type sfixed1downto_2_list_t is array (natural range <>) of sfixed(1 downto -2);'
        assert self.dut._pyha_typedef() == expect

    def test_pyha_type_is_compatible(self):
        a = VHDLList('name', [1, 2], [1, 2])
        b = VHDLList('name', [4, 5], [2, 2])
        c = VHDLList('name', [False, True], [False, True])
        d = VHDLList('name', [1, 2, 3], [1, 2, 3])
        assert a._pyha_type_is_compatible(a)
        assert a._pyha_type_is_compatible(b)
        assert not a._pyha_type_is_compatible(c)
        assert not d._pyha_type_is_compatible(c)

    def test_pyha_convert_from_stdlogic(self):
        a = VHDLList('name', [1, 2], [1, 2])
        expect = 'var(1) := to_integer(signed(in0(31 downto 0)));\n' \
                 'var(0) := to_integer(signed(in0(63 downto 32)));\n'

        assert expect == a._pyha_convert_from_stdlogic('var', 'in0')

    def test_pyha_convert_to_stdlogic(self):
        a = VHDLList('name', [1, 2], [1, 2])
        expect = 'var(31 downto 0) <= std_logic_vector(to_signed(in0(1), 32));\n' \
                 'var(63 downto 32) <= std_logic_vector(to_signed(in0(0), 32));\n'

        assert expect == a._pyha_convert_to_stdlogic('var', 'in0')

    def test_pyha_serialize(self):
        d = VHDLList('name', [1, 2], [1, 2])
        assert d._pyha_serialize() == '0000000000000000000000000000000100000000000000000000000000000010'

    def test_pyha_deserialize(self):
        d = VHDLList('name', [1, 2], [1, 2])
        assert d._pyha_deserialize('0000000000000000000000000000000100000000000000000000000000000010') \
               == [1, 2]


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
        expect = 'Sfix(0.29999542236328125, 1, -17)'
        assert dut._pyha_reset_value() == expect

        dut = VHDLSfix('name', Sfix(0, 2, -8), initial=Sfix(0.3))
        expect = 'Sfix(0.3, 2, -8)'
        assert dut._pyha_reset_value() == expect

    def test_pyha_type_is_compatible(self):
        a = VHDLSfix('name', Sfix(0, 1, -17), Sfix(0.3, 1, -17))
        b = VHDLSfix('name', Sfix(0, 1, -1), Sfix(0.3, 1, -1))
        assert a._pyha_type_is_compatible(a)
        assert not a._pyha_type_is_compatible(b)

    def test_pyha_serialize(self):
        d = VHDLSfix('name', Sfix(0, 1, -1), Sfix(0, 1, -1))
        assert d._pyha_serialize() == '000'

        d = VHDLSfix('name', Sfix(0.5, 0, -1), Sfix(0.5, 0, -1))
        assert d._pyha_serialize() == '01'

        d = VHDLSfix('name', Sfix(0.9999, 0, -8), Sfix(0.9999, 0, -8))
        assert d._pyha_serialize() == '011111111'

        d = VHDLSfix('name', Sfix(-1, 0, -8), Sfix(-1, 0, -8))
        assert d._pyha_serialize() == '100000000'


class TestVHDLModule:
    def setup(self):
        class T(Hardware):
            def __init__(self):
                self.a = 0
                self.b = Sfix(0, 0, -17)

        self.dut = VHDLModule('name', T(), T())

    def test_pyha_module_name(self):
        class T(Hardware):
            def __init__(self):
                self.a = 0
                self.b = Sfix(0, 0, -17)

        class Root(Hardware):
            def __init__(self):
                self.a = T()
                self.b = T()

        dut = VHDLModule('name', Root(), Root())
        expect = 'T_0'
        assert dut.elems[0]._pyha_module_name() == expect
        assert dut.elems[1]._pyha_module_name() == expect

    def test_pyha_module_name_not_compatible(self):
        class T(Hardware):
            def __init__(self, n):
                self.a = [1] * n
                self.b = Sfix(0, 0, -17)

        class Root(Hardware):
            def __init__(self):
                self.a = T(2)
                self.b = T(3)

        dut = VHDLModule('name', Root(), Root())
        assert dut.elems[0]._pyha_module_name() == 'T_0'
        assert dut.elems[1]._pyha_module_name() == 'T_1'

    def test_pyha_type(self):
        expect = 'T_0.self_t'
        assert self.dut._pyha_type() == expect

    def test_pyha_type_is_compatible(self):
        class A(Hardware):
            def __init__(self, init):
                self.REG = init

        class B(Hardware):
            def __init__(self):
                self.REG = 1
                self.lol = False

        class C(Hardware):
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

    def test_pyha_convert_from_stdlogic(self):
        class B(Hardware):
            def __init__(self):
                self.f = Sfix(0, 0, -17)

        class A(Hardware):
            def __init__(self):
                self.i = 1
                self.b = False
                self.sub = B()

        a = VHDLModule('name', A(), A())
        expect = 'var.i := to_integer(signed(in0(31 downto 0)));\n' \
                 'var.b := logic_to_bool(in0(32 downto 32));\n' \
                 'var.sub.f := Sfix(in0(50 downto 33), 0, -17);\n'

        assert expect == a._pyha_convert_from_stdlogic('var', 'in0')

    def test_pyha_convert_to_stdlogic(self):
        class B(Hardware):
            def __init__(self):
                self.f = Sfix(0, 0, -17)

        class A(Hardware):
            def __init__(self):
                self.i = 1
                self.b = False
                self.sub = B()

        a = VHDLModule('name', A(), A())

        expect = 'var(31 downto 0) <= std_logic_vector(to_signed(in0.i, 32));\n' \
                 'var(32 downto 32) <= bool_to_logic(in0.b);\n' \
                 'var(50 downto 33) <= to_slv(in0.sub.f);\n'

        assert expect == a._pyha_convert_to_stdlogic('var', 'in0')

    def test_pyha_is_equal(self):
        class A(Hardware):
            def __init__(self, v):
                self.f = v

        a = VHDLModule('name', A(False), A(True))
        b = VHDLModule('name', A(True), A(False))
        assert a._pyha_is_equal(a)
        assert not a._pyha_is_equal(b)

        a = VHDLModule('name', A([1, 2, 3]), A([1, 2, 3]))
        b = VHDLModule('name', A([3, 2, 1]), A([3, 2, 1]))
        assert a._pyha_is_equal(a)
        assert not a._pyha_is_equal(b)

    def test_pyha_to_python_value(self):
        class A(Hardware):
            def __init__(self):
                self.f = Sfix(0.5, 0, -5)
                self.fl = [Sfix(0.5, 0, -5)] * 2

        a = VHDLModule('name', A(), A())
        pyt = a._pyha_to_python_value()
        assert pyt.f == 0.5
        assert pyt.fl == [0.5] * 2

        # def test_serialize(self):
        #     class A(HW):
        #         def __init__(self):
        #             self.f = False
        #             self.t = True
        #
        #     a = VHDLModule('name', A(), A())
        #     r = a._pyha_serialize()
        #
        #     c = a._pyha_convert_from_stdlogic('var', 'in0')
        #     pass


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
        expect = 'subtype T is natural range 0 to 3; -- enum converted to range due to Quartus "bug", see #154'
        assert dut._pyha_typedef() == expect

    def test_pyha_reset_value(self):
        dut = VHDLEnum('name', self.T.ENUM0, self.T.ENUM1)
        expect = 1
        assert dut._pyha_reset_value() == expect


def test_get_conversion_vars_int():
    class T(Hardware):
        def __init__(self):
            self.i = 0

        def main(self, i):
            self.i = i

    dut = T()
    dut._pyha_enable_function_profiling_for_types()
    dut.main(1)
    dut._pyha_update_registers()
    ret = get_vars_as_vhdl_types(dut)

    expect = [VHDLInt('i', 1, 0)]

    assert ret == expect


def test_get_conversion_vars_int_list():
    class T(Hardware):
        def __init__(self):
            self.i = [0, 1, 2]

    dut = T()
    ret = get_vars_as_vhdl_types(dut)

    expect = [VHDLList('i', [0, 1, 2], [0, 1, 2])]

    assert ret == expect
