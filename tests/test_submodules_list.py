import textwrap
from pathlib import Path

import pytest

from pyha.common.const import Const
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.conversion.conversion import get_conversion_datamodel, Conversion
from pyha.conversion.coupling import reset_maker
from pyha.simulation.simulation_interface import assert_sim_match


class TestBasic:
    def setup_class(self):
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
                r0 = self.sublist[0].main(a)
                r1 = self.sublist[1].main(b)
                return r0, r1

        self.dut = B()
        self.dut.main(3, 4)
        self.dut.main(3, 4)
        self.conv = Conversion(self.dut)
        _, self.datamodel = get_conversion_datamodel(self.dut)

    def test_conversion_files(self):
        paths = self.conv.write_vhdl_files(Path('/tmp/'))
        names = [x.name for x in paths]
        assert names[1:] == ['A_0.vhd', 'B_0.vhd', 'top.vhd']

    def test_datamodel_training(self):
        assert self.datamodel.self_data['sublist'][0].main.calls == 2
        assert self.datamodel.self_data['sublist'][1].main.calls == 2

    def test_typedefs(self):
        assert 'sublist' in self.datamodel.self_data

        expect = ['type A_0_list_t is array (natural range <>) of A_0.self_t;']
        assert expect == self.conv.conv.get_typedefs()

    def test_vhdl_datamodel(self):
        data_conversion = self.conv.conv.get_datamodel()
        expect = textwrap.dedent("""\
                    type next_t is record
                        sublist: A_0_list_t(0 to 1);
                    end record;

                    type self_t is record

                        sublist: A_0_list_t(0 to 1);
                        \\next\\: next_t;
                    end record;""")

        assert expect == data_conversion

    def test_vhdl_reset(self):
        data_conversion = self.conv.conv.get_reset_self()
        expect = textwrap.dedent("""\
                procedure \\_pyha_reset_self\\(self: inout self_t) is
                begin
                    self.sublist(0).\\next\\.reg := 0;
                    self.sublist(1).\\next\\.reg := 0;
                    \\_pyha_update_self\\(self);
                end procedure;""")

        assert expect == data_conversion

    def test_reset_maker(self):
        expect = ['self.sublist(0).\\next\\.reg := 0;',
                  'self.sublist(1).\\next\\.reg := 0;']
        ret = reset_maker(self.datamodel.self_data)

        assert expect == ret

    def test_sim(self):
        x = [range(16), range(16)]
        expected = [[0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
                    [0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]]

        assert_sim_match(self.dut, [int, int], expected, *x)


class TestDeepSubmodules:
    def setup_class(self):
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
                r = self.submodule.main(1)
                self.next.reg = x
                return self.reg

        class B2(HW):
            def __init__(self):
                self.sublist = [A2(2), A2(128)]

            def main(self, a, b):
                r0 = self.sublist[0].main(a)
                r1 = self.sublist[1].main(b)
                return r0, r1

        self.dut = B2()
        self.dut.main(1, 1)

    def test_sim_case2(self):
        x = [range(16), range(16)]
        expected = [[2, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
                    [128, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]]

        assert_sim_match(self.dut, [int, int], expected, *x)

    def test_datamodel(self):
        conv, datamodel = get_conversion_datamodel(self.dut)
        assert len(datamodel.self_data) == 1
        assert datamodel.self_data['sublist'] == self.dut.sublist

        conv, datamodel = get_conversion_datamodel(self.dut.sublist[0])
        assert len(datamodel.self_data) == 2
        assert 'reg' in datamodel.self_data
        assert 'submodule' in datamodel.self_data

    def test_reset(self):
        conv, datamodel = get_conversion_datamodel(self.dut)

        expect = [
            'self.sublist(0).\\next\\.reg := 2;',
            'self.sublist(0).submodule.\\next\\.regor := False;',
            'self.sublist(1).\\next\\.reg := 128;',
            'self.sublist(1).submodule.\\next\\.regor := False;']
        ret = reset_maker(datamodel.self_data)

        assert expect == ret


class TestDeepDeepSubmodules:
    def setup_class(self):
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

        self.dut = B3()

    def test_reset(self):
        conv, datamodel = get_conversion_datamodel(self.dut)

        expect = [
            'self.\\next\\.\\ror\\ := 554;',
            'self.sublist(0).\\next\\.reg := 2;',
            'self.sublist(0).submodule.nested_list(0).\\next\\.\\register\\ := Sfix(0.563, 0, -18);',
            'self.sublist(0).submodule.nested_list(1).\\next\\.\\register\\ := Sfix(0.563, 0, -18);',
            'self.sublist(0).submodule.\\next\\.regor := False;',
            'self.sublist(1).\\next\\.reg := 128;',
            'self.sublist(1).submodule.nested_list(0).\\next\\.\\register\\ := Sfix(0.563, 0, -18);',
            'self.sublist(1).submodule.nested_list(1).\\next\\.\\register\\ := Sfix(0.563, 0, -18);',
            'self.sublist(1).submodule.\\next\\.regor := False;',
        ]
        ret = reset_maker(datamodel.self_data)

        assert expect == ret


def test_for():
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
            for i in range(len(self.sublist)):
                outs[i] = self.sublist[i].main(x)

            return outs[0]

    dut = B4()

    x = list(range(16))
    expected = [0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]

    assert_sim_match(dut, [int], expected, x)


def test_const_illegal():
    class A5(HW):
        def __init__(self, reg_init):
            self.reg = Const(reg_init)

        def main(self, x):
            return x

    with pytest.raises(Exception):
        class B5(HW):
            def __init__(self):
                self.sublist = [A5(i) for i in range(4)]

            def main(self, x):
                return x

        dut = B5()
        dut.main(0)
        dut.main(1)
