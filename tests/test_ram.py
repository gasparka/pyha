import pytest
from pyha import Hardware, simulate, sims_close, Complex
from pyha.common.ram import RAM
import numpy as np

from pyha.simulation.simulation_interface import get_ran_gate_simulation
from pyha.simulation.vhdl_simulation import VHDLSimulation


def test_basic_init_zero():
    class T(Hardware):
        def __init__(self, data):
            self.ram = RAM(data)

        def main(self, addr, write_val):
            self.ram.delayed_write(addr, write_val)
            r = self.ram.delayed_read(addr)
            return r

    N = 32
    init = [0] * N
    dut = T(init)

    addr = list(range(N)) * 2
    val = list(range(N)) * 2
    sims = simulate(dut, addr, val, simulations=['PYHA', 'RTL', 'GATE'])

    if get_ran_gate_simulation():
        assert VHDLSimulation.last_logic_elements == 0
        assert VHDLSimulation.last_memory_bits == 1024
    assert sims_close(sims)


def test_basic_reserved_name():
    class T(Hardware):
        def __init__(self, data):
            self.signal = RAM(data)

        def main(self, addr, write_val):
            self.signal.delayed_write(addr, write_val)
            r = self.signal.delayed_read(addr)
            return r

    N = 128
    init = [0] * N
    dut = T(init)

    addr = list(range(N)) * 2
    val = list(range(N)) * 2
    sims = simulate(dut, addr, val, simulations=['PYHA', 'RTL', 'GATE'])

    if get_ran_gate_simulation():
        assert VHDLSimulation.last_logic_elements == 0
        assert VHDLSimulation.last_memory_bits == 4096
    assert sims_close(sims)


def test_basic_init_random():
    class T(Hardware):
        def __init__(self, data):
            self.ram = RAM(data)

        def main(self, addr, write_val):
            self.ram.delayed_write(addr, write_val)
            r = self.ram.delayed_read(addr)
            return r

    N = 128
    np.random.seed(0)
    init = np.random.randint(0, N, N)
    dut = T(init)

    addr = list(range(N)) * 2
    val = list(range(N)) * 2
    sims = simulate(dut, addr, val, simulations=['PYHA', 'RTL', 'GATE'])

    if get_ran_gate_simulation():
        # handling non-zero reset is done using LUTS :(
        assert VHDLSimulation.last_logic_elements == 1643
        assert VHDLSimulation.last_memory_bits == 3200
    assert sims_close(sims)


def test_conditional_write():
    """ Only write on some cycles """

    class T(Hardware):
        def __init__(self, data):
            self.ram = RAM(data)

        def main(self, addr, write_val):
            if addr > 6:
                self.ram.delayed_write(addr, write_val)
            r = self.ram.delayed_read(addr)
            return r

    N = 32
    init = [0] * N
    dut = T(init)

    addr = list(range(N)) * 2
    val = list(range(N)) * 2
    sims = simulate(dut, addr, val, simulations=['PYHA', 'RTL', 'GATE'])

    if get_ran_gate_simulation():
        assert VHDLSimulation.last_logic_elements == 47
        assert VHDLSimulation.last_memory_bits == 1024
    assert sims_close(sims)


def test_conditional_read():
    """ Only read on some cycles """

    class T(Hardware):
        def __init__(self, data):
            self.ram = RAM(data)

        def main(self, addr, write_val):
            self.ram.delayed_write(addr, write_val)
            if addr > 8:
                return self.ram.delayed_read(addr)
            else:
                return -1

    N = 32
    init = [0] * N
    dut = T(init)

    addr = list(range(N)) * 2
    val = list(range(N)) * 2
    sims = simulate(dut, addr, val, simulations=['PYHA', 'RTL', 'GATE'])
    if get_ran_gate_simulation():
        assert VHDLSimulation.last_logic_elements == 47
        assert VHDLSimulation.last_memory_bits == 1024
    assert sims_close(sims)


def test_two():
    class T(Hardware):
        def __init__(self, data1, data2):
            self.ram1 = RAM(data1)
            self.ram2 = RAM(data2)

        def main(self, addr, write_val):
            self.ram1.delayed_write(addr, write_val)
            r1 = self.ram1.delayed_read(addr)

            self.ram2.delayed_write(addr, write_val)
            r2 = self.ram2.delayed_read(addr)
            return r1, r2

    N = 128
    np.random.seed(0)
    init1 = np.random.randint(0, N, N)
    init2 = np.random.randint(0, N, N)
    dut = T(init1, init2)

    addr = list(range(N)) * 2
    val = list(range(N)) * 2
    sims = simulate(dut, addr, val, simulations=['PYHA', 'RTL', 'GATE'])
    if get_ran_gate_simulation():
        assert VHDLSimulation.last_logic_elements == 2722
        assert VHDLSimulation.last_memory_bits == 6400
    assert sims_close(sims)


