library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.numeric_std.all;
  use ieee.fixed_float_types.all;
  use ieee.fixed_pkg.all;

package Average is
  type sfixed_list is array (natural range <>) of sfixed;
  type self_t is record
    -- window_pow: real;
    -- window: real;
    in_sr: sfixed_list(0 to 15)(0 downto - 17);
    sum: sfixed(4 downto -17);

  end record;

  procedure main (self: inout self_t; new_sample: sfixed; ret_0: out sfixed);
  procedure reset(self: inout self_t);
end package;


package body Average is

  procedure reset(self: inout self_t) is
  begin
    self := (in_sr =>  (others => (others => '0')), sum => (others => '0'));

  end procedure;

  procedure main (self: inout self_t; new_sample: sfixed; ret_0: out sfixed) is
    variable self_next: self_t;
    variable old: sfixed(0 downto -17);
    variable outp: sfixed(0 downto -21);
  begin
    self_next := self;

    old := self.in_sr(self.in_sr'length-1);

    -- x & x_r(0 to x_r'high(1) - 1);
    self_next.in_sr := new_sample & self.in_sr(0 to self.in_sr'high-1);

    self_next.sum := resize(self.sum + new_sample - old, 4, -17);
    outp := self.sum;

    ret_0 := resize(outp, 0, -17);
    -- ret_0 := old;
    -- ret_0 := resize(self.sum, 0, -17);
    self := self_next;
  end procedure;

end package body;
