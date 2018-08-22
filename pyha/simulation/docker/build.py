import subprocess
import os
from pathlib import Path

build_dir = str(Path(__file__).parents[0]) + '/'

# subprocess.run(['rm', '-rf', build_dir + '/reduced'])
# subprocess.run(['cp', '-r', '/home/gaspar/intelFPGA_lite/reduced', build_dir])
#
# subprocess.run(['rm', '-rf', build_dir + '/sim_lib'])
# subprocess.run(['cp', '-r', '/home/gaspar/intelFPGA_lite/18.0/quartus/eda/sim_lib', build_dir])
# # TODO: delete useless libs

subprocess.run('docker build -t pyha_simulation .', shell=True)
