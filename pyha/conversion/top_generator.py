import textwrap
from functools import wraps
from pathlib import Path

from pyha.common.sfix import Sfix
from pyha.common.util import tabber
from pyha.conversion.coupling import pytype_to_vhdl


def inout_saver(func):
    """ This decorator is used on __call__ function and saves the last args,kwargs and return
    values. Used to generate toplevel VHDL and Verilog files."""
    func._last_call = {'calls': 0}

    @wraps(func)
    def inout_saver_wrap(*args, **kwargs):
        func._last_call['args'] = args
        func._last_call['kwargs'] = kwargs

        ret = func(*args, **kwargs)

        func._last_call['calls'] += 1
        func._last_call['return'] = ret
        return ret

    return inout_saver_wrap


class TopGenerator:
    def __init__(self, simulated_object, path=Path('.')):
        self.path = path
        self.simulated_object = simulated_object

        # 0 or 1 calls wont propagate register outputs
        if self.simulated_object.__call__._last_call['calls'] <= 1:
            raise Exception('Object must be trained > 1 times.')


    def get_object_args(self) -> list:
        # skip first arg -> it is self
        return list(self.simulated_object.__call__._last_call['args'][1:])

    def get_object_kwargs(self) -> list:
        return self.simulated_object.__call__._last_call['kwargs'].items()

    def get_object_inputs(self) -> list:
        return self.get_object_args() + [x[1] for x in self.get_object_kwargs()]

    def get_object_return(self) -> list:
        rets = self.simulated_object.__call__._last_call['return']
        return list(rets) if isinstance(rets, tuple) else [rets]

    def pyvar_to_stdlogic(self, var) -> str:
        if type(var) == int:
            return 'std_logic_vector(31 downto 0)'
        elif type(var) == bool:
            return 'std_logic'
        elif type(var) == Sfix:
            return var.to_stdlogic()
        else:
            assert 0

    def vhdl_slv_to_normal(self, var, var_name) -> str:
        if type(var) == int:
            return 'to_integer(to_signed({}))'.format(var_name)
        elif type(var) == bool:
            return var_name
        elif type(var) == Sfix:
            return 'to_sfixed({}, {}, {})'.format(var_name, var.left, var.right)
        else:
            assert 0

    def normal_to_slv(self, var, var_name) -> str:
        if type(var) == int:
            return 'std_logic_vector(to_signed({}, 32))'.format(var_name)
        elif type(var) == bool:
            return 'std_logic({})'.format(var_name)
        elif type(var) == Sfix:
            return 'to_slv({})'.format(var_name)
        else:
            assert 0

    def make_entity_inputs(self) -> str:
        return '\n'.join('in{}: in {};'.format(i, self.pyvar_to_stdlogic(x))
                         for i, x in enumerate(self.get_object_inputs()))

    def make_entity_outputs(self) -> str:
        return '\n'.join('out{}: out {};'.format(i, self.pyvar_to_stdlogic(x))
                         for i, x in enumerate(self.get_object_return()))

    def make_output_variables(self) -> str:
        return '\n'.join('variable var_out{}: {};'.format(i, pytype_to_vhdl(x))
                         for i, x in enumerate(self.get_object_return()))

    def make_output_type_conversions(self) -> str:
        return '\n'.join('out{} <= {};'.format(i, self.normal_to_slv(x, 'var_out{}'.format(i)))
                         for i, x in enumerate(self.get_object_return()))

    def make_input_variables(self) -> str:
        return '\n'.join('variable var_in{}: {};'.format(i, pytype_to_vhdl(x))
                         for i, x in enumerate(self.get_object_inputs()))

    def make_input_type_conversions(self) -> str:
        return '\n'.join('var_in{} := {};'.format(i, self.vhdl_slv_to_normal(x, 'in{}'.format(i)))
                         for i, x in enumerate(self.get_object_inputs()))

    def make_imports(self) -> str:
        return textwrap.dedent("""\
            library ieee;
                use ieee.std_logic_1164.all;
                use ieee.numeric_std.all;
                use ieee.fixed_pkg.all;
                use ieee.math_real.all;

            library work;
                use work.all;""")

    def object_class_name(self) -> str:
        # make sure we escape reserved names
        from pyha.conversion.converter import NameNodeConv
        return str(NameNodeConv.parse(self.simulated_object.__class__.__name__))

    def make_call_arguments(self) -> str:

        input_args = ', '.join('var_in{}'.format(i)
                               for i, _ in enumerate(self.get_object_args()))
        ofs = len(self.get_object_args())
        input_kwargs = ', '.join('{}=>var_in{}'.format(x[0], i + ofs)
                                 for i, x in enumerate(self.get_object_kwargs()))

        inputs = ', '.join([input_args, input_kwargs]) if len(self.get_object_kwargs()) else input_args

        outputs = ', '.join('ret_{i}=>var_out{i}'.format(i=i)
                            for i, _ in enumerate(self.get_object_return()))

        return ', '.join([inputs, outputs])

    def make(self):
        template = textwrap.dedent("""\
                {IMPORTS}

                entity  top is
                    port (
                        clk, rst_n: in std_logic;

                        -- inputs
                {ENTITY_INPUTS}

                        -- outputs
                {ENTITY_OUTPUTS}
                    );
                end entity;

                architecture arch of top is
                begin
                    process(clk, rst_n)
                        variable self: {DUT_NAME}.register_t;
                        -- input variables
                {INPUT_VARIABLES}

                        --output variables
                {OUTPUT_VARIABLES}
                    begin
                    if (not rst_n) then
                        {DUT_NAME}.reset(self);
                    elsif rising_edge(clk) then
                        --convert slv to normal types
                {INPUT_TYPE_CONVERSIONS}

                        --call the main entry
                        {DUT_NAME}.\\__call__\\(self, {CALL_ARGUMENTS});

                        --convert normal types to slv
                {OUTPUT_TYPE_CONVERSIONS}
                      end if;

                    end process;
                end architecture;""")

        def tab(x):
            return tabber(tabber(x))

        sockets = {}
        sockets['DUT_NAME'] = self.object_class_name()
        sockets['IMPORTS'] = self.make_imports()
        sockets['ENTITY_INPUTS'] = tab(self.make_entity_inputs())
        sockets['ENTITY_OUTPUTS'] = tab(
            self.make_entity_outputs()[:-1])  # -1 removes the last ';', VHDL has some retarded rules
        sockets['INPUT_VARIABLES'] = tab(self.make_input_variables())
        sockets['OUTPUT_VARIABLES'] = tab(self.make_output_variables())
        sockets['INPUT_TYPE_CONVERSIONS'] = tab(self.make_input_type_conversions())
        sockets['OUTPUT_TYPE_CONVERSIONS'] = tab(self.make_output_type_conversions())
        sockets['CALL_ARGUMENTS'] = self.make_call_arguments()

        res = template.format(**sockets)
        with (self.path / 'top.vhd').open('w') as f:
            f.write(res)

        return res