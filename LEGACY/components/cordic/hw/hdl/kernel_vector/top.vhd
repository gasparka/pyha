
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
    x1,x2,x3 :  in std_logic_vector(19 downto 0);
    y1,y2,y3 :  out std_logic_vector(19 downto 0)
  );
end entity;

architecture arch of top is
begin
    process(clk, rst_n)
      variable self: cordickernel.self_t;
      variable return_y1,return_y2,return_y3: sfixed(2 downto -17);
    begin
      if (not rst_n) then
        cordickernel.reset(self);
      elsif rising_edge(clk) then
        cordickernel.call(self, to_sfixed(x1, 2, -17) ,to_sfixed(x2, 2, -17) ,to_sfixed(x3, 2, -17) , return_y1,return_y2,return_y3);
        y1 <= to_slv(return_y1);
        y2 <= to_slv(return_y2);
        y3 <= to_slv(return_y3);

      end if;

    end process;
end architecture;
