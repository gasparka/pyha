import os
import subprocess

import pyha

COCOTB_MAKEFILE_TEMPLATE = """
###############################################################################
# Copyright (c) 2013 Potential Ventures Ltd
# Copyright (c) 2013 SolarFlare Communications Inc
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of Potential Ventures Ltd,
#       SolarFlare Communications Inc nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL POTENTIAL VENTURES LTD BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
###############################################################################
include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim
"""


class CocotbAuto(object):
    def __init__(self, base_path, source_files, sim_folder='coco_sim', test_file='cocotb_testing',
                 top_level_entity='top_sv'):
        self.source_files = source_files
        self.top_level_entity = top_level_entity
        self.test_file = test_file
        self.base_path = base_path
        self.sim_folder = sim_folder

        self.environment = os.environ.copy()

        self.default_assignments()
        # self.default_files()

    def default_assignments(self):
        # TODO: cocotb should probably be submodule
        # FIXME: hardcoded paths
        self.environment['COCOTB'] = pyha.__path__[0] +'/../cocotb'
        # self.environment["PYTHONHOME"] = "/home/gaspar/anaconda3/"

        self.environment['SIM_BUILD'] = self.sim_folder
        self.environment['TOPLEVEL_LANG'] = 'vhdl'
        self.environment['SIM'] = 'ghdl'
        self.environment['GHDL_OPTIONS'] = '--std=08'



        self.environment["PYTHONPATH"] = str(self.source_files.base_path)

        self.environment['TOPLEVEL'] = 'top'
        self.environment['MODULE'] = self.test_file

        self.environment['VHDL_SOURCES'] = ''
        for file in self.source_files.vhdl_src:
            if not file.is_file():
                raise Exception("Cannot add '{0!s}'".format(file)) from FileNotFoundError(file)
            self.environment['VHDL_SOURCES'] += str(file) + ' '

        self.environment['OUTPUT_VARIABLES'] = str(len(self.source_files.output_sfix))

    def run(self, input_data):
        import numpy as np

        np.save(str(self.base_path / 'input.npy'), input_data)

        # write makefile template
        with (self.base_path / 'Makefile').open('w') as f:
            f.write(COCOTB_MAKEFILE_TEMPLATE)

        subprocess.call("make", env=self.environment, cwd=str(self.base_path))

        outp = np.load(str(self.base_path / 'output.npy'))
        return outp
