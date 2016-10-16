
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.fixed_pkg.all;
    use ieee.math_real.all;

library work;
use work.all;

entity  top is
  port (
    clk, rst_n : in std_logic;
    x1 :  in std_logic_vector(27 downto 0);
    y1 :  out std_logic_vector(27 downto 0)
  );
end entity;

architecture arch of top is
begin
    process(clk, rst_n)
      variable self: tc.register_t;
      variable return_y1: sfixed(0 downto -27);
    begin
      if rising_edge(clk) then
        if (not rst_n) then
          tc.reset(self);
        else
          tc.\__call__\(self, to_sfixed(x1, 0, -27));
          y1 <= to_slv(self.a);
        end if;

      end if;

    end process;
end architecture;
