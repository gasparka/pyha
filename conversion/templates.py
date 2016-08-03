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
