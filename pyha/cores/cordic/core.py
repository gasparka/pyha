from enum import Enum
import numpy as np
from pyha import Hardware, Sfix, simulate, sims_close


class CordicMode(Enum):
    VECTORING, ROTATION = range(2)


class Cordic(Hardware):
    """
    CORDIC algorithm. This is meant for internal use... as the outputs are not in standard format.

    readable paper -> http://www.andraka.com/files/crdcsrvy.pdf

    :param iterations: resource/ precision trade off
    :param mode: vectoring or rotation
    """

    def __init__(self, iterations=17, mode=CordicMode.VECTORING, precision=-17):
        self.MODE = mode
        self.ITERATIONS = iterations + 1  # + 1 is for initial step registers it also helps pipeline code
        self.DELAY = self.ITERATIONS
        self.PHASE_LUT = [Sfix(np.arctan(2 ** -i) / np.pi, 0, precision, round_style='round') for i in range(self.ITERATIONS)]

        # pipeline registers
        # give 1 extra bit, as there is stuff like CORDIC gain.. in some cases 2 bits may be needed!
        # there will be CORDIC gain + abs value held by x can be > 1
        self.x = [Sfix(0, 1, precision)] * self.ITERATIONS
        self.y = [Sfix(0, 1, precision)] * self.ITERATIONS
        self.phase = [Sfix(0, 1, precision)] * self.ITERATIONS

    def initial_step(self, phase, x, y):
        """
        Transform input to the CORDIC working quadrants
        """
        self.x[0] = x
        self.y[0] = y
        self.phase[0] = phase
        if self.MODE == CordicMode.ROTATION:
            if phase > 0.5:
                # > np.pi/2
                self.x[0] = -x
                self.phase[0] = phase - 1.0
            elif phase < -0.5:
                # < -np.pi/2
                self.x[0] = -x
                self.phase[0] = phase + 1.0

        elif self.MODE == CordicMode.VECTORING:
            if x < 0.0 and y > 0.0:
                # vector in II quadrant -> initial shift by PI to IV quadrant (mirror)
                self.x[0] = -x
                self.y[0] = -y
                self.phase[0] = 1.0
                # self.phase[0] = 0.0
            elif x < 0.0 and y < 0.0:
                # vector in III quadrant -> initial shift by -PI to I quadrant (mirror)
                self.x[0] = -x
                self.y[0] = -y
                self.phase[0] = -1.0

    def main(self, x, y, phase):
        """
        Runs one step of pipelined CORDIC
        Returned phase is in 1 to -1 range
        """
        self.initial_step(phase, x, y)

        # pipelined CORDIC
        for i in range(self.ITERATIONS - 1):
            if self.MODE == CordicMode.ROTATION:
                direction = self.phase[i] > 0
            elif self.MODE == CordicMode.VECTORING:
                direction = self.y[i] < 0

            if direction:
                self.x[i + 1] = self.x[i] - (self.y[i] >> i)
                self.y[i + 1] = self.y[i] + (self.x[i] >> i)
                self.phase[i + 1] = self.phase[i] - self.PHASE_LUT[i]
            else:
                self.x[i + 1] = self.x[i] + (self.y[i] >> i)
                self.y[i + 1] = self.y[i] - (self.x[i] >> i)
                self.phase[i + 1] = self.phase[i] + self.PHASE_LUT[i]

        return self.x[-1], self.y[-1], self.phase[-1]


def test_vectoring():
    np.random.seed(123456)
    inputs = 0.5 * (np.random.rand(3, 128) * 2 - 1)

    dut = Cordic(16, CordicMode.VECTORING)
    sim_out = simulate(dut, *inputs)
    assert sims_close(sim_out, rtol=1e-4, atol=1e-4)


def test_rotation():
    np.random.seed(123456)
    inputs = 0.5 * (np.random.rand(3, 128) * 2 - 1)

    dut = Cordic(16, CordicMode.ROTATION)
    sim_out = simulate(dut, *inputs)
    assert sims_close(sim_out, atol=1e-4)
