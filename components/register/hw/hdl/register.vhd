library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.numeric_std.all;
  use ieee.fixed_float_types.all;
  use ieee.fixed_pkg.all;
  use IEEE.math_real.all;

library work;
  use work.all;

package Register is

  type self_t is record
    a: sfixed(0 downto -27);
  end record;

  procedure call (self: inout self_t; step: sfixed; ret_0: out sfixed; ret_1: out boolean);
  procedure reset(self: inout self_t);
end package;

package body Register is

  procedure reset(self: inout self_t) is
  begin
    self.a := to_sfixed(0.0, self.a);
  end procedure;

procedure call (self: inout self_t;
                in_next: sfixed;
                ret_0: out sfixed) is
    variable self_next: self_t;
  begin
    self_next := self;

    self_next.a := in_next;

    ret_0 := self.a;
    self := self_next;
  end procedure;

end package body;