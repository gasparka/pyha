from pyha.common.fixed_point import Sfix
from pyha.common.core import Hardware
from pyha.simulation.simulation_interface import assert_sim_match

""" This example shows how multiple classes can be used in one sequential design.
Everything is sequentially executed, you can use debugger to step around in code.
Itself it does nothing useful."""


class A0(Hardware):
    """ Simple module that has one Sfix register """

    def __init__(self, initial_value):
        self.reg = Sfix(initial_value) # lazy sfix, bounds determined by simulation

        # how much does this block delay data flow?
        self.DELAY = 1

    def main(self, new):
        self.next.reg = new
        return self.reg


class A1(Hardware):
    """ This module has a Sfix register and an A0 submodule registers """

    def __init__(self, initial_value):
        self.submodule = A0(initial_value)
        self.reg = Sfix(0.98)  # lazy sfix, bounds determined by simulation

        # how much does this block delay data flow?
        self.DELAY = self.submodule.DELAY + 1

    def main(self, new):
        # call submodule
        r = self.submodule.main(new)
        self.next.reg = new
        return r, self.reg


class A2(Hardware):
    """ This module has list of registers and submodules """

    def __init__(self):
        # list of submodules
        self.sub_list = [A1(0.1), A1(0.2)]
        self.sfix_list = [Sfix(0)] * 12
        self.sum = Sfix()

        # how much does this block delay data flow?
        self.DELAY = self.sub_list[0].DELAY

    def main(self, new):
        # call submodules functions
        for x in self.sub_list:
            r1, r2 = x.main(new)

        return r1, r2


# TEST
def test_sim_case2():
    dut = A2()

    x = [0.1, 0.2, 0.3, 0.4]  # inputs
    assert_sim_match(dut,
                     [Sfix(left=0, right=-17)],  # inputs will be casted to this types
                     None,  # expected result, if None assert all simulations are the same
                     x,  # inputs
                     simulations=[PYHA,  # simulates in python
                                  RTL,  # requires GHDL and CocoTB
                                  GATE]  # requires Quartus and compiled libs
                     , dir_path='/home/gaspar/git/pyha/examples/deep_sequential/conversion'
                     # where to write conversion stuff
                     )
