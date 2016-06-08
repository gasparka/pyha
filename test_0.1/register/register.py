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




def clock_tick(func):
    def wrap(*args, **kwargs):
        from copy import deepcopy

        # first time, create the .next elem
        if 'next' not in args[0].__dict__:
            args[0].__dict__['next'] = deepcopy(args[0])

        args[0].__dict__.update(args[0].__dict__['next'].__dict__)
        const_self = deepcopy(args[0].__dict__)
        ret = func(*args, **kwargs)

        # ghetto code to alert when current value of reg is assigned
        const_self['next'] = args[0].__dict__['next']
        if const_self != args[0].__dict__:
            raise  Exception('You wrote to the current value of register, assure all writes go to self.next!')

        return ret

    return wrap

class Register3(object):
    def __init__(self):
        self.my_reg = 0

    @clock_tick
    def main(self, new_value):
        self.next.my_reg = new_value
        self.my_reg = 2
        print(self.my_reg)
        return self.my_reg




r = Register3()
for i in range(10):
    r.main(i)
