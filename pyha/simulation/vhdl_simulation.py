import logging
import os
import shutil
import subprocess
from pathlib import Path

import numpy as np

import pyha
from pyha.conversion.conversion import Conversion
from pyha.conversion.python_types_vhdl import init_vhdl_type

logger = logging.getLogger('sim')


def quartus_map(cwd):
    logger.info('Running quartus map...will take time.')

    cmd = f"docker run -v /sys:/sys:ro -v {str(cwd)[:-8]}:/pyha_simulation -w='/pyha_simulation/quartus' gasparka/pyha_simulation_env quartus_map quartus_project"

    # print(cmd)
    # subprocess.run(['quartus_map', 'quartus_project'], cwd=cwd)
    result = subprocess.run(cmd, shell=True)


def quartus_eda(cwd):
    logger.info('Running netlist writer.')
    # subprocess.run(['quartus_eda', 'quartus_project'], cwd=cwd)

    cmd = f"docker run -v /sys:/sys:ro -v {str(cwd)[:-8]}:/pyha_simulation -w='/pyha_simulation/quartus' gasparka/pyha_simulation_env quartus_eda quartus_project"

    result = subprocess.run(cmd, shell=True)

class VHDLSimulation:
    last_logic_elements = 0
    last_memory_bits = 0
    last_multiplier = 0

    def __init__(self, base_path, model, sim_type, make_files_only=False):
        self.sim_type = sim_type
        self.base_path = base_path

        self.src_path = self.base_path / 'src'
        self.quartus_path = self.base_path / 'quartus'
        self.src_util_path = self.src_path / 'util'

        if not self.src_path.exists():
            os.makedirs(self.src_path)

        if not self.quartus_path.exists():
            os.makedirs(self.quartus_path)

        if not self.src_util_path.exists():
            os.makedirs(self.src_util_path)

        self.model = model
        self.conv = Conversion(self.model)

        src = self.get_conversion_sources()

        self.make_quartus_project()
        if not make_files_only:
            if self.sim_type == 'GATE':
                vho = self.make_quartus_netlist()
                src = [str(vho)]

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
            # copy FPHDL dependencies to src - these are only neede by quartus
            fphdl_path = Path(pyha.__path__[0] + '/simulation/fphdl')
            shutil.copyfile(sim_inc / 'fixed_pkg_c.vhdl', self.src_util_path / 'fixed_pkg_c.vhdl')
            shutil.copyfile(sim_inc / 'fixed_float_types_c.vhdl', self.src_util_path / 'fixed_float_types_c.vhdl')
            src += [self.src_util_path / 'fixed_pkg_c.vhdl', self.src_util_path / 'fixed_float_types_c.vhdl']

        return src

    def main(self, *input_data):
        return self.cocoauto.run(*input_data)

    def make_quartus_project(self):
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

        src = self.get_conversion_sources()

        buffer = ""
        for key, value in rules.items():
            buffer += f"set_global_assignment -name {key} {value!s}\n"

        def to_relative_path(x):
            return '../src/' + str(file)[len(str(self.src_path)):]

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

    def make_quartus_netlist(self):
        quartus_map(self.quartus_path)

        # extract resource usage
        result = open(str(self.quartus_path) + '/output_files/quartus_project.map.summary').readlines()
        for l in result:
            logger.info(l[:-1])

        try:
            VHDLSimulation.last_logic_elements = int(result[5][result[5].find(':') + 1:-1].replace(',', ''))
            VHDLSimulation.last_memory_bits = int(result[11][result[11].find(':') + 1:-1].replace(',', ''))
            VHDLSimulation.last_multiplier = int(result[12][result[12].find(':') + 1:-1].replace(',', ''))
        except:
            pass

        quartus_eda(self.quartus_path)
        return self.quartus_path / 'simulation/modelsim/quartus_project.vho'


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

        # this is some cocotb bullshit that sometimes causes troubles
        # ill throw my computer out of the window counter: 12
        self.environment['COCOTB'] = pyha.__path__[0] + '/../cocotb'
        import sys
        if not is_virtual() or ('CI' in self.environment and self.environment['CI']):  # inside virtualenv??
            self.environment["PYTHONHOME"] = str(
                Path(sys.executable).parent.parent)  # on some computers required.. on some fucks up the build
            # print(f'\n\nSetting "PYTHONHOME" = {self.environment["PYTHONHOME"]}, because virtualenv is not active ('
            #       f'this is COCOTB related bullshit) - it may actually break your build\n\n')

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
              f" -v {self.base_path}:/pyha_simulation gasparka/pyha_rtl_simulator make " \
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
