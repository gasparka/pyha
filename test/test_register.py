import textwrap

from common.hwsim import HW
from common.sfix import Sfix
from conversion.converter import convert
from redbaron import RedBaron


class Register(HW):
    def __init__(self, init_value=0.):
        self.a = Sfix(init_value, 0, -27)

    def __call__(self, new_value):
        self.next.a = new_value
        return self.a


def test_functionality():
    dut = Register(0.0)
    ret = dut(Sfix(0.5, 0, -27))
    assert ret == Sfix(0.0, 0, -27)

    ret = dut(Sfix(0.5, 0, -27))
    assert ret == Sfix(0.5, 0, -27)


def test_conversion():
    f = open(__file__).read()
    reg_class = RedBaron(f)('class')[0]

    expect = textwrap.dedent("""\
            library ieee;
                use ieee.std_logic_1164.all;
                use ieee.numeric_std.all;
                use ieee.fixed_float_types.all;
                use ieee.fixed_pkg.all;
                use ieee.math_real.all;

            library work;
                use work.all;

            package \\Register\\ is
                type register_t is record
                end record;
                type self_t is record
                    \\next\\: register_t;
                end record;

                procedure reset(reg: inout register_t);
                procedure \\__call__\\(reg:inout register_t; new_value: unknown_type);
            end package;

            package body \\Register\\ is
                procedure reset(reg: inout register_t) is
                begin
                end procedure;

                procedure make_self(reg: register_t; self: out self_t) is
                begin
                    self.\\next\\ := reg;
                end procedure;

                procedure \\__call__\\(reg:inout register_t; new_value: unknown_type) is
                    variable self: self_t;
                begin
                    make_self(reg, self);
                    self.\\next\\.a := new_value;
                    reg := self.\\next\\;
                end procedure;
            end package body;""")

    conv = convert(reg_class)
    vhdl = str(conv)
    with open('converted.vhdl', 'w') as f:
        print(vhdl, file=f)
    assert vhdl == expect
