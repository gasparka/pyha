import textwrap

import pytest

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.conversion.conversion import get_objects_datamodel_conversion
from pyha.conversion.coupling import reset_maker


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


def test_simple_datamodel_training(simple):
    conv, datamodel = get_objects_datamodel_conversion(simple)
    assert datamodel.self_data['sublist'][0].main.calls == 2
    assert datamodel.self_data['sublist'][1].main.calls == 2


def test_simple_datamodel(simple):
    conv, datamodel = get_objects_datamodel_conversion(simple)
    assert 'sublist' in datamodel.self_data

    expect = ['type A_0_list_t is array (natural range <>) of A_0;']
    assert expect == conv.get_typedefs()

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
    conv, datamodel = get_objects_datamodel_conversion(simple)

    data_conversion = conv.get_reset_str()
    expect = textwrap.dedent("""\
            procedure reset(self_reg: inout register_t) is
            begin
                self_reg.sublist(0).reg := 0;
                self_reg.sublist(1).reg := 0;
            end procedure;""")

    assert expect == data_conversion


def test_reset_maker(simple):
    conv, datamodel = get_objects_datamodel_conversion(simple)

    expect = ['self_reg.sublist(0).reg := 0;', 'self_reg.sublist(1).reg := 0;']
    ret = reset_maker(datamodel.self_data)

    assert expect == ret


def test_simple_sim(simple):


@pytest.fixture
def case2():
    class C2(HW):
        def __init__(self):
            self.regor = False

    class A2(HW):
        def __init__(self, reg_init):
            self.reg = reg_init
            self.submodule = C2()

    class B2(HW):
        def __init__(self):
            self.sublist = [A2(2), A2(128)]

    dut = B2()
    return dut


def test_reset_maker_case2(case2):
    conv, datamodel = get_objects_datamodel_conversion(case2)

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
    conv, datamodel = get_objects_datamodel_conversion(case3)

    expect = [
        'self_reg.self_reg.\\ror\\ := 554;',
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
