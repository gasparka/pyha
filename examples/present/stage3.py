from examples.present.stage0 import Demo
from pyha.common.core import Hardware
from pyha.simulation.simulation_interface import *

""" Demo sharingut ja in/out interfeissi """


class ArraySharingDemo(Hardware):
    def __init__(self):
        self.components = [Demo(), Demo(), Demo(), Demo()]
        self.state = 0

    def main(self, coef, input):
        out = self.components[self.state].main(coef, input)

        # next_state = self.state + 1
        # if next_state >= len(self.components):
        #     next_state = 0
        #
        # self.state = next_state
        # self.state = min(len(self.components), self.state + 1)
        self.state = self.state + 1
        if self.state >= len(self.components):
            self.state = 0

        return out


class MoreDemo(Hardware):
    def __init__(self):
        self.reg = ArraySharingDemo()

    def main(self, array_demo):
        self.reg = array_demo
        self.reg[0].accumulator = self.reg[0].accumulator + 1

        return self.reg


def test_demo():
    """ Siin vist testi pole mõtet näidata ..."""
    coefs = list(range(8))
    inputs = list(range(8))

    model = ArraySharingDemo()
    sims = simulate(model, coefs, inputs, simulations=[MODEL, PYHA, RTL, GATE],
                    conversion_path='/home/gaspar/git/pyha/playground')

    print(sims['MODEL'])
    print(sims['HW_MODEL'])
    # plt.plot(sims['MODEL'])
    # plt.plot(sims['HW_MODEL'])
    # plt.plot(sims['RTL'])
    # plt.show()

    print(sims)
