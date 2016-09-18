from common.hwsim import HW


class Register(HW):
    def __init__(self, init_value=0.):
        self.a = init_value

    @property
    def delay(self):
        return 1

    def __call__(self, next):
        self.next.a = next
