import textwrap

from pyha.common.const import Const
from pyha.common.hwsim import HW
from pyha.conversion.conversion import get_conversion
from pyha.conversion.extract_datamodel import DataModel


class TestSingleInt:
    def setup(self):
        class T0(HW):
            def __init__(self):
                self.mode = Const(1)

            def main(self, a):
                if a:
                    return a
                else:
                    return 0

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






        # todo: for lists of submodules constants must match!
