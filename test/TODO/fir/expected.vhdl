library ieee;
  use ieee.numeric_std.all;

package FIR is

  type self_t is record
    order: real;
    taps: real_list(16);
    mul: real_list(16);
    sm: real_list(16);

    -- 90% sure that i have to add reset values here aswell.
  end record;

  procedure filter (self_p: inout self_t; x: real; ret_0: out real);
end package;


package body FIR is

  procedure filter (self_p: inout self_t; x: real; ret_0: out real) is
    variable self: self_t;
  begin
    self := self_p;

    for i in self.taps'reverse_range loop
      self.mul(i) := x * self.taps(i);
      if i = 0 then
        self.sm(i) := self.firMult(i)
      else
        self.sm(i) :=  self.sm(i - 1) + self.mul(i)
      end if;
    end loop;

    ret_0 := self.sm(self.sm'length-1)
    self_p := self;
  end procedure;

end package body;
