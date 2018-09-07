import logging
import os
import shutil
import subprocess
from pathlib import Path

import numpy as np

import pyha
from pyha.conversion.conversion import RecursiveConverter
from pyha.conversion.python_types_vhdl import init_vhdl_type

logger = logging.getLogger('sim')


class QuartusHelper:
    def __init__(self, project_path, project_name='quartus_project', silent=False):
        self.silent = silent
        self.project_name = project_name
        self.project_path = os.path.expanduser(project_path)

    def _run_quartus_docker(self, quartus_command):
        cmd = f"docker run " \
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


class VHDLSimulation:
    def __init__(self, base_path, model, sim_type, make_files_only=False):
        self.sim_type = sim_type
        self.base_path = base_path

        self.src_path = self.base_path / 'src'
        self.quartus_path = self.base_path
        self.src_util_path = self.src_path / 'util'

        self.quartus = QuartusHelper(self.base_path, 'quartus_project', silent=True)

        if not self.src_path.exists():
            os.makedirs(self.src_path)

        if not self.quartus_path.exists():
            os.makedirs(self.quartus_path)

        if not self.src_util_path.exists():
            os.makedirs(self.src_util_path)

        self.model = model
        self.conv = RecursiveConverter(self.model)

        src = self.get_conversion_sources()

        self.make_quartus_project()
        if not make_files_only:
            if self.sim_type == 'GATE':
                logger.info('Generating quartus netlist...')
                self.quartus.map()
                self.quartus.eda()
                src = [self.quartus.get_netlist_path()]

            self.cocoauto = CocotbAuto(self.base_path, src, self.conv)

    def get_conversion_sources(self):
        # NB! order of files added to src matters!
        sim_inc = Path(pyha.__path__[0] + '/simulation/sim_include')
        shutil.copyfile(sim_inc / 'complex.vhdl',
                        self.src_util_path / 'complex.vhdl')
        src = [self.src_util_path / 'complex.vhdl']

        # copy pyha_util to src dir
        shutil.copyfile(sim_inc / 'pyha_util.vhdl',
                        self.src_util_path / 'pyha_util.vhdl')
        src += [self.src_util_path / 'pyha_util.vhdl']

        # write typedefs file
        src += [self.src_util_path / 'typedefs.vhdl']
        with src[-1].open('w') as f:
            f.write(self.conv.build_typedefs_package())

        # add all conversion files as src
        src += self.conv.write_vhdl_files(self.src_path)

        if self.sim_type == 'GATE':
            shutil.copyfile(sim_inc / 'fixed_pkg_c.vhdl', self.src_util_path / 'fixed_pkg_c.vhdl')
            shutil.copyfile(sim_inc / 'fixed_float_types_c.vhdl', self.src_util_path / 'fixed_float_types_c.vhdl')
            src += [self.src_util_path / 'fixed_pkg_c.vhdl', self.src_util_path / 'fixed_float_types_c.vhdl']

        return src

    def main(self, *input_data):
        return self.cocoauto.run(*input_data)

    def make_quartus_project(self):
        rules = {}
        rules['DEVICE'] = 'EP4CE40F23C8'  # tried to change this to MAX10 but GATE simulation breaks (encrypted cores not usable in GHDL)
        rules['TOP_LEVEL_ENTITY'] = 'top'
        rules['PROJECT_OUTPUT_DIRECTORY'] = 'output_files'

        # EDA generation not working without this
        rules['EDA_SIMULATION_TOOL'] = '"ModelSim-Altera (VHDL)"'

        rules['EDA_GENERATE_FUNCTIONAL_NETLIST'] = 'ON -section_id eda_simulation'
        rules['VHDL_INPUT_VERSION'] = 'VHDL_2008'
        rules['VHDL_SHOW_LMF_MAPPING_MESSAGES'] = 'OFF'

        src = self.get_conversion_sources()

        buffer = ""
        for key, value in rules.items():
            buffer += f"set_global_assignment -name {key} {value!s}\n"

        def to_relative_path(x):
            return './src/' + str(x)[len(str(self.src_path)):]

        buffer += "\n"
        for file in src:
            buffer += f"set_global_assignment -name VHDL_FILE {to_relative_path(file)}\n"

        outpath = self.quartus_path / 'quartus_project.qsf'
        with outpath.open('w') as f:
            f.write(buffer)

        # this is just useless project file, enables opening from IDE
        outpath = self.quartus_path / 'quartus_project.qpf'
        with outpath.open('w') as f:
            f.write('PROJECT_REVISION = "quartus_project"')


