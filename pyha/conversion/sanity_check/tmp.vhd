library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.fixed_float_types.all;
    use ieee.fixed_pkg.all;
    use ieee.math_real.all;

library work;
    use work.all;

package Tc is
    type register_t is record
        a: sfixed(0 downto -27);
    end record;
    type self_t is record
        a: sfixed(0 downto -27);
        \next\: register_t;
    end record;

    procedure reset(reg: inout register_t);
    procedure \__call__\(reg:inout register_t; b: sfixed);
end package;

package body Tc is
    procedure reset(reg: inout register_t) is
    begin
        reg.a := to_sfixed(1.0, 0, -27);
    end procedure;

    procedure make_self(reg: register_t; self: out self_t) is
    begin
        self.a := reg.a;
        self.\next\ := reg;
    end procedure;

    procedure \__call__\(reg:inout register_t; b: sfixed) is
        variable self: self_t;
    begin
        make_self(reg, self);
        self.\next\.a := b;
        reg := self.\next\;
    end procedure;
end package body;
