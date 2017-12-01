import textwrap

from pyha.common.util import tabber
from pyha.conversion.python_types_vhdl import VHDLModule, init_vhdl_type
from pyha.conversion.redbaron_mods import file_header


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
        rets = [init_vhdl_type('-', val, val) for val in self.simulated_object.main.last_args]
        return rets

    def get_object_kwargs(self) -> list:
        rets = [init_vhdl_type(key, val, val) for key, val in self.simulated_object.main.last_kwargs.items()]
        return rets

    def get_object_inputs(self) -> list:
        return self.get_object_args() + self.get_object_kwargs()

    def get_object_return(self) -> list:
        rets = self.simulated_object.main.last_return
        if rets == None:
            return []
        if isinstance(rets, tuple):  # multiple returns
            rets = [init_vhdl_type('-', val, val) for val in rets]
        else:
            rets = [init_vhdl_type('-', rets, rets)]
        return rets

    def make_entity_inputs(self) -> str:
        return '\n'.join(f'in{i}: in {x._pyha_stdlogic_type()};'
                         for i, x in enumerate(self.get_object_inputs()))

    def make_entity_outputs(self) -> str:
        return '\n'.join(f'out{i}: out {x._pyha_stdlogic_type()};'
                         for i, x in enumerate(self.get_object_return()))

    def make_output_variables(self) -> str:
        return '\n'.join(f'variable var_out{i}: {x._pyha_type()};'
                         for i, x in enumerate(self.get_object_return()))

    def make_output_type_conversions(self) -> str:
        return ''.join(x._pyha_convert_to_stdlogic(f'out{i}', f'var_out{i}')
                       for i, x in enumerate(self.get_object_return()))

    def make_input_variables(self) -> str:
        return '\n'.join(f'variable var_in{i}: {x._pyha_type()};'
                         for i, x in enumerate(self.get_object_inputs()))

    def make_input_type_conversions(self) -> str:
        return ''.join(x._pyha_convert_from_stdlogic(f'var_in{i}', f'in{i}')
                       for i, x in enumerate(self.get_object_inputs()))

    def make_imports(self) -> str:
        return textwrap.dedent("""\
            library ieee;
                use ieee.std_logic_1164.all;
                use ieee.numeric_std.all;
                use ieee.fixed_pkg.all;
                use ieee.math_real.all;

            library work;
                use work.PyhaUtil.all;
                use work.Typedefs.all;
                use work.all;""")

    def object_class_name(self) -> str:
        # make sure we escape reserved names
        mod = VHDLModule('-', self.simulated_object)
        return mod._pyha_module_name()

    def make_call_arguments(self) -> str:

        input_args = ', '.join(f'var_in{i}'
                               for i, _ in enumerate(self.get_object_args()))
        ofs = len(self.get_object_args())
        input_kwargs = ', '.join(f'{x._pyha_name()}=>var_in{i + ofs}'
                                 for i, x in enumerate(self.get_object_kwargs()))

        inputs = ', '.join([input_args, input_kwargs]) if len(self.get_object_kwargs()) else input_args

        outputs = ', '.join(f'ret_{i}=>var_out{i}'
                            for i, _ in enumerate(self.get_object_return()))

        return ', '.join([inputs, outputs])

    def make(self):

        # http://stackoverflow.com/questions/8782630/how-to-detect-compiler
        template = textwrap.dedent("""\
                {FILE_HEADER}
                {IMPORTS}

                entity  top is
                    port (
                        clk, rst_n: in std_logic;
                        
                        -- look #153 if you want enable
                        -- enable: in std_logic;

                        -- inputs
                {ENTITY_INPUTS}

                        -- outputs
                {ENTITY_OUTPUTS}
                    );
                end entity;

                architecture arch of top is
                    -- make reset procedure callable
                    function init_regs return {DUT_NAME}.self_t is
                        variable self: {DUT_NAME}.self_t;
                    begin
                          {DUT_NAME}.\_pyha_reset\(self);
                          return self;
                    end function;

                    signal self: {DUT_NAME}.self_t := init_regs;
                begin
                    process(clk, rst_n)
                        variable self_var: {DUT_NAME}.self_t;
                        -- input variables
                {INPUT_VARIABLES}

                        --output variables
                {OUTPUT_VARIABLES}

                    begin
                        self_var := self;

                        --convert slv to normal types
                {INPUT_TYPE_CONVERSIONS}

                        --call the main entry
                        {DUT_NAME}.\\_pyha_init\\(self_var);
                        {DUT_NAME}.\\_pyha_reset_constants\\(self_var);
                        {DUT_NAME}.main(self_var, {CALL_ARGUMENTS});

                        --convert normal types to slv
                {OUTPUT_TYPE_CONVERSIONS}


                        if (not rst_n) then
                            {DUT_NAME}.\\_pyha_reset\\(self_var);
                            self <= self_var;
                        elsif rising_edge(clk) then
                            -- look #153 if you want enable
                            --if enable then
                                {DUT_NAME}.\\_pyha_update_registers\\(self_var);
                                {DUT_NAME}.\\_pyha_reset_constants\\(self_var);
                                self <= self_var;
                            --end if;
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
        sockets['INPUT_TYPE_CONVERSIONS'] = tab(self.make_input_type_conversions())
        sockets['OUTPUT_TYPE_CONVERSIONS'] = tab(self.make_output_type_conversions())
        sockets['CALL_ARGUMENTS'] = self.make_call_arguments()

        res = template.format(**sockets)

        return res
