library ieee;
  use ieee.numeric_std.all;

package Average is

  type self_t is record
    phase_h: real;
    mag_g: real;
    mu_pow: real;
    -- 90% sure that i have to add reset values here aswell.
  end record;

  procedure main (self_p: inout self_t; new_sample: real; ret_0: out real);
end package;


package body Average is

  -- Remove magnitude imbalance
  procedure mag_fix(self_p: inout self_t; i,q: real; ret_0, ret_1: out real) is
    variable y: real;
    variable e: real;
    variable step: real;
  begin
    self := self_p;

    y := i * self.mag_h;
    e := abs(q) - abs(y);

    -- SHOUDL BE SHIFT
    step := e * self.mu_pow;
    self.mag_h = self.mag_h + step;

    ret_0 := y;
    ret_1 := q;
    self_p := self;
  end procedure;


  -- Remove phase imbalance
  procedure phase_fix(self_p: inout self_t; i,q: real; ret_0, ret_1: out real) is
    variable clean_q: real;
    variable orth: real;
    variable step: real;
  begin
    self := self_p;

    clean_q := q - (i * self.phase_h);
    orth := clean_q * i;

    -- SHOUDL BE SHIFT
    step := orth * self.mu_pow;
    self.phase_h = self.phase_h + step;

    ret_0 := i;
    ret_1 := clean_q;
    self_p := self;
  end procedure;

  procedure main(self_p: inout self_t; i,q: real; ret_0, ret_1: out real) is
    variable self: self_t;
    variable ir: real;
    variable qr: real;
  begin
    self := self_p;

    mag_fix(self, i, q, ir, qr);
    phase_fix(self, ir, qr, ir, qr); -- inputs and outputs are the same, is this sane?

    ret_0 := ir;
    ret_1 := qr;
    self_p := self;
  end procedure;

end package body;
