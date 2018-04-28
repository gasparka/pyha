library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.fixed_float_types.all;
  use ieee.fixed_pkg.all;
  use ieee.math_real.all;


  package float_noround_pkg is
    type UNRESOLVED_float_t is array (INTEGER range <>) of STD_ULOGIC;
    subtype float_t is UNRESOLVED_float_t;

    function Float(a:std_logic_vector; exponent_bits, fractional_bits:integer) return float_t;
    function to_slv (arg : float_t) return STD_LOGIC_VECTOR;
    function to_sulv (arg : float_t)return STD_ULOGIC_VECTOR;

  end package;

  package body float_noround_pkg is

    function Float(a:std_logic_vector; exponent_bits, fractional_bits:integer) return float_t is
        variable result: float_t(exponent_bits-1 downto -fractional_bits);
    begin
      result := UNRESOLVED_float_t(a);
      return result;
    end function;


   constant NSLV : STD_ULOGIC_VECTOR (0 downto 1) := (others => '0');
    function to_sulv (arg : float_t) return STD_ULOGIC_VECTOR is
      subtype result_subtype is STD_ULOGIC_VECTOR (arg'length-1 downto 0);
      variable result : result_subtype;
    begin
      if arg'length < 1 then
        return NSLV;
      end if;
      result := result_subtype (arg);
      return result;
    end function to_sulv;

    function to_slv (arg : float_t) return STD_LOGIC_VECTOR is
    begin
      return std_logic_vector(to_sulv(arg));
    end function to_slv;


  end package body;