def test_two_list():
    class T(Hardware):
        def __init__(self, data1, data2):
            self.ram = [RAM(data1), RAM(data2)]

        def main(self, addr, write_val):
            self.ram[0].delayed_write(addr, write_val)
            r1 = self.ram[0].delayed_read(addr)

            self.ram[1].delayed_write(addr, write_val)
            r2 = self.ram[1].delayed_read(addr)
            return r1, r2

    N = 128
    np.random.seed(0)
    init1 = np.random.randint(0, N, N)
    init2 = np.random.randint(0, N, N)
    dut = T(init1, init2)

    addr = list(range(N)) * 2
    val = list(range(N)) * 2
    if get_ran_gate_simulation():
        assert VHDLSimulation.last_logic_elements == 2722
        assert VHDLSimulation.last_memory_bits == 6400
    sims = simulate(dut, addr, val, simulations=['PYHA', 'RTL', 'GATE'])
    assert sims_close(sims)


def test_submodule():
    class T(Hardware):
        def __init__(self, data1):
            self.ram1 = RAM(data1)

        def main(self, addr, write_val):
            self.ram1.delayed_write(addr, write_val)
            r = self.ram1.delayed_read(addr)
            return r

    class Top(Hardware):
        def __init__(self, data1):
            self.t = T(data1)

        def main(self, addr, write_val):
            r1 = self.t.main(addr, write_val)
            return r1

    N = 128
    np.random.seed(0)
    init1 = np.random.randint(0, N, N)
    dut = Top(init1)

    addr = list(range(N)) * 2
    val = list(range(N)) * 2
    sims = simulate(dut, addr, val, simulations=['PYHA', 'RTL', 'GATE'])
    if get_ran_gate_simulation():
        # handling non-zero reset is done using LUTS :(
        assert VHDLSimulation.last_logic_elements == 1643
        assert VHDLSimulation.last_memory_bits == 3200
    assert sims_close(sims)


def test_submodule_lists():
    class T(Hardware):
        def __init__(self, data1, data2):
            self.ram = [RAM(data1), RAM(data2)]

        def main(self, addr, write_val):
            self.ram[0].delayed_write(addr, write_val)
            r1 = self.ram[0].delayed_read(addr)

            self.ram[1].delayed_write(addr, write_val)
            r2 = self.ram[1].delayed_read(addr)
            return r1, r2

    class Top(Hardware):
        def __init__(self, data1, data2):
            self.submods = [T(data1, data2), T(data1, data2)]

        def main(self, addr, write_val):
            r1, r2 = self.submods[0].main(addr, write_val)
            r3, r4 = self.submods[1].main(addr, write_val)
            return r1, r2, r3, r4

    N = 128
    np.random.seed(0)
    init1 = np.random.randint(0, N, N)
    init2 = np.random.randint(0, N, N)
    dut = Top(init1, init2)

    addr = list(range(N)) * 2
    val = list(range(N)) * 2
    sims = simulate(dut, addr, val, simulations=['PYHA', 'RTL', 'GATE'])
    if get_ran_gate_simulation():
        assert VHDLSimulation.last_logic_elements == 2735
        assert VHDLSimulation.last_memory_bits == 12800
    assert sims_close(sims)


def test_two_reads():
    """ Quartus failed to infer RAM if there was no implicit read register.
    More important seems to be 'self.ram.read_reg <= self.ram.data(self_next.ram.read_address);' in top.vhd
    """
    class T(Hardware):
        def __init__(self, data):
            self.ram = RAM(data)
            self.read = 0

        def main(self, addr, addr2):
            self.ram.delayed_write(addr, addr2)
            if addr > addr2:
                self.read = self.ram.delayed_read(addr)
            else:
                self.read = self.ram.delayed_read(addr2)

            return self.read

    N = 128
    init = [0] * N
    dut = T(init)

    addr = np.random.randint(0, N, N)
    addr2 = np.random.randint(0, N, N)
    sims = simulate(dut, addr, addr2, simulations=['PYHA',
                                                   # 'RTL',
                                                   'GATE'
                                                   ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    if get_ran_gate_simulation():
        assert VHDLSimulation.last_logic_elements == 71
        assert VHDLSimulation.last_memory_bits == 4096
    assert sims_close(sims)


def test_read_modify_write():
    pytest.skip('Single cycle RMW not supported :(')
    class T(Hardware):
        def __init__(self, data):
            self.ram = RAM(data)

        def main(self, addr):
            read = self.ram.delayed_read(addr)
            self.ram.delayed_write(addr, read + 1)
            return read

    N = 8
    init = [0] * N
    dut = T(init)

    addr = list(range(N)) * 4
    sims = simulate(dut, addr, simulations=['PYHA',
                                            'RTL',
                                            'GATE'
                                            ],
                    conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims)
