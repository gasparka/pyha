import sys
from functools import wraps
from typing import List

from common.sfix import Sfix


class FunctionNotSimulated(Exception):
    pass


class VariableMultipleTypes(Exception):
    pass


class VariableNotConvertable(Exception):
    pass


class TraceManager:
    last_call_locals = {}
    refcount = 0

    @classmethod
    def tracer(cls, frame, event, arg):
        # Note: this runs for ALL returns, only the LAST frame is valid info
        if event == 'return':
            cls.last_call_locals = frame.f_locals.copy()

    @classmethod
    def set_profile(cls):
        cls.refcount += 1
        sys.setprofile(TraceManager.tracer)

    @classmethod
    def remove_profile(cls):
        cls.refcount -= 1
        assert cls.refcount >= 0
        sys.setprofile(None)

    @classmethod
    def restore_profile(cls):
        if cls.refcount > 0:
            sys.setprofile(TraceManager.tracer)


def locals_hack(func, class_name):
    func.class_name = class_name
    func.knows_locals = True
    func.fdict = {'calls': 0, 'locals': {}, 'last_call_locals': {}}

    @wraps(func)
    def locals_hack_wrap(*args, **kwargs):

        TraceManager.set_profile()
        res = func(*args, **kwargs)
        TraceManager.remove_profile()

        func.fdict['calls'] += 1
        TraceManager.last_call_locals.pop('self')
        multitype_check()

        func.fdict['locals'].update(TraceManager.last_call_locals)

        # in case nested call, restore the tracer function
        TraceManager.restore_profile()
        return res

    def multitype_check():
        def bad(var_name, old, new):
            raise VariableMultipleTypes(
                'Variable with multiple types!\nClass: {}\nFunction: {}\nVariable: {}\nOld: {}:{}\nNew: {}:{}'
                    .format(class_name,
                            func.__name__, var_name, type(old), old, type(new), new))

        for key, value in TraceManager.last_call_locals.items():
            if key in func.fdict['locals']:
                old = func.fdict['locals'][key]
                if isinstance(value, Sfix):
                    if value.left != old.left or value.right != old.right:
                        bad(key, old, value)
                elif type(value) != type(old):
                    bad(key, old, value)

    locals_hack_wrap._inner = func
    return locals_hack_wrap


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


def extract_locals(obj):
    ret = {}
    for method in dir(obj):
        if method == '__init__': continue
        call = getattr(obj, method)
        if hasattr(call, 'knows_locals'):
            if call.fdict['calls'] == 0:
                raise FunctionNotSimulated('\nClass: {}\nFunction: {}\n has not been simulated before conversion.'
                                           .format(type(obj).__name__, call.__name__))

            # if call.multitype_vars is not None:
            #     raise VariableMultipleTypes('\nClass: {}\nFunction: {}\nVariable: {}\n is used with multiple types'
            #                                 .format(type(obj).__name__, call.func.__name__, call.multitype_vars))

            for key, val in call.fdict['locals'].items():
                if not is_convertable(val):
                    raise VariableNotConvertable(
                        '\nClass: {}\nFunction: {}\nVariable: {}\nType: {},\n {} is not convertable.'
                            .format(type(obj).__name__, call.__name__, key, type(val).__name__, val))

            ret[call.__name__] = call.fdict['locals']

    return ret
