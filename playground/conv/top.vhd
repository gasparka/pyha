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
        in0: in std_logic_vector(19 downto 0);

        -- outputs
        out0: out std_logic_vector(19 downto 0)
    );
end entity;

architecture arch of top is
begin
    process(clk, rst_n)
        variable self: DCRemoval_0.register_t;
        -- input variables
        variable var_in0: sfixed(1 downto -18);

        --output variables
        variable var_out0: sfixed(1 downto -18);
    begin
    if (not rst_n) then
        DCRemoval_0.reset(self);
    elsif rising_edge(clk) then
        --convert slv to normal types
        var_in0 := to_sfixed(in0, 1, -18);

        --call the main entry
        DCRemoval_0.main(self, var_in0, ret_0=>var_out0);

        --convert normal types to slv
        out0 <= to_slv(var_out0);
      end if;

    end process;
end architecture;