def is_virtual():
    """ Return if we run in a virtual environtment. """
    # Check supports venv && virtualenv
    import sys
    return (getattr(sys, 'base_prefix', sys.prefix) != sys.prefix or
            hasattr(sys, 'real_prefix'))


class CocotbAuto:
    def __init__(self, base_path, src, conversion, sim_folder='coco_sim'):
        self.conversion = conversion
        self.src = src
        self.base_path = base_path
        self.sim_folder = sim_folder

        self.environment = os.environ.copy()
        self.setup_environment()

    def setup_environment(self):
        self.environment['SIM_BUILD'] = self.sim_folder
        self.environment['TOPLEVEL_LANG'] = 'vhdl'
        self.environment['SIM'] = 'ghdl'

        self.environment['GHDL_ARGS'] = '--std=08'

        if len(self.src) == 1:  # one file must be quartus netlist, need to simulate in 93 mode
            self.environment['GHDL_ARGS'] = '-P/quartus_sim_lib/ --ieee=synopsys --no-vital-checks'

        self.environment["PYTHONPATH"] = str(self.base_path)

        self.environment['TOPLEVEL'] = 'top'
        self.environment['MODULE'] = 'cocotb_simulation_top'

        srcstr = [str(x) for x in self.src]
        self.environment['VHDL_SOURCES'] = ' '.join('.' + x[len(str(self.base_path)):] for x in srcstr)

        # copy cocotb simulation top file
        coco_py = pyha.__path__[0] + '/simulation/sim_include/cocotb_simulation_top.py'
        shutil.copyfile(coco_py, str(self.base_path / Path(coco_py).name))

        # copy cocotb makefile
        coco_py = pyha.__path__[0] + '/simulation/sim_include/Makefile'
        shutil.copyfile(coco_py, str(self.base_path / Path(coco_py).name))

        self.environment['OUTPUT_VARIABLES'] = str(len(self.conversion.outputs))

    def run(self, *input_data):
        logger.info('Running COCOTB & GHDL simulation....')

        indata = []
        for arguments in input_data:
            if len(arguments) == 1:
                l = [init_vhdl_type('-', arguments[0], arguments[0])._pyha_serialize()]
            else:
                l = [init_vhdl_type('-', arg, arg)._pyha_serialize() for arg in arguments]
            indata.append(l)

        np.save(str(self.base_path / 'input.npy'), indata)

        # make sure output file does not exist
        out_path = str(self.base_path / 'output.npy')
        if os.path.exists(out_path):
            os.remove(out_path)

        # self.environment['VHDL_SOURCES'] = [x[x.find('/src'):] for x in self.src]

        # result = subprocess.run("make", env=self.environment, cwd=str(self.base_path), stderr=subprocess.PIPE)
        cmd = f"docker run " \
              f"-u `id -u` " \
              f" -v {self.base_path}:/pyha_simulation gasparka/pyha_simulation_env make " \
              f"VHDL_SOURCES=\"{self.environment['VHDL_SOURCES']}\" " \
              f"OUTPUT_VARIABLES=\"{str(len(self.conversion.outputs))}\" " \
              f"GHDL_ARGS=\"{self.environment['GHDL_ARGS']}\" "

        result = subprocess.run(cmd, shell=True)

        # if result.returncode != 0:
        #     msg = f'Build with GHDL/Cocotb failed:\n{tabber(result.stderr.decode())}'
        #     logger.error(msg)
        #     # logger.info(f'VHDL stdout: \n{tabber(result.stdout.decode())}')
        #     raise Exception(msg)

        # print(result.stdout.decode())
        # logger.info(f'VHDL stdout: \n{tabber(result.stdout.decode())}')

        # logger.info(f'VHDL stderr: \n{tabber(result.stderr.decode())}')
        # print(result.stderr.decode())

        out = np.load(out_path)
        outp = out.astype(object).T

        for i, row in enumerate(outp):
            for j, val in enumerate(row):
                outp[i][j] = self.conversion.outputs[i]._pyha_deserialize(val)

        outp = np.squeeze(outp)  # example [[1], [2], [3]] -> [1, 2, 3]
        outp = outp.T.tolist()

        # convert second level lists to tuples if dealing with 'multiple returns'
        if len(self.conversion.outputs) > 1:
            for i, row in enumerate(outp):
                try:
                    outp[i] = tuple(outp[i])
                except TypeError:  # happend when outp[i] is single float
                    outp[i] = [outp[i]]

        return outp
