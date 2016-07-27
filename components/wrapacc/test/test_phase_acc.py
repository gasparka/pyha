import os
from pathlib import Path

import numpy as np
import pytest
from scipy import signal

from common.memoize import memoize
from sim_automation.testing import Testing
from wrapacc import hw
from wrapacc.model.acc import WrapAcc


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
    vhdl_src = ['/home/gaspar/git/hwpy/components/wrapacc/hw/hdl/wrapacc.vhd',
                '/home/gaspar/git/hwpy/components/wrapacc/hw/hdl/top.vhd']
    vhdl_src = [Path(shutil.copyfile(x, str(tmpdir / Path(x).name))) for x in vhdl_src]

    verilog_src = ['/home/gaspar/git/hwpy/components/wrapacc/hw/hdl/top.sv']
    verilog_src = [Path(shutil.copyfile(x, str(tmpdir / Path(x).name))) for x in verilog_src]

    from common.sfix import Sfix
    output_sfix = [Sfix(left=2, right=-17)] * 2
    input_sfix = [Sfix(left=2, right=-17)] * 1
    return HDLStuff(tmpdir, vhdl_src, verilog_src, input_sfix, output_sfix)


# @pytest.fixture(scope='session')
@memoize
def gate_hdl(shared_dir):
    from copy import deepcopy
    hdl = deepcopy(generated_hdl(shared_dir))
    from sim_automation.quartus import make_gate_vhdl
    gate_vhdl = make_gate_vhdl(hdl)
    hdl.vhdl_src = [gate_vhdl]
    return hdl


@pytest.fixture(scope='session')
def shared_tmpdir(tmpdir_factory):
    tmpdir = tmpdir_factory.mktemp('src')  # this returns some retarded path class
    from pathlib import Path
    return Path(str(tmpdir))


@pytest.fixture(scope='function', params=['MODEL', 'HW-MODEL', 'HW-RTL', 'HW-GATE'])
def dut(request, tmpdir, shared_tmpdir):
    from sim_automation.cocotb import CocotbAuto
    limit = int(os.environ['TEST_DEPTH'])
    if request.param_index > limit:
        pytest.skip('Test not to be included, increase env["TEST_DEPTH"] to run more tests')

    bits = 31
    if request.param == 'MODEL':
        dut = Testing(request, WrapAcc(bits), None, None)
        return dut

    elif request.param == 'HW-MODEL':
        # FIXME: this name clash is bullshit
        import wrapacc.hw.acc
        dut = Testing(request, WrapAcc(bits), hw.acc.WrapAcc(bits), None)
        return dut

    elif request.param == 'HW-RTL':
        src = generated_hdl(shared_tmpdir)
        coco_sim = CocotbAuto(tmpdir, src)
        dut = Testing(request, WrapAcc(bits), hw.acc.WrapAcc(bits), coco_sim)
        return dut

    elif request.param == 'HW-GATE':
        src = gate_hdl(shared_tmpdir)
        coco_sim = CocotbAuto(tmpdir, src)
        dut = Testing(request, WrapAcc(bits), hw.acc.WrapAcc(bits), coco_sim)
        return dut


# @pytest.fixture
# def dut():
#     return WrapAcc(bits=32)


@pytest.fixture
def stimul(dut):
    fs = 128
    freq = 3
    t = np.linspace(0, 1, fs, endpoint=False)
    ref = signal.sawtooth(2 * np.pi * freq * t)

    # dut stuff
    step = dut.model.freq_to_step(freq, fs)
    # ret = dut([step] * fs)
    sig, is_wrap = dut([step] * fs)
    # sig, is_wrap = zip(*ret)
    return sig, ref, is_wrap, freq


def test_first(stimul):
    assert stimul[0][0] == -1.0


def test_end(stimul):
    assert np.isclose(stimul[0][-1], stimul[1][-1])


def test_step(stimul):
    # have to use linspace with endpoint=FALSE
    dut_step = np.diff(stimul[0])[0]
    ref_step = np.diff(stimul[1])[0]
    assert np.isclose(dut_step, ref_step)


def test_wrap_output(stimul):
    c = stimul[2].astype(bool).tolist().count(True)
    # c = stimul[2].count(True)
    assert c == stimul[3] - 1


def test_samples(stimul):
    # import matplotlib.pyplot as plt
    # plt.plot(stimul[0])
    # plt.plot(stimul[1])
    # plt.show()
    assert np.allclose(stimul[0], stimul[1])
