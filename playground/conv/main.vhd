library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.fixed_float_types.all;
    use ieee.fixed_pkg.all;
    use ieee.math_real.all;

library work;
    use work.PyhaUtil.all;
    use work.all;

package B is


    type register_t is record
        sub: A.register_t;
    end record;
    type self_t is record
        sub: A.register_t;
        \next\: register_t;
    end record;

    procedure reset(self_reg: inout register_t);
    procedure main(self_reg:inout register_t; a: integer; ret_0:out integer);
end package;

package body B is
    procedure reset(self_reg: inout register_t) is
    begin
        A.reset(self_reg.sub);
    end procedure;

    procedure make_self(self_reg: register_t; self: out self_t) is
    begin
        self.sub := self_reg.sub;
        self.\next\ := self_reg;
    end procedure;

    procedure main(self_reg:inout register_t; a: integer; ret_0:out integer) is
        variable ret: integer;
        variable self: self_t;
    begin
        make_self(self_reg, self);
        A.main(self.sub, a, ret_0=>ret);
        ret_0 := ret;
        self_reg := self.\next\;
    end procedure;
end package body;