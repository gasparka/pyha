import os
import shutil

from pathlib import Path

import subprocess

try:
    quartus_path = Path(shutil.which('quartus'))
except:
    raise Exception('You dont have Quartus in PATH!')

try:
    ghdl_path = Path(shutil.which('ghdl'))
except:
    raise Exception('You dont have GHDL in PATH!')


sim_libs = quartus_path.parent.parent / 'eda' / 'sim_lib'

base = Path(__file__).parent.parent
script_path = ghdl_path.parent.parent / 'lib/ghdl/vendors/compile-altera.sh'
output_path = ghdl_path.parent.parent / 'lib/ghdl/'

subprocess.run([script_path, '-a', '--src',  sim_libs], cwd=output_path, check=True)


