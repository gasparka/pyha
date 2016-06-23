-- Moving average filter
-- Limitation: Window size must be power of 2


library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use std.textio.all;
  use ieee.fixed_float_types.all;
  use ieee.fixed_pkg.all;
  use ieee.math_real.all;

library work;
use work.all;

package movingAvg is
  -- generic (WINDOW_POW    : integer   := 2;
  --         DATA_WIDTH      :integer   := 18  );

  constant MAX_DELAY: integer := (2 ** conf.GENERIC_WINDOW_POW);
  constant GUARD_BITS: integer := util.bitsForNr(MAX_DELAY-1);
  subtype data_t is sfixed(0 downto -(conf.GENERIC_DATA_WIDTH-1));
  subtype accum_t is sfixed(GUARD_BITS downto data_t'low);
  -- round away bits before they are shifted away
  subtype round_t is sfixed(accum_t'high downto accum_t'low + conf.GENERIC_WINDOW_POW);

  type reg_t is record
    delayLine  : util.sfixed_vector(0 to MAX_DELAY-1)(data_t'range);
    sum : accum_t;
    avg : data_t;
  end record;

  constant REG_RESET: reg_t :=
  (
      delayLine => (others => (others => '0')),
      avg => (others => '0'),
      sum => (others => '0')
  );

  function main(this :reg_t; newElem: data_t) return reg_t;
  function getAvg(this: reg_t) return data_t;
  procedure debug;

end package;


package body movingAvg is
  procedure debug is
  begin
    report "WP: " & to_string(conf.GENERIC_WINDOW_POW) & " DW: " & to_string(conf.GENERIC_DATA_WIDTH);
    report "H: " & to_string(data_t'high) & " L:" & to_string(data_t'low);
  end procedure;

  function getAvg(this: reg_t) return data_t is
  begin
    return this.avg;
  end function;

  -- perform one tick of averaging filtering
  function main(this :reg_t; newElem: data_t) return reg_t is
    variable thisNext: reg_t;
    variable lastElem: data_t;
    variable roundt: round_t;
  begin
    thisNext := this;
    lastElem := util.last(this.delayLine);

    --shift the array right and push new element to first spot
    thisNext.delayLine := util.pushAndShift(this.delayLine, newElem);

    --add new element and subtract last to SUM
    thisNext.sum := resize(this.sum + newElem - lastElem, this.sum,
                  round_style => fixed_truncate, overflow_style => fixed_wrap);

    --round the bits that are to be shifted
    roundt := resize(thisNext.sum, roundt,
                  round_style => fixed_round, overflow_style => fixed_wrap);

    --shift to correct range
    thisNext.avg := roundt;

    -- report "New=" & ip(newElem) & " Last=" & ip(lastElem)
    --   & " Sum=" & ip(thisNext.sum) & " Avg=" & ip(thisNext.avg)
    --   ;


    return thisNext;
  end function;

end package body;
