-- generated by pyha 0.0.0 at 2017-03-01 00:53:22
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

-- Takes in complex signal and gives out bits. It uses Quadrature demodulator followed by
-- matched filter (moving average). M&M clock recovery is the last DSP block, it performs timing recovery.
-- .. note:: M&M clock recovery is currently not implemented
package FSKDemodulator_0 is



    type next_t is record
        demod: QuadratureDemodulator_0.self_t;
        match: MovingAverage_0.self_t;
    end record;

    type self_t is record
        -- constants
        \_delay\: integer;

        demod: QuadratureDemodulator_0.self_t;
        match: MovingAverage_0.self_t;
        \next\: next_t;
    end record;

    procedure \_pyha_constants_self\(self: inout self_t);

    procedure \_pyha_reset_self\(self: inout self_t);

    procedure \_pyha_update_self\(self: inout self_t);

    -- :type  input: ComplexSfix
    -- :rtype: Sfix
    procedure main(self:inout self_t; input: complex_sfix0_17; ret_0:out sfixed(0 downto -17));
end package;

package body FSKDemodulator_0 is
    procedure \_pyha_constants_self\(self: inout self_t) is
    begin
        self.\_delay\ := 20;
        QuadratureDemodulator_0.\_pyha_constants_self\(self.demod);
        MovingAverage_0.\_pyha_constants_self\(self.match);
    end procedure;

    procedure \_pyha_reset_self\(self: inout self_t) is
    begin
        QuadratureDemodulator_0.\_pyha_reset_self\(self.demod);
        MovingAverage_0.\_pyha_reset_self\(self.match);
        \_pyha_update_self\(self);
    end procedure;

    procedure \_pyha_update_self\(self: inout self_t) is
    begin
        QuadratureDemodulator_0.\_pyha_update_self\(self.demod);
        MovingAverage_0.\_pyha_update_self\(self.match);
        \_pyha_constants_self\(self);
    end procedure;



    -- :type  input: ComplexSfix
    -- :rtype: Sfix
    procedure main(self:inout self_t; input: complex_sfix0_17; ret_0:out sfixed(0 downto -17)) is
        variable demod: sfixed(0 downto -17);
        variable match: sfixed(0 downto -17);
    begin
        QuadratureDemodulator_0.main(self.demod, input, ret_0=>demod);
        MovingAverage_0.main(self.match, demod, ret_0=>match);

        ret_0 := match;
        return;
    end procedure;
end package body;