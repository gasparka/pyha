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
            procedure reset(self_reg: inout register_t);

            procedure main(self_reg:inout register_t; a: integer; ret_0:out integer);

            -- func
            -- doc
            procedure main_user(self:inout self_t; a: integer; ret_0:out integer);""")
        dm = self.conversion.get_headers()
        assert expect == dm

    def test_main(self):
        expect = textwrap.dedent("""\
            -- func
            -- doc
            procedure main_user(self:inout self_t; a: integer; ret_0:out integer) is

            begin
                -- normal doc
                ret_0 := a;
                return;

            end procedure;""")

        dm = self.conversion.get_user_main()
        assert expect == dm

    def test_class_multiline_comment(self):
        expect = textwrap.dedent("""\
            -- class
            -- doc""")

        dm = self.conversion.multiline_comment
        assert expect == dm

    def test_class_full(self):
        expect = textwrap.dedent("""\
            library ieee;
                use ieee.std_logic_1164.all;
                use ieee.numeric_std.all;
                use ieee.fixed_float_types.all;
                use ieee.fixed_pkg.all;
                use ieee.math_real.all;

            library work;
                use work.ComplexTypes.all;
                use work.PyhaUtil.all;
                use work.all;

            -- class
            -- doc
            package B0_0 is



                type register_t is record
                    much_dummy_very_wow: integer;
                end record;

                type self_t is record

                    much_dummy_very_wow: integer;
                    \\next\\: register_t;
                end record;

                procedure reset(self_reg: inout register_t);

                procedure main(self_reg:inout register_t; a: integer; ret_0:out integer);

                -- func
                -- doc
                procedure main_user(self:inout self_t; a: integer; ret_0:out integer);

                -- very useless function
                procedure func2(self:inout self_t);
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

                procedure main(self_reg:inout register_t; a: integer; ret_0:out integer) is
                    variable self: self_t;
                begin
                    make_self(self_reg, self);
                    main_user(self, a, ret_0);
                    self_reg := self.\\next\\;
                end procedure;


                -- func
                -- doc
                procedure main_user(self:inout self_t; a: integer; ret_0:out integer) is

                begin
                    -- normal doc
                    ret_0 := a;
                    return;

                end procedure;

                -- very useless function
                procedure func2(self:inout self_t) is

                begin


                end procedure;
            end package body;
            """)

        conv = str(self.conversion)
        assert expect == conv

