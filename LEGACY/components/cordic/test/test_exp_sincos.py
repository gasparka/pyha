import logging
import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pytest
from LEGACY.common.memoize import memoize
from LEGACY.components import CORDIC
from LEGACY.components import CORDICKernel
from LEGACY.sim_automation.testing import Testing
from sim_automation.cocotb import CocotbAuto
from sim_automation.quartus import make_gate_vhdl

logger = logging.getLogger(__name__)

base_path = Path(__file__).parent


class HDLStuff(object):
    def __init__(self, base_path, vhdl_src, verilog_src, input_sfix, output_sfix):
        self.output_sfix = output_sfix
        self.input_sfix = input_sfix
        self.base_path = base_path
        self.vhdl_src = vhdl_src
        self.verilog_src = verilog_src


# @pytest.fixture(scope='session')
@memoize
def generated_hdl(tmpdir_factory):
    import shutil

    # tmpdir = tmpdir_factory.mktemp('src') # this returns some retarded path class
    tmpdir = tmpdir_factory  # this returns some retarded path class
    # tmpdir = Path(str(tmpdir))

    # copy cocotb python file to temp folder
    coco_py = '/home/gaspar/git/hwpy/sim_automation/cocotb_testing.py'
    shutil.copyfile(coco_py, str(tmpdir / Path(coco_py).name))

    # not implemented simulate by copying files to tmpdir
    vhdl_src = ['/home/gaspar/git/hwpy/components/cordic/hw/hdl/kernel_rotate/cordickernel.vhd',
                '/home/gaspar/git/hwpy/components/cordic/hw/hdl/kernel_rotate/top.vhd']
    vhdl_src = [Path(shutil.copyfile(x, str(tmpdir / Path(x).name))) for x in vhdl_src]

    verilog_src = ['/home/gaspar/git/hwpy/components/cordic/hw/hdl/kernel_rotate/top.sv']
    verilog_src = [Path(shutil.copyfile(x, str(tmpdir / Path(x).name))) for x in verilog_src]

    from common.sfix import Sfix
    output_sfix = [Sfix(left=2, right=-17)] * 3
    input_sfix = [Sfix(left=2, right=-17)] * 3
    return HDLStuff(tmpdir, vhdl_src, verilog_src, input_sfix, output_sfix)


# @pytest.fixture(scope='session')
@memoize
def gate_hdl(shared_dir):
    from copy import deepcopy
    hdl = deepcopy(generated_hdl(shared_dir))
    gate_vhdl = make_gate_vhdl(hdl)
    hdl.vhdl_src = [gate_vhdl]
    return hdl


@pytest.fixture(scope='session')
def shared_tmpdir(tmpdir_factory):
    tmpdir = tmpdir_factory.mktemp('src')  # this returns some retarded path class
    return Path(str(tmpdir))


@pytest.fixture(scope='function', params=['MODEL', 'HW-MODEL', 'HW-RTL', 'HW-GATE'])
def exp(request, tmpdir, shared_tmpdir):
    from cordic.model.exp import Exp as ModelExp
    from cordic.hw.cordic import Exp as HdlExp
    iterations = 18
    limit = int(os.environ['TEST_DEPTH'])
    if request.param_index > limit:
        pytest.skip('Test not to be included, increase env["TEST_DEPTH"] to run more tests')

    # request.param_index
    if request.param == 'MODEL':
        dut = Testing(request, ModelExp(iterations), None, None)
        return dut

    elif request.param == 'HW-MODEL':
        dut = Testing(request, ModelExp(iterations), HdlExp(iterations), None)
        return dut

    elif request.param == 'HW-RTL':
        src = generated_hdl(shared_tmpdir)
        coco_sim = CocotbAuto(tmpdir, src)
        dut = Testing(request, CORDIC(iterations), CORDICKernel(iterations), coco_sim)
        return dut

    elif request.param == 'HW-GATE':
        src = gate_hdl(shared_tmpdir)
        coco_sim = CocotbAuto(tmpdir, src)
        dut = Testing(request, CORDIC(iterations), CORDICKernel(iterations), coco_sim)
        return dut


@pytest.fixture(scope='function', params=[.25, .50, .75, 1, 2, 4, 8])
def periodfix(request):
    fs = 64
    periods = float(request.param)
    freq = 1
    phase_inc = 2 * np.pi * freq / fs
    phase_list = np.arange(0, periods * fs * phase_inc, phase_inc)
    return phase_list


def test_period(periodfix, exp):
    ref = np.exp(periodfix * 1j)

    res = exp(periodfix * 1j)

    plt.plot(res[0])
    plt.show()
    np.testing.assert_allclose(res[0], ref.real, atol=1e-4)
    np.testing.assert_allclose(res[1], ref.imag, atol=1e-4)


if __name__ == "__main__":
    os.environ['TEST_DEPTH'] = '1'
    pytest.main()
    # python - m vmprof - -web - -web - auth b6955f5be6bb3a7a61587895253f6fd1306d1d42 test_newcoco.py
