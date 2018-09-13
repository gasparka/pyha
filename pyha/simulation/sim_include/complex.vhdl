library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.fixed_float_types.all;
  use ieee.fixed_pkg.all;
  use ieee.math_real.all;


package complex_pkg is
  type UNRESOLVED_complex_t is array (INTEGER range <>) of STD_ULOGIC;
  subtype complex_t is UNRESOLVED_complex_t;

  function Complex(a:std_logic_vector; left_index, right_index:integer;
    constant overflow_style : fixed_overflow_style_type := fixed_wrap;
    constant round_style    : fixed_round_style_type    := fixed_truncate) return complex_t;

  function resize(a:complex_t; left_index, right_index:integer;
    constant overflow_style : fixed_overflow_style_type := fixed_wrap;
    constant round_style    : fixed_round_style_type    := fixed_truncate) return complex_t;

  function resize(a:complex_t; size_res: complex_t;
    constant overflow_style : fixed_overflow_style_type := fixed_wrap;
    constant round_style    : fixed_round_style_type    := fixed_truncate) return complex_t;

  function Complex(real, imag:sfixed) return complex_t;
  function Complex(r :real; left_index, right_index:integer) return complex_t;
  function Complex(real, imag:real; left_index, right_index:integer) return complex_t;
  function to_slv (arg : UNRESOLVED_complex_t) return STD_LOGIC_VECTOR;
  function to_sulv (arg : UNRESOLVED_complex_t)return STD_ULOGIC_VECTOR;

  function "*" (l, r : complex_t) return complex_t;
  function "*" (l : complex_t; r: sfixed) return complex_t;
  function "*" (l : complex_t; r: real) return complex_t;
  function "+" (l, r : complex_t) return complex_t;
  function "+" (l : complex_t; r: sfixed) return complex_t;
  function "+" (l : complex_t; r: real) return complex_t;
  function "-" (l, r : complex_t) return complex_t;
  function "-" (l : complex_t; r: sfixed) return complex_t;
  function "-" (l : complex_t; r: real) return complex_t;
  function "sra" (l: complex_t; r: integer) return complex_t;
  function "sla" (l: complex_t; r: integer) return complex_t;
  function scalb (l: complex_t; r: integer) return complex_t;

  function get_real(a: complex_t) return sfixed;
  function get_imag(a: complex_t) return sfixed;

end package;


