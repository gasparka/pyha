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
        # tmp = x
        # for i in range(len(self.mavg)):
        #     tmp = self.next.mavg[i].main(tmp)
        tmp = x
        for mav in self.next.mavg:
            tmp = mav.main(tmp)

        self.next.delay_x = x
        self.next.delay_x2 = self.delay_x
        self.next.out = resize(self.delay_x2 - tmp, size_res=x)
        return self.out

    def model_main(self, x):
        tmp = x
        for mav in self.next.mavg:
            tmp = mav.model_main(tmp)

        return x - tmp


# class DCRemoval(HW):
#     def __init__(self, window_len):
#         self.avg1 = MovingAverage(window_len)
#         self.avg2 = MovingAverage(window_len)
#         self.delay_x = Sfix()
#         self.delay_x2 = Sfix()
#         self.out = Sfix()
#
#     def main(self, x):
#         av1 = self.next.avg1.main(x)
#         av2 = self.next.avg2.main(av1)
#
#         self.next.delay_x = x
#         self.next.delay_x2 = self.delay_x
#         self.next.out = resize(self.delay_x2 - av2, size_res=x)
#         return self.out
#
#     def get_delay(self):
#         return 3
#
#     def model_main(self, x):
#         av1 = self.avg1.model_main(x)
#         av2 = self.avg2.model_main(av1)
#         return x - av2


class Tst(HW):
    def __init__(self, window_len):
        self.moving_average = MovingAverage(window_len)
        self.moving_average2 = MovingAverage(window_len)
        # self.delay_x = Sfix()
        # self.out = Sfix()

        self._delay = 2

    def main(self, x):
        av = self.moving_average.main(x)
        av2 = self.moving_average2.main(av)
        return av2
        # xd = self.moving_average.match_delay(x)
        # self.next.delay_x = x
        # self.next.out = resize(self.delay_x-av, size_res=x)
        # return self.out

    def model_main(self, x):
        av = self.moving_average.model_main(x)
        # return av
        av2 = self.moving_average2.model_main(av)
        return av2
