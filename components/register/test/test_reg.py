import pytest

# from components.register.model.model import Register
import numpy as np
from pathlib import Path

from common.hdlstuff import HDLStuff
from common.memoize import memoize
from components.register.model.hw_model import Register
from sim_automation.cocotb import CocotbAuto
from sim_automation.testing import Testing
import os

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
    vhdl_src = ['/home/gaspar/git/hwpy/components/register/hw/hdl/register.vhd',
                '/home/gaspar/git/hwpy/components/register/hw/hdl/top.vhd']
    vhdl_src = [Path(shutil.copyfile(x, str(tmpdir / Path(x).name))) for x in vhdl_src]

    verilog_src = ['/home/gaspar/git/hwpy/components/register/hw/hdl/top.sv']
    verilog_src = [Path(shutil.copyfile(x, str(tmpdir / Path(x).name))) for x in verilog_src]

    from common.sfix import Sfix
    output_sfix = [Sfix(left=2, right=-17)] * 2
    input_sfix = [Sfix(left=2, right=-17)] * 1
    return HDLStuff(tmpdir, vhdl_src, verilog_src, input_sfix, output_sfix)

@pytest.fixture(scope='session')
def shared_tmpdir(tmpdir_factory):
    tmpdir = tmpdir_factory.mktemp('src')  # this returns some retarded path class
    from pathlib import Path
    return Path(str(tmpdir))

@pytest.fixture(scope='function', params=['MODEL', 'HW-MODEL', 'HW-RTL', 'HW-GATE'])
def dut(request, tmpdir, shared_tmpdir):
    y = Register(init_value=0.0)
    if request.param == 'HW-MODEL':
        dut = Testing(request, None, y, None)
        return dut

    elif request.param == 'HW-RTL':
        src = generated_hdl(shared_tmpdir)
        coco_sim = CocotbAuto(tmpdir, src)
        dut = Testing(request, None, y, coco_sim)
        return dut
    else:
        pytest.skip()


def test_init_value(dut):
    stim = [0.1, 0.2, 0.3]
    dut(stim)
    assert dut.pure_output[0][0] == 0.0

def test_delay_attr(dut):
    assert dut.hw_model.delay == 1

def test_delay_one(dut):
    stim = [0.1, 0.2, 0.3]
    out = dut(stim)
    assert np.allclose(stim, out)
