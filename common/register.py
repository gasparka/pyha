from six import iteritems

REG_DELAY_ENABLED = 1


def enable_reg_delay():
    global REG_DELAY_ENABLED
    REG_DELAY_ENABLED = 1


def disable_reg_delay():
    global REG_DELAY_ENABLED
    REG_DELAY_ENABLED = 0


# https://writeonly.wordpress.com/2009/05/07/deepcopy-is-a-pig-for-simple-data/
def deepish_copy(org):
    '''
    much, much faster than deepcopy, for a dict of the simple python types.
    '''
    out = dict().fromkeys(org)
    # for k,v in org.iteritems():

    # for k,v in org.items():
    for k, v in iteritems(org):
        try:
            out[k] = v.copy()  # dicts, sets
        except AttributeError:
            try:
                out[k] = v[:]  # lists, tuples, strings, unicode
            except TypeError:
                out[k] = v  # ints

    return out

def clock_tick(func):
    def clock_tick_wrap(*args, **kwargs):
        from copy import deepcopy

        # first time, create the .next elem
        if 'next' not in args[0].__dict__:
            args[0].__dict__['next'] = deepcopy(args[0])

        if not REG_DELAY_ENABLED:
            # registers disabled set next equal to q.
            # clearly also have to disable q write check
            args[0].__dict__['next'] = args[0]
            ret = func(*args, **kwargs)
        else:
            now = args[0].__dict__
            next = args[0].__dict__['next'].__dict__
            # pickle.loads(pickle.dumps(next, -1))
            # lol = pickle.dump(next)

            now.update(deepish_copy(next))
            # import cPickle as pickle
            # now.update(pickle.loads(pickle.dumps(next, -1)))
            # now.update(next)

            # args[0].__dict__.update(deepcopy(args[0].__dict__['next'].__dict__))


            ret = func(*args, **kwargs)

            # ghetto code to alert when current value of reg is assigned
            # const_self['next'] = args[0].__dict__['next']
            # if const_self != args[0].__dict__:
            #     raise Exception('You wrote to the current value of register, assure all writes go to self.next!')

        return ret

    return clock_tick_wrap

# def test():
#     class S(object):
#         def __init__(self):
#             self.tmp = 0
#             self.list = [x for x in range(128)]
#
#         @clock_tick
#         def main_ok(self):
#             self.next.tmp = 1
#
#         @clock_tick
#         def main_bad(self):
#             self.tmp = 2
#
#         @clock_tick
#         def list_bad(self):
#             self.list[0] = 5
#
#         @clock_tick
#         def list_ok(self):
#             self.next.list[10] = 5
#
#     dut = S()
#     dut.main_ok()
#     dut.main_ok()
#     assert dut.tmp == 1
#
#     # this fails when value is already same
#     with pytest.raises(Exception):
#         dut.main_bad()
#
#     with pytest.raises(Exception):
#         dut.list_bad()
#
#     # args[0].__dict__.update(deepcopy(args[0].__dict__['next'].__dict__))
#     # need that inner deepcopy to make this work
#     dut.list_ok()
#
#     # TODO: THIS FAILS
#     class B(object):
#         def __init__(self):
#             self.taps = signal.remez(16, [0, 0.1, 0.2, 0.5], [1, 0]).tolist()
#
#         @clock_tick
#         def main(self):
#             pass
#
#     dut = B()
#     dut.main()
#
# # test()
