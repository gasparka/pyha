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

    function "+" (l, r : float_t) return float_t;

  end package;

  package body float_noround_pkg is

    function Float(a:std_logic_vector; exponent_bits, fractional_bits:integer) return float_t is
        variable result: float_t(exponent_bits-1 downto -fractional_bits);
    begin
      result := UNRESOLVED_float_t(a);
      return result;
    end function;

    function get_exponent(a: float_t) return signed is
    begin
      return signed(a(a'left downto 0));
    end function;

    function get_fractional(a: float_t) return signed is
      variable slv : std_logic_vector (a'length-1 downto 0) := to_slv(a);
    begin
      return signed(slv(-a'right-1 downto 0));
    end function;

    function find_leftmost (ARG : signed)
      return INTEGER is
    begin
      -- report to_string(arg'left) & to_string(arg'right);
      for INDEX in arg(arg'left -1 downto arg'right)'range loop
        if ARG(INDEX) = not arg(arg'high) then
          return INDEX - 7;
        end if;
      end loop;
      return -1;
    end function find_leftmost;

    function "+" (l, r : float_t) return float_t is
      variable result : float_t (l'left downto l'right);
      variable exponent_l, exponent_r, new_exponent, larger_exponent, smaller_exponent : signed (l'left downto 0);
      variable smaller, larger: float_t(l'range);
      variable exp_diff: unsigned (l'left downto 0); -- bug..need 1 more bit
      variable smaller_fractional, larger_fractional: signed (-l'right-1 downto 0);
      variable new_fractional: signed (-l'right downto 0);
      variable final_fractional: signed (-l'right-1 downto 0);
      variable leftmost: integer;
      variable fractional_sign : std_logic;
    begin
      exponent_l := get_exponent(l);
      exponent_r := get_exponent(r);
      -- report "Expoent left: " & to_string(exponent_l);
      -- report "Expoent right: " & to_string(exponent_r);

      if exponent_l >= exponent_r then
        -- report "Left has bigger/equal exponent";
        smaller := r;
        larger := l;
      else
        -- report "Right has bigger exponent";
        smaller := l;
        larger := r;
      end if;

      -- larger_exponent := get_exponent(larger);
      -- smaller_exponent := -get_exponent(smaller);
      -- report "Larger exponent  : " & to_string(larger_exponent);
      -- report "Smaller exponent : " & to_string(smaller_exponent);
      exp_diff := unsigned(get_exponent(larger) - get_exponent(smaller));
      -- report "Exponent diff: " & to_string(exp_diff);

      smaller_fractional := get_fractional(smaller);
      -- report "Smaller fractional: " & to_string(smaller_fractional);
      smaller_fractional := shift_right(smaller_fractional, to_integer(exp_diff));
      -- report "Smaller after >>  : " & to_string(smaller_fractional);

      larger_fractional := get_fractional(larger);
      -- report "Larger fractional : " & to_string(larger_fractional);

      new_fractional := resize(larger_fractional, larger_fractional'length+1) + resize(smaller_fractional, smaller_fractional'length+1);
      -- report "larger + smaller  : " & to_string(new_fractional);

      fractional_sign := new_fractional(new_fractional'left);
      new_exponent := get_exponent(larger);
      -- report "exponent   : " & to_string(new_exponent);
      -- report "new_fractional'left :" & to_string(new_fractional'left);
      if new_fractional(new_fractional'left-1) = not fractional_sign then
        -- report "Branch  overflow";
        new_exponent := new_exponent + 1;
        -- report "exponent normal   : " & to_string(new_exponent);

        final_fractional :=  new_fractional(new_fractional'left downto new_fractional'right+1);
        -- report "fraction normal   : " & to_string(final_fractional);
      elsif new_fractional(new_fractional'left-2) = not fractional_sign  then
        -- report "Branch  already normal";
        new_exponent := new_exponent;
        -- report "exponent normal   : " & to_string(new_exponent);

        final_fractional :=  new_fractional(new_fractional'left-1 downto new_fractional'right);
        -- report "fraction normal   : " & to_string(final_fractional);
      elsif new_fractional(new_fractional'left-3) = not fractional_sign  then
        -- report "Branch  underflow -1";
        new_exponent := new_exponent - 1;
        -- report "exponent normal   : " & to_string(new_exponent);

        final_fractional :=  new_fractional(new_fractional'left-2 downto new_fractional'right) & '0';
        -- report "fraction normal   : " & to_string(final_fractional);
      elsif new_fractional(new_fractional'left-4) = not fractional_sign  then
        -- report "Branch  underflow -2";
        new_exponent := new_exponent - 2;
        -- report "exponent normal   : " & to_string(new_exponent);

        final_fractional :=  new_fractional(new_fractional'left-3 downto new_fractional'right) & "00";
        -- report "fraction normal   : " & to_string(final_fractional);
      elsif new_fractional(new_fractional'left-5) = not fractional_sign  then
        -- report "Branch  underflow -3";
        new_exponent := new_exponent - 3;
        -- report "exponent normal   : " & to_string(new_exponent);

        final_fractional :=  new_fractional(new_fractional'left-4 downto new_fractional'right) & "000";
        -- report "fraction normal   : " & to_string(final_fractional);
      elsif new_fractional(new_fractional'left-6) = not fractional_sign  then
        -- report "Branch  underflow -4";
        new_exponent := new_exponent - 4;
        -- report "exponent normal   : " & to_string(new_exponent);

        final_fractional :=  new_fractional(new_fractional'left-5 downto new_fractional'right) & "0000";
        -- report "fraction normal   : " & to_string(final_fractional);
      elsif new_fractional(new_fractional'left-7) = not fractional_sign  then
        -- report "Branch  underflow -5";
        new_exponent := new_exponent - 5;
        -- report "exponent normal   : " & to_string(new_exponent);

        final_fractional :=  new_fractional(new_fractional'left-6 downto new_fractional'right) & "00000";
        -- report "fraction normal   : " & to_string(final_fractional);
      elsif new_fractional(new_fractional'left-8) = not fractional_sign  then
        -- report "Branch  underflow -6";
        new_exponent := new_exponent - 6;
        -- report "exponent normal   : " & to_string(new_exponent);

        final_fractional :=  new_fractional(new_fractional'left-7 downto new_fractional'right) & "000000";
        -- report "fraction normal   : " & to_string(final_fractional);
      elsif new_fractional(new_fractional'left-9) = not fractional_sign  then
        -- report "Branch  underflow -7";
        new_exponent := new_exponent - 7;
        -- report "exponent normal   : " & to_string(new_exponent);

        final_fractional :=  new_fractional(new_fractional'left-8 downto new_fractional'right) & "0000000";
        -- report "fraction normal   : " & to_string(final_fractional);
      else
        -- report "Result is ZERO or minimal NEG";
        if fractional_sign then
          new_exponent := new_exponent - 8;
          final_fractional := fractional_sign & "00000000";
        else
          new_exponent := (others=>'0');
          final_fractional := (others=>'0');
        end if;
      end if;
      return float_t(new_exponent & final_fractional);



      -- if new_fractional = 0 then
      --   -- report "Result is ZERO!";
      --   result := (others=>'0');
      --   return result;
      -- else
      --   new_new_fractional := resize(new_fractional, new_fractional'length+1);
      --   report "new_new_fractional: " & to_string(new_new_fractional);
      --   leftmost := find_leftmost(new_new_fractional);
      --   report "Leftmost: " & to_string(leftmost);
      --
      --   -- report "Shift: " & to_string(shift_right(new_fractional, leftmost));
      --   new_new_fractional := shift_left(new_new_fractional, leftmost);
      --   report "fract normal      : " & to_string(new_new_fractional);
      --
      --   new_exponent := get_exponent(larger);
      --   report "exponent          : " & to_string(new_exponent);
      --   new_exponent := new_exponent + to_signed(Leftmost, new_exponent'length) -1;
      --   report "exponent normal   : " & to_string(new_exponent);
      --
      --   result := UNRESOLVED_float_t(new_exponent & new_new_fractional(new_new_fractional'left-1 downto new_new_fractional'right+1));
      --
      --   -- report "Result            : " & to_string(result);
      --   return result;
      -- end if;
    end function "+";


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
