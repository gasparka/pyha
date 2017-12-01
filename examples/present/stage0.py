import matplotlib.pyplot as plt

from pyha.common.hwsim import Hardware
from pyha.simulation.simulation_interface import *

""" Algatuseks kasutame integer tüüpi, pärast tuleb fixed """


class Demo(Hardware):
    def __init__(self):
        self.accumulator = 0
        self.DELAY = 1

    def main(self, coef, input):
        self.accumulator = self.accumulator + coef * input
        return self.accumulator


def test_demo():
    """ Põhiidee tuua sisse unit testid ja näidata, et iga mudeli kohta on vaja ainult ühte testi """
    coefs = list(range(128))
    inputs = list(range(128))

    model = Demo()
    sims = simulate(model, coefs, inputs, simulations=[MODEL, PYHA, RTL, GATE],
                    conversion_path='/home/gaspar/git/pyha/playground')

    plt.plot(sims['MODEL'])
    plt.plot(sims['HW_MODEL'])
    plt.plot(sims['RTL'])
    plt.show()

    print(sims)
