import textwrap
from pathlib import Path

import pytest
from pyha.common.const import Const
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.conversion.conversion import get_conversion_datamodel, Conversion
from pyha.simulation.simulation_interface import assert_sim_match, SIM_GATE, SIM_RTL, SIM_HW_MODEL


class TestBasic:
    def setup_class(self):
        class A(HW):
            def __init__(self):
                self.reg = 0

            def main(self, x):
                self.reg = x
                return self.reg

        class B(HW):
            def __init__(self):
                self.sublist = [A(), A()]
                self.DELAY = 1

            def main(self, a, b):
                r0 = self.sublist[0].main(a)
                r1 = self.sublist[1].main(b)
                return r0, r1

        self.dut = B()
        self.dut.main(3, 4)
        self.dut.main(3, 4)
        self.conv = Conversion(self.dut)
        _, self.datamodel = get_conversion_datamodel(self.dut)


    def test_datamodel_training(self):
        assert self.datamodel.self_data['sublist'][0].main.calls == 2
        assert self.datamodel.self_data['sublist'][1].main.calls == 2

    def test_typedefs(self):
        assert 'sublist' in self.datamodel.self_data

        expect = 'type A_0_self_t_list_t is array (natural range <>) of A_0.self_t;'
        assert expect == self.conv.conv.build_typedefs()


    def test_sim(self):
        x = [range(16), range(16)]
        expected = [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
                    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]]

        assert_sim_match(self.dut, expected, *x)


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
                self.reg = x
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

        assert_sim_match(self.dut, expected, *x, simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])

    def test_datamodel(self):
        conv, datamodel = get_conversion_datamodel(self.dut)
        assert len(datamodel.self_data) == 1
        assert datamodel.self_data['sublist'] == self.dut.sublist

        conv, datamodel = get_conversion_datamodel(self.dut.sublist[0])
        assert len(datamodel.self_data) == 2
        assert 'reg' in datamodel.self_data
        assert 'submodule' in datamodel.self_data


def test_for():
    pytest.skip("TODO: fails because typedefs are not discovered from locals")
    class A4(HW):
        def __init__(self, reg_init):
            self.reg = reg_init

        def main(self, x):
            self.reg = x
            return self.reg

    class B4(HW):
        def __init__(self):
            self.sublist = [A4(i) for i in range(4)]
            self.DELAY = 1

        def main(self, x):
            outs = [0, 0, 0, 0]
            for i in range(len(self.sublist)):
                outs[i] = self.sublist[i].main(x)

            return outs[0]

    dut = B4()

    x = list(range(16))
    expected = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

    assert_sim_match(dut, expected, x)