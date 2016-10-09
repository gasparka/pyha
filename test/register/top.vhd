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
        in0: in std_logic_vector(27 downto 0);

        -- outputs
        out0: out std_logic_vector(27 downto 0)
    );
end entity;

architecture arch of top is
begin
    process(clk, rst_n)
        variable self: \Register\.register_t;
        -- input variables
        variable var_in0: sfixed(0 downto -27);

        --output variables
        variable var_out0: sfixed(0 downto -27);
    begin
    if (not rst_n) then
        \Register\.reset(self);
    elsif rising_edge(clk) then
        --convert slv to normal types
        var_in0 := to_sfixed(in0, 0, -27);

        --call the main entry
        \Register\.\__call__\(self, var_in0, ret_0=>var_out0);

        --convert normal types to slv
        out0 <= to_slv(var_out0);
      end if;

    end process;
end architecture;