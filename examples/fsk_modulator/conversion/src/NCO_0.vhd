-- generated by pyha 0.0.0 at 2017-03-01 01:09:35
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.fixed_float_types.all;
    use ieee.fixed_pkg.all;
    use ieee.math_real.all;

library work;
    use work.ComplexTypes.all;
    use work.PyhaUtil.all;
    use work.all;

-- Signal generator. Input phase must be normalized to -1 to 1 range!
-- :param cordic_iterations: performace/resource usage trade off
package NCO_0 is



    type next_t is record
        cordic: Cordic_0.self_t;
        phase_acc: sfixed(0 downto -17);
    end record;

    type self_t is record
        -- constants
        \_delay\: integer;

        cordic: Cordic_0.self_t;
        phase_acc: sfixed(0 downto -17);
        \next\: next_t;
    end record;

    procedure \_pyha_constants_self\(self: inout self_t);

    procedure \_pyha_reset_self\(self: inout self_t);

    procedure \_pyha_update_self\(self: inout self_t);

    -- 18 bits precision.
    -- :param phase_inc: amount of rotation applied for next clock cycle, must be normalized to -1 to 1.
    -- :return: baseband signal
    -- :rtype: ComplexSfix
    procedure main(self:inout self_t; phase_inc: sfixed(0 downto -17); ret_0:out complex_sfix0_17);
end package;

package body NCO_0 is
    procedure \_pyha_constants_self\(self: inout self_t) is
    begin
        self.\_delay\ := 18;
        Cordic_0.\_pyha_constants_self\(self.cordic);
    end procedure;

    procedure \_pyha_reset_self\(self: inout self_t) is
    begin
        Cordic_0.\_pyha_reset_self\(self.cordic);
        self.\next\.phase_acc := Sfix(0.0, 0, -17);
        \_pyha_update_self\(self);
    end procedure;

    procedure \_pyha_update_self\(self: inout self_t) is
    begin
        Cordic_0.\_pyha_update_self\(self.cordic);
        self.phase_acc := self.\next\.phase_acc;
        \_pyha_constants_self\(self);
    end procedure;

    -- 18 bits precision.
    -- :param phase_inc: amount of rotation applied for next clock cycle, must be normalized to -1 to 1.
    -- :return: baseband signal
    -- :rtype: ComplexSfix
    procedure main(self:inout self_t; phase_inc: sfixed(0 downto -17); ret_0:out complex_sfix0_17) is
        variable start_x: sfixed(1 downto -17);
        variable start_y: sfixed(1 downto -17);
        variable xr: sfixed(0 downto -17);
        variable yr: sfixed(0 downto -17);
        variable retc: complex_sfix0_17;
        variable x: sfixed(1 downto -17);
        variable y: sfixed(1 downto -17);
        variable phase: sfixed(0 downto -17);
    begin
        self.\next\.phase_acc := resize(self.phase_acc + phase_inc, size_res=>phase_inc, overflow_style=>fixed_wrap, round_style=>fixed_truncate);

        start_x := Sfix(1.0 / 1.646760, 1, -17);
        -- gets rid of cordic gain, could add amplitude modulation here
        start_y := Sfix(0.0, 1, -17);
        -- 1 bit for gains, remove later

        Cordic_0.main(self.cordic, start_x, start_y, self.phase_acc, ret_0=>x, ret_1=>y, ret_2=>phase);
        xr := resize(x, 0, -17);
        yr := resize(y, 0, -17);
        retc := ComplexSfix(xr, yr);
        ret_0 := retc;
        return;
    end procedure;
end package body;