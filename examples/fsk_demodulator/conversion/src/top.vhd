-- generated by pyha 0.0.0 at 2017-03-01 00:53:26
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.fixed_pkg.all;
    use ieee.math_real.all;

library work;
    use work.PyhaUtil.all;
    use work.ComplexTypes.all;
    use work.all;

entity  top is
    port (
        clk, rst_n, enable: in std_logic;

        -- inputs
        in0: in std_logic_vector(35 downto 0);

        -- outputs
        out0: out std_logic_vector(17 downto 0)
    );
end entity;

architecture arch of top is
begin
    process(clk, rst_n)
        variable self: FSKDemodulator_0.self_t;
        -- input variables
        variable var_in0: complex_sfix0_17;

        --output variables
        variable var_out0: sfixed(0 downto -17);
    begin
    if (not rst_n) then
        FSKDemodulator_0.\_pyha_reset_self\(self);
    elsif rising_edge(clk) then
        if enable then
            --convert slv to normal types
            var_in0 := (real=>Sfix(in0(35 downto 18), 0, -17), imag=>Sfix(in0(17 downto 0), 0, -17));

            --call the main entry
            -- without this Quartus wont honor constants
            FSKDemodulator_0.\_pyha_constants_self\(self);
            FSKDemodulator_0.main(self, var_in0, ret_0=>var_out0);
            FSKDemodulator_0.\_pyha_update_self\(self);

            --convert normal types to slv
            out0 <= to_slv(var_out0);
        end if;
      end if;

    end process;
end architecture;