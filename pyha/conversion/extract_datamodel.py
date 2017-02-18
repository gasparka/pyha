from pyha.common.hwsim import HW, PyhaFunc, SKIP_FUNCTIONS, is_convertible, PYHA_VARIABLES
from pyha.common.sfix import Sfix, ComplexSfix


class FunctionNotSimulated(Exception):
    def __init__(self, class_name, function_name):
        message = f'Function not simulated before conversion!\nClass: {class_name}\nFunction: {function_name}'
        super().__init__(message)


class VariableNotConvertible(Exception):
    def __init__(self, class_name, function_name, variable_name, variable):
        message = f'Variable not convertable!\nClass: {class_name}\nFunction: {function_name}\nVariable: {variable_name}\nValue: {type(variable)}:{variable}'
        super().__init__(message)


def extract_datamodel(obj):
    ret = {}
    for key, val in obj.__dict__['_pyha_initial_self'].__dict__.items():
        if key in PYHA_VARIABLES:
            continue
        if is_convertible(val):
            last = obj.__dict__[key]
            # for Sfix use the initial value but LATEST bounds
            if isinstance(val, Sfix):
                val = Sfix(val.init_val, last.left, last.right)
            elif isinstance(val, ComplexSfix):
                val = ComplexSfix(val.init_val, last.left, last.right)
            elif isinstance(val, list) and isinstance(val[0], Sfix):
                val = [Sfix(new_val.init_val, last_val.left, last_val.right) for new_val, last_val in zip(val, last)]
            elif isinstance(val, HW):
                val = last
            elif isinstance(val, list) and isinstance(val[0], HW):
                # list of submodules
                # set all to single id
                val = last
                first_id = val[0]._pyha_instance_id
                for x in val:
                    x._pyha_instance_id = first_id
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
        self.obj = obj
        if obj is None:
            self.self_data = None if self_data is None else self_data
            self.locals = None if locals is None else locals
            self.constants = {}
        else:
            dm = extract_datamodel(obj)

            constants = obj._pyha_constants

            # remove constants from self data
            dm_clean = {k: v for k, v in dm.items() if k not in constants}
            if len(dm_clean) == 0:
                dm_clean['much_dummy_very_wow'] = 0  # this simplifies many testing code
            loc = extract_locals(obj)
            self.self_data = dm_clean
            self.locals = loc
            self.constants = constants

    def __str__(self):
        return f'self_data: {self.self_data}\tlocals: {self.locals}'
