-- Demo class, multiply and add coef to input
package Demo_0 is
    type next_t is record
        mult: sfixed(0 downto -17);
        add: sfixed(0 downto -17);
        coef_f: sfixed(0 downto -17);
    end record;

    type self_t is record
        -- constants
        \_delay\: integer;

        mult: sfixed(0 downto -17);
        add: sfixed(0 downto -17);
        coef_f: sfixed(0 downto -17);
        \next\: next_t;
    end record;
end package;

package body Demo_0 is
    -- Mulitply 'input' with self.coef
    procedure multiply(self:inout self_t; input: sfixed(0 downto -17); ret_0:out sfixed(0 downto -17)) is

    begin
        self.\next\.mult := resize(input * self.coef_f, size_res=>input, round_style=>fixed_truncate);
        ret_0 := self.mult;
        return;
    end procedure;

    -- Add 'input' and self.coef
    procedure adder(self:inout self_t; input: sfixed(0 downto -17); ret_0:out sfixed(0 downto -17)) is

    begin
        self.\next\.add := resize(input + self.coef_f, size_res=>input);
        ret_0 := self.add;
        return;
    end procedure;

    procedure main(self:inout self_t; input: sfixed(0 downto -17); ret_0:out sfixed(0 downto -17); ret_1:out sfixed(0 downto -17)) is
        variable mult: sfixed(0 downto -17);
        variable add: sfixed(0 downto -17);
    begin
        multiply(self, input, ret_0=>mult);
        adder(self, input, ret_0=>add);
        ret_0 := mult;
        ret_1 := add;
        return;

    end procedure;
end package body;
