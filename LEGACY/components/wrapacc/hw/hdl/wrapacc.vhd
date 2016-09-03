library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.numeric_std.all;
  use ieee.fixed_float_types.all;
  use ieee.fixed_pkg.all;
  use IEEE.math_real.all;

library work;
  use work.all;

package WrapAcc is

  type self_t is record
    counter: sfixed(0 downto - 31);
    is_wrap: boolean;
  end record;

  procedure call (self: inout self_t; step: sfixed; ret_0: out sfixed; ret_1: out boolean);
  procedure reset(self: inout self_t);
end package;


package body WrapAcc is

  procedure reset(self: inout self_t) is
  begin
    self.counter := to_sfixed(-1.0, self.counter);
    self.is_wrap := False;
  end procedure;

procedure call (self: inout self_t; step: sfixed; ret_0: out sfixed; ret_1: out boolean) is
    variable self_next: self_t;
    variable val: sfixed(1 downto -31);
  begin
    self_next := self;

    val := self.counter + step;


    self_next.is_wrap := val > to_sfixed(1.0, self.counter) or val < to_sfixed(-1.0, self.counter);

    self_next.counter := resize(val, self.counter, overflow_style => FIXED_WRAP);

    ret_0 := self.counter;
    ret_1 := self.is_wrap;

    self := self_next;
  end procedure;

end package body;
