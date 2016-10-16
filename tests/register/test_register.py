from pathlib import Path

import numpy as np
import pytest
from common.hwsim import HW
from common.sfix import Sfix
from conversion.converter import convert
from conversion.extract_datamodel import DataModel
from conversion.top_generator import TopGenerator
from pyha.simulation import CocotbAuto
from pyha.simulation import Testing
from redbaron import RedBaron


class HDLStuff(object):
    def __init__(self, base_path, vhdl_src, verilog_src, input_sfix, output_sfix):
        self.output_sfix = output_sfix
        self.input_sfix = input_sfix
        self.base_path = base_path
        self.vhdl_src = vhdl_src
        self.verilog_src = verilog_src


def full_conversion(obj, tmpdir):
    datamodel = DataModel(obj)
    f = open(__file__).read()
    reg_class = RedBaron(f)('class', name='Register')[0]

    conv = convert(reg_class, caller=None, datamodel=datamodel)
    conv = str(conv)
    with open('converted.vhd', 'w') as f:
        f.write(conv)

    TopGenerator(obj).make()


def test_main():
    class Register(HW):
        def __init__(self, init_value=0.):
            self.a = Sfix(init_value)

        def __call__(self, new_value):
            self.next.a = new_value
            return self.a

    ret = Register()
    ret(Sfix(0.5, 0, -27))
    ret(Sfix(0.5, 0, -27))

    full_conversion(ret, None)


def generated_hdl(tmpdir_factory):
    import shutil

    # full_conversion()
    # tmpdir = tmpdir_factory.mktemp('src') # this returns some retarded path class
    tmpdir = tmpdir_factory  # this returns some retarded path class
    # tmpdir = Path(str(tmpdir))

    # copy cocotb python file to temp folder
    coco_py = '/home/gaspar/git/hapy/simulation/cocotb_testing.py'
    shutil.copyfile(coco_py, str(tmpdir / Path(coco_py).name))

    # not implemented simulate by copying files to tmpdir
    vhdl_src = ['/home/gaspar/git/hapy/test/register/converted.vhd',
                '/home/gaspar/git/hapy/test/register/top.vhd']
    vhdl_src = [Path(shutil.copyfile(x, str(tmpdir / Path(x).name))) for x in vhdl_src]

    from pyha.common import Sfix

    output_sfix = [Sfix(left=0, right=-27)] * 1
    input_sfix = [Sfix(left=0, right=-27)] * 1
    return HDLStuff(tmpdir, vhdl_src, None, input_sfix, output_sfix)


# @pytest.fixture
# def dut():
#     class Register(HW):
#         def __init__(self, init_value=0.):
#             self.a = Sfix(init_value)
#
#         def __call__(self, new_value):
#             self.next.a = new_value
#             return self.a
#
#     ret = Register()
#     ret(Sfix(0.5, 0, -27))
#     ret(Sfix(0.5, 0, -27))
#     return ret


@pytest.fixture(scope='session')
def shared_tmpdir(tmpdir_factory):
    tmpdir = tmpdir_factory.mktemp('src')  # this returns some retarded path class
    return Path(str(tmpdir))


@pytest.fixture(scope='function', params=['MODEL', 'HW-MODEL', 'HW-RTL', 'HW-GATE'])
def dut(request, tmpdir, shared_tmpdir):
    # limit = int(os.environ['TEST_DEPTH'])
    limit = 2
    if request.param_index > limit:
        pytest.skip('Test not to be included, increase env["TEST_DEPTH"] to run more tests')

    class Register(HW):
        def __init__(self, init_value=0.):
            self.a = Sfix(init_value)
            self.output_sfix = [Sfix(left=0, right=-27)] * 1
            self.input_sfix = [Sfix(left=0, right=-27)] * 1

        def __call__(self, new_value):
            self.next.a = new_value
            return self.a

        @property
        def delay(self):
            return 1

    ret = Register()

    if request.param == 'MODEL':
        pytest.skip('LOL')
        # dut = Testing(request, WrapAcc(bits), None, None)
        # return dut

    elif request.param == 'HW-MODEL':


        dut = Testing(request, None, ret, None)
        return dut

    elif request.param == 'HW-RTL':
        src = generated_hdl(shared_tmpdir)
        coco_sim = CocotbAuto(tmpdir, src)
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

    # ret = dut(0.6)
    # assert np.isclose(ret, [0.6])

#
#
# def test_conversion():
#     dut = Register(0.52)
#     ret = dut(Sfix(0.5, 0, -12))
#
#     datamodel = DataModel(dut)
#     f = open(__file__).read()
#     reg_class = RedBaron(f)('class')[0]
#
#     expect = textwrap.dedent("""\
#             package \\Register\\ is
#                 type register_t is record
#                     a: sfixed(0 downto -12);
#                 end record;
#                 type self_t is record
#                     a: sfixed(0 downto -12);
#                     \\next\\: register_t;
#                 end record;
#
#                 procedure reset(self_reg: inout register_t);
#                 procedure \\__call__\\(self_reg:inout register_t; new_value: sfixed(0 downto -12); ret_0:out sfixed(0 downto -12));
#             end package;
#
#             package body \\Register\\ is
#                 procedure reset(self_reg: inout register_t) is
#                 begin
#                     self_reg.a := to_sfixed(0.52, 0, -12);
#                 end procedure;
#
#                 procedure make_self(self_reg: register_t; self: out self_t) is
#                 begin
#                     self.a := self_reg.a;
#                     self.\\next\\ := self_reg;
#                 end procedure;
#
#                 procedure \\__call__\\(self_reg:inout register_t; new_value: sfixed(0 downto -12); ret_0:out sfixed(0 downto -12)) is
#                     variable self: self_t;
#                 begin
#                     make_self(self_reg, self);
#                     self.\\next\\.a := new_value;
#                     ret_0 := self.a;
#                     self_reg := self.\\next\\;
#                 end procedure;
#             end package body;""")
#
#     conv = convert(reg_class, caller=None, datamodel=datamodel)
#     conv = str(conv)
#     with open('converted.vhdl', 'w') as f:
#         print(conv, file=f)
#
#     assert expect == conv[conv.index('package'):]
