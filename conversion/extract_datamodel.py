# http://code.activestate.com/recipes/577283-decorator-to-expose-local-variables-of-a-function-/
# persistent_locals2 has been co-authored with Andrea Maffezzoli
import sys
from typing import List

from common.sfix import Sfix


class persistent_locals2(object):
    def __init__(self, func):
        self._locals = {}
        self.func = func
        self._call_count = 0

    def __call__(self, *args, **kwargs):
        def tracer(frame, event, arg):
            if event == 'return':
                self._locals = frame.f_locals.copy()
                del self._locals['self']
                self._call_count += 1

        # tracer is activated on next call, return or exception
        sys.setprofile(tracer)
        try:
            # trace the function call
            res = self.func(self, *args, **kwargs)
        finally:
            # disable tracer and replace with old one
            sys.setprofile(None)
        return res

    def clear_locals(self):
        self._locals = {}

    @property
    def locals(self):
        return self._locals


def is_convertable(obj):
    if isinstance(obj, Sfix) or isinstance(obj, int):
        return True
    elif isinstance(obj, List):
        sfix_list = all([isinstance(x, Sfix) for x in obj])
        int_list = all([isinstance(x, int) for x in obj])
        if sfix_list or int_list:
            return True

    return False


# TODO: for initial values i just reject unconvertable types, this makes sense??
def initial_values(obj):
    ret = {}
    for key, val in obj.__dict__.items():
        if is_convertable(val):
            ret.update({key: val})
    return ret


def extract_locals(obj):
    ret = {}
    if hasattr(obj, '__call__'):
        call = obj.__call__
        if call._call_count == 0:
            raise Exception('\nClass: {}\nFunction: {}\n has not been simulated before conversion.'
                            .format(type(obj).__name__, call.func.__name__))

        for key, val in call.locals.items():
            if not is_convertable(val):
                raise Exception('\nClass: {}\nFunction: {}\nVariable: {}\nType: {},\n {} is not convertable.'
                                .format(type(obj).__name__, call.func.__name__, key, type(val).__name__, val))

        ret[call.func.__name__] = call.locals

    return ret
