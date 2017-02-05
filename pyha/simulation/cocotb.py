import logging
import os
import shutil
import subprocess
import sys
from pathlib import Path

import numpy as np

import pyha
from pyha.common.sfix import Sfix, ComplexSfix

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


# def std_logic_conversions(func):
#     """ Convert input data to std_logic and output data to 'normal types' (sfix for example) """
#     def to_std_logic(x):
#         if isinstance(x, (Sfix, ComplexSfix)):
#             return x.fixed_value()
#         else:
#             return x
#     @wraps(func)
#     def wrap(self, *args):
#         input_data = np.vectorize(to_std_logic)(args)
#
#         ret = func(self, *input_data)
#         return ret
#
#     return wrap


class CocotbAuto(object):
    def __init__(self, base_path, src, outputs, sim_folder='coco_sim'):
        self.logger = logging.getLogger(__name__)
        self.outputs = outputs
        self.src = src
        self.base_path = base_path
        self.sim_folder = sim_folder

        self.environment = os.environ.copy()
        self.default_assignments()

    def default_assignments(self):
        self.environment['COCOTB'] = pyha.__path__[0] + '/../cocotb'

        # this line is called 'i hate cocotb'
        # ill throw my computer out of the window counter: 6
        self.environment["PYTHONHOME"] = str(Path(sys.executable).parent.parent)

        self.environment['SIM_BUILD'] = self.sim_folder
        self.environment['TOPLEVEL_LANG'] = 'vhdl'
        self.environment['SIM'] = 'ghdl'

        self.environment['GHDL_OPTIONS'] = '--std=08'  # TODO: push PR to cocotb

        if len(self.src) == 1:  # one file must be quartus netlist, need to simulate in 93 mode
            altera_libs = pyha.__path__[0] + '/common/hdl/altera'
            self.environment[
                'GHDL_OPTIONS'] = '-P' + altera_libs + ' --ieee=synopsys --no-vital-checks'  # TODO: push PR to cocotb

        self.environment["PYTHONPATH"] = str(self.base_path)

        self.environment['TOPLEVEL'] = 'top'
        self.environment['MODULE'] = 'cocotb_simulation_top'

        self.environment['VHDL_SOURCES'] = ' '.join(str(x) for x in self.src)

        # copy cocotb simulation top file
        coco_py = pyha.__path__[0] + '/simulation/cocotb_simulation_top.py'
        shutil.copyfile(coco_py, str(self.base_path / Path(coco_py).name))
        self.environment['OUTPUT_VARIABLES'] = str(len(self.outputs))

    # @std_logic_conversions
    def run(self, *input_data):
        self.logger.info('Running COCOTB simulation....')
        # # convert all Sfix elements to 'integer' form
        input_data = np.vectorize(
            lambda x: x.fixed_value() if isinstance(x, (Sfix, ComplexSfix)) else x)(input_data)

        np.save(str(self.base_path / 'input.npy'), input_data)

        # write makefile template
        with (self.base_path / 'Makefile').open('w') as f:
            f.write(COCOTB_MAKEFILE_TEMPLATE)

        try:
            subprocess.run("make", env=self.environment, cwd=str(self.base_path), check=True)
            pass
        except subprocess.CalledProcessError as err:
            print('GHDL failed!')
            import os
            os._exit(-1)

        outp = np.load(str(self.base_path / 'output.npy'))
        outp = outp.astype(object)
        # outp = outp.astype(complex)

        # FIXME: fix this retarded solution, combien with Sfix to 'integer'part and implement in decorator, maybe after transpose decorator!
        # convert 'integer' form back to Sfix
        outp = np.transpose(outp)

        def getSignedNumber(number, bitLength):
            # http://stackoverflow.com/questions/1375897/how-to-get-the-signed-integer-value-of-a-long-in-python
            mask = (2 ** bitLength) - 1
            if number & (1 << (bitLength - 1)):
                return number | ~mask
            else:
                return number & mask

        for i, row in enumerate(outp):
            for j, val in enumerate(row):
                if isinstance(self.outputs[i], bool):
                    outp[i][j] = bool(int(val))
                elif isinstance(self.outputs[i], int):
                    val = getSignedNumber(int(val, 2), 32)
                    outp[i][j] = val
                elif not isinstance(self.outputs[i], list):
                    val = getSignedNumber(int(val, 2), len(self.outputs[i]))


                if isinstance(self.outputs[i], Sfix):
                    outp[i][j] = (val * 2 ** self.outputs[i].right)
                elif isinstance(self.outputs[i], ComplexSfix):
                    val = int(val.real)
                    mask = (2 ** (self.outputs[i].bitwidth() // 2)) - 1
                    real = (val >> (self.outputs[i].bitwidth() // 2))
                    real = getSignedNumber(real & mask, self.outputs[i].bitwidth() // 2)
                    real *= 2 ** self.outputs[i].right

                    imag = getSignedNumber(val & mask, self.outputs[i].bitwidth() // 2)
                    imag *= 2 ** self.outputs[i].right
                    outp[i][j] = real + imag * 1j
                elif isinstance(self.outputs[i], list) and isinstance(self.outputs[i][0], bool):
                    v = np.array([bool(int(x)) for x in val])
                    outp[i][j] = v
                    pass

        outp = np.squeeze(outp)  # example [[1], [2], [3]] -> [1, 2, 3]
        outp = np.transpose(outp)

        return outp
