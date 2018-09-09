import textwrap

from pyha.common.ram import RAM
from pyha.common.util import tabber, formatter, is_constant, const_filter
from pyha.conversion.type_transforms import VHDLModule, init_vhdl_type, VHDLList, escape_reserved_vhdl
from pyha.conversion.redbaron_transforms import file_header

class NotTrainedError(Exception):
    pass


class NoInputsError(Exception):
    pass


class NoOutputsError(Exception):
    pass


class TopGenerator:
    def __init__(self, simulated_object):
        self.simulated_object = simulated_object
        self.simulated_object_vhdl = VHDLModule('-', self.simulated_object)

        # 0 or 1 calls wont propagate register outputs
        if self.simulated_object.main.calls == 0:
            raise NotTrainedError('Top level object must be trained (executed) > 1 times.')

        if len(self.get_object_inputs()) == 0:
            raise NoInputsError('Top level "main" has no inputs (arguments to main).')

        if len(self.get_object_return()) == 0:
            raise NoOutputsError('Top level "main" has no outputs (return values).')

    def get_object_args(self) -> list:
        rets = [init_vhdl_type('-', val, val) for val in self.simulated_object.main.get_arg_types()]
        return rets

    def get_object_kwargs(self) -> list:
        rets = [init_vhdl_type(key, val, val) for key, val in self.simulated_object.main.get_kwarg_types().items()]
        return rets

    def get_object_inputs(self) -> list:
        return self.get_object_args() + self.get_object_kwargs()

    def get_object_return(self) -> list:
        rets = self.simulated_object.main.get_output_types()
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
                use work.complex_pkg.all;
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

    def make_reset(self):
        data = [x._pyha_reset(filter_func=lambda x: not is_constant(x._name)) for x in self.simulated_object_vhdl.elems]
        return formatter(data)

    def make_constants(self):
        data = [x._pyha_reset(filter_func=const_filter) for x in self.simulated_object_vhdl.elems]
        return formatter(data)

    def get_ram_names(self):

        def escape_name(name):
            return escape_reserved_vhdl(name.replace('[', '(').replace(']', ')'))

        def recu(base='', obj=None):
            ret = []
            for elem in obj.elems:
                if isinstance(elem.current, RAM):
                    ret.append(base + escape_name(elem._name))
                elif isinstance(elem, VHDLModule):
                    ret.extend(recu(base + escape_name(elem._name) + '.', elem))
                elif isinstance(elem, VHDLList):
                    ret.extend(recu(base + escape_name(elem._name), elem))
            return ret

        ret = recu('', self.simulated_object_vhdl)
        return ret

    def make_ram_resets(self, rams):
        data = [f'self.{x} <= self.{x};' for x in rams]
        return formatter(data)

    def make_ram_edge(self, rams):
        data = [f'\tself.{name}.data(self_next.{name}.write_address) <= self_next.{name}.write_value;\n' \
                f'\tself.{name}.read_reg <= self.{name}.data(self_next.{name}.read_address);\n\n' for name in rams]

        return formatter(data)

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
                {RESET_COMMANDS}
                          return self;
                    end function;
                    
                    function init_constants return {DUT_NAME}.self_t_const is
                        variable self: {DUT_NAME}.self_t_const;
                    begin
                {INIT_CONSTANTS_COMMANDS}
                          return self;
                    end function;

                    signal self: {DUT_NAME}.self_t := init_regs;
                    constant self_const: {DUT_NAME}.self_t_const := init_constants;
                begin
                    process(clk, rst_n)
                        variable self_next: {DUT_NAME}.self_t;
                        -- input variables
                {INPUT_VARIABLES}

                        --output variables
                {OUTPUT_VARIABLES}

                    begin
                        self_next := self;

                        --convert slv to normal types
                {INPUT_TYPE_CONVERSIONS}

                        --call the main entry
                        {DUT_NAME}.main(self, self_next, self_const, {CALL_ARGUMENTS});

                        --convert normal types to slv
                {OUTPUT_TYPE_CONVERSIONS}


                        if (rst_n = '0') then
                            self <= init_regs;
                {RAM_HOLD_VALUE}
                        elsif rising_edge(clk) then
                            -- look #153 if you want enable
                            --if enable = '1' then
                                self <= self_next;
                                
                {RAM_ON_EDGE}
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
        sockets['RESET_COMMANDS'] = tab(self.make_reset())
        sockets['INIT_CONSTANTS_COMMANDS'] = tab(self.make_constants())
        sockets['OUTPUT_VARIABLES'] = tab(self.make_output_variables())
        sockets['INPUT_TYPE_CONVERSIONS'] = tab(self.make_input_type_conversions())
        sockets['OUTPUT_TYPE_CONVERSIONS'] = tab(self.make_output_type_conversions())
        sockets['CALL_ARGUMENTS'] = self.make_call_arguments()

        # Handle rams.
        # 1. on reset RAMS must keep the old value, or Quartus refuses to infer RAM
        # 2. read and write logic must be in top level 'rising_edge', or Quartus refuses to infer RAM
        rams = self.get_ram_names()
        sockets['RAM_HOLD_VALUE'] = tab(self.make_ram_resets(rams))
        sockets['RAM_ON_EDGE'] = tab(self.make_ram_edge(rams))

        res = template.format(**sockets)

        return res
