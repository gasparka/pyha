import textwrap
from pathlib import Path

import pytest

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.conversion.conversion import get_conversion_datamodel, Conversion
from pyha.conversion.coupling import reset_maker
from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL, SIM_RTL


@pytest.fixture
def simple():
    class A(HW):
        def __init__(self):
            self.reg = 0

        def main(self, x):
            self.next.reg = x
            return self.reg

    class B(HW):
        def __init__(self):
            self.sublist = [A(), A()]

        def main(self, a, b):
            r0 = self.next.sublist[0].main(a)
            r1 = self.next.sublist[1].main(b)
            return r0, r1

    dut = B()
    dut.main(1, 2)
    dut.main(3, 4)
    return dut


def test_simple_conversion_files(simple):
    conv = Conversion(simple)
    paths = conv.write_vhdl_files(Path('/tmp/'))
    names = [x.name for x in paths]
    assert names == ['A_0.vhd', 'B_0.vhd', 'top.vhd']


def test_simple_datamodel_training(simple):
    conv, datamodel = get_conversion_datamodel(simple)
    assert datamodel.self_data['sublist'][0].main.calls == 2
    assert datamodel.self_data['sublist'][1].main.calls == 2


def test_simple_typedefs(simple):
    conv, datamodel = get_conversion_datamodel(simple)
    assert 'sublist' in datamodel.self_data

    expect = ['type A_0_list_t is array (natural range <>) of A_0.register_t;']
    assert expect == conv.get_typedefs()


def test_simple_datamodel(simple):
    conv, datamodel = get_conversion_datamodel(simple)
    data_conversion = conv.get_datamodel()
    expect = textwrap.dedent("""\
                type register_t is record
                    sublist: A_0_list_t(0 to 1);
                end record;

                type self_t is record
                    sublist: A_0_list_t(0 to 1);
                    \\next\\: register_t;
                end record;""")

    assert expect == data_conversion


def test_simple_reset(simple):
    conv, datamodel = get_conversion_datamodel(simple)

    data_conversion = conv.get_reset_str()
    expect = textwrap.dedent("""\
            procedure reset(self_reg: inout register_t) is
            begin
                self_reg.sublist(0).reg := 0;
                self_reg.sublist(1).reg := 0;
            end procedure;""")

    assert expect == data_conversion


def test_reset_maker(simple):
    conv, datamodel = get_conversion_datamodel(simple)

    expect = ['self_reg.sublist(0).reg := 0;', 'self_reg.sublist(1).reg := 0;']
    ret = reset_maker(datamodel.self_data)

    assert expect == ret


def test_simple_sim(simple):
    x = [range(16), range(16)]
    expected = [[0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
                [0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]]
    dut = simple

    assert_sim_match(dut, [int, int], expected, *x,
                     simulations=[SIM_HW_MODEL, SIM_RTL])


@pytest.fixture
def case2():
    class C2(HW):
        def __init__(self):
            self.regor = False

        def main(self, x):
            return x

    class A2(HW):
        def __init__(self, reg_init):
            self.reg = reg_init
            self.submodule = C2()

        def main(self, x):
            r = self.next.submodule.main(1)
            self.next.reg = x
            return self.reg

    class B2(HW):
        def __init__(self):
            self.sublist = [A2(2), A2(128)]

        def main(self, a, b):
            r0 = self.next.sublist[0].main(a)
            r1 = self.next.sublist[1].main(b)
            return r0, r1

    dut = B2()
    dut.main(1, 1)
    dut.main(1, 1)
    return dut


def test_sim_case2(case2):
    x = [range(16), range(16)]
    expected = [[2, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
                [128, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]]
    dut = case2

    assert_sim_match(dut, [int, int], expected, *x,
                     simulations=[SIM_HW_MODEL, SIM_RTL])


def test_reset_maker_case2(case2):
    conv, datamodel = get_conversion_datamodel(case2)

    expect = [
        'self_reg.sublist(0).reg := 2;',
        'self_reg.sublist(0).submodule.regor := False;',
        'self_reg.sublist(1).reg := 128;',
        'self_reg.sublist(1).submodule.regor := False;']
    ret = reset_maker(datamodel.self_data)

    assert expect == ret


@pytest.fixture
def case3():
    class Label(HW):
        def __init__(self):
            self.register = Sfix(0.563, 0, -18)

    class C3(HW):
        def __init__(self):
            self.nested_list = [Label(), Label()]
            self.regor = False

    class A3(HW):
        def __init__(self, reg_init):
            self.reg = reg_init
            self.submodule = C3()

    class B3(HW):
        def __init__(self):
            self.ror = 554
            self.sublist = [A3(2), A3(128)]

    dut = B3()
    return dut


def test_reset_maker_case3(case3):
    conv, datamodel = get_conversion_datamodel(case3)

    expect = [
        'self_reg.\\ror\\ := 554;',
        'self_reg.sublist(0).reg := 2;',
        'self_reg.sublist(0).submodule.nested_list(0).\\register\\ := to_sfixed(0.563, 0, -18);',
        'self_reg.sublist(0).submodule.nested_list(1).\\register\\ := to_sfixed(0.563, 0, -18);',
        'self_reg.sublist(0).submodule.regor := False;',
        'self_reg.sublist(1).reg := 128;',
        'self_reg.sublist(1).submodule.nested_list(0).\\register\\ := to_sfixed(0.563, 0, -18);',
        'self_reg.sublist(1).submodule.nested_list(1).\\register\\ := to_sfixed(0.563, 0, -18);',
        'self_reg.sublist(1).submodule.regor := False;',
    ]
    ret = reset_maker(datamodel.self_data)

    assert expect == ret


@pytest.fixture
def case_for():
    class A4(HW):
        def __init__(self, reg_init):
            self.reg = reg_init

        def main(self, x):
            self.next.reg = x
            return self.reg

    class B4(HW):
        def __init__(self):
            self.sublist = [A4(i) for i in range(4)]

        def main(self, x):
            outs = [0, 0, 0, 0]
            for i in range(len(self.next.sublist)):
                outs[i] = self.next.sublist[i].main(x)

            return outs[0]

    dut = B4()
    return dut


def test_sim_case_for(case_for):
    x = list(range(16))
    expected = [0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
    dut = case_for

    assert_sim_match(dut, [int], expected, x,
                     simulations=[SIM_HW_MODEL, SIM_RTL])