package body complex_pkg is

  function complex_left(element_left: integer) return integer is
  begin
    if element_left = 0 then
      return 1;
    else
      return 2 * element_left + 1;
    end if;
  end function;

  function complex_right(element_right: integer) return integer is
  begin
    if element_right = 0 then
      return -1;
    else
      return 2 * element_right;
    end if;
  end function;

  function get_real(a: complex_t) return sfixed is
    constant left_index : integer := integer(floor(real(a'left) / 2.0));
    constant right_index : integer := integer(floor(real(a'right) / 2.0));
    variable slv : std_logic_vector (a'length-1 downto 0);
    variable result : sfixed (left_index downto right_index);
  begin
    slv := to_slv(a);
    result := to_sfixed(slv(slv'left downto slv'length/2), left_index, right_index);
    return result;
  end function;

  function get_imag(a: complex_t) return sfixed is
    constant left_index : integer := integer(floor(real(a'left) / 2.0));
    constant right_index : integer := integer(floor(real(a'right) / 2.0));
    variable slv : std_logic_vector (a'length-1 downto 0);
    variable result : sfixed (left_index downto right_index);
  begin
    slv := to_slv(a);
    result := to_sfixed(slv(slv'length/2-1 downto 0), left_index, right_index);
    return result;
  end function;

  function "*" (l, r : complex_t) return complex_t is
    constant l_left_index : integer := integer(floor(real(l'left) / 2.0));
    constant r_left_index : integer := integer(floor(real(r'left) / 2.0));
    variable new_real, new_imag : sfixed (l_left_index + r_left_index+1+1 downto l'low/2 + r'low/2);
    variable result : complex_t (complex_left(new_real'left) downto complex_right(new_real'right));
  begin
    report to_string(l'left/2);
    report to_string(r'low/2);

    report to_string(new_real'left);
    report to_string(new_real'right);
    report to_string(result'left);
    report to_string(result'right);
    new_real := (get_real(l) * get_real(r)) - (get_imag(l) * get_imag(r));
    new_imag := (get_real(l) * get_imag(r)) + (get_imag(l) * get_real(r));
    result := Complex(new_real, new_imag);
    return result;
  end function "*";

  function "*" (l : complex_t; r: sfixed) return complex_t is
    variable new_real, new_imag : sfixed (l'left/2 + r'left+1 downto l'low/2 + r'low);
    variable result : complex_t (complex_left(new_real'left) downto complex_right(new_real'right));
  begin
    new_real := get_real(l) * r;
    new_imag := get_imag(l) * r;
    result := Complex(new_real, new_imag);
    return result;
  end function "*";

  function "*" (l : complex_t; r: real) return complex_t is
    variable new_real, new_imag : sfixed (l'left/2 + l'left/2 + 1 downto l'low/2 + l'low/2);
    variable result : complex_t (complex_left(new_real'left) downto complex_right(new_real'right));
  begin
    new_real := get_real(l) * r;
    new_imag := get_imag(l) * r;
    result := Complex(new_real, new_imag);
    return result;
  end function "*";

  function minimum(a, b: integer) return integer is
  begin
    if a < b then
      return a;
    end if;
    return b;
  end function minimum;

  function maximum(a, b: integer) return integer is
  begin
    if a > b then
      return a;
    end if;
    return b;
  end function maximum;

  function "+" (l, r : complex_t) return complex_t is
    variable new_real, new_imag : sfixed (maximum(l'left/2, r'left/2) + 1 downto minimum(l'low/2, r'low/2));
    variable result : complex_t (complex_left(new_real'left) downto complex_right(new_real'right));
  begin
    new_real := get_real(l) + get_real(r);
    new_imag := get_imag(l) + get_imag(r);
    result := Complex(new_real, new_imag);
    return result;
  end function "+";


  function "+" (l : complex_t; r: sfixed) return complex_t is
    variable new_real, new_imag : sfixed (maximum(l'left/2, r'left) + 1 downto minimum(l'low/2, r'low));
    variable result : complex_t (complex_left(new_real'left) downto complex_right(new_real'right));
  begin
    new_real := get_real(l) + r;
    new_imag := resize(get_imag(l), new_imag);
    result := Complex(new_real, new_imag);
    return result;
  end function "+";

  function "+" (l : complex_t; r: real) return complex_t is
    variable new_real, new_imag : sfixed (l'left/2 + 1 downto l'low/2);
    variable result : complex_t (complex_left(new_real'left) downto complex_right(new_real'right));
  begin
    new_real := get_real(l) + r;
    new_imag := resize(get_imag(l), new_imag);
    result := Complex(new_real, new_imag);
    return result;
  end function "+";

  function "-" (l, r : complex_t) return complex_t is
    variable new_real, new_imag : sfixed (maximum(l'left/2, r'left/2) + 1 downto minimum(l'low/2, r'low/2));
    variable result : complex_t (complex_left(new_real'left) downto complex_right(new_real'right));
  begin
    new_real := get_real(l) - get_real(r);
    new_imag := get_imag(l) - get_imag(r);
    result := Complex(new_real, new_imag);
    return result;
  end function "-";

   function "-" (l : complex_t; r: sfixed) return complex_t is
    variable new_real, new_imag : sfixed (maximum(l'left/2, r'left) + 1 downto minimum(l'low/2, r'low));
    variable result : complex_t (complex_left(new_real'left) downto complex_right(new_real'right));
  begin
    new_real := get_real(l) - r;
    new_imag := resize(get_imag(l), new_imag);
    result := Complex(new_real, new_imag);
    return result;
  end function "-";

  function "-" (l : complex_t; r: real) return complex_t is
    variable new_real, new_imag : sfixed (l'left/2 + 1 downto l'low/2);
    variable result : complex_t (complex_left(new_real'left) downto complex_right(new_real'right));
  begin
    new_real := get_real(l) - r;
    new_imag := resize(get_imag(l), new_imag);
    result := Complex(new_real, new_imag);
    return result;
  end function "-";


  function "sra" (l: complex_t; r: integer) return complex_t is
    variable new_real, new_imag : sfixed (l'left/2 downto l'right/2);
    variable result : complex_t (complex_left(new_real'left) downto complex_right(new_real'right));
  begin
    new_real := get_real(l) sra r;
    new_imag := get_imag(l) sra r;
    result := Complex(new_real, new_imag);
    return result;
  end function "sra";

  function "sla" (l: complex_t; r: integer) return complex_t is
    variable new_real, new_imag : sfixed (l'left/2 downto l'right/2);
    variable result : complex_t (complex_left(new_real'left) downto complex_right(new_real'right));
  begin
    new_real := get_real(l) sla r;
    new_imag := get_imag(l) sla r;
    result := Complex(new_real, new_imag);
    return result;
  end function "sla";

  function scalb (l: complex_t; r: integer) return complex_t is
    variable new_real, new_imag : sfixed (l'left/2+r downto l'right/2+r);
    variable result : complex_t (complex_left(new_real'left) downto complex_right(new_real'right));
  begin
    new_real := scalb(get_real(l), r);
    new_imag := scalb(get_imag(l), r);
    result := Complex(new_real, new_imag);
    return result;
  end function scalb;


  constant NSLV : STD_ULOGIC_VECTOR (0 downto 1) := (others => '0');
  function Complex(a:std_logic_vector; left_index, right_index:integer;
      constant overflow_style : fixed_overflow_style_type := fixed_wrap;
      constant round_style    : fixed_round_style_type    := fixed_truncate) return complex_t is

      variable real, imag: sfixed(left_index downto right_index);
      variable middle: integer;
  begin
    middle := (a'length / 2);
    real := to_sfixed(a(a'left downto middle), left_index, right_index);
    imag := to_sfixed(a(middle-1 downto 0), left_index, right_index);

    return Complex(real, imag);
  end function;

  function resize(a:complex_t; left_index, right_index:integer;
      constant overflow_style : fixed_overflow_style_type := fixed_wrap;
      constant round_style    : fixed_round_style_type    := fixed_truncate) return complex_t is

      variable result : complex_t (complex_left(left_index) downto complex_right(right_index));
      variable real, imag: sfixed(left_index downto right_index);
  begin
    real := resize(get_real(a), left_index, right_index, overflow_style, round_style);
    imag := resize(get_imag(a), left_index, right_index, overflow_style, round_style);
    result := Complex(real, imag);
    return result;
  end function;

  function resize(a:complex_t; size_res: complex_t;
      constant overflow_style : fixed_overflow_style_type := fixed_wrap;
      constant round_style    : fixed_round_style_type    := fixed_truncate) return complex_t is
  begin
    return resize(a, complex_left(size_res'left), complex_right(size_res'right), overflow_style, round_style);
  end function;

  function Complex(real, imag:sfixed) return complex_t is
    variable left : integer := maximum(real'left, imag'left);
    variable right : integer := real'right;
    variable result : complex_t (complex_left(left) downto complex_right(right));
  begin

    result := complex_t(to_slv(resize(real, left, right)) & to_slv(resize(imag, left, right)));
    return result;
  end function;

  function Complex(real, imag:real; left_index, right_index:integer) return complex_t is
    variable result : complex_t (complex_left(left_index) downto complex_right(right_index));
  begin
    result := complex_t(to_slv(to_sfixed(real, left_index, right_index, guard_bits=>0, round_style=>fixed_truncate, overflow_style=>fixed_wrap)) & to_slv(to_sfixed(imag, left_index, right_index, guard_bits=>0, round_style=>fixed_truncate, overflow_style=>fixed_wrap)));
    return result;
  end function;

   function Complex(r:real; left_index, right_index:integer) return complex_t is
    variable result : complex_t (complex_left(left_index) downto complex_right(right_index));
  begin
    result := complex_t(to_slv(to_sfixed(r, left_index, right_index, guard_bits=>0, round_style=>fixed_truncate, overflow_style=>fixed_wrap)) & to_slv(to_sfixed(r, left_index, right_index, guard_bits=>0, round_style=>fixed_truncate, overflow_style=>fixed_wrap)));
    return result;
  end function;

  function to_sulv (
    arg : UNRESOLVED_complex_t)            -- fixed point vector
    return STD_ULOGIC_VECTOR
  is
    subtype result_subtype is STD_ULOGIC_VECTOR (arg'length-1 downto 0);
    variable result : result_subtype;
    --variable result : STD_ULOGIC_VECTOR (arg'length-1 downto 0);
  begin
    if arg'length < 1 then
      return NSLV;
    end if;
    --result := STD_ULOGIC_VECTOR (arg);
    result := result_subtype (arg);
    return result;
  end function to_sulv;

  function to_slv (
    arg : UNRESOLVED_complex_t)            -- fixed point vector
    return STD_LOGIC_VECTOR is
  begin
    return std_logic_vector(to_sulv(arg));
  end function to_slv;

end package body;
