import logging
import os
import shutil
import subprocess
import sys
from pathlib import Path

import numpy as np
import pyha
from pyha.conversion.conversion_types import conv_class

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
    def __init__(self, base_path, src, conversion, sim_folder='coco_sim'):
        self.logger = logging.getLogger(__name__)
        self.conversion = conversion
        self.src = src
        self.base_path = base_path
        self.sim_folder = sim_folder

        self.environment = os.environ.copy()
        self.default_assignments()

    def default_assignments(self):

        # ill throw my computer out of the window counter: 8
        self.environment['COCOTB'] = pyha.__path__[0] + '/../cocotb'
        self.environment["PYTHONHOME"] = str(Path(sys.executable).parent.parent) # on some computers required.. on some fucks up the build

        self.environment['SIM_BUILD'] = self.sim_folder
        self.environment['TOPLEVEL_LANG'] = 'vhdl'
        self.environment['SIM'] = 'ghdl'

        self.environment['GHDL_ARGS'] = '--std=08'

        self.environment['PATH'] = pyha.__path__[0] + '/../ghdl/bin/:' + self.environment['PATH']
        print(self.environment['PATH'])
        # try:
        #     ghdl_path = Path(shutil.which('ghdl'))
        # except:
        #     raise Exception('You dont have GHDL in PATH!')

        if len(self.src) == 1:  # one file must be quartus netlist, need to simulate in 93 mode
            try:
                ghdl_path = Path(shutil.which('ghdl'))
            except:
                raise Exception('You dont have GHDL in PATH!')
            altera_libs = str(ghdl_path.parent.parent / 'lib/ghdl/altera')
            # altera_libs = pyha.__path__[0] + '/common/hdl/altera'
            self.environment['GHDL_ARGS'] = '-P' + altera_libs + ' --ieee=synopsys --no-vital-checks'

        self.environment["PYTHONPATH"] = str(self.base_path)

        self.environment['TOPLEVEL'] = 'top'
        self.environment['MODULE'] = 'cocotb_simulation_top'

        self.environment['VHDL_SOURCES'] = ' '.join(str(x) for x in self.src)

        # copy cocotb simulation top file
        coco_py = pyha.__path__[0] + '/simulation/cocotb_simulation_top.py'
        shutil.copyfile(coco_py, str(self.base_path / Path(coco_py).name))
        self.environment['OUTPUT_VARIABLES'] = str(len(self.conversion.outputs))

    def run(self, *input_data):
        self.logger.info('Running COCOTB simulation....')

        indata = []
        for arguments in input_data:
            if len(arguments) == 1:
                l = [conv_class('-', arguments[0], arguments[0])._pyha_serialize()]
            else:
                l = [conv_class('-', arg, arg)._pyha_serialize() for arg in arguments]
            indata.append(l)

        np.save(str(self.base_path / 'input.npy'), indata)

        # write makefile template
        with (self.base_path / 'Makefile').open('w') as f:
            f.write(COCOTB_MAKEFILE_TEMPLATE)

        try:
            subprocess.run("make", env=self.environment, cwd=str(self.base_path), check=True)
            pass
        except subprocess.CalledProcessError as err:
            print('GHDL failed!')
            print(err)
            return []

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
                outp[i] = tuple(outp[i])

        return outp
