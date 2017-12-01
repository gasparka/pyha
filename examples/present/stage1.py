from examples.present.stage0 import Demo
from pyha.common.hwsim import Hardware
from pyha.simulation.simulation_interface import *

""" Demoda kuidas taaskasutus toimib ... serial ja parallel"""


class DualDemo(Hardware):
    def __init__(self):
        self.first = Demo()
        self.second = Demo()

    def main2(self, coef, input):
        first_out = self.first.main(coef, input)
        second_out = self.second.main(coef, input)

        return first_out, second_out

    def main(self, coef, input):
        first_out = self.first.main(coef, input)
        second_out = self.second.main(coef, first_out)

        return second_out


def test_demo():
    """ Siin vist testi pole mõtet näidata ..."""
    coefs = list(range(8))
    inputs = list(range(8))

    model = DualDemo()
    sims = simulate(model, coefs, inputs, simulations=[MODEL, PYHA, RTL, GATE],
                    conversion_path='/home/gaspar/git/pyha/playground')
    print(sims['MODEL'])
    print(sims['HW_MODEL'])
    # plt.plot(sims['MODEL'])
    # plt.plot(sims['HW_MODEL'])
    # plt.plot(sims['RTL'])
    # plt.show()

    print(sims)
