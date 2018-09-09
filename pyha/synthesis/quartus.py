import logging
import os
import shutil
import subprocess
from pathlib import Path

import pyha
from pyha.conversion.conversion import Converter

logger = logging.getLogger('synth')


def make_quartus_project(conversion: Converter):
    rules = {}
    rules[
        'DEVICE'] = 'EP4CE40F23C8'  # tried to change this to MAX10 but GATE simulation breaks (encrypted cores not usable in GHDL)
    rules['TOP_LEVEL_ENTITY'] = 'top'
    rules['PROJECT_OUTPUT_DIRECTORY'] = 'output_files'

    # EDA generation not working without this
    rules['EDA_SIMULATION_TOOL'] = '"ModelSim-Altera (VHDL)"'

    rules['EDA_GENERATE_FUNCTIONAL_NETLIST'] = 'ON -section_id eda_simulation'
    rules['VHDL_INPUT_VERSION'] = 'VHDL_2008'
    rules['VHDL_SHOW_LMF_MAPPING_MESSAGES'] = 'OFF'


    buffer = ""
    for key, value in rules.items():
        buffer += f"set_global_assignment -name {key} {value!s}\n"

    buffer += "\n"
    for file in conversion.get_vhdl_sources_relative():
        buffer += f"set_global_assignment -name VHDL_FILE {file}\n"

    # add fixed-point library files (only needed for Quartus)
    sim_inc = Path(pyha.__path__[0] + '/simulation/sim_include')
    shutil.copyfile(sim_inc / 'fixed_pkg_c.vhdl', conversion.src_util_path / 'fixed_pkg_c.vhdl')
    buffer += f"set_global_assignment -name VHDL_FILE ./src/util/fixed_pkg_c.vhdl\n"
    shutil.copyfile(sim_inc / 'fixed_float_types_c.vhdl', conversion.src_util_path / 'fixed_float_types_c.vhdl')
    buffer += f"set_global_assignment -name VHDL_FILE ./src/util/fixed_float_types_c.vhdl\n"


    outpath = conversion.base_path / 'quartus_project.qsf'
    with outpath.open('w') as f:
        f.write(buffer)

    # this is just useless project file, enables opening from IDE
    outpath = conversion.base_path / 'quartus_project.qpf'
    with outpath.open('w') as f:
        f.write('PROJECT_REVISION = "quartus_project"')


class QuartusDockerWrapper:
    def __init__(self, project_path, project_name='quartus_project', silent=False):
        self.silent = silent
        self.project_name = project_name
        self.project_path = os.path.expanduser(project_path)

    def _run_quartus_docker(self, quartus_command):
        cmd = f"docker run " \
              f"-u `id -u` " \
              f"-v /sys:/sys:ro " \
              f"-v {self.project_path}:/pyha_simulation " \
              f"gasparka/pyha_simulation_env {quartus_command}"
        if self.silent:
            subprocess.run(cmd, shell=True)
        else:
            logger.info(f'Running {quartus_command}...')
            from wurlitzer import sys_pipes
            with sys_pipes():
                subprocess.run(cmd, shell=True)

    def map(self):
        self._run_quartus_docker(f'quartus_map {self.project_name}')

    def fit(self):
        self._run_quartus_docker(f'quartus_fit {self.project_name}')

    def eda(self):
        self._run_quartus_docker(f'quartus_eda {self.project_name}')

    def get_fmax(self):
        # https://www.intel.com/content/www/us/en/programmable/quartushelp/current/index.htm#tafs/tafs/tcl_pkg_sta_ver_1.0_cmd_report_clock_fmax_summary.htm
        tcl = f"""
        project_open {self.project_name}
        create_timing_netlist -model slow
        read_sdc
        update_timing_netlist
        report_clock_fmax_summary -file fmax_result.txt -multi_corner
        """

        with open(self.project_path + '/script.tcl', 'w+') as fp:
            fp.write(tcl)

        self._run_quartus_docker(f'quartus_sta -t script.tcl')
        result = open(self.project_path + f'/fmax_result.txt').read()
        return result

    def get_resource_usage(self, after='map'):
        result = open(self.project_path + f'/output_files/{self.project_name}.{after}.summary').readlines()

        # ignore first lines because they include the date which would break unit-testing
        return ''.join(result[4:])

    def get_netlist_path(self):
        return self.project_path + f'/simulation/modelsim/{self.project_name}.vho'
