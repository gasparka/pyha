import textwrap

from pyha.common.hwsim import HW
from pyha.conversion.conversion import get_conversion
from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL, SIM_RTL, SIM_GATE


# This fail shall collect all simple conversion tests?
class TestReg:
    def setup(self):
        class Reg(HW):
            def __init__(self):
                self.a = 0

            def main(self, a):
                self.next.a = a
                return self.a

        self.dut = Reg()
        self.dut.main(1)
        self.conversion = get_conversion(self.dut)

    def test_simulate(self):
        inputs = [1, 2, 3, 4]
        expect = [0, 1, 2, 3]

        assert_sim_match(self.dut, [int], expect, inputs,
                         simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         dir_path='/home/gaspar/git/pyha/playground/conv')

    def test_datamodel(self):
        expect = textwrap.dedent("""\
                type register_t is record
                    a: integer;
                end record;

                type self_t is record

                    a: integer;
                    \\next\\: register_t;
                end record;""")
        dm = self.conversion.get_datamodel()
        assert expect == dm

    def test_update_self(self):
        expect = textwrap.dedent("""\
            procedure update_self(self: inout self_t) is
            begin

                self.a := self.\\next\\.a;
            end procedure;""")
        dm = self.conversion.get_update_self()
        assert expect == dm

    def test_reset(self):
        expect = textwrap.dedent("""\
            procedure reset_self(self: inout self_t) is
            begin
                self.a := 0;
                self.\\next\\.a := 0;
            end procedure;""")

        dm = self.conversion.get_reset_self()
        assert expect == dm


class TestCounter:
    def setup(self):
        class Dut1(HW):
            def __init__(self):
                self.a = 0

            def main(self, a):
                self.next.a = self.a + 1
                if self.next.a > 3 or self.next.a < 0:
                    self.next.a = 0

                return self.a

        self.dut = Dut1()
        self.dut.main(1)
        self.conversion = get_conversion(self.dut)

    def test_simulate(self):
        inputs = [0] * 16
        expect = [0, 1, 2, 3] * 4

        assert_sim_match(self.dut, [int], expect, inputs,
                         simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         dir_path='/home/gaspar/git/pyha/playground/conv')

    def test_datamodel(self):
        expect = textwrap.dedent("""\
                type register_t is record
                    a: integer;
                end record;

                type self_t is record

                    a: integer;
                    \\next\\: register_t;
                end record;""")
        dm = self.conversion.get_datamodel()
        assert expect == dm

    def test_update_self(self):
        expect = textwrap.dedent("""\
            procedure update_self(self: inout self_t) is
            begin

                self.a := self.\\next\\.a;
            end procedure;""")
        dm = self.conversion.get_update_self()
        assert expect == dm

    def test_reset(self):
        expect = textwrap.dedent("""\
            procedure reset_self(self: inout self_t) is
            begin
                self.a := 0;
                self.\\next\\.a := 0;
            end procedure;""")

        dm = self.conversion.get_reset_self()
        assert expect == dm

        # maybe const works now without tricks?
