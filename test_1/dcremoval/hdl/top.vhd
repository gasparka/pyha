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
    x1, x2 :  in std_logic_vector(17 downto 0);
    y1, y2 :  out std_logic_vector(17 downto 0)
  );
end entity;


architecture arch of top is
begin
    process(clk, rst_n)
      variable mv: dcremoval.self_t;
      variable out_1, out_2: sfixed(0 downto -17);
    begin
      if (not rst_n) then
        dcremoval.reset(mv);
      elsif rising_edge(clk) then
        dcremoval.main(mv, to_sfixed(x1, 0, -17), to_sfixed(x2, 0, -17), out_1, out_2);
        y1 <= to_slv(out_1);
        y2 <= to_slv(out_2);
      end if;

    end process;
end architecture;
