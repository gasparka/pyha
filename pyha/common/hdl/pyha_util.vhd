library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.numeric_std.all;
  use ieee.fixed_float_types.all;
  use ieee.fixed_pkg.all;

package PyhaUtil is
  function left_index(x: sfixed) return integer;
  function right_index(x: sfixed) return integer;
  function \>>\(x: sfixed; n: integer) return sfixed;
  -- function resize(x: sfixed; left:integer; right:integer) return sfixed;
  -- function resize(x: sfixed; \type\: sfixed) return sfixed;
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

  function \>>\(x: sfixed; n: integer) return sfixed is
    variable outp: sfixed(x'left-n downto x'right-n);
  begin
    outp := x;
    return outp;
  end function;
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
