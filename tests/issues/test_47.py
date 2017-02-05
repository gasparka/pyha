import textwrap

from pyha.common.hwsim import HW
from pyha.conversion.conversion import get_conversion


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

        # def test_full(self):
        #     expect = textwrap.dedent("""\
        #        package B0_0 is
        #
        #
        #
        #            type register_t is record
        #                much_dummy_very_wow: integer;
        #            end record;
        #            type self_t is record
        #                much_dummy_very_wow: integer;
        #                \\next\\: register_t;
        #            end record;
        #
        #            procedure reset(self_reg: inout register_t);
        #            procedure main(self_reg:inout register_t; new_value: sfixed(0 downto -27); ret_0:out sfixed(0 downto -27));
        #            procedure get_delay(self:inout self_t; ret_0:out integer);
        #        end package;
        #
        #        package body B0_0 is
        #            procedure reset(self_reg: inout register_t) is
        #            begin
        #                self_reg.a := Sfix(0.0, 0, -27);
        #            end procedure;
        #
        #            procedure make_self(self_reg: register_t; self: out self_t) is
        #            begin
        #                self.a := self_reg.a;
        #                self.\\next\\ := self_reg;
        #            end procedure;
        #
        #            procedure main(self_reg:inout register_t; new_value: sfixed(0 downto -27); ret_0:out sfixed(0 downto -27)) is
        #                variable self: self_t;
        #            begin
        #                make_self(self_reg, self);
        #                self.\\next\\.a := new_value;
        #                ret_0 := self.a;
        #                self_reg := self.\\next\\;
        #            end procedure;
        #
        #            procedure get_delay(self:inout self_t; ret_0:out integer) is
        #            begin
        #                ret_0 := 1;
        #            end procedure;
        #            end package body;""")
        #
        #     conv = str(self.conversion)
        #     assert expect == conv[conv.index('package'):]
