# http://code.activestate.com/recipes/577283-decorator-to-expose-local-variables-of-a-function-/
# persistent_locals2 has been co-authored with Andrea Maffezzoli
import copy
import sys
from typing import List

from common.hwsim import deepish_copy
from common.sfix import Sfix


class persistent_locals2(object):
    def __init__(self, func):
        self.tmp_locals = {}
        self._locals = {}
        self.func = func
        self._call_count = 0
        self.multitype_vars = None

    def __call__(self, *args, **kwargs):
        def tracer(frame, event, arg):
            # Note: this runs for ALL returns, only the LAST frame is valid info
            # TODO: filter to only run for wanted methods return? (tried -> failed)
            if event == 'return':
                self.tmp_locals = frame.f_locals.copy()

        # tracer is activated on next call, return or exception
        sys.setprofile(tracer)
        # trace the function call
        res = self.func(self, *args, **kwargs)
        sys.setprofile(None)

        self._call_count += 1
        self.tmp_locals.pop('self')
        # check multitype
        for key, value in self.tmp_locals.items():
            if key in self._locals:
                if type(value) != type(self._locals[key]):
                    self.multitype_vars = key

        self._locals.update(copy.deepcopy(self.tmp_locals))

        return res

    def clear_locals(self):
        self._locals = {}

    @property
    def locals(self):
        return self._locals


def is_convertable(obj):
    allowed_types = [Sfix, int, bool]
    if type(obj) in allowed_types:
        return True
    elif isinstance(obj, List):
        # To check whether all elements are of the same type
        if len(set(map(type, obj))) == 1:
            if all(type(x) in allowed_types for x in obj):
                return True

    return False


# TODO: for initial values i just reject unconvertable types, this makes sense??
def initial_values(obj):
    ret = {}
    for key, val in obj.__dict__.items():
        if is_convertable(val):
            ret.update({key: val})
    return ret


class FunctionNotSimulated(Exception):
    pass


class VariableMultipleTypes(Exception):
    pass


class VariableNotConvertable(Exception):
    pass


def extract_locals(obj):
    ret = {}
    for method in dir(obj):
        call = getattr(obj, method)
        if type(call) == persistent_locals2:
            if call._call_count == 0:
                raise FunctionNotSimulated('\nClass: {}\nFunction: {}\n has not been simulated before conversion.'
                                           .format(type(obj).__name__, call.func.__name__))

            if call.multitype_vars is not None:
                raise VariableMultipleTypes('\nClass: {}\nFunction: {}\nVariable: {}\n is used with multiple types'
                                            .format(type(obj).__name__, call.func.__name__, call.multitype_vars))

            for key, val in call.locals.items():
                if not is_convertable(val):
                    raise VariableNotConvertable(
                        '\nClass: {}\nFunction: {}\nVariable: {}\nType: {},\n {} is not convertable.'
                        .format(type(obj).__name__, call.func.__name__, key, type(val).__name__, val))

            ret[call.func.__name__] = call.locals

    return ret
