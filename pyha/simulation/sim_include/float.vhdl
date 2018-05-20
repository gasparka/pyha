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
      variable abs_exp_diff: natural;
      variable smaller_fractional, larger_fractional: unsigned (-l'right-1 downto 0);
      -- variable smaller_fractional_shifted: signed (-l'right-1 downto 0);
      variable new_fractional: unsigned (-l'right downto 0);
      -- variable leftmost: integer;
      -- variable fractional_sign : std_logic;
      -- variable exp_add : integer;
      --
      variable final_fractional: unsigned (-l'right-1 downto 0);
      variable final_exponent : signed (l'left-1 downto 0);
      variable new_sign : std_logic;
      --
      -- variable comp : std_logic_vector(4 downto 0);
      variable first, second, third: boolean;
      variable add_or_sub : boolean;
      variable l_small: boolean;
    begin
      exponent_l := get_exponent(l);
      exponent_r := get_exponent(r);
      -- report "Expoent left: " & to_string(to_integer(exponent_l));
      -- report "Expoent right: " & to_string(to_integer(exponent_r));

      exp_diff := resize(exponent_l, exponent_l'length+1) - exponent_r;
      -- report "Exponent diff: " & to_string(exp_diff);

      if get_fractional(l) < get_fractional(r) then
        l_small := True;
        new_sign := get_sign(r);
      else
        new_sign := get_sign(l);
        l_small := False;
      end if;


      if exp_diff(exp_diff'left) = '0' then
        if to_integer(exp_diff) = 0 and  l_small then
          smaller := l;
          larger := r;
        else
          smaller := r;
          larger := l;
        end if;
      else
        -- report "Right has bigger exponent";
        smaller := l;
        larger := r;
      end if;

      abs_exp_diff := to_integer(unsigned(abs(exp_diff)));
      -- report "ABS Exponent diff: " & to_string(abs_exp_diff);

      smaller_fractional := get_fractional(smaller);
      -- report "Smaller fractional: " & to_string(smaller_fractional);


      if abs_exp_diff = 0 then
        smaller_fractional := smaller_fractional;
      elsif abs_exp_diff = 1 then
        smaller_fractional := shift_right(smaller_fractional, 5);
      elsif abs_exp_diff = 2 then
        smaller_fractional := shift_right(smaller_fractional, 10);
      else
        smaller_fractional := (others => '0');
      end if;
      -- smaller_fractional := shift_right(smaller_fractional, abs_exp_diff * 5);
      -- smaller_fractional_shifted :+
      -- if abs_exp_diff = 1 then
      --   smaller_fractional_shifted := shift_right(smaller_fractional, 5);
      -- end if;
      --
      -- if abs_exp_diff = 1 then
      --   smaller_fractional_shifted := shift_right(smaller_fractional, 10);
      -- end if;
      --
      -- if abs_exp_diff > 2 then
      --   smaller_fractional_shifted := shift_right(smaller_fractional, 15);
      -- end if;

      -- report "Smaller after >>  : " & to_string(smaller_fractional);

      larger_fractional := get_fractional(larger);
      -- report "Larger fractional : " & to_string(larger_fractional);
      add_or_sub := get_sign(larger) = get_sign(smaller);
      if add_or_sub then
        report "+";
        new_fractional := resize(larger_fractional, larger_fractional'length+1) + resize(smaller_fractional, smaller_fractional'length+1);
      else
        report "-";
        new_fractional := resize(larger_fractional, larger_fractional'length+1) - resize(smaller_fractional, smaller_fractional'length+1);
        -- new_fractional := resize(smaller_fractional, smaller_fractional'length+1) - resize(larger_fractional, larger_fractional'length+1);

      end if;
      -- report "larger + smaller  : " & to_string(new_fractional);

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
      final_exponent := new_exponent;

      if first then
        report "first";
        final_fractional := shift_left(new_fractional, 5)(new_fractional'left-1 downto new_fractional'right);
        final_exponent := new_exponent - 1;
      end if;

      if  first and second then
        report "first and second";
        final_fractional := shift_left(new_fractional, 10)(new_fractional'left-1 downto new_fractional'right);
        final_exponent := new_exponent -2;
      end if;

      if  first and second and third then
        report "first and second and third";
        final_fractional := (others=>'0');
        final_exponent := (others=>'0');
      end if;

      if new_fractional(new_fractional'left) = '1' then
        report "Handling overflow!";
        final_fractional := shift_right(new_fractional, 5)(new_fractional'left-1 downto new_fractional'right);
        final_exponent := new_exponent + 1;
      end if;


      result := float_t(new_sign & std_logic_vector(final_exponent) & std_logic_vector(final_fractional));
      return result;
    end function "+";

    -- function "-" (l, r : float_t) return float_t is
    --   variable result : float_t (l'left downto l'right);
    --   variable exponent_l, exponent_r, new_exponent, larger_exponent, smaller_exponent : signed (l'left downto 0);
    --   variable smaller, larger: float_t(l'range);
    --   variable exp_diff: signed (l'left+1 downto 0);
    --   variable smaller_fractional, larger_fractional: signed (-l'right-1 downto 0);
    --   variable new_fractional: signed (-l'right downto 0);
    --   variable final_fractional: signed (-l'right-1 downto 0);
    --   variable leftmost: integer;
    --   variable fractional_sign : std_logic;
    --   variable exp_compensate : integer;
    --   variable flip: boolean;
    -- begin
    --   exponent_l := get_exponent(l);
    --   exponent_r := get_exponent(r);
    --   -- report "Expoent left: " & to_string(exponent_l);
    --   -- report "Expoent right: " & to_string(exponent_r);
    --
    --   exp_diff := resize(exponent_l, exponent_l'length+1) - exponent_r;
    --   if exp_diff(exp_diff'left) = '0' then
    --     -- report "Left has bigger/equal exponent";
    --     smaller := r;
    --     larger := l;
    --     flip := False;
    --   else
    --     -- report "Right has bigger exponent";
    --     smaller := l;
    --     larger := r;
    --     flip := True;
    --   end if;
    --
    --   -- larger_exponent := get_exponent(larger);
    --   -- smaller_exponent := -get_exponent(smaller);
    --   -- report "Larger exponent  : " & to_string(larger_exponent);
    --   -- report "Smaller exponent : " & to_string(smaller_exponent);
    --   -- exp_diff := unsigned(get_exponent(larger) - get_exponent(smaller));
    --   -- report "Exponent diff: " & to_string(exp_diff);
    --
    --   smaller_fractional := get_fractional(smaller);
    --   -- report "Smaller fractional: " & to_string(smaller_fractional);
    --   smaller_fractional := shift_right(smaller_fractional, to_integer(abs(exp_diff)));
    --
    --   -- report "Smaller after >>  : " & to_string(smaller_fractional);
    --
    --   larger_fractional := get_fractional(larger);
    --   -- report "Larger fractional : " & to_string(larger_fractional);
    --
    --   if flip then
    --       larger_fractional := smaller_fractional;
    --       smaller_fractional := get_fractional(larger);
    --   end if;
    --   -- report "Larger fractional : " & to_string(larger_fractional);
    --   -- report "Smaller after >>  : " & to_string(smaller_fractional);
    --
    --   new_fractional := resize(larger_fractional, larger_fractional'length+1) - resize(smaller_fractional, smaller_fractional'length+1);
    --   -- report "larger - smaller  : " & to_string(new_fractional);
    --
    --   fractional_sign := new_fractional(new_fractional'left);
    --   new_exponent := get_exponent(larger);
    --
    --   leftmost := find_leftmost(new_fractional);
    --   if leftmost = new_fractional'left and fractional_sign = '0' then
    --       -- note that when leftmost is 9 but sign is 1, then we are dealing with minimal negative number
    --       -- report "Result is ZERO!";
    --       result := (others=>'0');
    --       return result;
    --   end if;
    --   -- report "Leftmost: " & to_string(leftmost);
    --
    --   new_fractional := shift_left(new_fractional, leftmost);
    --   -- report "fract normal      : " & to_string(new_fractional);
    --
    --   new_exponent := get_exponent(larger);
    --   -- report "exponent          : " & to_string(new_exponent);
    --   new_exponent := new_exponent - to_signed(leftmost, new_exponent'length) + 1;
    --   -- report "exponent normal   : " & to_string(new_exponent);
    --
    --   result := float_t(new_exponent & new_fractional(new_fractional'left downto new_fractional'right+1));
    --
    --   -- report "Result            : " & to_string(result);
    --   return result;
    -- end function "-";
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

      if res_exp < -4 then
        report "Handling expoment underflow!";
        res_exp := to_signed(-4, res_exp'length);
        new_fractional := (others => '0');
      end if;

      -- if fractional_mult(fractional_mult'left downto fractional_mult'left+1-new_fractional'length) = "10000000000000" then
      --   new_fractional(0) := '1';
      -- end if;

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
