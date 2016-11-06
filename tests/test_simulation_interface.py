import subprocess

import numpy as np
import pytest

import pyha
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.simulation.simulation_interface import NoModelError, Simulation, SIM_GATE, SIM_RTL, SIM_HW_MODEL, SIM_MODEL, \
    type_conversions, in_out_transpose, flush_pipeline


def test_ghdl_version():
    # ghdl has same version for 'all versions', a bit shit
    ret = subprocess.getoutput('ghdl --version | grep -m1 GHDL')
    assert 'GHDL 0.34dev (20151126) [Dunoon edition]' == ret


def test_cocotb_version():
    version_file = pyha.__path__[0] + '/../cocotb/version'
    with open(version_file, 'r') as f:
        assert 'VERSION=1.0\n' == f.read()


def test_sim_no_model():
    with pytest.raises(NoModelError):
        Simulation(SIM_MODEL, None, None)

    with pytest.raises(NoModelError):
        Simulation(SIM_HW_MODEL, object(), None)

    with pytest.raises(NoModelError):
        Simulation(SIM_RTL, None, None)

    with pytest.raises(NoModelError):
        Simulation(SIM_GATE, None, None)


def test_type_conversion():
    class Tmp:
        def __init__(self):
            self.input_types = [Sfix(left=8, right=-8)]

        def wtf(self, *args, **kwargs):
            return self.dummy(*args)

        @type_conversions
        @in_out_transpose
        def dummy(self, *args):
            return [self(*x) for x in args]

        def __call__(self, a):
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
            return [self(*x) for x in args]

        def __call__(self, a, b, c):
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


@pytest.mark.parametrize("delay", [0, 1, 2])
def test_flush_pipeline_int(delay):
    class Tmp:
        def __init__(self):
            class Dummer:
                def get_delay(self):
                    return delay

            self.hw_model = Dummer()

        @flush_pipeline
        def dummy(self, *inp):
            delay = self.hw_model.get_delay()
            if delay == 0:
                return inp
            if len()
                inp = list(inp[0]) * delay + list(inp[:-delay])
            return inp

    inp = [1, 2, 3]
    expected = inp

    outp = Tmp().dummy(*np.transpose(inp).tolist())
    assert (list(outp) == expected)


@pytest.mark.parametrize("delay", [0, 1, 2])
def test_flush_pipeline_bool(delay):
    class Tmp:
        def get_delay(self):
            return delay

        @flush_pipeline
        def dummy(self, inp):
            """ Simulates delay, think abut 'delay' chained registers"""
            if self.get_delay() == 0:
                return inp
            return self.get_delay() * [0] + inp[:-self.get_delay()]

    inp = [False, True, False]
    expected = inp

    outp = Tmp().dummy(inp)
    assert outp == expected


@pytest.mark.parametrize("delay", [0, 1, 2])
def test_flush_pipeline_sfixed(delay):
    class Tmp:
        def get_delay(self):
            return delay

        @flush_pipeline
        def dummy(self, inp):
            """ Simulates delay, think abut 'delay' chained registers"""
            if self.get_delay() == 0:
                return inp
            return self.get_delay() * [0] + inp[:-self.get_delay()]

    inp = [Sfix(0.5, 1, -5), Sfix(1.4, 1, -5), Sfix(0.3, 1, -5)]
    expected = inp

    outp = Tmp().dummy(inp)
    assert outp == expected


#########################################
# SIMPLE COMB INT
#########################################


@pytest.fixture(scope='session', params=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL])
def comb_int(request):
    class Dummy:
        def __call__(self, in_int):
            return [x * 2 for x in in_int]
            # return in_int * 2

    class Dummy_HW(HW):
        def __init__(self):
            self.dummy = 0

        def __call__(self, in_int):
            ret = in_int * 2
            return ret

    return Simulation(request.param, model=Dummy(), hw_model=Dummy_HW(), input_types=[int])


def test_comb_int_list(comb_int):
    in_int = [1, 2, 3, 4, 5]
    expect = np.array([x * 2 for x in in_int])
    ret = comb_int(in_int)

    assert (ret == expect).all()


def test_comb_int_numpy(comb_int):
    in_int = np.array([1, 2, 3, 4, 5])
    ret = comb_int(in_int)

    assert (ret == in_int * 2).all()


def test_comb_int_single(comb_int):
    # fails if run separately! (not enough training)
    in_int = np.array([1])
    ret = comb_int(in_int)

    assert (ret == in_int * 2).all()


#########################################
# SIMPLE COMB BOOL
#########################################

@pytest.fixture(scope='session', params=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL])
def comb_bool(request):
    class Dummy:
        def __call__(self, in_int):
            return [not x for x in in_int]

    class Bool_HW(HW):
        def __init__(self):
            self.dummy = 0

        def __call__(self, in_int):
            ret = not in_int
            return ret

    return Simulation(request.param, model=Dummy(), hw_model=Bool_HW(), input_types=[bool])


def test_comb_bool_list(comb_bool):
    input = [True, False, False]
    expect = np.array([not x for x in input])
    ret = comb_bool(input)
    assert (ret.astype(bool) == expect).all()


