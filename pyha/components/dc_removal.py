from pyha.common.hwsim import HW
# from pyha.common.sfix import resize
from pyha.common.sfix import resize, Sfix
from pyha.components.moving_average import MovingAverage


class DCRemoval(HW):
    def __init__(self, window_len):
        self.moving_average = MovingAverage(window_len)
        self.delay_x = Sfix()
        self.out = Sfix()

    def main(self, x):
        av = self.next.moving_average.main(x)
        # TODO: self.call should error, self.next is correct...actually who cares?
        # MovingAverage.main(self.next.moving_average, x, ret_0=>av)
        self.next.delay_x = x
        self.next.out = resize(self.delay_x-av, size_res=x)
        return self.out

    def get_delay(self):
        return 2

    def model_main(self, x):
        av = self.moving_average.model_main(x)
        return x - av


class Tst(HW):
    def __init__(self, window_len):
        self.moving_average = MovingAverage(window_len)
        self.moving_average2 = MovingAverage(window_len)
        # self.delay_x = Sfix()
        # self.out = Sfix()

    def main(self, x):
        av = self.moving_average.main(x)
        av2 = self.moving_average2.main(av)
        return av2
        # xd = self.moving_average.match_delay(x)
        # self.next.delay_x = x
        # self.next.out = resize(self.delay_x-av, size_res=x)
        # return self.out

    def get_delay(self):
        return 2

    def model_main(self, x):
        av = self.moving_average.model_main(x)
        # return av
        av2 = self.moving_average2.model_main(av)
        return av2
