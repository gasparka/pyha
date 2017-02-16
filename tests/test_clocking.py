import textwrap

from pyha.common.hwsim import HW
from pyha.conversion.conversion import get_conversion
from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL, SIM_RTL, SIM_GATE


class TestBasic:
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
                         simulations=[SIM_HW_MODEL, SIM_RTL],
                         dir_path='/home/gkarm/git/pyha/playground/conv')

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
            end procedure;""")

        dm = self.conversion.get_reset_self()
        assert expect == dm

    # def test_vhdl_main(self):
    #     expect = textwrap.dedent("""\
    #         procedure main(self_reg:inout register_t; a: boolean; ret_0:out integer) is
    #             variable self: self_t;
    #         begin
    #             make_self(self_reg, self);
    #             main_user(self, a, ret_0);
    #             self_reg := self.\\next\\;
    #         end procedure;""")
    #
    #     dm = self.conversion.get_main()
    #     assert expect == dm
    #
    # def test_main_user(self):
    #     expect = textwrap.dedent("""\
    #
    #         procedure main_user(self:inout self_t; a: boolean; ret_0:out integer) is
    #
    #         begin
    #             if a then
    #                 ret_0 := 1;
    #                 return;
    #             end if;
    #             ret_0 := 2;
    #             return;
    #         end procedure;""")
    #     dm = self.conversion.get_user_main()
    #     assert expect == dm
    #
    # def test_headers(self):
    #     expect = textwrap.dedent("""\
    #         procedure reset(self_reg: inout register_t);
    #
    #         procedure main(self_reg:inout register_t; a: boolean; ret_0:out integer);
    #
    #
    #         procedure main_user(self:inout self_t; a: boolean; ret_0:out integer);""")
    #     dm = self.conversion.get_headers()
    #     assert expect == dm
    #
    # def test_full(self):
    #     expect = textwrap.dedent("""\
    #         package B0_0 is
    #
    #
    #
    #             type register_t is record
    #                 much_dummy_very_wow: integer;
    #             end record;
    #
    #             type self_t is record
    #
    #                 much_dummy_very_wow: integer;
    #                 \\next\\: register_t;
    #             end record;
    #
    #             procedure reset(self_reg: inout register_t);
    #
    #             procedure main(self_reg:inout register_t; a: boolean; ret_0:out integer);
    #
    #
    #             procedure main_user(self:inout self_t; a: boolean; ret_0:out integer);
    #         end package;
    #
    #         package body B0_0 is
    #             procedure reset(self_reg: inout register_t) is
    #             begin
    #                 self_reg.much_dummy_very_wow := 0;
    #             end procedure;
    #
    #             procedure make_self(self_reg: register_t; self: out self_t) is
    #             begin
    #
    #                 self.much_dummy_very_wow := self_reg.much_dummy_very_wow;
    #                 self.\\next\\ := self_reg;
    #             end procedure;
    #
    #             procedure main(self_reg:inout register_t; a: boolean; ret_0:out integer) is
    #                 variable self: self_t;
    #             begin
    #                 make_self(self_reg, self);
    #                 main_user(self, a, ret_0);
    #                 self_reg := self.\\next\\;
    #             end procedure;
    #
    #             procedure main_user(self:inout self_t; a: boolean; ret_0:out integer) is
    #
    #             begin
    #                 if a then
    #                     ret_0 := 1;
    #                     return;
    #                 end if;
    #                 ret_0 := 2;
    #                 return;
    #             end procedure;
    #         end package body;
    #         """)
    #
    #     conv = str(self.conversion)
    #     assert expect == conv[conv.index('package'):]
    #
