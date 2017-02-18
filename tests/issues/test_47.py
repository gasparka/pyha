import textwrap

from pyha.common.hwsim import HW
from pyha.conversion.conversion import get_conversion
from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL, SIM_RTL, SIM_GATE


class TestBasic:
    def setup(self):
        class B0(HW):
            def main(self, a):
                if a:
                    return 1
                return 2

        self.dut = B0()
        self.dut.main(True)
        self.dut.main(False)
        self.conversion = get_conversion(self.dut)

    def test_vhdl_main(self):
        expect = textwrap.dedent("""\
            procedure main(self_reg:inout register_t; a: boolean; ret_0:out integer) is
                variable self: self_t;
            begin
                make_self(self_reg, self);
                main_user(self, a, ret_0);
                self_reg := self.\\next\\;
            end procedure;""")

        dm = self.conversion.get_main()
        assert expect == dm

    def test_main_user(self):
        expect = textwrap.dedent("""\

            procedure main_user(self:inout self_t; a: boolean; ret_0:out integer) is

            begin
                if a then
                    ret_0 := 1;
                    return;
                end if;
                ret_0 := 2;
                return;
            end procedure;""")
        dm = self.conversion.get_user_main()
        assert expect == dm

    def test_headers(self):
        expect = textwrap.dedent("""\
            procedure reset(self_reg: inout register_t);

            procedure main(self_reg:inout register_t; a: boolean; ret_0:out integer);


            procedure main_user(self:inout self_t; a: boolean; ret_0:out integer);""")
        dm = self.conversion.get_headers()
        assert expect == dm

    def test_full(self):
        expect = textwrap.dedent("""\
            package B0_0 is



                type next_t is record
                    much_dummy_very_wow: integer;
                end record;

                type self_t is record

                    much_dummy_very_wow: integer;
                    \\next\\: register_t;
                end record;

                procedure reset(self_reg: inout register_t);

                procedure main(self_reg:inout register_t; a: boolean; ret_0:out integer);


                procedure main_user(self:inout self_t; a: boolean; ret_0:out integer);
            end package;

            package body B0_0 is
                procedure reset(self_reg: inout register_t) is
                begin
                    self_reg.much_dummy_very_wow := 0;
                end procedure;

                procedure make_self(self_reg: register_t; self: out self_t) is
                begin

                    self.much_dummy_very_wow := self_reg.much_dummy_very_wow;
                    self.\\next\\ := self_reg;
                end procedure;

                procedure main(self_reg:inout register_t; a: boolean; ret_0:out integer) is
                    variable self: self_t;
                begin
                    make_self(self_reg, self);
                    main_user(self, a, ret_0);
                    self_reg := self.\\next\\;
                end procedure;

                procedure main_user(self:inout self_t; a: boolean; ret_0:out integer) is

                begin
                    if a then
                        ret_0 := 1;
                        return;
                    end if;
                    ret_0 := 2;
                    return;
                end procedure;
            end package body;
            """)

        conv = str(self.conversion)
        assert expect == conv[conv.index('package'):]

    def test_simulate(self):
        inputs = [True, True, False, False, True]
        expect = [1, 1, 2, 2, 1]

        assert_sim_match(self.dut, [bool], expect, inputs,
                         simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])
