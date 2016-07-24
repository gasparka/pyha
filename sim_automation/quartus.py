import logging
import subprocess
from collections import OrderedDict
from pathlib import Path

import common

logger = logging.getLogger(__name__)
class QuartusException(Exception):
    pass


# mostly stolen from POC
class QuartusProject(object):
    def __init__(self, base_path):
        self.name = 'qpro'

        if not base_path.exists():
            base_path.mkdir()

        self.path = base_path / (self.name + '.qsf')
        self.source_files = []
        self.assignments = OrderedDict()

        self.default_assignments()
        self.default_files()

    def default_assignments(self):
        self.assignments['FAMILY'] = '"Cyclone V"'
        self.assignments['DEVICE'] = '5CEBA7F27C7'
        self.assignments['TOP_LEVEL_ENTITY'] = 'top'
        self.assignments['PROJECT_OUTPUT_DIRECTORY'] = 'output_files'

        # EDA generation not working without this
        self.assignments['EDA_SIMULATION_TOOL'] = '"ModelSim-Altera (VHDL)"'

        self.assignments['EDA_GENERATE_FUNCTIONAL_NETLIST'] = 'ON -section_id eda_simulation'
        self.assignments['VHDL_INPUT_VERSION'] = 'VHDL_2008'
        self.assignments['VHDL_SHOW_LMF_MAPPING_MESSAGES'] = 'OFF'

    def default_files(self):
        common_path = Path(common.__file__).parent / 'hdl/fixed_pkg/'
        self.source_files += [common_path / 'fixed_pkg_c.vhd']
        self.source_files += [common_path / 'fixed_float_types_c.vhd']

    def make(self):
        buffer = ""
        for key, value in self.assignments.items():
            buffer += "set_global_assignment -name {key} {value!s}\n".format(key=key, value=value)

        buffer += "\n"
        for file in self.source_files:
            # file = os.path.abspath(file)
            if not file.is_file():
                raise QuartusException("Cannot add '{0!s}' to Quartus settings file.".
                                       format(file)) from FileNotFoundError(file)
            buffer += "set_global_assignment -name VHDL_FILE {}\n".format(file)

        with self.path.open('w') as f:
            f.write(buffer)


def make_gate_vhdl(generated_hdl):
    cwd = generated_hdl.base_path / 'quartus'
    d = QuartusProject(cwd)
    d.source_files.extend(generated_hdl.vhdl_src)
    # no need for verilog top
    d.make()

    logger.info('Running quartus map...will take time.')
    make_process = subprocess.call(['quartus_map', d.name], cwd=str(cwd))
    assert make_process == 0

    logger.info('Running netlist writer.')
    make_process = subprocess.call(['quartus_eda', d.name], cwd=str(cwd))
    assert make_process == 0

    logger.info('Successfully generated gate-level hdl!')
    return cwd / 'simulation/modelsim/qpro.vho'
