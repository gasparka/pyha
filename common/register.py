from copy import copy

REG_DELAY_ENABLED = 1


def enable_reg_delay():
    global REG_DELAY_ENABLED
    REG_DELAY_ENABLED = 1


def disable_reg_delay():
    global REG_DELAY_ENABLED
    REG_DELAY_ENABLED = 0


def clock_tick(func):
    def wrap(*args, **kwargs):
        from copy import deepcopy

        # first time, create the .next elem
        if 'next' not in args[0].__dict__:
            args[0].__dict__['next'] = deepcopy(args[0])

        if not REG_DELAY_ENABLED:
            args[0].__dict__['next'] = args[0]

        args[0].__dict__.update(args[0].__dict__['next'].__dict__)

        ret = func(*args, **kwargs)

        # ghetto code to alert when current value of reg is assigned
        const_self = copy(args[0].__dict__)
        const_self['next'] = args[0].__dict__['next']
        if const_self != args[0].__dict__:
            raise Exception('You wrote to the current value of register, assure all writes go to self.next!')

        return ret

    return wrap
