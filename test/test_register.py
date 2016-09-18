import textwrap

from common.hwsim import HW
from common.sfix import Sfix
from conversion.converter import convert
from conversion.extract_datamodel import DataModel
from redbaron import RedBaron


class Register(HW):
    def __init__(self, init_value=0.):
        self.a = Sfix(init_value)

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
    dut = Register(0.52)
    ret = dut(Sfix(0.5, 0, -12))

    datamodel = DataModel(dut)
    f = open(__file__).read()
    reg_class = RedBaron(f)('class')[0]

    expect = textwrap.dedent("""\
            package \\Register\\ is
                type register_t is record
                    a: sfixed(0 downto -12);
                end record;
                type self_t is record
                    a: sfixed(0 downto -12);
                    \\next\\: register_t;
                end record;

                procedure reset(self_reg: inout register_t);
                procedure \\__call__\\(self_reg:inout register_t; new_value: sfixed(0 downto -12); ret_0:out sfixed(0 downto -12));
            end package;

            package body \\Register\\ is
                procedure reset(self_reg: inout register_t) is
                begin
                    self_reg.a := to_sfixed(0.52, 0, -12);
                end procedure;

                procedure make_self(self_reg: register_t; self: out self_t) is
                begin
                    self.a := self_reg.a;
                    self.\\next\\ := self_reg;
                end procedure;

                procedure \\__call__\\(self_reg:inout register_t; new_value: sfixed(0 downto -12); ret_0:out sfixed(0 downto -12)) is
                    variable self: self_t;
                begin
                    make_self(self_reg, self);
                    self.\\next\\.a := new_value;
                    ret_0 := self.a;
                    self_reg := self.\\next\\;
                end procedure;
            end package body;""")

    conv = convert(reg_class, caller=None, datamodel=datamodel)
    conv = str(conv)
    with open('converted.vhdl', 'w') as f:
        print(conv, file=f)

    assert expect == conv[conv.index('package'):]
