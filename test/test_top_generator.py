import textwrap
from pathlib import Path

import pytest
from common.sfix import Sfix
from conversion.top_generator import inout_saver, TopGenerator


@pytest.fixture
def basic_obj():
    # this is reserved name in VHDL
    class Register:
        @inout_saver
        def __call__(self, a, b, c):
            return a * 5, True, Sfix(0.0, 5, -8)

    dut = Register()
    dut(2, Sfix(1.0, 2, -17), False)
    dut(-57, Sfix(1.0, 2, -17), True)
    dut(-57, Sfix(1.0, 2, -17), c=True)
    return dut


def test_entity_inputs(basic_obj):
    dut = basic_obj
    expect = textwrap.dedent("""\
                in0: in std_logic_vector(31 downto 0);
                in1: in std_logic_vector(19 downto 0);
                in2: in std_logic;""")

    res = TopGenerator(dut)

    assert expect == res.make_entity_inputs()


def test_entity_outputs(basic_obj):
    dut = basic_obj
    expect = textwrap.dedent("""\
                out0: out std_logic_vector(31 downto 0);
                out1: out std_logic;
                out2: out std_logic_vector(13 downto 0);""")

    res = TopGenerator(dut)

    assert expect == res.make_entity_outputs()


def test_variables_output(basic_obj):
    dut = basic_obj
    expect = textwrap.dedent("""\
                variable var_out0: integer;
                variable var_out1: boolean;
                variable var_out2: sfixed(5 downto -8);""")

    res = TopGenerator(dut)

    assert expect == res.make_output_variables()


def test_output_type_conversion(basic_obj):
    dut = basic_obj
    expect = textwrap.dedent("""\
                out0 <= std_logic_vector(to_signed(var_out0, 32));
                out1 <= std_logic(var_out1);
                out2 <= to_slv(var_out2);""")

    res = TopGenerator(dut)

    assert expect == res.make_output_type_conversions()


def test_variables_input(basic_obj):
    dut = basic_obj
    expect = textwrap.dedent("""\
                variable var_in0: integer;
                variable var_in1: sfixed(2 downto -17);
                variable var_in2: boolean;""")

    res = TopGenerator(dut)

    assert expect == res.make_input_variables()


def test_input_type_conversion(basic_obj):
    dut = basic_obj
    expect = textwrap.dedent("""\
                var_in0 := to_integer(to_signed(in0));
                var_in1 := to_sfixed(in1, 2, -17);
                var_in2 := in2;""")

    res = TopGenerator(dut)

    assert expect == res.make_input_type_conversions()


def test_dut_name(basic_obj):
    dut = basic_obj
    expect = '\\Register\\'

    res = TopGenerator(dut)

    assert expect == res.object_class_name()


def test_imports(basic_obj):
    dut = basic_obj
    expect = textwrap.dedent("""\
        library ieee;
            use ieee.std_logic_1164.all;
            use ieee.numeric_std.all;
            use ieee.fixed_pkg.all;
            use ieee.math_real.all;

        library work;
            use work.all;""")

    res = TopGenerator(dut)

    assert expect == res.make_imports()


def test_call_arguments(basic_obj):
    dut = basic_obj
    expect = 'var_in0, var_in1, c=>var_in2, ret_0=>var_out0, ret_1=>var_out1, ret_2=>var_out2'

    res = TopGenerator(dut)

    assert expect == res.make_call_arguments()


def test_full(basic_obj, tmpdir):
    dut = basic_obj
    expect = textwrap.dedent("""\
                    library ieee;
                        use ieee.std_logic_1164.all;
                        use ieee.numeric_std.all;
                        use ieee.fixed_pkg.all;
                        use ieee.math_real.all;

                    library work;
                        use work.all;

                    entity  top is
                        port (
                            clk, rst_n: in std_logic;

                            -- inputs
                            in0: in std_logic_vector(31 downto 0);
                            in1: in std_logic_vector(19 downto 0);
                            in2: in std_logic;

                            -- outputs
                            out0: out std_logic_vector(31 downto 0);
                            out1: out std_logic;
                            out2: out std_logic_vector(13 downto 0)
                        );
                    end entity;

                    architecture arch of top is
                    begin
                        process(clk, rst_n)
                            variable self: \\Register\\.register_t;
                            -- input variables
                            variable var_in0: integer;
                            variable var_in1: sfixed(2 downto -17);
                            variable var_in2: boolean;

                            --output variables
                            variable var_out0: integer;
                            variable var_out1: boolean;
                            variable var_out2: sfixed(5 downto -8);
                        begin
                        if (not rst_n) then
                            \\Register\\.reset(self);
                        elsif rising_edge(clk) then
                            --convert slv to normal types
                            var_in0 := to_integer(to_signed(in0));
                            var_in1 := to_sfixed(in1, 2, -17);
                            var_in2 := in2;

                            --call the main entry
                            \\Register\\.\\__call__\\(self, var_in0, var_in1, c=>var_in2, ret_0=>var_out0, ret_1=>var_out1, ret_2=>var_out2);

                            --convert normal types to slv
                            out0 <= std_logic_vector(to_signed(var_out0, 32));
                            out1 <= std_logic(var_out1);
                            out2 <= to_slv(var_out2);
                          end if;

                        end process;
                    end architecture;""")

    path = Path(str(tmpdir))
    res = TopGenerator(dut, path=path).make()
    assert expect == res
    with (path / 'top.vhd').open('r') as f:
        assert expect == f.read()


def test_decorator():
    class A:
        @inout_saver
        def __call__(self, a, b, c):
            return a * 5, True, Sfix(0.0)

    dut = A()
    dut(2, Sfix(1.0), False)
    assert type(dut.__call__._last_call['args'][1]) == int
    assert type(dut.__call__._last_call['args'][2]) == Sfix
    assert type(dut.__call__._last_call['args'][3]) == bool

    assert type(dut.__call__._last_call['return'][0]) == int
    assert type(dut.__call__._last_call['return'][1]) == bool
    assert type(dut.__call__._last_call['return'][2]) == Sfix


def test_decorator_kwargs():
    class A:
        @inout_saver
        def __call__(self, a, b, c):
            return a * 5, True, Sfix(0.0)

    dut = A()
    dut(b=2, c=Sfix(1.0), a=False)
    assert type(dut.__call__._last_call['kwargs']['b']) == int
    assert type(dut.__call__._last_call['kwargs']['c']) == Sfix
    assert type(dut.__call__._last_call['kwargs']['a']) == bool

    assert type(dut.__call__._last_call['return'][0]) == int
    assert type(dut.__call__._last_call['return'][1]) == bool
    assert type(dut.__call__._last_call['return'][2]) == Sfix
