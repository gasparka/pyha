import sys
from functools import wraps

from common.sfix import Sfix


class FunctionNotSimulated(Exception):
    def __init__(self, class_name, function_name):
        message = 'Function not simulated before conversion!\nClass: {}\nFunction: {}'.format(class_name, function_name)
        super().__init__(message)


class VariableNotConvertable(Exception):
    def __init__(self, class_name, function_name, variable_name, variable):
        message = 'Variable not convertable!\nClass: {}\nFunction: {}\nVariable: {}\nValue: {}:{}'.format(
            class_name, function_name, variable_name, type(variable), variable)
        super().__init__(message)



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
        from common.hwsim import dict_types_consistent_check
        dict_types_consistent_check(class_name, func.__name__, TraceManager.last_call_locals, func.fdict['locals'])

        func.fdict['locals'].update(TraceManager.last_call_locals)

        # in case nested call, restore the tracer function
        TraceManager.restore_profile()
        return res

    return locals_hack_wrap


def is_convertible(obj):
    allowed_types = [Sfix, int, bool]
    if type(obj) in allowed_types:
        return True
    elif isinstance(obj, list):
        # To check whether all elements are of the same type
        if len(set(map(type, obj))) == 1:
            if all(type(x) in allowed_types for x in obj):
                return True

    return False


# TODO: for initial values i just reject unconvertable types, this makes sense??
def extract_datamodel(obj):

    ret = {}
    for key, val in obj.__dict__['__initial_self__'].__dict__.items():
        if is_convertible(val):
            # for Sfix use the initial value but LATEST bounds
            if isinstance(val, Sfix):
                last = obj.next.__dict__[key]
                val = Sfix(val.init_val, last.left, last.right)

            # elif isinstance(val, list) and isinstance(val[0], Sfix):
            #     x. for x in obj.__dict__[key]
            #     val = []


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
                if not is_convertible(val):
                    raise VariableNotConvertable(class_name, call.__name__, key, val)

            ret[call.__name__] = call.fdict['locals']

    return ret
