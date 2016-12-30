import logging
import subprocess
from collections import OrderedDict
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

        # if not base_path.exists():
        #     base_path.mkdir()
        #
        # self.path = base_path / (self.name + '.qsf')
        #
        # # source files
        # self.source_files = conv.write_vhdl_files(base_path)
        # rules = OrderedDict()
        #
        # self.default_assignments()
        # self.default_files()

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
        # dir_util.copy_tree(str(self.base_path), str(self.copy_sources_dst))
        return CocotbAuto(self.base_path, src, self.conv.outputs)

    def make_quartus_project(self):
        rules = OrderedDict()
        rules['FAMILY'] = '"Cyclone V"'
        rules['DEVICE'] = '5CEBA7F27C7'
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
            buffer += "set_global_assignment -name {key} {value!s}\n".format(key=key, value=value)

        buffer += "\n"
        for file in src:
            buffer += "set_global_assignment -name VHDL_FILE {}\n".format(file)

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

        self.logger.info('Successfully generated gate-level hdl!')
        return self.base_path / 'simulation/modelsim/quartus_project.vho'



            #
            # def make(self):
            #     buffer = ""
            #     for key, value in rules.items():
            #         buffer += "set_global_assignment -name {key} {value!s}\n".format(key=key, value=value)
            #
            #     buffer += "\n"
            #     for file in self.source_files:
            #         buffer += "set_global_assignment -name VHDL_FILE {}\n".format(file)
            #
            #     with self.path.open('w') as f:
            #         f.write(buffer)

# def make_quartus_project(path, conv: Conversion):
#
#
#
# def make_gate_vhdl(generated_hdl):
#     cwd = generated_hdl.base_path / 'quartus'
#     d = QuartusProject(cwd)
#     d.source_files.extend(generated_hdl.vhdl_src)
#     # no need for verilog top
#     d.make()
#
#     logger.info('Running quartus map...will take time.')
#     make_process = subprocess.call(['quartus_map', d.name], cwd=str(cwd))
#     assert make_process == 0
#
#     logger.info('Running netlist writer.')
#     make_process = subprocess.call(['quartus_eda', d.name], cwd=str(cwd))
#     assert make_process == 0
#
#     logger.info('Successfully generated gate-level hdl!')
#     return cwd / 'simulation/modelsim/qpro.vho'
