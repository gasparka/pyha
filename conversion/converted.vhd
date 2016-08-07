
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.numeric_std.all;
    use ieee.fixed_float_types.all;
    use ieee.fixed_pkg.all;
    use ieee.math_real.all;

library work;
    use work.all;

package \Register\ is

	type self_t is record
		a: sfixed(0 downto -27);
	end record;

	procedure call(self: inout self_t; \next\: sfixed; ret_0: out sfixed);
end package;

package body \Register\ is

	procedure call(self: inout self_t; \next\: sfixed := 0; ret_0: out sfixed) is
		variable self_next: self_t;
	begin
		self_next := self;
		self_next.a := \next\;
		ret_0 := self.a;
		self := self_next;
	end procedure;

end package body;
