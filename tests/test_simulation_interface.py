import subprocess

import numpy as np
import pyha
import pytest
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.simulation.simulation_interface import NoModelError, Simulation, SIM_GATE, SIM_RTL, SIM_HW_MODEL, SIM_MODEL, \
    type_conversions, in_out_transpose


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


def test_flush_pipeline_samples():
    pass


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
    input = np.array([True])
    expect = np.array([not x for x in input])
    ret = comb_bool(input)
    assert (ret.astype(bool) == expect).all()

#########################################
# SIMPLE SEQ
#########################################

# @pytest.fixture(scope='session', params=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL])
# def seq(request):
#     class DummySeq:
#         def __call__(self, inp):
#             return inp + 1
#
#     class DummySeq_HW(HW):
#         def __init__(self):
#             self.reg = 0
#
#         def __call__(self, inp):
#             self.next.reg = inp + 1
#             return self.reg
#
#         def get_delay(self):
#             return 1
#
#     return Simulation(request.param, model=DummySeq(), hw_model=DummySeq_HW())
#
#
# def test_sim_seq(seq):
#     inp = np.array([1, 2, 3, 4, 5])
#     ret = seq(inp)
#
#     assert (ret == inp + 1).all()
