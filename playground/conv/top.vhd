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
        in1: in std_logic_vector(17 downto 0);

        -- outputs
        out0: out std_logic_vector(17 downto 0);
        out1: out std_logic_vector(17 downto 0);
        out2: out std_logic_vector(17 downto 0)
    );
end entity;

architecture arch of top is
begin
    process(clk, rst_n)
        variable self: CordicCore_0.register_t;
        -- input variables
        variable var_in0: complex_sfix2_15;
        variable var_in1: sfixed(2 downto -15);

        --output variables
        variable var_out0: sfixed(2 downto -15);
        variable var_out1: sfixed(2 downto -15);
        variable var_out2: sfixed(2 downto -15);
    begin
    if (not rst_n) then
        CordicCore_0.reset(self);
    elsif rising_edge(clk) then
        --convert slv to normal types
        var_in0 := (real=>to_sfixed(in0(35 downto 18), 2, -15), imag=>to_sfixed(in0(17 downto 0), 2, -15));
        var_in1 := to_sfixed(in1, 2, -15);

        --call the main entry
        CordicCore_0.main(self, var_in0, var_in1, ret_0=>var_out0, ret_1=>var_out1, ret_2=>var_out2);

        --convert normal types to slv
        out0 <= to_slv(var_out0);
        out1 <= to_slv(var_out1);
        out2 <= to_slv(var_out2);
      end if;

    end process;
end architecture;