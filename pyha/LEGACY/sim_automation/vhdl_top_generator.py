VHDL_TOP_TEMPLATE = """
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.fixed_pkg.all;
    use ieee.math_real.all;

library work;
use work.all;

entity  top is
  port (
    clk, rst_n : in std_logic;
    {INPUT_SIGNALS} :  in std_logic_vector(17 downto 0);
    {OUTPUT_SIGNALS} :  out std_logic_vector(17 downto 0)
  );
end entity;

architecture arch of top is
begin
    process(clk, rst_n)
      variable self: {DUT_NAME}.self_t;
      variable {OUTPUT_VARIABLES}: sfixed(0 downto -17);
    begin
      if (not rst_n) then
        {DUT_NAME}.reset(self);
      elsif rising_edge(clk) then
        {DUT_NAME}.main(self, {INPUT_SIGNALS_CALL}, {OUTPUT_VARIABLES});
        {OUTPUT_VARIABLES_TO_SLV}
      end if;

    end process;
end architecture;
"""

VERILOG_TOP_TEMPLATE = """
module top_sv #()
  (
  input clk,rst_n,
  input  [17 :0]    {INPUT_SIGNALS},
  output [17 :0]    {OUTPUT_SIGNALS}
  );

  top #()
  top (.*);
endmodule
"""


class TopMaker(object):
    def __init__(self, base_dir, dut_name, inputs, outputs):
        self.inputs = inputs
        self.dut_name = dut_name
        self.base_dir = base_dir
        self.outputs = outputs

    def _make_verilog_top(self):
        subs = dict()
        subs['INPUT_SIGNALS'] = ','.join(self.inputs)
        subs['OUTPUT_SIGNALS'] = ','.join(self.outputs)
        with (self.base_dir / 'top.sv').open('w') as f:
            f.write(VERILOG_TOP_TEMPLATE.format(**subs))

    def _make_vhdl_top(self):
        subs = dict()
        subs['INPUT_SIGNALS'] = ','.join(self.inputs)
        subs['OUTPUT_SIGNALS'] = ','.join(self.outputs)
        subs['DUT_NAME'] = self.dut_name

        in_call = ['to_sfixed({va}, 0, -17) '.format(va=x) for x in self.inputs]
        subs['INPUT_SIGNALS_CALL'] = ','.join(in_call)

        out_vars = ['return_' + x for x in self.outputs]
        subs['OUTPUT_VARIABLES'] = ','.join(out_vars)

        out_slv = ['{va} <= to_slv(return_{va});\n'.format(va=x) for x in self.outputs]
        subs['OUTPUT_VARIABLES_TO_SLV'] = ''.join(out_slv)

        with (self.base_dir / 'top.vhd').open('w') as f:
            f.write(VHDL_TOP_TEMPLATE.format(**subs))

    def make(self):
        self._make_vhdl_top()
        self._make_verilog_top()


if __name__ == "__main__":
    in_sig = ['x']
    out_sig = ['y']
    d = TopMaker('.', 'average', in_sig, out_sig)
    d.make()
