import logging
import subprocess
from pathlib import Path

import pyha
from pyha import common
from pyha.conversion.conversion import Conversion
from pyha.simulation.cocotb import CocotbAuto


class SimProvider:
    def __init__(self, base_path, model, sim_type, copy_sources_dst='/home/gaspar/git/pyha/playground'):
        self.logger = logging.getLogger(__name__)
        self.copy_sources_dst = copy_sources_dst  # copy tmp dir of all sources to here
        self.sim_type = sim_type
        self.base_path = base_path
        self.model = model
        self.conv = Conversion(self.model)

    def get_conversion_sources(self):
        src = [pyha.__path__[0] + '/common/hdl/pyha_util.vhd']
        src += self.conv.write_vhdl_files(self.base_path)
        return src

    def main(self):
        from pyha.simulation.simulation_interface import SIM_GATE
        src = self.get_conversion_sources()
        if self.sim_type == SIM_GATE:
            self.make_quartus_project()
            vho = self.make_quartus_netlist()
            src = [str(vho)]
            # src = ['/home/gaspar/git/pyha/playground/conv/simulation/modelsim/quartus_project.vho']

        return CocotbAuto(self.base_path, src, self.conv.outputs)

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

        common_path = Path(common.__file__).parent / 'hdl/fixed_pkg/'
        src = [common_path / 'fixed_pkg_c.vhd', common_path / 'fixed_float_types_c.vhd']
        src += self.get_conversion_sources()

        buffer = ""
        for key, value in rules.items():
            buffer += f"set_global_assignment -name {key} {value!s}\n"

        buffer += "\n"
        for file in src:
            buffer += f"set_global_assignment -name VHDL_FILE {file}\n"

        outpath = self.base_path / 'quartus_project.qsf'
        with outpath.open('w') as f:
            f.write(buffer)

        # this is just useless project file, enables opening from IDE
        outpath = self.base_path / 'quartus_project.qpf'
        with outpath.open('w') as f:
            f.write('PROJECT_REVISION = "quartus_project"')

    def make_quartus_netlist(self):
        self.logger.info('Running quartus map...will take time.')
        make_process = subprocess.call(['quartus_map', 'quartus_project'], cwd=str(self.base_path))
        assert make_process == 0

        self.logger.info('Running netlist writer.')
        make_process = subprocess.call(['quartus_eda', 'quartus_project'], cwd=str(self.base_path))
        assert make_process == 0

        return self.base_path / 'simulation/modelsim/quartus_project.vho'
