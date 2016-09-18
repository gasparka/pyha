library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.fixed_float_types.all;
    use ieee.fixed_pkg.all;
    use ieee.math_real.all;

library work;
    use work.all;

package \Register\ is
    type register_t is record
        a: sfixed(0 downto -12);
    end record;
    type self_t is record
        a: sfixed(0 downto -12);
        \next\: register_t;
    end record;

    procedure reset(self_reg: inout register_t);
    procedure \__call__\(self_reg:inout register_t; new_value: sfixed(0 downto -12); ret_0:out sfixed(0 downto -12));
end package;

package body \Register\ is
    procedure reset(self_reg: inout register_t) is
    begin
        self_reg.a := to_sfixed(0.52, 0, -12);
    end procedure;

    procedure make_self(self_reg: register_t; self: out self_t) is
    begin
        self.a := self_reg.a;
        self.\next\ := self_reg;
    end procedure;

    procedure \__call__\(self_reg:inout register_t; new_value: sfixed(0 downto -12); ret_0:out sfixed(0 downto -12)) is
        variable self: self_t;
    begin
        make_self(self_reg, self);
        self.\next\.a := new_value;
        ret_0 := self.a;
        self_reg := self.\next\;
    end procedure;
end package body;
