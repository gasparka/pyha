from pyha.common.hwsim import HW
# from pyha.common.sfix import resize
from pyha.common.sfix import resize, Sfix
from pyha.components.moving_average import MovingAverage


class QuadratureDemod(HW):
    def __init__(self):
        pass

    def main(self, x):
        pass

    def get_delay(self):
        return 0

    def model_main(self, x):
        tmp = x
        for mav in self.next.mavg:
            tmp = mav.model_main(tmp)

        return x - tmp