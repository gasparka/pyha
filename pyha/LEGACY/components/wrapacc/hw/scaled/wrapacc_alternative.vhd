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
  constant scalebits: integer := 27;
  type self_t is record
    counter: sfixed(1 downto - 25);
    is_wrap: boolean;
  end record;

  procedure call (self: inout self_t; step: sfixed; ret_0: out sfixed; ret_1: out boolean);
  procedure reset(self: inout self_t);
end package;


package body WrapAcc is

  procedure reset(self: inout self_t) is
  begin
    self.counter := to_sfixed(-MATH_PI / 2.0, self.counter);
    self.is_wrap := False;
  end procedure;

procedure call (self: inout self_t; step: sfixed; ret_0: out sfixed; ret_1: out boolean) is
    variable self_next: self_t;
    variable val: sfixed(2 downto -25);
    variable corrected_val: sfixed(3 downto -25);
  begin
    self_next := self;

    val := self.counter + resize(step,0, -25, overflow_style => FIXED_WRAP);

    -- not correct
    -- self_next.is_wrap := val > to_sfixed(1.0, self.counter) or val < to_sfixed(-1.0, self.counter);

    -- self_next.counter := resize(val, self.counter, overflow_style => FIXED_WRAP);

    -- self_next.is_wrap_delay := self.is_wrap;
    if val > MATH_PI / 2.0 then
      corrected_val := val - MATH_PI / 2.0;
      self_next.counter := resize(corrected_val, self.counter, overflow_style => FIXED_WRAP);
    else
      self_next.counter := resize(val, self.counter, overflow_style => FIXED_WRAP);
    end if;

    ret_0 := self.counter;
    -- ret_0 := counter_small;
    ret_1 := self.is_wrap;

    self := self_next;
  end procedure;

end package body;
