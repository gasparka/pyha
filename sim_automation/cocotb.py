import os
import subprocess
from contextlib import suppress

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
    def __init__(self, base_path, sim_folder='coco_sim', test_file='hdl_tests', top_level_entity='top_sv'):
        self.top_level_entity = top_level_entity
        self.test_file = test_file
        self.base_path = base_path
        self.sim_folder = sim_folder
        self.path = base_path / 'Makefile'
        if not base_path.exists():
            base_path.mkdir()

        with suppress(Exception):
            (base_path / sim_folder / 'results.xml').unlink()

        self.vhdl_source_files = []
        self.verilog_source_files = []
        self.environment = os.environ.copy()

        self.default_assignments()
        # self.default_files()

    def default_assignments(self):
        # TODO: cocotb should probably be submodule
        # FIXME: hardcoded paths
        self.environment['COCOTB'] = '~/git/cocotb/'
        self.environment["PYTHONHOME"] = "/home/gaspar/programs/anaconda2_32"
        self.environment["PATH"] = "/home/gaspar/programs/anaconda2_32/bin:" + self.environment["PATH"]

        self.environment['SIM_BUILD'] = self.sim_folder
        self.environment['TOPLEVEL_LANG'] = 'verilog'
        self.environment['SIM'] = 'modelsim'
        self.environment['ARCH'] = 'i686'

        # this is needed for gate level sim
        # FIXME: this creates the last line error
        # if using makefile argument:
        # vsim -t ps -onfinish exit -pli "libvpi.so" work.top_sv
        # but python var yields:
        # vsim -t ps -onfinish exit -pli "libvpi.so" -pli "libvpi.so" work.top_sv
        self.environment['VSIM_ARGS'] = "-t ps"
        self.environment['VCOM_ARGS'] = '-2008'

        # this path is quite fucked up
        self.environment["PYTHONPATH"] = str(self.base_path.parent) + ':' + self.environment["PYTHONPATH"]

        self.environment['TOPLEVEL'] = self.top_level_entity
        self.environment['MODULE'] = self.test_file

        self.environment['VHDL_SOURCES'] = ''
        self.environment['VERILOG_SOURCES'] = ''


    def run(self):
        for file in self.vhdl_source_files:
            if not file.is_file():
                raise Exception("Cannot add '{0!s}'".format(file)) from FileNotFoundError(file)
            self.environment['VHDL_SOURCES'] += str(file) + ' '

        for file in self.verilog_source_files:
            if not file.is_file():
                raise Exception("Cannot add '{0!s}'".format(file)) from FileNotFoundError(file)
            self.environment['VERILOG_SOURCES'] += str(file)

        # write makefile template
        with self.path.open('w') as f:
            f.write(COCOTB_MAKEFILE_TEMPLATE)

        make_process = subprocess.call("make", env=self.environment, cwd=str(self.base_path))
        assert make_process == 0

        # check that all tests passed
        resf = self.base_path / self.sim_folder / 'results.xml'
        with resf.open('r') as f:
            assert f.read().find('failure') == -1