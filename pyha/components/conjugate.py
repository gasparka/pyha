from pyha.common.hwsim import HW
from pyha.common.sfix import resize, Sfix
from pyha.components.moving_average import MovingAverage
import numpy as np


class Conjugate(HW):
    def __init__(self):
        self.outi = Sfix()
        self.outq = Sfix()

    def main(self, x):
        pass

    def get_delay(self):
        return 1

    def model_main(self, x):
        return np.conjugate(x)
