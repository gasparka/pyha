from pyha.common.hwsim import HW
# from pyha.common.sfix import resize
from pyha.common.sfix import resize, Sfix
from pyha.components.moving_average import MovingAverage


class DCRemoval(HW):
    def __init__(self, window_len):
        self.mavg = [MovingAverage(window_len) for _ in range(2)]
        self.delay_x = Sfix()
        self.delay_x2 = Sfix()
        self.out = Sfix()

        self._delay = 3

    def main(self, x):

        # run sample trough all moving averages
        tmp = x
        for mav in self.mavg:
            tmp = mav.main(tmp)

        self.next.delay_x = x
        self.next.delay_x2 = self.delay_x
        self.next.out = resize(self.delay_x2 - tmp, size_res=x)
        return self.out

    def model_main(self, x):
        tmp = x
        for mav in self.mavg:
            tmp = mav.model_main(tmp)

        return x - tmp
