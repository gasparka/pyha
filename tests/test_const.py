import textwrap
from enum import Enum

import numpy as np

from pyha.common.const import Const
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.conversion.conversion import get_conversion
from pyha.conversion.extract_datamodel import DataModel
from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL, SIM_RTL, SIM_GATE


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
        assert self.datamodel.constants['mode'] == Const(1)

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

    def test_vhdl_reset(self):
        expect = textwrap.dedent("""\
            procedure reset(self_reg: inout register_t) is
            begin
                self_reg.much_dummy_very_wow := 0;
            end procedure;""")

        assert expect == str(self.conversion.get_reset_str())

    def test_vhdl_makeself(self):
        expect = textwrap.dedent("""\
            procedure make_self(self_reg: register_t; self: out self_t) is
            begin
                -- constants
                self.mode := 1;

                self.much_dummy_very_wow := self_reg.much_dummy_very_wow;
                self.\\next\\ := self_reg;
            end procedure;""")

        assert expect == str(self.conversion.get_makeself_str())

    def test_simulate(self):
        x = [0] * 8
        expected = [self.dut.mode.value] * 8
        assert_sim_match(self.dut, [int], expected, x,
                         simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])


class DummyEnum(Enum):
    FIRST, SECOND = [0, 1]


class TestMultiIntSfixEnumBoolean:
    def setup(self):
        class T1(HW):
            def __init__(self):
                self.reg = 0

                self.cint = Const(32)
                self.cbool = Const(False)
                self.cenum = Const(DummyEnum.SECOND)
                self.csfix = Const(Sfix(np.pi, 0, -18))

            def main(self, a):
                return self.cint, self.cbool, self.cenum, self.csfix

        self.dut = T1()
        self.dut.main(1)
        self.dut.main(2)
        self.datamodel = DataModel(self.dut)
        self.conversion = get_conversion(self.dut)

    def test_datamodel(self):
        assert self.datamodel.self_data[
                   'reg'] == 0  # dummy because constants are not added to VHDL self
        assert self.datamodel.constants['cint'] == Const(32)
        assert self.datamodel.constants['cbool'] == Const(False)
        assert self.datamodel.constants['cenum'] == Const(DummyEnum.SECOND)
        assert self.datamodel.constants['csfix'] == Const(Sfix(np.pi, 0, -18))

    def test_vhdl_datamodel(self):
        expect = textwrap.dedent("""\
                type register_t is record
                    reg: integer;
                end record;

                type self_t is record
                    -- constants
                    cbool: boolean;
                    cenum: DummyEnum;
                    cint: integer;
                    csfix: sfixed(0 downto -18);

                    reg: integer;
                    \\next\\: register_t;
                end record;""")
        dm = self.conversion.get_datamodel()
        assert expect == dm

    def test_vhdl_reset(self):
        expect = textwrap.dedent("""\
            procedure reset(self_reg: inout register_t) is
            begin
                self_reg.reg := 0;
            end procedure;""")

        assert expect == str(self.conversion.get_reset_str())
        #
        # def test_vhdl_makeself(self):
        #     expect = textwrap.dedent("""\
        #         procedure make_self(self_reg: register_t; self: out self_t) is
        #         begin
        #             -- constants
        #             self.mode := 1;
        #
        #             self.much_dummy_very_wow := self_reg.much_dummy_very_wow;
        #             self.\\next\\ := self_reg;
        #         end procedure;""")
        #
        #     assert expect == str(self.conversion.get_makeself_str())
        #
        # def test_simulate(self):
        #     x = [0] * 8
        #     expected = [self.dut.mode.value] * 8
        #     assert_sim_match(self.dut, [int], expected, x,
        #                      simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])






        # todo: for lists of submodules constants must match!
        # todo: to_sfixed to Sfix
        # todo: test invalid stuff, like assign to const
