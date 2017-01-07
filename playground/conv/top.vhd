library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.fixed_pkg.all;
    use ieee.math_real.all;

library work;
    use work.ComplexTypes.all;
    use work.all;

entity  top is
    port (
        clk, rst_n: in std_logic;

        -- inputs
        in0: in std_logic_vector(27 downto 0);
        in1: in std_logic_vector(45 downto 0);
        in2: in std_logic_vector(27 downto 0);

        -- outputs
        out0: out std_logic_vector(27 downto 0);
        out1: out std_logic_vector(45 downto 0);
        out2: out std_logic_vector(27 downto 0)
    );
end entity;

architecture arch of top is
begin
    process(clk, rst_n)
        variable self: A3_0.register_t;
        -- input variables
        variable var_in0: complex_sfix1_12;
        variable var_in1: complex_sfix1_21;
        variable var_in2: complex_sfix1_12;

        --output variables
        variable var_out0: complex_sfix1_12;
        variable var_out1: complex_sfix1_21;
        variable var_out2: complex_sfix1_12;
    begin
    if (not rst_n) then
        A3_0.reset(self);
    elsif rising_edge(clk) then
        --convert slv to normal types
        var_in0 := (real=>to_sfixed(in0(27 downto 14), 1, -12), imag=>to_sfixed(in0(13 downto 0), 1, -12));
        var_in1 := (real=>to_sfixed(in1(45 downto 23), 1, -21), imag=>to_sfixed(in1(22 downto 0), 1, -21));
        var_in2 := (real=>to_sfixed(in2(27 downto 14), 1, -12), imag=>to_sfixed(in2(13 downto 0), 1, -12));

        --call the main entry
        A3_0.main(self, var_in0, var_in1, var_in2, ret_0=>var_out0, ret_1=>var_out1, ret_2=>var_out2);

        --convert normal types to slv
        out0 <= to_slv(var_out0.real) & to_slv(var_out0.imag);
        out1 <= to_slv(var_out1.real) & to_slv(var_out1.imag);
        out2 <= to_slv(var_out2.real) & to_slv(var_out2.imag);
      end if;

    end process;
end architecture;