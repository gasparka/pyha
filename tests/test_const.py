import textwrap
from enum import Enum

import numpy as np
import pytest

from pyha.common.const import Const
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, ComplexSfix
from pyha.conversion.conversion import get_conversion, Conversion
from pyha.conversion.extract_datamodel import DataModel
from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL, SIM_RTL, SIM_GATE


class TestBasic:
    def setup(self):
        class B0(HW):
            def __init__(self):
                self.reg = 32
                self.mode = Const(1)

            def main(self, a):
                l = [1, 2, 3]
                b = l[self.mode]
                return self.mode

        self.dut = B0()
        self.dut.main(1)
        self.dut.main(2)
        self.datamodel = DataModel(self.dut)
        # self.conversion = get_conversion(self.dut)

    def test_collect(self):
        assert len(self.dut.__dict__['_pyha_constants']) == 1
        assert self.dut.__dict__['_pyha_constants']['mode'] == 1
        assert self.dut.__dict__['mode'] == 1
        assert self.dut.__dict__['reg'] == 32

    def test_datamodel(self):
        assert self.datamodel.self_data['reg'] == 32
        assert len(self.datamodel.self_data) == 1

        assert self.datamodel.constants['mode'] == 1
        assert len(self.datamodel.constants) == 1


class TestSingleInt:
    def setup(self):
        class T0(HW):
            def __init__(self):
                self.mode = Const(1)

            def main(self, a):
                return self.mode

        self.dut = T0()
        self.dut.main(1)
        self.dut.main(2)
        self.datamodel = DataModel(self.dut)
        self.conversion = get_conversion(self.dut)

    def test_datamodel(self):
        assert self.datamodel.self_data[
                   'much_dummy_very_wow'] == 0  # dummy because constants are not added to VHDL self
        assert self.datamodel.constants['mode'] == 1

    def test_vhdl_datamodel(self):
        expect = textwrap.dedent("""\
                type register_t is record
                    much_dummy_very_wow: integer;
                end record;

                type self_t is record
                    -- constants
                    mode: integer;

                    much_dummy_very_wow: integer;
                    \\next\\: register_t;
                end record;""")
        dm = self.conversion.get_datamodel()
        assert expect == dm

    def test_constants_self(self):
        expect = textwrap.dedent("""\
            procedure \\_pyha_constants_self\\(self: inout self_t) is
            begin
                self.mode := 1;
            end procedure;""")

        assert expect == str(self.conversion.get_constants_self())

    def test_reset_self(self):
        expect = textwrap.dedent("""\
            procedure \\_pyha_reset_self\\(self: inout self_t) is
            begin
                self.much_dummy_very_wow := 0;
                self.\\next\\.much_dummy_very_wow := self.much_dummy_very_wow;
                \\_pyha_constants_self\\(self);
            end procedure;""")

        assert expect == str(self.conversion.get_reset_self())

    def test_update_self(self):
        expect = textwrap.dedent("""\
            procedure \\_pyha_update_self\\(self: inout self_t) is
            begin
                self.much_dummy_very_wow := self.\\next\\.much_dummy_very_wow;
            end procedure;""")

        assert expect == str(self.conversion.get_update_self())

    def test_simulate(self):
        x = [0] * 8
        expected = [self.dut.mode] * 8
        assert_sim_match(self.dut, [int], expected, x)


class DummyEnum(Enum):
    FIRST, SECOND = [0, 1]


class TestMultiIntSfixEnumBooleanCFix:
    def setup(self):
        class T1(HW):
            def __init__(self):
                self.reg = 0

                self.cint = Const(32)
                self.cbool = Const(False)
                self.cenum = Const(DummyEnum.SECOND)
                self.csfix = Const(Sfix(np.pi, 2, -18))
                self.ccfix = Const(ComplexSfix(0.5 - 0.25j, 0, -18))

            def main(self, a):
                # enum cannot be returned atm
                return self.cint, self.cbool, self.csfix, self.ccfix

        self.dut = T1()
        self.dut.main(1)
        self.dut.main(2)
        self.datamodel = DataModel(self.dut)
        self.conversion = get_conversion(self.dut)

    def test_datamodel(self):
        assert self.datamodel.self_data[
                   'reg'] == 0  # dummy because constants are not added to VHDL self
        assert self.datamodel.constants['cint'] == 32
        assert self.datamodel.constants['cbool'] == False
        assert self.datamodel.constants['cenum'] == DummyEnum.SECOND
        assert self.datamodel.constants['csfix'] == Sfix(np.pi, 2, -18)
        assert self.datamodel.constants['ccfix'] == ComplexSfix(0.5 - 0.25j, 0, -18)

    def test_vhdl_enum_define(self):
        expect = ['type DummyEnum is (FIRST,SECOND);']
        dm = self.conversion.get_enumdefs()
        assert expect == dm

    def test_vhdl_datamodel(self):
        expect = textwrap.dedent("""\
                type register_t is record
                    reg: integer;
                end record;

                type self_t is record
                    -- constants
                    cint: integer;
                    cbool: boolean;
                    cenum: DummyEnum;
                    csfix: sfixed(2 downto -18);
                    ccfix: complex_sfix0_18;

                    reg: integer;
                    \\next\\: register_t;
                end record;""")
        dm = self.conversion.get_datamodel()
        assert expect == dm

    def test_constants_self(self):
        expect = textwrap.dedent("""\
            procedure \\_pyha_constants_self\\(self: inout self_t) is
            begin
                self.cint := 32;
                self.cbool := False;
                self.cenum := SECOND;
                self.csfix := Sfix(3.141592653589793, 2, -18);
                self.ccfix := (real=>Sfix(0.5, 0, -18), imag=>Sfix(-0.25, 0, -18));
            end procedure;""")

        assert expect == str(self.conversion.get_constants_self())

    def test_simulate(self):
        x = [0] * 8
        expected = [
            [32] * 8,
            [False] * 8,
            [np.pi] * 8,
            [0.5 - 0.25j] * 8
        ]

        assert_sim_match(self.dut, [int], expected, x)