def test_comb_bool_numpy(comb_bool):
    input = np.array([True, False, False])
    expect = np.array([not x for x in input])
    ret = comb_bool(input)
    assert (ret.astype(bool) == expect).all()


def test_comb_bool_single(comb_bool):
    # fails if run separately! (not enough training)
    input = np.array([True])
    expect = np.array([not x for x in input])
    ret = comb_bool(input)
    assert (ret.astype(bool) == expect).all()


#########################################
# SIMPLE COMB BOOL
#########################################

@pytest.fixture(scope='session', params=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL])
def comb_sfix(request):
    class Dummy:
        def __call__(self, in_int):
            return [x - 1.0 for x in in_int]

    class Sfix_HW(HW):
        def __init__(self):
            self.dummy = 0

        def __call__(self, in_int):
            ret = in_int - 1.0
            return ret

    return Simulation(request.param, model=Dummy(), hw_model=Sfix_HW(), input_types=[Sfix(left=2, right=-8)])


def test_comb_sfix_list(comb_sfix):
    input = [0.25, 1, 1.5]
    expect = np.array([x - 1.0 for x in input])
    ret = comb_sfix(input)
    assert (ret == expect).all()


def test_comb_sfix_numpy(comb_sfix):
    input = np.array([0.25, 1, 1.5])
    expect = np.array([x - 1.0 for x in input])
    ret = comb_sfix(input)
    assert (ret == expect).all()


def test_comb_sfix_single(comb_sfix):
    # fails if run separately! (not enough training)
    input = np.array([0.25])
    expect = np.array([x - 1.0 for x in input])
    ret = comb_sfix(input)
    assert (ret == expect).all()


#########################################
# MULTIPLE COMB
#########################################

@pytest.fixture(scope='session', params=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL])
def comb_multi(request):
    class Dummy:
        def __call__(self, in_int, in_bool, in_sfix):
            return [(xi * 2, not xb, xf - 1) for xi, xb, xf in zip(in_int, in_bool, in_sfix)]
            # return [not x for x in in_int]
            # return [x - 1.0 for x in in_int]

    class Multi_HW(HW):
        def __init__(self):
            self.dummy = 0

        def __call__(self, in_int, in_bool, in_sfix):
            ret_int = in_int * 2
            ret_bool = not in_bool
            ret_sfix = in_sfix - 1.0
            return ret_int, ret_bool, ret_sfix

    return Simulation(request.param, model=Dummy(), hw_model=Multi_HW(),
                      input_types=[int, bool, Sfix(left=2, right=-8)])


def test_comb_multi_list(comb_multi):
    input = [[1, 2, 3], [True, False, False], [0.25, 1, 1.5]]
    expect = [[2, 4, 6], [False, True, True], [-0.75, 0.0, 0.5]]
    ret = comb_multi(*input)
    assert (ret[0] == expect[0]).all()
    assert (ret[1].astype(bool) == expect[1]).all()
    assert (ret[2] == expect[2]).all()


def test_comb_multi_numpy(comb_multi):
    input = np.array([[1, 2, 3], [True, False, False], [0.25, 1, 1.5]])
    expect = [[2, 4, 6], [False, True, True], [-0.75, 0.0, 0.5]]
    ret = comb_multi(*input)
    assert (ret[0] == expect[0]).all()
    assert (ret[1].astype(bool) == expect[1]).all()
    assert (ret[2] == expect[2]).all()


def test_comb_multi_single(comb_multi):
    input = np.array([[1], [True], [0.25]])
    expect = [[2], [False], [-0.75]]
    ret = comb_multi(*input)
    assert (ret[0] == expect[0]).all()
    assert (ret[1].astype(bool) == expect[1]).all()
    assert (ret[2] == expect[2]).all()


#########################################
# MULTIPLE SEQUENTIAL
# Purpose is to test @flush_pipeline at real environment
#########################################

@pytest.fixture(scope='session', params=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL])
def sequential_multi(request):
    class Dummy:
        def __call__(self, in_int, in_bool, in_sfix):
            return [(xi * 2, not xb, xf - 1) for xi, xb, xf in zip(in_int, in_bool, in_sfix)]

    class MultiSeq_HW(HW):
        def __init__(self):
            self.get_delay()
            self.int_reg = 0
            self.bool_reg = False
            self.sfix_reg = Sfix(0.0)

        def __call__(self, in_int, in_bool, in_sfix):
            self.next.int_reg = in_int * 2
            self.next.bool_reg = not in_bool
            self.next.sfix_reg = in_sfix - 1.0
            return self.int_reg, self.bool_reg, self.sfix_reg

        def get_delay(self):
            return 1

    return Simulation(request.param, model=Dummy(), hw_model=MultiSeq_HW(),
                      input_types=[int, bool, Sfix(left=2, right=-8)])


def test_sequential_multi_list(sequential_multi):
    input = [[1, 2, 3], [True, False, False], [0.25, 1, 1.5]]
    expect = [[2, 4, 6], [False, True, True], [-0.75, 0.0, 0.5]]
    ret = sequential_multi(*input)
    assert (ret[0] == expect[0]).all()
    assert (ret[1].astype(bool) == expect[1]).all()
    assert (ret[2] == expect[2]).all()
