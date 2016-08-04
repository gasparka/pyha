PACKAGE_TEMPLATE = """
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.numeric_std.all;
    use ieee.fixed_float_types.all;
    use ieee.fixed_pkg.all;
    use ieee.math_real.all;

library work;
    use work.all;

package {NAME} is
{SELF_T}
{HEADER}
end package;

package body {NAME} is
{BODY}
end package body;

"""

RECORD_TEMPLATE = """
type {NAME} is record
{MEMBERS}
end record;
"""

PROCEDURE_TEMPLATE = """
procedure {NAME}({ARGUMENTS}) is
{VARIABLES}
begin
{BODY}
end procedure;
"""

PROCEDURE_PROTO_TEMPLATE = """
procedure {NAME}({ARGUMENTS});
"""

# RESET_PROTO_TEMPLATE =
#
# RESET_TEMPLATE = """
# procedure reset(self: inout self_t) is
# begin
# {BODY}
# end procedure;
# """

RED_DEF_TEMPLATE = """
def {NAME}({ARGUMENTS}):
{BODY}
"""
