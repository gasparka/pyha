# TODO: this file is messy, alot of copy paste code
import subprocess

import numpy as np
import pytest

import pyha
from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix
from pyha.simulation.simulation_interface import NoModelError, Simulation, SIM_RTL, SIM_HW_MODEL, SIM_MODEL, \
    SIM_GATE, assert_sim_match, debug_assert_sim_match


def test_ghdl_version():
    # ghdl has same version for 'all versions'
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

    # with pytest.raises(NoModelError):
    #     Simulation(SIM_MODEL, NoModelMain(), None)

    # this shall not raise as we are not simulating model
    Simulation(SIM_HW_MODEL, NoModelMain(), None)

    # ok, not using main
    Simulation(SIM_MODEL, NoMain(), None)


class TestInterface:
    def test_basic(self):
        class T(HW):
            def main(self, i):
                return i

        dut = T()
        assert_sim_match(dut, range(4), range(4))

    def test_multi(self):
        class T(HW):
            def main(self, b, sfix):
                return b, sfix

        dut = T()
        data = [[True, False, False], [0.1, 0.2, 0.3]]
        assert_sim_match(dut, data, *data)

    def test_list(self):
        class T(HW):
            def main(self, l):
                return l

        dut = T()
        data = [[1, 2], [3, 4], [5, 6]]
        debug_assert_sim_match(dut, data, data, dir_path='/home/gaspar/git/pyha/playground')


def test_hw_sim_resets():
    """ Registers should take initial values on each new simulation(call of main) invocation,
    motivation is to provide same interface as with COCOTB based RTL simulation."""

    class Rst_Hw(HW):
        def __init__(self):
            self.sfix_reg = Sfix(0.5, 0, -18)
            self.DELAY = 1

        def main(self, in_sfix):
            self.sfix_reg = in_sfix
            return self.sfix_reg

    dut = Simulation(SIM_HW_MODEL, model=Rst_Hw())
    dut.main([0.1])
    first_out = float(dut.pure_output[0])
    assert first_out == 0.5

    # make new simulation, registers must reset
    dut.main([0.1])
    first_out = float(dut.pure_output[0])
    assert first_out == 0.5


def test_numpy_complex64():
    pytest.skip('TODO')

    class T4(HW):
        def main(self, x):
            return x

    dut = T4()
    input = np.array([0.5 + 0.1j, 0.1 - 0.5j], dtype=np.complex64)
    assert_sim_match(dut, None, input, simulations=[SIM_HW_MODEL, SIM_RTL])
