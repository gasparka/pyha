library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.numeric_std.all;
  use ieee.fixed_float_types.all;
  use ieee.fixed_pkg.all;

package PyhaUtil is
  function left_bound(x: sfixed)->integer;
  function right_bound(x: sfixed)->integer;
end package;


package body PyhaUtil is
  function left_bound(x: sfixed)->integer
  begin
    return x'left;
  end function;

  function right_bound(x: sfixed)->integer
  begin
    return x'right;
  end function;

end package body;
