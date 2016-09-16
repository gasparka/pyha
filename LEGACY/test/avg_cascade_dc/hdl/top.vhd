
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
    x :  in std_logic_vector(17 downto 0);
    y :  out std_logic_vector(17 downto 0)
  );
end entity;

architecture arch of top is
begin
    process(clk, rst_n)
      variable self: casc.self_t;
      variable return_y: sfixed(0 downto -17);
    begin
      if (not rst_n) then
        casc.reset(self);
      elsif rising_edge(clk) then
        casc.main(self, to_sfixed(x, 0, -17) , return_y);
        y <= to_slv(return_y);

      end if;

    end process;
end architecture;
