import textwrap

import pytest

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.conversion.top_generator import TopGenerator, NotTrainedError, NoInputsError, NoOutputsError


@pytest.fixture
def basic_obj():
    class Register(HW):
        def main(self, a, b, c):
            return a * 5, True, Sfix(0.0, 5, -8)

    dut = Register()
    dut.main(2, Sfix(1.0, 2, -17), False)
    dut.main(-57, Sfix(1.0, 2, -17), True)
    dut.main(-57, Sfix(1.0, 2, -17), c=True)
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
                out1 <= bool_to_logic(var_out1);
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
                var_in0 := to_integer(signed(in0));
                var_in1 := Sfix(in1, 2, -17);
                var_in2 := logic_to_bool(in2);
                """)

    res = TopGenerator(dut)

    assert expect == res.make_input_type_conversions()


def test_dut_name(basic_obj):
    dut = basic_obj
    expect = 'Register_0'

    res = TopGenerator(dut)

    assert expect == res.object_class_name()


def test_call_arguments(basic_obj):
    dut = basic_obj
    expect = 'var_in0, var_in1, c=>var_in2, ret_0=>var_out0, ret_1=>var_out1, ret_2=>var_out2'

    res = TopGenerator(dut)

    assert expect == res.make_call_arguments()


##################################
# SIMPLE OBJECT
##################################

@pytest.fixture
def simple_obj():
    class Simple(HW):
        def main(self, a):
            return a

    dut = Simple()
    dut.main(2)
    dut.main(2)
    return dut


def test_simple_call_arguments(simple_obj):
    dut = simple_obj
    expect = 'var_in0, ret_0=>var_out0'

    res = TopGenerator(dut)

    assert expect == res.make_call_arguments()


def test_simple_full(simple_obj):
    dut = simple_obj
    expect = textwrap.dedent("""\
                    library ieee;
                        use ieee.std_logic_1164.all;
                        use ieee.numeric_std.all;
                        use ieee.fixed_pkg.all;
                        use ieee.math_real.all;

                    library work;
                        use work.PyhaUtil.all;
                        use work.all;

                    entity  top is
                        port (
                            clk, rst_n, enable: in std_logic;

                            -- inputs
                            in0: in std_logic_vector(31 downto 0);

                            -- outputs
                            out0: out std_logic_vector(31 downto 0)
                        );
                    end entity;

                    architecture arch of top is
                        -- make reset procedure callable
                        function init_regs return Simple_0.self_t is
                            variable self: Simple_0.self_t;
                        begin
                              Simple_0.\_pyha_reset\(self);
                              return self;
                        end function;

                        signal self: Simple_0.self_t := init_regs;
                    begin
                        process(clk, rst_n)
                            variable self_var: Simple_0.self_t;
                            -- input variables
                            variable var_in0: integer;

                            --output variables
                            variable var_out0: integer;

                        begin
                            self_var := self;

                            --convert slv to normal types
                            var_in0 := to_integer(signed(in0));

                            --call the main entry
                            Simple_0.\_pyha_init\(self_var);
                            Simple_0.\_pyha_reset_constants\(self_var);
                            Simple_0.main(self_var, var_in0, ret_0=>var_out0);

                            --convert normal types to slv
                            out0 <= std_logic_vector(to_signed(var_out0, 32));


                            if (not rst_n) then
                                Simple_0.\_pyha_reset\(self_var);
                                self <= self_var;
                            elsif rising_edge(clk) then
                                if enable then
                                    Simple_0.\_pyha_update_registers\(self_var);
                                    Simple_0.\_pyha_reset_constants\(self_var);
                                    self <= self_var;
                                end if;
                            end if;

                        end process;
                    end architecture;""")

    res = TopGenerator(dut).make()
    # text_file = open("Output.txt", "w")
    # text_file.write(res)
    # text_file.close()

    assert expect == res[res.index('library'):]


##################################
# MISC
##################################

def test_no_inputs():
    class Simple(HW):
        def main(self):
            return 1

    dut = Simple()
    dut.main()
    dut.main()

    with pytest.raises(NoInputsError):
        TopGenerator(dut)


def test_no_outputs():
    class Simple(HW):
        def main(self, a):
            pass

    dut = Simple()
    dut.main(1)
    dut.main(2)

    with pytest.raises(NoOutputsError):
        TopGenerator(dut)


def test_no_sim():
    class Simple(HW):
        def main(self, a):
            return a

    dut = Simple()

    with pytest.raises(NotTrainedError):
        TopGenerator(dut)


def test_decorator():
    class A(HW):
        def main(self, a, b, c):
            return a * 5, True, Sfix(0.0)

    dut = A()
    dut.main(2, Sfix(1.0), False)
    assert type(dut.main.last_args[0]) == int
    assert type(dut.main.last_args[1]) == Sfix
    assert type(dut.main.last_args[2]) == bool

    assert type(dut.main.last_return[0]) == int
    assert type(dut.main.last_return[1]) == bool
    assert type(dut.main.last_return[2]) == Sfix


def test_decorator_kwargs():
    class A(HW):
        def main(self, a, b, c):
            return a * 5, True, Sfix(0.0)

    dut = A()
    dut.main(b=2, c=Sfix(1.0), a=False)
    assert type(dut.main.last_kwargs['b']) == int
    assert type(dut.main.last_kwargs['c']) == Sfix
    assert type(dut.main.last_kwargs['a']) == bool

    assert type(dut.main.last_return[0]) == int
    assert type(dut.main.last_return[1]) == bool
    assert type(dut.main.last_return[2]) == Sfix
