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
        in0: in std_logic_vector(35 downto 0);
        in1: in std_logic_vector(35 downto 0);

        -- outputs
        out0: out std_logic_vector(35 downto 0)
    );
end entity;

architecture arch of top is
begin
    process(clk, rst_n)
        variable self: ComplexMultiply_1.register_t;
        -- input variables
        variable var_in0: complex_sfix0_17;
        variable var_in1: complex_sfix0_17;

        --output variables
        variable var_out0: complex_sfix0_17;
    begin
    if (not rst_n) then
        ComplexMultiply_1.reset(self);
    elsif rising_edge(clk) then
        --convert slv to normal types
        var_in0 := (real=>to_sfixed(in0(35 downto 18), 0, -17), imag=>to_sfixed(in0(17 downto 0), 0, -17));
        var_in1 := (real=>to_sfixed(in1(35 downto 18), 0, -17), imag=>to_sfixed(in1(17 downto 0), 0, -17));

        --call the main entry
        ComplexMultiply_1.main(self, var_in0, var_in1, ret_0=>var_out0);

        --convert normal types to slv
        out0 <= to_slv(var_out0.real) & to_slv(var_out0.imag);
      end if;

    end process;
end architecture;