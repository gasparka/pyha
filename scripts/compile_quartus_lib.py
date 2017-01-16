import os
import shutil

from pathlib import Path

import subprocess

quartus_path = Path(shutil.which('quartus'))
sim_libs = str(quartus_path.parent.parent / 'eda' / 'sim_lib')

base = Path(__file__).parent.parent
script_path = str(base / 'ghdl/lib/ghdl/vendors/compile-altera.sh')
output_path = str(base / 'pyha/common/hdl/')
os.makedirs(output_path, exist_ok=True)

subprocess.run([script_path, '-a', '--src',  sim_libs], cwd=output_path, check=True)
