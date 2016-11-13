import functools
import sys
from collections import OrderedDict

from pyha.common.sfix import Sfix


class FunctionNotSimulated(Exception):
    def __init__(self, class_name, function_name):
        message = 'Function not simulated before conversion!\nClass: {}\nFunction: {}'.format(class_name, function_name)
        super().__init__(message)


class VariableNotConvertible(Exception):
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


class LocalsExtractor:
    def __init__(self, func, class_name):
        self.class_name = class_name
        self.func = func
        self.calls = 0
        self.knows_locals = True
        self.locals = {}

    def __call__(self, *args, **kwargs):
        TraceManager.set_profile()
        res = self.func(*args, **kwargs)
        TraceManager.remove_profile()

        self.calls += 1
        # TraceManager.last_call_locals.pop('self')
        from pyha.common.hwsim import dict_types_consistent_check
        dict_types_consistent_check(self.class_name, self.func.__name__, TraceManager.last_call_locals, self.locals)

        self.locals.update(TraceManager.last_call_locals)

        # in case nested call, restore the tracer function
        TraceManager.restore_profile()
        return res

    def __get__(self, obj, objtype):
        """Support instance methods."""
        return functools.partial(self.__call__, obj)


# def locals_hack(func, class_name):
#     """ Use system trace to get function locals after each call """
#     func.class_name = class_name
#     func.knows_locals = True
#     func.fdict = {'calls': 0, 'locals': {}, 'last_call_locals': {}}
#
#     @wraps(func)
#     def locals_hack_wrap(*args, **kwargs):
#         TraceManager.set_profile()
#         res = func(*args, **kwargs)
#         TraceManager.remove_profile()
#
#         func.fdict['calls'] += 1
#         TraceManager.last_call_locals.pop('self')
#         from pyha.common.hwsim import dict_types_consistent_check
#         dict_types_consistent_check(class_name, func.__name__, TraceManager.last_call_locals, func.fdict['locals'])
#
#         func.fdict['locals'].update(TraceManager.last_call_locals)
#
#         # in case nested call, restore the tracer function
#         TraceManager.restore_profile()
#         return res
#
#     return locals_hack_wrap


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


def extract_datamodel(obj):
    ret = {}
    for key, val in obj.__dict__['__initial_self__'].__dict__.items():
        if is_convertible(val):
            last = obj.next.__dict__[key]
            # for Sfix use the initial value but LATEST bounds
            if isinstance(val, Sfix):
                val = Sfix(val.init_val, last.left, last.right)
            elif isinstance(val, list) and isinstance(val[0], Sfix):
                val = [Sfix(new_val.init_val, last_val.left, last_val.right) for new_val, last_val in zip(val, last)]

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
                    raise VariableNotConvertible(class_name, call.__name__, key, val)

            ret[call.__name__] = call.fdict['locals']

    return ret

class DataModel:
    def __init__(self, obj=None, self_data=None, locals=None):
        if obj is None:
            self.self_data = None if self_data is None else OrderedDict(sorted(self_data.items(), key=lambda t: t[0]))
            self.locals = None if locals is None else OrderedDict(sorted(locals.items(), key=lambda t: t[0]))
        else:
            dm = extract_datamodel(obj)
            loc = extract_locals(obj)
            self.self_data = OrderedDict(sorted(dm.items()))
            self.locals = OrderedDict(sorted(loc.items()))

    def __str__(self):
        return 'self_data: {}\tlocals: {}'.format(self.self_data, self.locals)
