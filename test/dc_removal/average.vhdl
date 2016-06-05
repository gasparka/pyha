library ieee;
  use ieee.numeric_std.all;

package Average is

  type self_t is record
    window_pow: real;
    window: real;
    in_sr: real_list(32);
    sum: real;
    old: real;
    -- 90% sure that i have to add reset values here aswell.
  end record;

  procedure main (self_p: inout self_t; new_sample: real; ret_0: out real);
end package;


package body Average is

  procedure main (self_p: inout self_t; new_sample: real; ret_0: out real) is
    variable self: self_t;
  begin
    self := self_p;

    self.old := self.in_sr(self.in_sr'length-1);

    -- x & x_r(0 to x_r'high(1) - 1);
    self.in_sr := new_sample & self.in_sr(0 to self.in_sr'high-1);

    self.sum := self.sum + new_sample - self.old;

    ret_0 := self.sum / self.window;
    self_p := self;
  end procedure;

end package body;
