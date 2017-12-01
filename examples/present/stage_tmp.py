import matplotlib.pyplot as plt

from pyha.common.core import Hardware
from pyha.simulation.simulation_interface import *

""" Algatuseks kasutame integer tüüpi, pärast tuleb fixed """


class Demo(Hardware):

    def f(self, in0):
        return in0 + 1

    def main(self, in0):
        add = self.f(in0)
        mul = in0 * 123
        return add, mul


def test_demo():
    """ Põhiidee tuua sisse unit testid ja näidata, et iga mudeli kohta on vaja ainult ühte testi """
    coefs = list(range(128))
    inputs = list(range(128))

    model = Demo()
    sims = simulate(model, coefs, simulations=[MODEL, PYHA, RTL, GATE],
                    conversion_path='/home/gaspar/git/pyha/playground')

    plt.plot(sims['MODEL'])
    plt.plot(sims['HW_MODEL'])
    plt.plot(sims['RTL'])
    plt.show()

    print(sims)
