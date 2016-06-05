library ieee;
  use ieee.numeric_std.all;

library work;
  use work.Average.all;

package DCRemoval is

  type self_t is record
    window_pow: real;
    i_avg: Average.self_t;
    q_avg: Average.self_t;
    clean_i: real;
    clean_q: real;
    -- 90% sure that i have to add reset values here aswell.
  end record;

  procedure main (self_p: inout self_t; i, q: real; ret_0, ret_1: out real);
end package;


package body DCRemoval is

  procedure main (self_p: inout self_t; i, q: real; ret_0, ret_1: out real) is
    variable self: self_t;
  begin
    self := self_p;

    Average.main(self.i_avg, i, self.clean_i);
    Average.main(self.q_avg, q, self.clean_q);

    ret_0 := self.clean_i;
    ret_1 := self.clean_q;

    self_p := self;
  end procedure;

end package body;
