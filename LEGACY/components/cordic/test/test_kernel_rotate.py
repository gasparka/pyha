import logging
import os
from pathlib import Path

import numpy as np
import pytest
from LEGACY.common.memoize import memoize
from LEGACY.components import CORDIC
from LEGACY.components import CORDICKernel
from LEGACY.sim_automation.testing import Testing
from sim_automation.cocotb import CocotbAuto
from sim_automation.quartus import make_gate_vhdl

logger = logging.getLogger(__name__)


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


@pytest.fixture(scope='function', params=['MODEL', 'HW-MODEL', 'HW-RTL', 'HW-GATE'])
def kernel(request, tmpdir, shared_tmpdir):
    iterations = 18
    limit = int(os.environ['TEST_DEPTH'])
    if request.param_index > limit:
        pytest.skip('Test not to be included, increase env["TEST_DEPTH"] to run more tests')

    # request.param_index
    if request.param == 'MODEL':
        dut = Testing(request, CORDIC(iterations), None, None)
        return dut

    elif request.param == 'HW-MODEL':
        dut = Testing(request, CORDIC(iterations), CORDICKernel(iterations), None)
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


def test_kernel_first_out_rot(kernel):
    rx, ry, rphase = kernel(1, 1, 0, mode='ROTATE')
    assert np.isclose(rx, [1.6467515412835914], atol=1e-3)
    assert np.isclose(ry, [1.6467689748804477], atol=1e-3)
    assert np.isclose(rphase, [-5.2933e-6], atol=1e-3)


def test_kernel_first_out_rot2(kernel):
    rx, ry, rphase = kernel(0.2, -0.01, np.pi, mode='ROTATE')
    assert np.isclose(rx, [-0.0403], atol=1e-3)
    assert np.isclose(ry, [0.3272], atol=1e-3)
    assert np.isclose(rphase, [1.3983], atol=1e-3)


def test_kernel_rot(kernel):
    x = 1 / 1.646760
    y = 0
    phase = 0.5
    ref = np.exp(phase * 1j)

    rx, ry, rphase = kernel(x, y, phase, mode='ROTATE')
    # print(ref, x, y)
    np.testing.assert_almost_equal(rx, np.cos(phase), decimal=3)
    np.testing.assert_almost_equal(ry, np.sin(phase), decimal=3)


if __name__ == "__main__":
    os.environ['TEST_DEPTH'] = '1'
    pytest.main()
    # python - m vmprof - -web - -web - auth b6955f5be6bb3a7a61587895253f6fd1306d1d42 test_newcoco.py
