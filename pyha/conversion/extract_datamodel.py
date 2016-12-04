from collections import OrderedDict

from pyha.common.hwsim import PyhaFunc, SKIP_FUNCTIONS
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
        if method in SKIP_FUNCTIONS:  continue
        call = getattr(obj, method)
        # if hasattr(call, 'knows_locals'):
        if isinstance(call, PyhaFunc):
            if call.calls == 0:
                raise FunctionNotSimulated(class_name, call.func.__name__)

            for key, val in call.locals.items():
                if not is_convertible(val):
                    raise VariableNotConvertible(class_name, call.func.__name__, key, val)

            ret[call.func.__name__] = call.locals

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
