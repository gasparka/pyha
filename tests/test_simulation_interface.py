import subprocess

import numpy as np
import pyha
import pytest
from pyha.common.hwsim import HW
from pyha.simulation.simulation_interface import NoModelError, Simulation, SIM_GATE, SIM_RTL, SIM_HW_MODEL, SIM_MODEL


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


def test_prepaire_input_int():
    sim = Simulation(SIM_RTL, hw_model=object(), input_types=[int])
    ret = sim.prepaire_input([1, 2, 3])
    assert ret == [1, 2, 3]


def test_prepaire_input_numpy():
    sim = Simulation(SIM_RTL, hw_model=object(), input_types=[int])
    ret = sim.prepaire_input(np.array([0, 2, 3]))
    assert ret == [0, 2, 3]
    assert type(ret) is list


@pytest.fixture(scope='session', params=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL])
def simple_model(request):
    class Dummy:
        def __call__(self, inp):
            return inp * 2

    class Dummy_HW(HW):
        def __init__(self):
            self.dummy = 0

        def __call__(self, inp):
            ret = inp * 2
            return ret

    return Simulation(request.param, model=Dummy(), hw_model=Dummy_HW())


def test_sim_simple_model(simple_model):
    inp = np.array([1, 2, 3, 4, 5])
    ret = simple_model(inp)

    assert (ret == inp * 2).all()
