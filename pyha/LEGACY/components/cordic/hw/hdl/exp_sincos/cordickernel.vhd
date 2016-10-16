library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.numeric_std.all;
  use ieee.fixed_float_types.all;
  use ieee.fixed_pkg.all;

library work;
  use work.all;

package CORDICKernel is
  type sfixed_list is array (natural range <>) of sfixed;
  constant iterations: integer := 18 + 1;
  constant mode: string := "VECTOR";

  type self_t is record
    phase_lut: sfixed_list(0 to iterations-1)(0 downto -17);
    x: sfixed_list(0 to iterations-1)(0 downto - 17);
    y: sfixed_list(0 to iterations-1)(0 downto - 17);
    phase: sfixed_list(0 to iterations-1)(1 downto - 17);
  end record;

  procedure rotate (self: inout self_t;
    i : integer;
    x, y, phase: sfixed;
    ret_0, ret_1, ret_2: out sfixed);
  procedure call (self: inout self_t; x, y, phase: sfixed; ret_0, ret_1, ret_2: out sfixed);
  procedure reset(self: inout self_t);
end package;


package body CORDICKernel is

  procedure reset(self: inout self_t) is
    type real_vector is array (natural range <>) of real;
    constant phase_lut_init : real_vector := (0.7853981633670628,0.4636476091109216,0.24497866304591298,
    0.12435499439015985,0.062418810091912746,0.03123983321711421,0.01562372874468565,0.007812341209501028,
    0.0039062299765646458,0.0019531226716935635,0.0009765620343387127,0.00048828125,0.000244140625,
    0.0001220703125,6.103515625e-05,3.0517578125e-05,1.52587890625e-05,7.62939453125e-06,3.814697265625e-06);
  begin
    -- self.mode := "ROTATE";
    self.x := (others => (others => '0'));
    self.y := (others => (others => '0'));
    self.phase := (others => (others => '0'));

    for i in self.phase_lut'range loop
      self.phase_lut(i) := to_sfixed(phase_lut_init(i), self.phase_lut(0));
    end loop;

  end procedure;


  procedure rotate (self: inout self_t;
    i : integer;
    x, y, phase: sfixed;
    ret_0, ret_1, ret_2: out sfixed) is
    variable direction: boolean;
    variable next_x: sfixed(1 downto -17);
    variable next_y: sfixed(1 downto -17);
    variable next_phase: sfixed(2 downto -31);

  begin
    if mode = "ROTATE" then
      direction := not phase < 0;
    elsif mode = "VECTOR" then
      direction := y < 0;
    else
      assert not FALSE report "Unknown mode" severity failure;
    end if;

    if direction then
      next_x := x - SHIFT_RIGHT(y, i);
      next_y := y + SHIFT_RIGHT(x, i);
      next_phase := phase - self.phase_lut(i);
    else
      next_x := x + SHIFT_RIGHT(y, i);
      next_y := y - SHIFT_RIGHT(x, i);
      next_phase := phase + self.phase_lut(i);
    end if;

    ret_0 := resize(next_x, x);
    ret_1 := resize(next_y, y);
    ret_2 := resize(next_phase, phase);

  end procedure;


  procedure call (self: inout self_t; x, y, phase: sfixed; ret_0, ret_1, ret_2: out sfixed) is
    variable self_next: self_t;
  begin
    self_next := self;

    self_next.phase_lut := self.phase_lut;
    -- next.x[0], next.y[0], next.phase[0] = x, y, phase
    -- NOT correct to unroll this statement, python solution avoids temp varibles
    self_next.x(0) := x;
    self_next.y(0) := y;
    self_next.phase(0) := phase;

    -- for i in range(len(self.phase_lut) - 1):
    -- not sure this is correct
    for i in 0 to self.phase_lut'length - 1 -1 loop
      rotate(self_next, i, self.x(i), self.y(i), self.phase(i),
        self_next.x(i + 1), self_next.y(i + 1), self_next.phase(i + 1));
    end loop;

    ret_0 := self.x(self.x'length-1);
    ret_1 := self.y(self.y'length-1);
    ret_2 := self.phase(self.phase'length-1);

    self := self_next;
  end procedure;

end package body;
