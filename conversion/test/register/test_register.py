from LEGACY.misc.metaclass.hwsim import HW
from common.sfix import Sfix


class Register(HW):
    def __init__(self, init_value=0.):
        self.a = Sfix(init_value, 0, -27)

    def __call__(self, new_value):
        self.next.a = new_value


def test_shit():
    pass
    pass
