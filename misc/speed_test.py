import numpy as np

from components.cordic.hw.kernel import CORDICKernel
from components.cordic.model.cordic import CORDIC
from sim_automation.testing import Testing


class lol:
    def __init__(self, param):
        self.param = param


def dut():
    iterations = 18
    l = lol('HW-MODEL')
    dut = Testing(l, CORDIC(iterations), CORDICKernel(iterations), None)
    return dut


def main():
    kernel = dut()
    fs = 10e4
    periods = 1
    freq = 1
    phase_inc = 2 * np.pi * freq / fs
    phase_list = np.arange(0, periods * fs * phase_inc, phase_inc)

    x = [1 / 1.646760] * len(phase_list)
    y = [0] * len(phase_list)

    rx, ry, rphase = kernel(x, y, phase_list, mode='ROTATE')


if __name__ == "__main__":
    main()
    # python -m vmprof --web --web-auth b6955f5be6bb3a7a61587895253f6fd1306d1d42 test_newcoco.py
    # python - m vmprof - -web - -web - auth b6955f5be6bb3a7a61587895253f6fd1306d1d42 test_newcoco.py
