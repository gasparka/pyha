import os
from collections import OrderedDict


# mostly stolen from POC


class QuartusException(Exception):
    pass


class QuartusProject(object):
    def __init__(self, name, path):
        self.name = name
        self.path = path
        self.source_files = []
        self.assignments = OrderedDict()

        self.default_assignments()

    def default_assignments(self):
        self.assignments['FAMILY'] = '"Cyclone V"'
        self.assignments['DEVICE'] = '5CEBA7F27C7'
        self.assignments['TOP_LEVEL_ENTITY'] = 'top'
        self.assignments['PROJECT_OUTPUT_DIRECTORY'] = '-section_id eda_simulation'
        self.assignments['VHDL_INPUT_VERSION'] = 'VHDL_2008'
        self.assignments['VHDL_SHOW_LMF_MAPPING_MESSAGES'] = 'OFF'
        self.assignments['EDA_GENERATE_FUNCTIONAL_NETLIST'] = 'ON -section_id eda_simulation'

    def make(self):
        buffer = ""
        for key, value in self.assignments.items():
            buffer += "set_global_assignment -name {key} {value!s}\n".format(key=key, value=value)

        buffer += "\n"
        for file in self.source_files:
            if not os.path.isfile(file):
                raise QuartusException("Cannot add '{0!s}' to Quartus settings file.".
                                       format(file)) from FileNotFoundError(file)
            buffer += "set_global_assignment -name VHDL_FILE {}\n".format(file)

        with open(self.path + self.name, 'w') as f:
            f.write(buffer)


d = QuartusProject('qpro.qsf', './')
d.source_files += ['../common/hdl/fixed_pkg/fixed_pkg_c.vhd']
d.source_files += ['../common/hdl/fixed_pkg/fixed_float_types_c.vhd']
d.make()
