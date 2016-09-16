library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.numeric_std.all;
  use ieee.fixed_float_types.all;
  use ieee.fixed_pkg.all;

package ShiftReg is
  type sfixed_list is array (natural range <>) of sfixed;
  type self_t is record
    shr: sfixed_list(0 to 15)(0 downto - 17);
  end record;

  procedure main (self: inout self_t; new_sample: sfixed; ret_0: out sfixed);
  procedure reset(self: inout self_t);
end package;


package body ShiftReg is

  procedure reset(self: inout self_t) is
  begin
    self.shr := (others => (others => '0'));
  end procedure;

  procedure main (self: inout self_t; new_sample: sfixed; ret_0: out sfixed) is
    variable self_next: self_t;
    variable outp: sfixed(0 downto -17);
  begin
    self_next := self;

    outp := self.shr(self.shr'length-1);
    self_next.shr := new_sample & self.shr(0 to self.shr'high-1);

    ret_0 := outp;
    self := self_next;
  end procedure;

end package body;
