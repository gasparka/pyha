import numpy as np

from pyha.common.fixed_point import Sfix, resize, fixed_truncate
from pyha.common.hwsim import Hardware


class BigFir(Hardware):
    def __init__(self, coef):
        self.coef = coef

        # define output registers
        # bounds will be determined during simulation
        self.out_resized = Sfix()

        # constants
        self.coef_f = Sfix(coef, 0, -17)

        # uncomment this and quartus will optimize away multiplication (assuming coef=0.5)
        # self.coef_f = Const(Sfix(coef, 0, -17))

        self.DELAY = 1

    def main(self, input):
        # this will also infer saturation logic
        # for registers you always assign to self.next
        self.next.out_resized = resize(input * self.coef_f, size_res=input,
                                       round_style=fixed_truncate)

        return self.out_resized

    def model_main(self, input_list):
        # note that model works on lists
        return np.array(input_list) * self.coef


def test_basic():
    from pyha.simulation.legacy import assert_sim_match
    dut = BigFir(coef=0.5)
    inputs = [0.1, 0.2, 0.3, 0.2, 0.1]
    expect = [0.05, 0.1, 0.15, 0.1, 0.05]

    assert_sim_match(dut,
                     [Sfix(left=0, right=-17)],
                     expect, inputs,
                     rtol=1e-4,
                     dir_path='/home/gaspar/git/pyha/examples/basic_usage/conversion')