class TestFloat:
    def setup(self):
        class T2(HW):
            def __init__(self):
                self.reg = 0
                self.cfloat = Const(0.5219)

            def main(self, a):
                r = Sfix(self.cfloat, 0, -28)
                b = r + self.cfloat
                return b

        self.dut = T2()
        self.dut.main(1)
        self.dut.main(2)
        self.datamodel = DataModel(self.dut)
        self.conversion = get_conversion(self.dut)

    def test_datamodel(self):
        assert self.datamodel.self_data['reg'] == 0  # dummy because constants are not added to VHDL self
        assert self.datamodel.constants['cfloat'] == 0.5219

    def test_vhdl_datamodel(self):
        expect = textwrap.dedent("""\
                type register_t is record
                    reg: integer;
                end record;

                type self_t is record
                    -- constants
                    cfloat: real;

                    reg: integer;
                    \\next\\: register_t;
                end record;""")
        dm = self.conversion.get_datamodel()
        assert expect == dm

    def test_constants_self(self):
        expect = textwrap.dedent("""\
            procedure \\_pyha_constants_self\\(self: inout self_t) is
            begin
                self.cfloat := 0.5219;
            end procedure;""")

        assert expect == str(self.conversion.get_constants_self())

    def test_simulate(self):
        # back there constants were not part of the register variable, so float constants did work
        # it is possible to bring it back, but is it worth it?
        pytest.xfail('Works in revision bfa723e80afa9e3967fd51c2dc179b6a414d3e82')
        x = [0] * 8
        expected = [0.5219 * 2] * 8
        assert_sim_match(self.dut, [int], expected, x)


class TestLists:
    def setup(self):
        class T3(HW):
            def __init__(self):
                self.reg = 0
                self.cfloat = Const([0.1, 0.2, 0.3, 0.4])
                self.cint = Const([1, 2, 3, 4])
                self.cbool = Const([True, True, True, False])
                self.csfix = Const([Sfix(0.25, 0, -18)] * 4)
                self.ccfix = Const([ComplexSfix(0.25 + 0.5j, 0, -18)] * 4)

            def main(self, a):
                b = self.csfix[0] * self.cfloat[3]
                c = self.ccfix[0].real * self.cfloat[1]
                return b, c

        self.dut = T3()
        self.dut.main(1)
        self.dut.main(2)
        self.datamodel = DataModel(self.dut)
        self.conversion = get_conversion(self.dut)

    def test_vhdl_datamodel(self):
        expect = textwrap.dedent("""\
                type register_t is record
                    reg: integer;
                end record;

                type self_t is record
                    -- constants
                    cfloat: real_list_t(0 to 3);
                    cint: integer_list_t(0 to 3);
                    cbool: boolean_list_t(0 to 3);
                    csfix: sfixed0_18_list_t(0 to 3);
                    ccfix: complex_sfix0_18_list_t(0 to 3);

                    reg: integer;
                    \\next\\: register_t;
                end record;""")
        dm = self.conversion.get_datamodel()
        assert expect == dm

    def test_constants_self(self):
        expect = textwrap.dedent("""\
            procedure \\_pyha_constants_self\\(self: inout self_t) is
            begin
                self.cfloat := (0.1, 0.2, 0.3, 0.4);
                self.cint := (1, 2, 3, 4);
                self.cbool := (True, True, True, False);
                self.csfix := (Sfix(0.25, 0, -18), Sfix(0.25, 0, -18), Sfix(0.25, 0, -18), Sfix(0.25, 0, -18));
                self.ccfix := ((real=>Sfix(0.25, 0, -18), imag=>Sfix(0.5, 0, -18)), (real=>Sfix(0.25, 0, -18), imag=>Sfix(0.5, 0, -18)), (real=>Sfix(0.25, 0, -18), imag=>Sfix(0.5, 0, -18)), (real=>Sfix(0.25, 0, -18), imag=>Sfix(0.5, 0, -18)));
            end procedure;""")

        assert expect == str(self.conversion.get_constants_self())

    def test_complex_types(self):
        expect = textwrap.dedent("""\
            library ieee;
                use ieee.fixed_pkg.all;

            package ComplexTypes is
            type complex_sfix0_18 is record
                real: sfixed(0 downto -18);
                imag: sfixed(0 downto -18);
            end record;
            function ComplexSfix(a, b: sfixed(0 downto -18)) return complex_sfix0_18;

            end package;

            package body ComplexTypes is
            function ComplexSfix(a, b: sfixed(0 downto -18)) return complex_sfix0_18 is
            begin
                return (a, b);
            end function;

            end package body;
            """)

        s = Conversion(self.dut).make_vhdl_complex_types()
        assert expect == s[s.index('library'):]

    def test_simulate(self):
        # back there constants were not part of the register variable, so float constants did work
        # it is possible to bring it back, but is it worth it?
        pytest.xfail('Works in revision bfa723e80afa9e3967fd51c2dc179b6a414d3e82')
        x = [0] * 8
        expected = [[0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1],
                    [0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05]]

        assert_sim_match(self.dut, [int], expected, x,
                         simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         rtol=1e-4)
