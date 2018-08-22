-- generated by pyha 0.0.7
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.fixed_pkg.all;
    use ieee.math_real.all;

library work;
    use work.complex_pkg.all;
    use work.PyhaUtil.all;
    use work.Typedefs.all;
    use work.all;

entity  top is
    port (
        clk, rst_n: in std_logic;

        -- look #153 if you want enable
        -- enable: in std_logic;

        -- inputs
        in0: in std_logic_vector(17 downto 0);

        -- outputs
        out0: out std_logic_vector(17 downto 0)
    );
end entity;

architecture arch of top is
    -- make reset procedure callable
    function init_regs return MovingAverage_0.self_t is
        variable self: MovingAverage_0.self_t;
    begin
            self.mem := (Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22), Sfix(0.0, -5, -22));
            self.sum := Sfix(0.0, 0, -22);
          return self;
    end function;

    function init_constants return MovingAverage_0.self_t_const is
        variable self: MovingAverage_0.self_t_const;
    begin
            self.WINDOW_LEN := 32;
            self.BIT_GROWTH := 5;
            self.DELAY := 1;
          return self;
    end function;

    signal self: MovingAverage_0.self_t := init_regs;
    constant self_const: MovingAverage_0.self_t_const := init_constants;
begin
    process(clk, rst_n)
        variable self_next: MovingAverage_0.self_t;
        -- input variables
        variable var_in0: sfixed(0 downto -17);

        --output variables
        variable var_out0: sfixed(0 downto -17);

    begin
        self_next := self;

        --convert slv to normal types
        var_in0 := Sfix(in0(17 downto 0), 0, -17);

        --call the main entry
        MovingAverage_0.main(self, self_next, self_const, var_in0, ret_0=>var_out0);

        --convert normal types to slv
        out0(17 downto 0) <= to_slv(var_out0);


        if (rst_n = '0') then
            self <= init_regs;

        elsif rising_edge(clk) then
            -- look #153 if you want enable
            --if enable = '1' then
                self <= self_next;


            --end if;
        end if;

    end process;
end architecture;