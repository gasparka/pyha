library ieee;
  use ieee.numeric_std.all;

library work;
  use work.FIR.all;
  use work.DCRemoval.all;
  use work.ImbalanceFix.all;

package PreRecv is

  type self_t is record
    i_fir: FIR.self_t;
    q_fir: FIR.self_t;
    dc_rem: DCRemoval.self_t;
    imbal: ImbalanceFix.self_t;
    -- 90% sure that i have to add reset values here aswell.
  end record;

  procedure main (self_p: inout self_t; new_sample: real; ret_0: out real);
end package;


package body PreRecv is

  procedure main(self_p: inout self_t; i,q: real; ret_0, ret_1: out real) is
    variable dec_i: real;
    variable dec_q: real;
    variable dc_rem_i: real;
    variable dc_rem_w: real;
    variable imbal_i: real;
    variable imbal_q: real;
  begin
    self := self_p;

    self.i_fir.filter(self, i, dec_i);
    self.q_fir.filter(self, q, dec_q);

    self.dc_rem.main(self, dec_i, dec_q, dc_rem_i, dc_rem_q);
    self.imbal.main(self, dc_rem_i, dc_rem_q, imbal_i, imbal_q);

    ret_0 := imbal_i;
    ret_1 := imbap_q;
    self_p := self;
  end procedure;

end package body;
