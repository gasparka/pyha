import logging
import os
import shutil
import subprocess
from pathlib import Path

import numpy as np
import pyha
from pyha.conversion.conversion import Conversion
from pyha.conversion.python_types_vhdl import init_vhdl_type

logger = logging.getLogger('simulation')


class VHDLSimulation:
    def __init__(self, base_path, model, sim_type):
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
        if self.sim_type == 'GATE':
            self.make_quartus_project()
            vho = self.make_quartus_netlist()
            src = [str(vho)]

        self.cocoauto = CocotbAuto(self.base_path, src, self.conv)

    def get_conversion_sources(self):
        # NB! order of files added to src matters!

        # copy pyha_util to src dir
        shutil.copyfile(pyha.__path__[0] + '/simulation/sim_include/pyha_util.vhdl',
                        self.src_util_path / 'pyha_util.vhdl')
        src = [self.src_util_path / 'pyha_util.vhdl']

        # write typedefs file
        src += [self.src_util_path / 'typedefs.vhdl']
        with src[-1].open('w') as f:
            f.write(self.conv.build_typedefs_package())

        # add all conversion files as src
        src += self.conv.write_vhdl_files(self.src_path)

        if self.sim_type == 'GATE':
            # copy FPHDL dependencies to src - these are only neede by quartus
            fphdl_path = Path(pyha.__path__[0]) / '../fphdl'
            shutil.copyfile(fphdl_path / 'fixed_pkg_c.vhdl', self.src_util_path / 'fixed_pkg_c.vhdl')
            shutil.copyfile(fphdl_path / 'fixed_float_types_c.vhdl', self.src_util_path / 'fixed_float_types_c.vhdl')
            src += [self.src_util_path / 'fixed_pkg_c.vhdl', self.src_util_path / 'fixed_float_types_c.vhdl']

        return src

    def main(self, *input_data):
        return self.cocoauto.run(*input_data)

    def make_quartus_project(self):
        rules = {}
        rules['DEVICE'] = 'EP4CE40F23C8'
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

        buffer += "\n"
        for file in src:
            buffer += f"set_global_assignment -name VHDL_FILE {file}\n"

        outpath = self.quartus_path / 'quartus_project.qsf'
        with outpath.open('w') as f:
            f.write(buffer)

        # this is just useless project file, enables opening from IDE
        outpath = self.quartus_path / 'quartus_project.qpf'
        with outpath.open('w') as f:
            f.write('PROJECT_REVISION = "quartus_project"')

    def make_quartus_netlist(self):
        logger.info('Running quartus map...will take time.')
        make_process = subprocess.call(['quartus_map', 'quartus_project'], cwd=self.quartus_path)
        assert make_process == 0

        logger.info('Running netlist writer.')
        make_process = subprocess.call(['quartus_eda', 'quartus_project'], cwd=self.quartus_path)
        assert make_process == 0

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

        # ill throw my computer out of the window counter: 10
        self.environment['COCOTB'] = pyha.__path__[0] + '/../cocotb'

        # this is some cocotb bullshit that sometimes causes troubles
        # ill throw my computer out of the window counter: 10
        import sys
        if not is_virtual() or ('CI' in self.environment and self.environment['CI']):  # inside virtualenv??
            self.environment["PYTHONHOME"] = str(
                Path(sys.executable).parent.parent)  # on some computers required.. on some fucks up the build
            print(f'\n\nSetting "PYTHONHOME" = {self.environment["PYTHONHOME"]}, because virtualenv is not active ('
                  f'this is COCOTB related bullshit) - it may actually break your build\n\n')

        self.environment['SIM_BUILD'] = self.sim_folder
        self.environment['TOPLEVEL_LANG'] = 'vhdl'
        self.environment['SIM'] = 'ghdl'

        self.environment['GHDL_ARGS'] = '--std=08'

        if len(self.src) == 1:  # one file must be quartus netlist, need to simulate in 93 mode
            ghdl_path = Path(shutil.which('ghdl'))
            altera_libs = str(ghdl_path.parent.parent / 'lib/ghdl/altera')
            self.environment['GHDL_ARGS'] = '-P' + altera_libs + ' --ieee=synopsys --no-vital-checks'

        self.environment["PYTHONPATH"] = str(self.base_path)

        self.environment['TOPLEVEL'] = 'top'
        self.environment['MODULE'] = 'cocotb_simulation_top'

        self.environment['VHDL_SOURCES'] = ' '.join(str(x) for x in self.src)

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

        try:
            subprocess.run("make", env=self.environment, cwd=str(self.base_path), check=True)
        except subprocess.CalledProcessError as err:
            raise Exception(
                'Build with GHDL/Cocotb failed. See the converted sources for possible errors (run out of Notebook to actually see stdout and GHDL errors...)')

        out = np.load(str(self.base_path / 'output.npy'))
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
