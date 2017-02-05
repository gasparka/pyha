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
