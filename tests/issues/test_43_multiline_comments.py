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

            def func2(self):
                """ very useless function """
                pass

        self.dut = B0()
        self.dut.main(0)
        self.dut.main(1)
        self.dut.func2()
        self.dut.func2()
        self.conversion = get_conversion(self.dut)

    def test_headers(self):
        expect = textwrap.dedent("""\
            procedure \_pyha_init\(self: inout self_t);

            procedure \_pyha_reset_constants\(self: inout self_t);

            procedure \_pyha_reset\(self: inout self_t);

            procedure \_pyha_update_registers\(self: inout self_t);

            -- func
            -- doc
            procedure main(self:inout self_t; a: integer; ret_0:out integer);

            -- very useless function
            procedure func2(self:inout self_t);""")
        dm = self.conversion.build_prototypes()
        assert expect == dm

    def test_main(self):
        expect = textwrap.dedent("""\
            -- func
            -- doc
            procedure main(self:inout self_t; a: integer; ret_0:out integer) is

            begin
                -- normal doc
                ret_0 := a;
                return;
            end procedure;""")

        dm = self.conversion.build_function_by_name('main')
        assert expect == dm

    def test_class_multiline_comment(self):
        expect = textwrap.dedent("""\
            -- class
            -- doc""")

        dm = self.conversion.multiline_comment
        assert expect == dm

    def test_class_header(self):
        expect = textwrap.dedent("""\
            -- class
            -- doc
            package B0_0 is


                type next_t is record
                    much_dummy_very_wow: integer;
                end record;

                type self_t is record
                    much_dummy_very_wow: integer;
                    \\next\\: next_t;
                end record;

                procedure \_pyha_init\(self: inout self_t);

                procedure \_pyha_reset_constants\(self: inout self_t);

                procedure \_pyha_reset\(self: inout self_t);

                procedure \_pyha_update_registers\(self: inout self_t);

                -- func
                -- doc
                procedure main(self:inout self_t; a: integer; ret_0:out integer);

                -- very useless function
                procedure func2(self:inout self_t);
            end package;""")

        conv = self.conversion.build_package_header()
        assert expect == conv
