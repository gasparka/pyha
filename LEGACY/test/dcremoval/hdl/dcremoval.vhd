library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.numeric_std.all;
  use ieee.fixed_float_types.all;
  use ieee.fixed_pkg.all;

library work;
  use work.all;

package DCRemoval is

  type self_t is record
    iav: casc.self_t;
    qav: casc.self_t;
  end record;

  procedure main (self: inout self_t; new_i, new_q: sfixed; ret_0, ret_1: out sfixed);
  procedure reset(self: inout self_t);
end package;


package body DCRemoval is

  procedure reset(self: inout self_t) is
  begin
    casc.reset(self.iav);
    casc.reset(self.qav);
  end procedure;

  procedure main (self: inout self_t; new_i, new_q: sfixed; ret_0, ret_1: out sfixed) is
    variable self_next: self_t;
    variable out_i: sfixed(0 downto -17);
    variable out_q: sfixed(0 downto -17);
  begin
    self_next := self;

    casc.main(self_next.iav, new_i, out_i);
    casc.main(self_next.qav, new_q, out_q);

    ret_0 := out_i;
    ret_1 := out_q;
    self := self_next;
  end procedure;

end package body;
