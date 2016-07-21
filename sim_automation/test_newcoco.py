import numpy as np
# class Project(object):
#     def __init__(self, base_path, sources):
#
# 1. generate vhdl and verilog tops (one time)
# 2. generate cocotb stuff  + put input data to env var
# 3. run the simulation ( GATE or RTL )
#   3.1 for gate run quartus (one time)
# 4. return output data
import pytest
from pathlib import Path

from sim_automation.cocotb import CocotbAuto


class HDLStuff(object):
    def __init__(self, base_path, vhdl_src, verilog_src, input_sfix, output_sfix):
        self.output_sfix = output_sfix
        self.input_sfix = input_sfix
        self.base_path = base_path
        self.vhdl_src = vhdl_src
        self.verilog_src = verilog_src


@pytest.fixture(scope='session')
def generated_hdl(tmpdir_factory):
    import shutil
    tmpdir = tmpdir_factory.mktemp('src')

    # copy cocotb python file to temp folder
    coco_py = '/home/gaspar/git/hwpy/components/cordic/hw/hdl/test/hdl_tests.py'
    shutil.copyfile(coco_py, str(tmpdir / Path(coco_py).name))

    # not implemented simulate by copying files to tmpdir
    vhdl_src = ['/home/gaspar/git/hwpy/components/cordic/hw/hdl/cordickernel.vhd',
                '/home/gaspar/git/hwpy/components/cordic/hw/hdl/top.vhd']
    vhdl_src = [Path(shutil.copyfile(x, str(tmpdir / Path(x).name))) for x in vhdl_src]

    verilog_src = ['/home/gaspar/git/hwpy/components/cordic/hw/hdl/top.sv']
    verilog_src = [Path(shutil.copyfile(x, str(tmpdir / Path(x).name))) for x in verilog_src]

    from common.sfix import Sfix
    output_sfix = [Sfix(left=2, right=-17)] * 3
    input_sfix = [Sfix(left=2, right=-17)] * 3
    return HDLStuff(tmpdir, vhdl_src, verilog_src, input_sfix, output_sfix)


@pytest.fixture(scope='module')
def rtl_source(generated_hdl):
    pass


@pytest.fixture(scope='module')
def gate_source(generated_hdl):
    from sim_automation.quartus import make_gate_vhdl
    make_gate_vhdl(generated_hdl)
    pass


class Caller(object):
    def __init__(self, tmpdir, generated_hdl):
        self.generated_hdl = generated_hdl
        self.tmpdir = tmpdir

        self.coco_sim = CocotbAuto(self.tmpdir, self.generated_hdl)

    def __call__(self, *args, **kwargs):
        from common.sfix import Sfix
        delay = 19
        # flush pipeline
        args = [[x] + [0.0] * delay for x in args]

        # fixed conversion
        for i, (values, type) in enumerate(zip(args, self.generated_hdl.input_sfix)):
            args[i] = [Sfix(x, type.left, type.right).fixed_value() for x in values]

        out = self.coco_sim.run(args)

        # convert fixed values to float
        out = out.astype(float)
        for i, (values, type) in enumerate(zip(out, self.generated_hdl.output_sfix)):
            out[i] = (values * 2 ** type.right)

        # remove pipeline fill samples
        pure_out = np.transpose(np.transpose(out)[delay:])

        return pure_out


# @pytest.fixture(scope='function', params=['MODEL', 'HW-MODEL', 'HW-RTL', 'HW-GATE'])
@pytest.fixture(scope='function')
def kernel(request, tmpdir, generated_hdl):
    # iterations = 18
    # if request.param == 'MODEL':
    #     from components.cordic.model.cordic import CORDIC
    #     cord = CORDIC(iterations)
    #     return cord.kernel
    #
    # elif request.param == 'HW-MODEL':
    #     from components.cordic.hw.kernel import CORDICKernel
    #     cord = CORDICKernel(iterations)
    #     return cord.test_interface
    #
    # elif request.param == 'HW-RTL':
    return Caller(tmpdir, generated_hdl)
    # d = CocotbAuto(tmpdir, generated_hdl)
    # d.run()
    # return wrap
    # assert 0
    # from components.cordic.hw.kernel import CORDICKernel
    # cord = CORDICKernel(iterations)
    # return cord.test_interface


@pytest.fixture(params=[pytest.mark.skipif(True, reason='reason')('b')])
def tst_fixt():
    assert 0


@pytest.fixture()
def main_fix(tst_fixt=None):
    return 1


def test_kernel_first_out_rot(kernel):
    rx, ry, rphase = kernel(1, 1, 0, mode='ROTATE')
    assert np.isclose(rx, [1.6467515412835914], atol=1e-3)
    assert np.isclose(ry, [1.6467689748804477], atol=1e-3)
    assert np.isclose(rphase, [-5.2933e-6], atol=1e-3)
