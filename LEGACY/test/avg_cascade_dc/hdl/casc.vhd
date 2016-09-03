library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.numeric_std.all;
  use ieee.fixed_float_types.all;
  use ieee.fixed_pkg.all;

library work;
  use work.all;

package Casc is
  type sfixed_list is array (natural range <>) of sfixed;
  type average_list is array (natural range <>) of average.self_t;

  type self_t is record
    av: average_list(0 to 2-1);
    in_sr: sfixed_list(0 to 14)(0 downto - 17);
  end record;

  procedure main (self: inout self_t; new_sample: sfixed; ret_0: out sfixed);
  procedure reset(self: inout self_t);
end package;


package body Casc is

  procedure reset(self: inout self_t) is
  begin
    self.in_sr := (others => (others => '0'));

    for i in self.av'range loop
      average.reset(self.av(i));
    end loop;

  end procedure;

  procedure main (self: inout self_t; new_sample: sfixed; ret_0: out sfixed) is
    variable self_next: self_t;
    variable old: sfixed(0 downto -17);
    variable outp: sfixed(0 downto -17);
    variable r,r2: sfixed(0 downto -17);
  begin
    self_next := self;

    old := self.in_sr(self.in_sr'length-1);

    -- x & x_r(0 to x_r'high(1) - 1);
    self_next.in_sr := new_sample & self.in_sr(0 to self.in_sr'high-1);

    r := new_sample;
    for i in self.av'range loop
      average.main(self_next.av(i), r, r2);
      r := r2;
    end loop;

    outp := resize(old - r, 0, -17);
    -- outp := old;

    ret_0 := outp;
    self := self_next;
  end procedure;

end package body;
