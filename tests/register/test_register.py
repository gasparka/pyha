import numpy as np
import pytest
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.conversion.conversion import Conversion
from pyha.simulation.cocotb import CocotbAuto
from pyha.simulation.testing import Testing


@pytest.fixture(scope='function', params=['MODEL', 'HW-MODEL', 'HW-RTL', 'HW-GATE'])
def dut(request, tmpdir):
    # limit = int(os.environ['TEST_DEPTH'])
    limit = 2
    if request.param_index > limit:
        pytest.skip('Test not to be included, increase env["TEST_DEPTH"] to run more tests')

    class Register(HW):
        def __init__(self, init_value=0.):
            self.a = Sfix(init_value)

        def __call__(self, new_value):
            self.next.a = new_value
            return self.a

        def get_delay(self):
            return 1

    ret = Register()
    ret.get_delay()
    ret(Sfix(0.0, 0, -27))
    ret(Sfix(0.0, 0, -27))

    if request.param == 'MODEL':
        pytest.skip('LOL')
        # dut = Testing(request, WrapAcc(bits), None, None)
        # return dut

    elif request.param == 'HW-MODEL':

        dut = Testing(request, None, ret, None)
        return dut

    elif request.param == 'HW-RTL':
        # src = generated_hdl(shared_tmpdir)

        conv = Conversion(ret)
        coco_sim = CocotbAuto(tmpdir, conv)
        dut = Testing(request, None, ret, coco_sim)
        return dut
        #
        # elif request.param == 'HW-GATE':
        #     src = gate_hdl(shared_tmpdir)
        #     coco_sim = CocotbAuto(tmpdir, src)
        #     dut = Testing(request, WrapAcc(bits), wrapacc.hw.acc.WrapAcc(bits), coco_sim)
        #     return dut


def test_functionality(dut):
    ret = dut([0.5, 0.6, 0.7])
    assert np.allclose(ret, [0.5, 0.6, 0.7])
