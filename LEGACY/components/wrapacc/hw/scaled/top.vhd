
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
    x1 :  in std_logic_vector(31 downto 0);
    y1 :  out std_logic_vector(26 downto 0);
    y2 : out boolean
  );
end entity;

architecture arch of top is
begin
    process(clk, rst_n)
      variable self: WrapAcc.self_t;
      variable return_y1: sfixed(1 downto -25);
      variable return_y2: boolean;
    begin
      if (not rst_n) then
        WrapAcc.reset(self);
      elsif rising_edge(clk) then
        WrapAcc.call(self, to_sfixed(x1, 0, -31) , return_y1,return_y2);
        y1 <= to_slv(return_y1);
        y2 <= return_y2;

      end if;

    end process;
end architecture;
