library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.numeric_std.all;
  use ieee.fixed_float_types.all;
  use ieee.fixed_pkg.all;
  use ieee.math_real.all;


package PyhaUtil is
  function left_index(x: sfixed) return integer;
  function right_index(x: sfixed) return integer;
  function \>>\(x: sfixed; n: integer) return sfixed;
  function Sfix(a:real; left_index, right_index:integer) return sfixed;
  function Sfix(a:real; size_res:sfixed) return sfixed;

  function Sfix(a:std_logic_vector; left_index, right_index:integer) return sfixed;

  function logic_to_bool(x: std_logic) return boolean;
  function bool_to_logic(x: boolean) return std_logic;

  -- function resize(x: sfixed; left:integer; right:integer) return sfixed;
  -- function resize(x: sfixed; \type\: sfixed) return sfixed;
  -- type range_t is array (natural range <>) of integer;
  -- type range_t is range;
    -- function \range\(a: integer) return range_t;
  -- function \range\(a: integer) return range_t;

end package;


package body PyhaUtil is
  function left_index(x: sfixed) return integer is
  begin
    return x'left;
  end function;

  function right_index(x: sfixed) return integer is
  begin
    return x'right;
  end function;

  -- shift that wont lose precision
  function \>>\(x: sfixed; n: integer) return sfixed is
    variable outp: sfixed(x'left-n downto x'right-n);
  begin
    outp := x;
    return outp;
  end function;

  function Sfix(a:real; left_index, right_index:integer) return sfixed is
  begin
    return to_sfixed(a, left_index, right_index, guard_bits=>16);
  end function;

  function Sfix(a:real; size_res:sfixed) return sfixed is
  begin
    return to_sfixed(a, size_res, guard_bits=>16);
  end function;

  function Sfix(a:std_logic_vector; left_index, right_index:integer) return sfixed is
  begin
    return to_sfixed(a, left_index, right_index);
  end function;

  function logic_to_bool(x: std_logic) return boolean is
  begin
    if x = '1' then
      return True;
    else
      return False;
    end if;
  end function;

  function bool_to_logic(x: boolean) return std_logic is
  begin
    if x = True then
      return '1';
    else
      return '0';
    end if;
  end function;


  -- function \range\(a: integer) return range_t is
  --   subtype range_l is Natural range 0 downto 16;
  -- begin
  --   return range_l;
  -- end function;

  -- function \range\(a: integer) return range_t is
  -- begin
  --   return range 0 to 1;
  -- end function;
  -- function resize(x: sfixed; left:integer; right:integer) return sfixed is
  -- begin
  --   return resize(x, left_index=>left, right_index=>right);
  -- end function;
  --
  -- function resize(x: sfixed; \type\: sfixed) return sfixed is
  -- begin
  --   return resize(x, size_res);
  -- end function;
end package body;



package np is
  constant  pi :  real := 3.141592653589793;
end package;
