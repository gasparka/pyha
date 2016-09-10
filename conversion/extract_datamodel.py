import sys
from functools import wraps
from typing import List

from common.sfix import Sfix


class FunctionNotSimulated(Exception):
    def __init__(self, class_name, function_name):
        message = 'Function not simulated before conversion!\nClass: {}\nFunction: {}'.format(class_name, function_name)
        super().__init__(message)


class TypeNotConsistent(Exception):
    def __init__(self, class_name, function_name, variable_name, old, new):
        message = 'Self/local not consistent type!\nClass: {}\nFunction: {}\nVariable: {}\nOld: {}:{}\nNew: {}:{}'.format(
            class_name, function_name, variable_name, type(old), repr(old), type(new), new)
        super().__init__(message)


class VariableNotConvertable(Exception):
    def __init__(self, class_name, function_name, variable_name, variable):
        message = 'Variable not convertable!\nClass: {}\nFunction: {}\nVariable: {}\nValue: {}:{}'.format(
            class_name, function_name, variable_name, type(variable), variable)
        super().__init__(message)


class AssignToSelf(Exception):
    def __init__(self, class_name, variable_name):
        message = 'Assigment to self.{}, did you mean self.next.{}?\nClass: {}'.format(
            variable_name, variable_name, class_name)
        super().__init__(message)


def dict_types_consistent_check(class_name, function_name, new, old):
    """ Check 'new' dict against 'new' dict for types, if not consistent raise """
    for key, value in new.items():
        if key in old:
            old_value = old[key]
            if isinstance(value, Sfix):
                if value.left != old_value.left or value.right != old_value.right:
                    raise TypeNotConsistent(class_name, function_name, key, old, new)
            elif type(value) != type(old_value):
                raise TypeNotConsistent(class_name, function_name, key, old, new)


class TraceManager:
    """ Enables nested functions calls, thanks to ref counting """
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
    """ Use system trace to get function locals after each call """
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
        dict_types_consistent_check(class_name, func.__name__, TraceManager.last_call_locals, func.fdict['locals'])

        func.fdict['locals'].update(TraceManager.last_call_locals)

        # in case nested call, restore the tracer function
        TraceManager.restore_profile()
        return res

    return locals_hack_wrap


def forbid_assign_to_self(func, class_name):
    """ In Hapy user should only assign to self.next.X, any assign to
        'self.X' is a bug and this decorator tests for that """

    @wraps(func)
    def forbid_assign_to_self_wrap(*args, **kwargs):
        from common.hwsim import deepish_copy
        old = deepish_copy(args[0].__dict__)
        res = func(*args, **kwargs)

        for key, value in args[0].__dict__.items():
            if key == 'next':
                continue
            if value != old[key]:
                raise AssignToSelf(class_name, key)

        return res

    return forbid_assign_to_self_wrap


def self_type_consistent_checker(func, class_name):
    """ After each __call__, check that 'self' has consistent types(only single type over time)
     This only checks the 'next' dict, since assign to 'normal' dict **should** be impossible
    """

    calls = 0

    @wraps(func)
    def self_type_consistent_checker_wrap(*args, **kwargs):
        nonlocal calls
        calls += 1
        if calls == 1:
            return func(*args, **kwargs)

        from common.hwsim import deepish_copy
        nxt = args[0].__dict__['next'].__dict__
        old = deepish_copy(nxt)
        res = func(*args, **kwargs)
        new = nxt

        dict_types_consistent_check(class_name, func.__name__, new, old)

        return res

    return self_type_consistent_checker_wrap


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
    class_name = type(obj).__name__
    for method in dir(obj):
        if method == '__init__': continue
        call = getattr(obj, method)
        if hasattr(call, 'knows_locals'):
            if call.fdict['calls'] == 0:
                raise FunctionNotSimulated(class_name, call.__name__)

            for key, val in call.fdict['locals'].items():
                if not is_convertable(val):
                    raise VariableNotConvertable(class_name, call.__name__, key, val)

            ret[call.__name__] = call.fdict['locals']

    return ret
