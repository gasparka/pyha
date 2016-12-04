import matplotlib.pyplot as plt
import numpy as np
import pytest

from pyha.common.hwsim import HW
from pyha.simulation.simulation_interface import SIM_MODEL, Simulation


class MovingAverage(HW):
    def __init__(self, window_len):
        self.window_len = window_len

    def model_main(self, inputs):
        return np.convolve(inputs, np.ones((self.window_len,)) / self.window_len, mode='full')


@pytest.fixture(scope='module', params=[SIM_MODEL])
def dut(request):
    model = MovingAverage(4)
    return Simulation(request.param, model=model)


# New average = old average * (n-1)/n + new value /n
def tst(inp):
    N = 4
    res = [0]
    for i, x in enumerate(inp):
        # if i == 0: continue
        # res.append(res[i] + x - res[i] / N)
        res.append(res[i] * (N - 1) / N + x / N)

    return res
    # return [x/N for x in res]


def test_tmp():
    inp = np.random.uniform(-1, 1, 128)
    outp = tst(inp.tolist())

    plt.plot(inp)
    plt.plot(outp)
    plt.show()


def test_basic(dut):
    inp = np.random.uniform(-1, 1, 128)
    outp = dut.main(inp)

    outp2 = tst(inp.tolist())

    plt.plot(inp)
    plt.plot(outp)
    plt.plot(outp2)
    plt.show()
