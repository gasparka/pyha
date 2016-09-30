import textwrap
from functools import wraps

from common.sfix import Sfix
from common.util import tabber


def inout_saver(func):
    """ This decorator is used on __call__ function and saves the last args,kwargs and return
    values. Used to generate toplevel VHDL and Verilog files."""
    func._last_call = {}

    @wraps(func)
    def inout_saver_wrap(*args, **kwargs):
        func._last_call['args'] = args
        func._last_call['kwargs'] = kwargs

        ret = func(*args, **kwargs)

        func._last_call['return'] = ret
        return ret

    return inout_saver_wrap


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


class TopGenerator:
    def __init__(self, simulated_object):
        self.simulated_object = simulated_object

    def get_object_args(self) -> list:
        # skip first arg -> it is self
        return list(self.simulated_object.__call__._last_call['args'][1:])

    def get_object_kwargs(self) -> list:
        return self.simulated_object.__call__._last_call['kwargs'].items()

    def get_object_inputs(self) -> list:
        return self.get_object_args() + [x[1] for x in self.get_object_kwargs()]

    def get_object_return(self) -> list:
        return list(self.simulated_object.__call__._last_call['return'])

    def pyvar_to_stdlogic(self, var) -> str:
        if type(var) == int:
            return 'std_logic_vector(31 downto 0)'
        elif type(var) == bool:
            return 'std_logic'
        elif type(var) == Sfix:
            return var.to_stdlogic()
        else:
            assert 0

    def make_entity(self) -> str:
        template = textwrap.dedent("""\
            entity  top is
                port (
                    clk, rst_n: in std_logic;

                    -- inputs
            {INPUTS}

                    -- outputs
            {OUTPUTS}
                );
            end entity;""")
        sockets = dict()

        inputs = [tabber(tabber('in{}: in {};'.format(i, self.pyvar_to_stdlogic(x))))
                  for i, x in enumerate(self.get_object_inputs())]

        sockets['INPUTS'] = '\n'.join(inputs)

        outputs = [tabber(tabber('out{}: out {};'.format(i, self.pyvar_to_stdlogic(x))))
                   for i, x in enumerate(self.get_object_return())]

        sockets['OUTPUTS'] = '\n'.join(outputs)
        return template.format(**sockets)

    def inputs(self):
        return [tabber(tabber('in{}: in {};'.format(i, self.pyvar_to_stdlogic(x))))
                for i, x in enumerate(self.get_object_args())]

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
    d = TopGenerator('.', 'average', in_sig, out_sig)
    d.make()
