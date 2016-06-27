import os
import subprocess
from collections import OrderedDict


# mostly stolen from POC
import common


class QuartusException(Exception):
    pass

class QuartusProject(object):
    def __init__(self, base_path):
        self.name = 'qpro'

        if not os.path.exists(base_path):
            os.makedirs(base_path)

        self.path = base_path + self.name + '.qsf'
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
        common_path = os.path.dirname(common.__file__)
        self.source_files += [common_path + '/hdl/fixed_pkg/fixed_pkg_c.vhd']
        self.source_files += [common_path + '/hdl/fixed_pkg/fixed_float_types_c.vhd']

    def make(self):
        buffer = ""
        for key, value in self.assignments.items():
            buffer += "set_global_assignment -name {key} {value!s}\n".format(key=key, value=value)

        buffer += "\n"
        for file in self.source_files:
            file = os.path.abspath(file)
            if not os.path.isfile(file):
                raise QuartusException("Cannot add '{0!s}' to Quartus settings file.".
                                       format(file)) from FileNotFoundError(file)
            buffer += "set_global_assignment -name VHDL_FILE {}\n".format(file)

        with open(self.path, 'w') as f:
            f.write(buffer)


def make_gate_vhdl(base_path, vhdl_sources):
    cwd = base_path
    d = QuartusProject(cwd)
    d.source_files.extend(vhdl_sources)

    d.make()
    make_process = subprocess.call(['quartus_map', d.name], cwd=cwd)
    assert make_process == 0

    make_process = subprocess.call(['quartus_eda', d.name], cwd=cwd)
    assert make_process == 0