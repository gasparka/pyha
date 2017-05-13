# TODO: this file is messy, alot of copy paste code
import subprocess

import numpy as np
import pyha
import pytest
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.simulation.simulation_interface import NoModelError, Simulation, SIM_RTL, SIM_HW_MODEL, SIM_MODEL, \
    type_conversions, in_out_transpose, SIM_GATE, assert_sim_match


def test_ghdl_version():
    # ghdl has same version for 'all versions', a bit shit
    ret = subprocess.getoutput('ghdl --version | grep -m1 GHDL')
    assert 'GHDL 0.34dev (20151126) [Dunoon edition]' == ret


def test_cocotb_version():
    version_file = pyha.__path__[0] + '/../cocotb/version'
    with open(version_file, 'r') as f:
        assert 'VERSION=1.0\n' == f.read()


def test_sim_no_model():
    class NoMain(HW):
        def model_main(self):
            pass

    class NoModelMain(HW):
        def main(self):
            pass

    with pytest.raises(NoModelError):
        Simulation(SIM_MODEL, None)

    with pytest.raises(NoModelError):
        Simulation(SIM_HW_MODEL, NoMain(), None)

    with pytest.raises(NoModelError):
        Simulation(SIM_GATE, NoMain(), None)

    with pytest.raises(NoModelError):
        Simulation(SIM_RTL, NoMain(), None)

    with pytest.raises(NoModelError):
        Simulation(SIM_MODEL, NoModelMain(), None)

    # this shall not raise as we are not simulating model
    Simulation(SIM_HW_MODEL, NoModelMain(), None)

    # ok, not using main
    Simulation(SIM_MODEL, NoMain(), None)


def test_type_conversion():
    class Tmp:
        def __init__(self):
            self.input_types = [Sfix(left=8, right=-8)]

        def wtf(self, *args, **kwargs):
            return self.dummy(*args)

        @type_conversions
        @in_out_transpose
        def dummy(self, *args):
            return [self.main(*x) for x in args]

        def main(self, a):
            assert type(a) == Sfix
            return a

    ret = Tmp().wtf([0.5, 0.5, 1.5, 9])
    assert (ret == [0.5, 0.5, 1.5, 9]).all()
    # assert type(ret[0]) == float

    ret = Tmp().wtf(np.array([0.5, 0.5, 1.5, 9]))
    assert (ret == [0.5, 0.5, 1.5, 9]).all()
    # assert type(ret[0]) == float


def test_type_conversions_multi():
    class Tmp:
        def __init__(self):
            self.input_types = [int, bool, Sfix(left=8, right=-8)]

        def wtf(self, *args):
            return self.dummy(*args)

        @type_conversions
        @in_out_transpose
        def dummy(self, *args):
            return [self.main(*x) for x in args]

        def main(self, a, b, c):
            assert type(a) == int
            assert type(b) == bool
            assert type(c) == Sfix
            return a, b, c

    ain, bin, cin = [[1, 2, 3, 4], [True, False, True, False], [0.5, 0.5, 1.5, 9]]
    ret = Tmp().wtf(ain, bin, cin)
    aout, bout, cout = ret
    assert (ain == aout).all()
    # assert type(aout[0]) == int

    assert (bin == bout).all()
    # assert type(bout[0]) == bool

    assert (cin == cout).all()
    # assert type(cout[0]) == float


class TestCombInt:
    def setup_class(self):
        class T0(HW):
            def __init__(self):
                self.dummy = 0

            def main(self, in_int):
                ret = in_int * 2
                return ret

            def model_main(self, in_int):
                return [x * 2 for x in in_int]

        self.dut = T0()

    def test_list(self):
        input = [1, 2, 3, 4, 5]
        assert_sim_match(self.dut, None, input)

    # def test_numpy(self):
    #     input = np.array([1, 2, 3, 4, 5])
    #     assert_sim_match(self.dut, None, input)


#########################################
# SIMPLE COMB BOOL
#########################################

class TestCombBool:
    def setup_class(self):
        class T1(HW):
            def __init__(self):
                self.dummy = 0

            def main(self, in_int):
                ret = not in_int
                return ret

            def model_main(self, in_int):
                return [not x for x in in_int]

        self.dut = T1()

    def test_list(self):
        input = [True, False, False]
        assert_sim_match(self.dut, None, input)

    # def test_numpy(self):
    #     input = np.array([True, False, False])
    #     assert_sim_match(self.dut, None, input)


class TestCombSfix:
    def setup_class(self):
        class T2(HW):
            def __init__(self):
                self.dummy = 0

            def main(self, in_int):
                ret = in_int - 1.0
                return ret

            def model_main(self, in_int):
                return [x - 1.0 for x in in_int]

        self.dut = T2()

    def test_list(self):
        input = [0.25, 1, 1.5]
        assert_sim_match(self.dut, None, input, types=[Sfix(left=2, right=-8)])

    def test_numpy(self):
        input = np.array([0.25, 1, 1.5])
        assert_sim_match(self.dut, None, input, types=[Sfix(left=2, right=-8)])


#########################################
# MULTIPLE COMB
#########################################

