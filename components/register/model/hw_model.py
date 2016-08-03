from common.sfix import Sfix
from misc.metaclass.hwsim import HW


class Register(HW):

    def __init__(self, init_value=0.):
        self.init_value = init_value
        self.input_sfix = [Sfix(init_value, 0, -27)]

        def reset():
            self.a = Sfix(self.init_value, 0, -27)

        reset()

    def reset(self):
        self.a = Sfix(self.init_value, 0, -27)

    @property
    def delay(self):
        return 1

    def __call__(self, next):
        self.next.a = next
        return self.a
