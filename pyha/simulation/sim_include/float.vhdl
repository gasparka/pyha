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
    function Float(value: real; a:std_logic_vector; exponent_bits, fractional_bits:integer) return float_t;
    function to_slv (arg : float_t) return STD_LOGIC_VECTOR;
    function to_sulv (arg : float_t)return STD_ULOGIC_VECTOR;

    function "+" (l, r : float_t) return float_t;
    -- function "-" (l, r : float_t) return float_t;
    function "*" (l, r : float_t) return float_t;
    function "-" (l : float_t) return float_t;
    function "-" (l, r : float_t) return float_t;
    -- function "*" (l : float_t; r: sfixed) return float_t;

  end package;

  package body float_noround_pkg is

    function Float(a:std_logic_vector; exponent_bits, fractional_bits:integer) return float_t is
        variable result: float_t(exponent_bits downto -fractional_bits);
    begin
      result := float_t(a);
      return result;
    end function;

    function Float(value: real; a:std_logic_vector; exponent_bits, fractional_bits:integer) return float_t is
        variable result: float_t(exponent_bits downto -fractional_bits);
    begin
      result := float_t(a);
      return result;
    end function;


    function get_sign(a: float_t) return std_logic is
    begin
      return a(a'left);
    end function;

    function get_exponent(a: float_t) return signed is
    begin
      return signed(a(a'left-1 downto 0));
    end function;

    function get_fractional(a: float_t) return unsigned is
      variable slv : std_logic_vector (a'length-1 downto 0) := to_slv(a);
    begin
      return unsigned(slv(-a'right-1 downto 0));
    end function;

    function find_leftmost (ARG : signed)
      return INTEGER is
    begin
      -- report to_string(arg'left) & to_string(arg'right);
      for INDEX in arg(arg'left -1 downto arg'right)'range loop
        if ARG(INDEX) = not arg(arg'high) then
          return arg'left -1 - INDEX;
        end if;
      end loop;
      return arg'left;
    end function find_leftmost;

    function "+" (l, r : float_t) return float_t is
      variable result : float_t (l'left downto l'right);
      variable exponent_l, exponent_r, new_exponent : signed (l'left-1 downto 0);
      variable smaller, larger: float_t(l'range);
      variable exp_diff: signed (l'left downto 0);
      variable abs_exp_diff: integer;
      variable smaller_fractional, larger_fractional: unsigned (-l'right-1 downto 0);
      -- variable smaller_fractional_shifted: signed (-l'right-1 downto 0);
      variable new_fractional: unsigned (-l'right downto 0);
      -- variable leftmost: integer;
      -- variable fractional_sign : std_logic;
      -- variable exp_add : integer;
      --
      variable final_fractional: unsigned (-l'right-1 downto 0);
      variable final_exponent : signed (l'left downto 0);
      variable new_sign : std_logic;
      --
      -- variable comp : std_logic_vector(4 downto 0);
      variable first, second, third: boolean;
      variable add_or_sub : boolean;
      variable l_small: boolean;
      variable exp_equal, left_fract_smaller: boolean;
      variable small_1, small_2, small_3: unsigned (-l'right-1 downto 0);
    begin
      exponent_l := get_exponent(l);
      exponent_r := get_exponent(r);
      -- report "Left  : " & to_string(get_sign(l)) & " " & to_string(exponent_l) & " " & to_string(get_fractional(l));
      -- report "Right : " & to_string(get_sign(r)) & " " & to_string(exponent_r) & " " & to_string(get_fractional(r));

      -- report "Expoent left: " & to_string(to_integer(exponent_l));
      -- report "Expoent right: " & to_string(to_integer(exponent_r));

      exp_diff := resize(exponent_l, exponent_l'length+1) - exponent_r;
      exp_equal := exponent_l = exponent_r;
      left_fract_smaller := get_fractional(l) < get_fractional(r);
      add_or_sub := get_sign(l) = get_sign(r);
      -- report "Exponents difference: " & to_string(exp_diff);

      if exp_diff(exp_diff'left) = '1' or (exp_equal and left_fract_smaller) then
        smaller := l;
        larger := r;
      else
        -- report "Right has bigger exponent";
        smaller := r;
        larger := l;
      end if;
      new_sign := get_sign(larger);

      abs_exp_diff := to_integer(unsigned(abs(exp_diff)));
      -- report "ABS Exponents difference: " & to_string(abs_exp_diff);

      smaller_fractional := get_fractional(smaller);
      if abs_exp_diff = 0 then
        smaller_fractional := smaller_fractional;
      elsif abs_exp_diff = 1 then
        smaller_fractional := shift_right(smaller_fractional, 5);
      elsif abs_exp_diff = 2 then
        smaller_fractional := shift_right(smaller_fractional, 10);
      else
        smaller_fractional := (others => '0');
      end if;

      -- if abs_exp_diff > 6 then
      --   small_1 := shift_right(get_fractional(smaller), 6);
      -- else
      --   small_1 := get_fractional(smaller);

      -- if unsigned(abs(exp_diff))(2) then
      --   small_1 := shift_right(get_fractional(smaller), 8);
      -- else
      --   small_1 := get_fractional(smaller);
      -- end if;
      --
      -- if unsigned(abs(exp_diff))(1) then
      --   small_2 := shift_right(small_1, 4);
      -- else
      --   small_2 := small_1;
      -- end if;
      --
      -- if unsigned(abs(exp_diff))(0) then
      --   small_3 := shift_right(small_2, 2);
      -- else
      --   small_3 := small_2;
      -- end if;

      --
      -- result := float_t(new_sign & std_logic_vector(get_exponent(larger)) & std_logic_vector(smaller_fractional));
      -- return result;

      -- report "Smaller after >>  : " & to_string(smaller_fractional);

      larger_fractional := get_fractional(larger);
      -- report "Larger fractional : " & to_string(larger_fractional);
      if add_or_sub then
        -- report "+";
        new_fractional := resize(larger_fractional, larger_fractional'length+1) + resize(smaller_fractional, smaller_fractional'length+1);
      else
        -- report "-";
        new_fractional := resize(larger_fractional, larger_fractional'length+1) - resize(smaller_fractional, smaller_fractional'length+1);
      end if;
      -- report "sum  : " & to_string(new_fractional);

      -- fractional_sign := new_fractional(new_fractional'left);
      new_exponent := get_exponent(larger);
      -- report "exponent   : " & to_string(new_exponent);
      -- report "new_fractional'left :" & to_string(new_fractional'left);

      -- comp := (others=>fractional_sign);

      first := new_fractional(new_fractional'left-1 downto new_fractional'left-5) = "00000";
      second := new_fractional(new_fractional'left-6 downto new_fractional'left-10) = "00000";
      third := new_fractional(new_fractional'left-11 downto new_fractional'right) = "0000";

      -- report "first   : " & to_string(std_logic_vector(new_fractional(new_fractional'left-1 downto new_fractional'left-6)));
      -- report "second   : " & to_string(new_fractional(new_fractional'left-7 downto new_fractional'left-11));
      -- report "sec   : " & to_string(std_logic_vector(new_fractional(new_fractional'left-7 downto new_fractional'left-11)) );
      -- report "comp   : " & to_string(comp);
      -- report "flags   : " & to_string(first)& to_string(second)& to_string(third);
      -- exp_add := 0;
      -- if new_fractional(new_fractional'left-1) /= fractional_sign then
      --   -- report "Handling overflow!";
      --   new_fractional := shift_right(new_fractional, 5);
      --   -- exp_add := 1;
      --   new_exponent := new_exponent + 1;
      -- elsif  first and second and third then
      --   -- report "Handling uf 2";
      --   new_fractional := (others=>'0');
      --   new_exponent := (others=>'0');
      -- elsif  first and second then
      --   -- report "Handling uf 2";
      --   new_fractional := shift_left(new_fractional, 10);
      --   new_exponent := new_exponent -2;
      -- elsif first then
      --   -- report "Handling uf 1";
      --   new_fractional := shift_left(new_fractional, 5);
      --   new_exponent := new_exponent - 1;
      -- end if;

      final_fractional := new_fractional(new_fractional'left-1 downto new_fractional'right);
      final_exponent := resize(new_exponent, final_exponent'length);

      if first then
        -- report "first";
        final_fractional := shift_left(new_fractional, 5)(new_fractional'left-1 downto new_fractional'right);
        final_exponent := resize(new_exponent, final_exponent'length) - 1;
      end if;

      if  first and second then
        -- report "first and second";
        final_fractional := shift_left(new_fractional, 10)(new_fractional'left-1 downto new_fractional'right);
        final_exponent := resize(new_exponent, final_exponent'length) -2;
      end if;

      if  (first and second and third) or to_integer(final_exponent) < -4 then
        report "first and second and third or exponent underflow";
        final_fractional := (others=>'0');
        final_exponent := to_signed(-4, final_exponent'length);
        new_sign := '0';
      end if;

      if new_fractional(new_fractional'left) = '1' then
        report "Handling overflow!";
        final_fractional := shift_right(new_fractional, 5)(new_fractional'left-1 downto new_fractional'right);
        final_exponent := resize(new_exponent, final_exponent'length) + 1;
        new_sign := get_sign(larger);
      end if;


      -- report "Result : " & to_string(new_sign) & " " & to_string(final_exponent(final_exponent'left-1 downto 0)) & " " & to_string(final_fractional);
      result := float_t(new_sign & std_logic_vector(final_exponent(final_exponent'left-1 downto 0)) & std_logic_vector(final_fractional));
      return result;
    end function "+";


    function "-" (l : float_t) return float_t is
      variable result : float_t (l'left downto l'right);
    begin
      result := float_t((get_sign(l) xor '1') & std_logic_vector(get_exponent(l)) & std_logic_vector(get_fractional(l)));
      return result;
    end function "-";


    function "-" (l, r : float_t) return float_t is
      variable result : float_t (l'left downto l'right);
    begin
      result := l + (-r);
      return result;
    end function "-";
    --
    --
    function "*" (l, r : float_t) return float_t is
      variable result : float_t (l'left downto l'right);
      variable new_exponent : signed (l'left-1 downto 0);
      variable tmp_exponent: signed (l'left downto 0);
      variable res_exp : signed (l'left+1 downto 0);
      variable fractional_mult: unsigned (-l'right*2-1 downto 0);
      variable new_fractional: unsigned (-l'right-1 downto 0);

      variable sign_result : std_logic;
      variable needs_normalize: boolean;
      variable exp_undeflow_on_normalization: boolean := False;
      variable exp_underflow: boolean := False;
      variable overflows: boolean := False;
      variable new_sign: std_logic;
    begin

      tmp_exponent := resize(get_exponent(l), tmp_exponent'length) + resize(get_exponent(r), tmp_exponent'length);

      fractional_mult := get_fractional(l) * get_fractional(r);
      -- report "fractional_mult: " & to_string(fractional_mult);

      needs_normalize := fractional_mult(fractional_mult'left downto fractional_mult'left-4) = "00000";


      new_fractional := fractional_mult(fractional_mult'left downto fractional_mult'left+1-new_fractional'length);
      res_exp := resize(tmp_exponent, res_exp'length);
      if  needs_normalize then
        report "needs_normalize";
        new_fractional := fractional_mult(fractional_mult'left-5 downto fractional_mult'left-5-new_fractional'length+1);
        res_exp := resize(tmp_exponent, res_exp'length) - 1;
      end if;

      if res_exp < -4 or to_integer(new_fractional) = 0 then
        report "Handling expoment underflow!";
        new_sign := '0';
        new_fractional := (others => '0');
        new_exponent := to_signed(-4, new_exponent'length);
        result := float_t(new_sign & std_logic_vector(new_exponent) & std_logic_vector(new_fractional));
        return result;
      end if;

      new_exponent := res_exp(res_exp'left-2 downto 0);
      new_sign := get_sign(l) xor get_sign(r);
      result := float_t(new_sign & std_logic_vector(new_exponent) & std_logic_vector(new_fractional));
      return result;

    end function "*";
    --
    -- function "*" (l : float_t; r: sfixed) return float_t is
    --   variable result : float_t (l'left downto l'right);
    --   variable new_exponent : signed (l'left downto 0);
    --   variable fractional_mult: signed (18+12-1 downto 0);
    --   variable new_fractional: signed (-l'right-1 downto 0);
    --   variable leftmost: integer;
    --   variable head: signed(2 downto 0);
    --
    --   variable fractional_sign : std_logic;
    --   variable comp : std_logic_vector(3 downto 0);
    --   variable first, second, third: boolean;
    -- begin
    --
    --   new_exponent := get_exponent(l);
    --   fractional_mult := get_fractional(l) * signed(to_slv(r));
    --   -- report "fractional_mult: " & to_string(fractional_mult);
    --
    --   fractional_sign := fractional_mult(fractional_mult'left);
    --
    --   comp := (others=>fractional_sign);
    --   -- report "comp: " & to_string(comp);
    --   -- report "f: " & to_string(std_logic_vector(fractional_mult(fractional_mult'left-2 downto fractional_mult'left-5)));
    --   first := std_logic_vector(fractional_mult(fractional_mult'left-2 downto fractional_mult'left-5)) = comp;
    --
    --   -- new_fractional := fractional_mult(fractional_mult'left-1 downto fractional_mult'left-new_fractional'length-1+1);
    --   if fractional_mult(fractional_mult'left-1) /= fractional_sign then
    --     -- report "Handling overflow!";
    --     -- report "len: " & to_string(new_fractional'length);
    --     -- report "fractional_mult: " & to_string(fractional_mult(fractional_mult'left downto fractional_mult'left-new_fractional'length+1));
    --     -- new_fractional := fractional_mult(fractional_mult'left downto fractional_mult'left-new_fractional'length+1);
    --     fractional_mult := shift_right(fractional_mult, 4);
    --     new_exponent := new_exponent + 1;
    --   elsif  first then
    --     -- report "Handling uf";
    --     -- report "fractional_mult: " & to_string(fractional_mult(fractional_mult'left-5 downto fractional_mult'left-new_fractional'length-5+1));
    --     -- new_fractional := fractional_mult(fractional_mult'left-5 downto fractional_mult'left-new_fractional'length-5+1);
    --     fractional_mult := shift_left(fractional_mult, 4);
    --     new_exponent := new_exponent - 1;
    --   end if;
    --
    --   -- report "fractional_mult: " & to_string(fractional_mult(fractional_mult'left-5 downto fractional_mult'left-new_fractional'length-5+1));
    --
    --   result := float_t(new_exponent & fractional_mult(fractional_mult'left-1 downto fractional_mult'left-new_fractional'length-1+1));
    --   return result;
    --
    -- end function "*";


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
