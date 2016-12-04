import matplotlib.pyplot as plt
import numpy as np
import pytest

from pyha.simulation.simulation_interface import SIM_MODEL, Simulation


class MovingAverage:
    def __init__(self, window_len):
        self.window_len = window_len

    def model_main(self, inputs):
        return np.convolve(inputs, np.ones((self.window_len,)) / self.window_len, mode='full')


@pytest.fixture(scope='module', params=[SIM_MODEL])
def dut(request):
    model = MovingAverage(4)
    return Simulation(request.param, model=model)


def test_basic(dut):
    inp = np.random.uniform(-1, 1, 128)
    outp = dut.main(inp)

    plt.plot(inp)
    plt.plot(outp)
    plt.show()
