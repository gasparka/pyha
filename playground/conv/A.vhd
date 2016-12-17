library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.fixed_float_types.all;
    use ieee.fixed_pkg.all;
    use ieee.math_real.all;

library work;
    use work.PyhaUtil.all;
    use work.all;

package A is


    type register_t is record
        reg: integer;
    end record;
    type self_t is record
        reg: integer;
        \next\: register_t;
    end record;

    procedure reset(self_reg: inout register_t);
    procedure main(self_reg:inout register_t; a: integer; ret_0:out integer);
end package;

package body A is
    procedure reset(self_reg: inout register_t) is
    begin
        self_reg.reg := 0;
    end procedure;

    procedure make_self(self_reg: register_t; self: out self_t) is
    begin
        self.reg := self_reg.reg;
        self.\next\ := self_reg;
    end procedure;

    procedure main(self_reg:inout register_t; a: integer; ret_0:out integer) is
        variable self: self_t;
    begin
        make_self(self_reg, self);
        self.\next\.reg := a;
        ret_0 := self.reg;
        self_reg := self.\next\;
    end procedure;
end package body;