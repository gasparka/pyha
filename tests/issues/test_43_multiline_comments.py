import textwrap

from pyha.common.hwsim import HW
from pyha.conversion.conversion import get_conversion


class TestBasic:
    def setup(self):
        class B0(HW):
            """ class
            doc """

            def main(self, a):
                """ func
                doc
                """
                # normal doc
                return a

        self.dut = B0()
        self.dut.main(True)
        self.dut.main(False)
        self.conversion = get_conversion(self.dut)

    def test_vhdl_main_header(self):
        pass

    def test_vhdl_main(self):
        expect = textwrap.dedent("""\
            -- func
            -- doc
            procedure main_user(self:inout self_t; a: boolean; ret_0:out boolean) is

            begin
                -- normal doc
                ret_0 := a;
                return;

            end procedure;""")

        dm = self.conversion.get_user_main()
        assert expect == dm
