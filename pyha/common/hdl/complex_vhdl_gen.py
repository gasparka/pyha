import textwrap

from pyha.common.sfix import ComplexSfix

template = textwrap.dedent("""\
    library ieee;
        use ieee.fixed_pkg.all;

    package ComplexTypes is
    {COMPLEX_TYPES}
    end package;""")

l = []
for left in range(-64, 64, 1):
    for right in range(-64, 64):
        if left <= right or left < 0 or right > 0:
            continue
        d = ComplexSfix(0, left, right)
        l.append(d.vhdl_type_define())


with open('complex_types.vhd', 'w') as f:
    print(template.format(COMPLEX_TYPES='\n'.join(x for x in l)), file=f)