class TestCombMulti:
    def setup_class(self):
        class T3(HW):
            def __init__(self):
                self.dummy = 0

            def main(self, in_int, in_bool, in_sfix):
                ret_int = in_int * 2
                ret_bool = not in_bool
                ret_sfix = in_sfix - 1.0
                return ret_int, ret_bool, ret_sfix

            def model_main(self, in_int, in_bool, in_sfix):
                return [(xi * 2, not xb, xf - 1) for xi, xb, xf in zip(in_int, in_bool, in_sfix)]

        self.dut = T3()

    # def test_arguments_mismatch(self):
    #     with pytest.raises(InputTypesError):
    #         assert_sim_match(self.dut, [int, bool, Sfix(left=2, right=-8)], None, [1, 2], [False, True], [0.5, 0, 6], [3, 4])
    #         comb_multi.main([1, 2], [False, True], [0.5, 0, 6], [3, 4])
    #
    #     with pytest.raises(InputTypesError):
    #         comb_multi.main([1, 2], [False, True])
    #
    # def test_pass_sfixed(comb_multi):
    #     with pytest.raises(InputTypesError):
    #         comb_multi.main([1, 2], [False, True], [Sfix(0.5, 2, -8), Sfix(0.5, 2, -8)])

    def test_comb_multi_list(self):
        input = [[1, 2, 3], [True, False, False], [0.25, 1, 1.5]]
        expect = [[2, 4, 6], [False, True, True], [-0.75, 0.0, 0.5]]
        assert_sim_match(self.dut, expect, *input, types=[int, bool, Sfix(left=2, right=-8)])

    def test_comb_multi_numpy(self):
        input = np.array([[1, 2, 3], [True, False, False], [0.25, 1, 1.5]])
        expect = [[2, 4, 6], [False, True, True], [-0.75, 0.0, 0.5]]
        assert_sim_match(self.dut, expect, *input, types=[int, bool, Sfix(left=2, right=-8)])

    # def test_comb_multi_single(self):
    #     input = np.array([[1], [True], [0.25]])
    #     expect = [[2], [False], [-0.75]]
    #     assert_sim_match(self.dut, [int, bool, Sfix(left=2, right=-8)], expect, *input)


#########################################
# MULTIPLE SEQUENTIAL
# Purpose is to test @flush_pipeline at real environment
#########################################

def test_sequential_single():
    class SeqSingle_HW(HW):
        def __init__(self):
            self.sfix_reg = Sfix(0.0, 2, -8)
            self._delay = 1

        def main(self, in_sfix):
            self.next.sfix_reg = in_sfix - 1.0
            return self.sfix_reg

        def model_main(self, in_sfix):
            return [xf - 1 for xf in in_sfix]

    dut = SeqSingle_HW()

    input = [0.25, 1, 1.5]
    expect = [-0.75, 0.0, 0.5]

    assert_sim_match(dut, expect, input, types=[Sfix(left=2, right=-8)])


def test_sequential_single_delay2():
    class SeqSingle2_HW(HW):
        def __init__(self):
            self.sfix_reg = Sfix(0.0, 2, -8)
            self.sfix_reg2 = Sfix(0.0, 2, -8)
            self._delay = 2

        def main(self, in_sfix):
            self.next.sfix_reg = in_sfix - 1.0
            self.next.sfix_reg2 = self.sfix_reg
            return self.sfix_reg2

        def model_main(self, in_sfix):
            return [xf - 1 for xf in in_sfix]

    dut = SeqSingle2_HW()
    input = [0.25, 1, 1.5]
    expect = [-0.75, 0.0, 0.5]
    assert_sim_match(dut, expect, input, types= [Sfix(left=2, right=-8)])


def test_sequential_multi():
    class MultiSeq_HW(HW):
        def __init__(self):
            self.int_reg = 0
            self.bool_reg = False
            self.sfix_reg = Sfix(0.0, 2, -8)
            self._delay = 1

        def main(self, in_int, in_bool, in_sfix):
            self.next.int_reg = in_int * 2
            self.next.bool_reg = not in_bool
            self.next.sfix_reg = in_sfix - 1.0
            return self.int_reg, self.bool_reg, self.sfix_reg

        def model_main(self, in_int, in_bool, in_sfix):
            return [(xi * 2, not xb, xf - 1) for xi, xb, xf in zip(in_int, in_bool, in_sfix)]

    dut = MultiSeq_HW()
    input = [[1, 2, 3], [True, False, False], [0.25, 1, 1.5]]
    expect = [[2, 4, 6], [False, True, True], [-0.75, 0.0, 0.5]]
    assert_sim_match(dut, expect, *input, types=[int, bool, Sfix(left=2, right=-8)])


def test_hw_sim_resets():
    """ Registers should take initial values on each new simulation(call of main) invocation,
    motivation is to provide same interface as with COCOTB based RTL simulation."""

    class Rst_Hw(HW):
        def __init__(self):
            self.sfix_reg = Sfix(0.5, 0, -18)
            self._delay = 1

        def main(self, in_sfix):
            self.next.sfix_reg = in_sfix
            return self.sfix_reg

    dut = Simulation(SIM_HW_MODEL, model=Rst_Hw())
    dut.main([0.1])
    first_out = float(dut.pure_output[0])
    assert first_out == 0.5

    # make new simulation, registers must reset
    dut.main([0.1])
    first_out = float(dut.pure_output[0])
    assert first_out == 0.5
