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


-- architecture arch of top_vhdl is
--   signal mv: movingAvg.reg_t := movingAvg.REG_RESET;
-- begin
--     process(clk, rst_n)
--     begin
--       if (not rst_n) then
--         mv <= movingAvg.REG_RESET;
--       elsif rising_edge(clk) then
--         mv <= movingAvg.main(mv, to_sfixed(x, mv.avg));
--       end if;
--     end process;
--     y <= to_slv(movingAvg.getAvg(mv));
-- end architecture;

-- architecture arch of top_vhdl is
--   signal mv: average.self_t;
--   sig
-- begin
--     process(clk, rst_n)
--       variable av_out: sfixed(0 downto -17);
--     begin
--       if (not rst_n) then
--         average.reset(mv);
--       elsif rising_edge(clk) then
--         average.main(mv, to_sfixed(x, 0, -17), av_out);
--       end if;
--
--     end process;
--     y <= to_slv(av_out);
-- end architecture;


architecture arch of top is
  -- signal mv: average.self_t;
begin
    process(clk, rst_n)
      variable mv: average.self_t;
      variable av_out: sfixed(0 downto -17);
    begin
      if (not rst_n) then
        average.reset(mv);
      elsif rising_edge(clk) then
        average.main(mv, to_sfixed(x, 0, -17), av_out);
        y <= to_slv(av_out);
      end if;

    end process;
end architecture;
