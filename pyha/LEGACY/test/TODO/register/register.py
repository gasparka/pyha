from LEGACY.common.register import clock_tick


class Register(object):
    def __init__(self):
        self.my_reg = 0

    def main(self, new_value):
        self.my_reg = new_value
        return self.my_reg


class Register2(object):
    def __init__(self):
        self.my_reg = Reg()

    def main(self, new_value):
        self.my_reg.next = new_value
        return self.my_reg


def class_deco(cls):
    pass


# TODO: use metaclass instead of this horrid decoratro
# http://eli.thegreenplace.net/2011/08/14/python-metaclasses-by-example

class Register3(object):
    def __init__(self):
        self.my_reg = 0

    @clock_tick
    def main(self, new_value):
        self.next.my_reg = new_value
        # self.my_reg = 2
        print(self.my_reg)
        return self.my_reg


r = Register3()
for i in range(10):
    r.main(i)
