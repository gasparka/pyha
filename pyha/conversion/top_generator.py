import textwrap
from enum import Enum

from pyha.common.sfix import Sfix, ComplexSfix
from pyha.common.util import tabber
from pyha.conversion.converter import file_header
from pyha.conversion.coupling import pytype_to_vhdl, get_instance_vhdl_name


class NotTrainedError(Exception):
    pass


class NoInputsError(Exception):
    pass


class NoOutputsError(Exception):
    pass


class TopGenerator:
    def __init__(self, simulated_object):
        self.simulated_object = simulated_object

        # 0 or 1 calls wont propagate register outputs
        if self.simulated_object.main.calls == 0:
            raise NotTrainedError('Object must be trained > 1 times.')

        if len(self.get_object_inputs()) == 0:
            raise NoInputsError('Model has no inputs (arguments to main).')

        if len(self.get_object_return()) == 0:
            raise NoOutputsError('Model has no outputs (main returns).')

    def get_object_args(self) -> list:
        return list(self.simulated_object.main.last_args)

    def get_object_kwargs(self) -> list:
        return self.simulated_object.main.last_kwargs.items()

    def get_object_inputs(self) -> list:
        return self.get_object_args() + [x[1] for x in self.get_object_kwargs()]

    def get_object_return(self) -> list:
        rets = self.simulated_object.main.last_return
        if isinstance(rets, tuple):
            return list(rets)
        elif rets is None:
            return []
        else:
            return [rets]  # single value

    def pyvar_to_stdlogic(self, var) -> str:
        if type(var) == int:
            return 'std_logic_vector(31 downto 0)'
        elif type(var) == bool:
            return 'std_logic'
        elif type(var) in (Sfix, ComplexSfix):
            return var.to_stdlogic()
        elif isinstance(var, Enum):
            return self.pyvar_to_stdlogic(var.value)
        elif isinstance(var, list):
            if isinstance(var[0], bool):
                return f'std_logic_vector({len(var) - 1} downto 0)'
        else:
            assert 0

    def vhdl_slv_to_normal(self, var, var_name) -> str:
        if type(var) == int:
            return f'to_integer(signed({var_name}))'
        elif type(var) == bool:
            return f'logic_to_bool({var_name})'
        elif type(var) == Sfix:
            return f'Sfix({var_name}, {var.left}, {var.right})'
        elif type(var) == ComplexSfix:
            size = int(var.bitwidth())
            mid = size // 2
            real = f'Sfix({var_name}({size - 1} downto {mid}), {var.left}, {var.right})'
            imag = f'Sfix({var_name}({mid - 1} downto {0}), {var.left}, {var.right})'
            return f'(real=>{real}, imag=>{imag})'
        else:
            assert 0

    def normal_to_slv(self, var, var_name) -> str:
        if type(var) == int:
            return f'std_logic_vector(to_signed({var_name}, 32))'
        elif type(var) == bool:
            return f'bool_to_logic({var_name})'
        elif type(var) == Sfix:
            return f'to_slv({var_name})'
        elif type(var) == ComplexSfix:
            return f'to_slv({var_name}.real) & to_slv({var_name}.imag)'
        elif isinstance(var, Enum):
            return self.normal_to_slv(var.value, var_name)
        elif isinstance(var, list):
            if isinstance(var[0], bool):
                return f'bool_list_to_logic({var_name})'
        else:
            assert 0

    def make_entity_inputs(self) -> str:
        return '\n'.join(f'in{i}: in {self.pyvar_to_stdlogic(x)};'
                         for i, x in enumerate(self.get_object_inputs()))

    def make_entity_outputs(self) -> str:
        return '\n'.join(f'out{i}: out {self.pyvar_to_stdlogic(x)};'
                         for i, x in enumerate(self.get_object_return()))

    def make_output_variables(self) -> str:
        return '\n'.join(f'variable var_out{i}: {pytype_to_vhdl(x)};'
                         for i, x in enumerate(self.get_object_return()))

    def make_output_type_conversions(self) -> str:
        return '\n'.join(f'out{i} <= {self.normal_to_slv(x, "var_out{}".format(i))};'
                         for i, x in enumerate(self.get_object_return()))

    def make_input_variables(self) -> str:
        return '\n'.join(f'variable var_in{i}: {pytype_to_vhdl(x)};'
                         for i, x in enumerate(self.get_object_inputs()))

    def make_input_type_conversions(self) -> str:
        return '\n'.join(f'var_in{i} := {self.vhdl_slv_to_normal(x, "in{}".format(i))};'
                         for i, x in enumerate(self.get_object_inputs()))

    def make_complex_types(self):
        complex_vars = []
        for x in self.get_object_inputs() + self.get_object_return():
            if type(x) is ComplexSfix:
                new = x.vhdl_type_define()
                if new not in complex_vars:
                    complex_vars.append(new)
        return '\n'.join(x for x in complex_vars)

    def make_imports(self) -> str:
        return textwrap.dedent("""\
            library ieee;
                use ieee.std_logic_1164.all;
                use ieee.numeric_std.all;
                use ieee.fixed_pkg.all;
                use ieee.math_real.all;

            library work;
                use work.PyhaUtil.all;
                use work.ComplexTypes.all;
                use work.all;""")

    def object_class_name(self) -> str:
        # make sure we escape reserved names
        return get_instance_vhdl_name(self.simulated_object)

    def make_call_arguments(self) -> str:

        input_args = ', '.join(f'var_in{i}'
                               for i, _ in enumerate(self.get_object_args()))
        ofs = len(self.get_object_args())
        input_kwargs = ', '.join(f'{x[0]}=>var_in{i + ofs}'
                                 for i, x in enumerate(self.get_object_kwargs()))

        inputs = ', '.join([input_args, input_kwargs]) if len(self.get_object_kwargs()) else input_args

        outputs = ', '.join(f'ret_{i}=>var_out{i}'
                            for i, _ in enumerate(self.get_object_return()))

        return ', '.join([inputs, outputs])

    def make(self):
        template = textwrap.dedent("""\
                {FILE_HEADER}
                {IMPORTS}

                entity  top is
                    port (
                        clk, rst_n, enable: in std_logic;

                        -- inputs
                {ENTITY_INPUTS}

                        -- outputs
                {ENTITY_OUTPUTS}
                    );
                end entity;

                architecture arch of top is
                begin
                    process(clk, rst_n)
                        variable self: {DUT_NAME}.self_t;
                        -- input variables
                {INPUT_VARIABLES}

                        --output variables
                {OUTPUT_VARIABLES}
                    begin
                    if (not rst_n) then
                        {DUT_NAME}.\\_pyha_reset_self\\(self);
                    elsif rising_edge(clk) then
                        if enable then
                            --convert slv to normal types
                {INPUT_TYPE_CONVERSIONS}

                            --call the main entry
                            -- without this Quartus wont honor constants
                            {DUT_NAME}.\\_pyha_constants_self\\(self);
                            {DUT_NAME}.main(self, {CALL_ARGUMENTS});
                            {DUT_NAME}.\\_pyha_update_self\\(self);

                            --convert normal types to slv
                {OUTPUT_TYPE_CONVERSIONS}
                        end if;
                      end if;

                    end process;
                end architecture;""")

        def tab(x):
            return tabber(tabber(x))

        sockets = {}
        sockets['FILE_HEADER'] = file_header()
        sockets['DUT_NAME'] = self.object_class_name()
        sockets['IMPORTS'] = self.make_imports()
        sockets['ENTITY_INPUTS'] = tab(self.make_entity_inputs())
        sockets['ENTITY_OUTPUTS'] = tab(
            self.make_entity_outputs()[:-1])  # -1 removes the last ';', VHDL has some retarded rules
        sockets['INPUT_VARIABLES'] = tab(self.make_input_variables())
        sockets['OUTPUT_VARIABLES'] = tab(self.make_output_variables())
        sockets['INPUT_TYPE_CONVERSIONS'] = tabber(tab(self.make_input_type_conversions()))
        sockets['OUTPUT_TYPE_CONVERSIONS'] = tabber(tab(self.make_output_type_conversions()))
        sockets['CALL_ARGUMENTS'] = self.make_call_arguments()

        res = template.format(**sockets)

        return res
