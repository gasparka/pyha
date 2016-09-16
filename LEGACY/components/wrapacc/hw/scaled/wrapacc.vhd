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
    counter: sfixed(0 downto - 31);
    is_wrap: boolean;
    is_wrap_delay: boolean;
    count_scaled: sfixed(1 downto -25);
    scale: sfixed(1 downto -25);
  end record;

  procedure call (self: inout self_t; step: sfixed; ret_0: out sfixed; ret_1: out boolean);
  procedure reset(self: inout self_t);
end package;


package body WrapAcc is

  procedure reset(self: inout self_t) is
  begin
    self.counter := to_sfixed(-1.0, self.counter);
    self.is_wrap := False;
    self.count_scaled := to_sfixed(-MATH_PI / 2.0, self.count_scaled);
    self.scale := to_sfixed(MATH_PI / 2.0, self.scale);
  end procedure;

procedure call (self: inout self_t; step: sfixed; ret_0: out sfixed; ret_1: out boolean) is
    variable self_next: self_t;
    variable val: sfixed(1 downto -31);
    variable counter_small: sfixed(0 downto -scalebits+1);
  begin
    self_next := self;

    val := self.counter + step;

    -- not correct
    self_next.is_wrap := val > to_sfixed(1.0, self.counter) or val < to_sfixed(-1.0, self.counter);

    self_next.counter := resize(val, self.counter, overflow_style => FIXED_WRAP);

    self_next.is_wrap_delay := self.is_wrap;

    counter_small := resize(self.counter, 0, -scalebits+1 , overflow_style => FIXED_WRAP, round_style => FIXED_TRUNCATE);
    -- if self.scale is not None:
    self_next.count_scaled := resize(counter_small * self.scale, self.scale, round_style => FIXED_TRUNCATE);
    -- report "SCALE: " & to_string(to_real(self.scale));
    -- report "COUNT_SMALL: " & to_string(to_real(counter_small));
    -- else:
        -- self.next.scaled = counter_small

    ret_0 := self.count_scaled;
    -- ret_0 := counter_small;
    ret_1 := self.is_wrap_delay;

    self := self_next;
  end procedure;

end package body;
