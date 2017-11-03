import matplotlib.pyplot as plt

from pyha.common.hwsim import Hardware
from pyha.simulation.simulation_interface import *

""" Fixed point! Lazy fixed point... """

class Demo(Hardware):
    def __init__(self):
        self.accumulator = Sfix()
        self.DELAY = 1

    def main(self, coef, input):
        self.accumulator = self.accumulator + coef * input
        return self.accumulator


def test_demo():
    """ Demo fixed point erinevust. Vb näita kuidas käsitis default tüüpi muuta?
    -1 to 1 normaliseermine
    """
    coefs = np.random.rand(8)
    inputs = np.random.rand(8)

    model = Demo()
    sims = simulate(model, coefs, inputs, simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL])

    plt.plot(sims['MODEL'])
    plt.plot(sims['HW_MODEL'])
    plt.plot(sims['RTL'])
    plt.show()

    print(sims)


