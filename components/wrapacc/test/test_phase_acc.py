import os

import numpy as np
import pytest
from scipy import signal

from sim_automation.testing import Testing
from wrapacc.model.acc import WrapAcc


@pytest.fixture(scope='session')
def shared_tmpdir(tmpdir_factory):
    tmpdir = tmpdir_factory.mktemp('src')  # this returns some retarded path class
    from pathlib import Path
    return Path(str(tmpdir))


@pytest.fixture(scope='function', params=['MODEL', 'HW-MODEL', 'HW-RTL', 'HW-GATE'])
def dut(request, tmpdir, shared_tmpdir):
    limit = int(os.environ['TEST_DEPTH'])
    if request.param_index > limit:
        pytest.skip('Test not to be included, increase env["TEST_DEPTH"] to run more tests')

    bits = 32
    if request.param == 'MODEL':
        dut = Testing(request, WrapAcc(bits), None, None)
        return dut

        # elif request.param == 'HW-MODEL':
        #     dut = Testing(request, CORDIC(iterations), CORDICKernel(iterations), None)
        #     return dut
        #
        # elif request.param == 'HW-RTL':
        #     src = generated_hdl(shared_tmpdir)
        #     coco_sim = CocotbAuto(tmpdir, src)
        #     dut = Testing(request, CORDIC(iterations), CORDICKernel(iterations), coco_sim)
        #     return dut
        #
        # elif request.param == 'HW-GATE':
        #     src = gate_hdl(shared_tmpdir)
        #     coco_sim = CocotbAuto(tmpdir, src)
        #     dut = Testing(request, CORDIC(iterations), CORDICKernel(iterations), coco_sim)
        #     return dut


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
    assert np.allclose(stimul[0], stimul[1])
