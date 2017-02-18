import sys
from copy import deepcopy, copy
from enum import Enum

import numpy as np
from six import iteritems, with_metaclass

from pyha.common.const import Const
from pyha.common.sfix import Sfix, ComplexSfix

"""
Purpose: Make python class simulatable as hardware, mainly provide 'register' behaviour
"""

# functions that will not be decorated/converted/parsed
SKIP_FUNCTIONS = ('__init__', 'model_main')

# Pyha related variables in the object __dict__
PYHA_VARIABLES = ('_pyha_constants', '_pyha_initial_self', 'next', '_pyha_submodules', '_pyha_instance_id', '_delay')


class AssignToSelf(Exception):
    def __init__(self, class_name, variable_name):
        message = f'Assigment to self.{variable_name}, did you mean self.next.{variable_name}?\nClass: {class_name}'
        super().__init__(message)


class TypeNotConsistent(Exception):
    def __init__(self, class_name, function_name, variable_name, old, new):
        # these clutter printing
        from contextlib import suppress
        with suppress(KeyError):  # only available for 'self'
            new.pop('_pyha_initial_self')
            old.pop('_pyha_initial_self')
        message = f'Self/local not consistent type!\nClass: {class_name}\nFunction: {function_name}\nVariable: {variable_name}\nOld: {type(old)}:{repr(old)}\nNew: {type(new)}:{new}'
        super().__init__(message)


def is_convertible(obj):
    allowed_types = [ComplexSfix, Sfix, int, bool, Const]
    if type(obj) in allowed_types:
        return True
    elif isinstance(obj, list):
        # To check whether all elements are of the same type
        if len(set(map(type, obj))) == 1:
            if all(type(x) in allowed_types for x in obj):
                return True
            elif isinstance(obj[0], HW):  # list of submodules
                return True
    elif isinstance(obj, Enum):
        return True
    elif isinstance(obj, HW):
        return True

    return False

def deepish_copy(org):
    """
    https://writeonly.wordpress.com/2009/05/07/deepcopy-is-a-pig-for-simple-data/
    much, much faster than deepcopy, for a dict of the simple python types.
    """
    out = dict().fromkeys(org)
    for k, v in iteritems(org):
        try:
            out[k] = v.copy()  # dicts, sets
        except AttributeError:
            try:
                out[k] = v[:]  # lists, tuples, strings, unicode
            except TypeError:
                # Without this assign to imag or real will fuck up everything
                out[k] = deepcopy(v)
                # if isinstance(v, ComplexSfix):
                #     out[k] = copy(v)
                # else:
                #     out[k] = v  # ints

    return out


class PyhaFunc:
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
            sys.setprofile(cls.tracer)

        @classmethod
        def remove_profile(cls):
            cls.refcount -= 1
            assert cls.refcount >= 0
            sys.setprofile(None)

        @classmethod
        def restore_profile(cls):
            if cls.refcount > 0:
                sys.setprofile(cls.tracer)

    def __init__(self, func):
        self.class_name = func.__self__.__class__.__name__
        self.function_name = func.__name__
        self.func = func
        self.calls = 0
        self.locals = {}

        # used for top_generator
        self.last_args = {}
        self.last_kwargs = {}
        self.last_return = {}

        self.is_main = self.function_name == 'main'

    def dict_types_consistent_check(self, new, old):
        """ Check 'old' dict against 'new' dict for types, if not consistent raise """
        for key, value in new.items():
            if key in old:
                old_value = old[key]
                if isinstance(value, (Sfix, ComplexSfix)):
                    if value.left != old_value.left or value.right != old_value.right:
                        if old_value.left == 0 and old_value.right == 0:
                            # sfix lazy init
                            continue
                        elif value.right == 0 and value.left == 0:
                            # sfix lazy init, can happen for pipelines
                            continue
                        elif value.val == old_value.init_val:
                            # this is a shady condition, it helps against sfix values propagating trough pipelines, but may also mask valid errors
                            # HERE is reason why sometimes consistency check fails!
                            continue
                        elif old_value.val == old_value.init_val:
                            # shady shady stuff, helps if initival junk value is resized..
                            continue

                        raise TypeNotConsistent(self.class_name, self.function_name, key, old, new)
                elif type(value) != type(old_value):
                    raise TypeNotConsistent(self.class_name, self.function_name, key, old, new)
                elif isinstance(value, list):
                    if len(old_value) != len(value):
                        raise TypeNotConsistent(self.class_name, self.function_name, key, old, new)

    def forbid_assign_to_self(self, new, old):
        """ User should only assign to self.next.X, any assign to
            'self.X' is a bug and this decorator tests for that """

        for key, value in new.items():
            if key == 'next' or isinstance(value, (np.ndarray, np.generic)):
                continue

            if value != old[key]:
                raise AssignToSelf(self.class_name, key)

    def call_with_locals_discovery(self, *args, **kwargs):
        """ Call decorated function with tracing to read back local values """
        self.TraceManager.set_profile()
        res = self.func(*args, **kwargs)
        self.TraceManager.remove_profile()

        self.TraceManager.last_call_locals.pop('self')
        # self.dict_types_consistent_check(self.TraceManager.last_call_locals, self.locals)

        self.locals.update(self.TraceManager.last_call_locals)

        # in case nested call, restore the tracer function
        self.TraceManager.restore_profile()
        return res

    def __call__(self, *args, **kwargs):

        self.last_args = args
        self.last_kwargs = kwargs
        real_self = self.func.__self__
        self.calls += 1

        # # CALL IS HERE!
        ret = self.call_with_locals_discovery(*args, **kwargs)

        self.last_return = ret

        real_self._outputs.append(ret)
        return ret


class Meta(type):
    """
    https://blog.ionelmc.ro/2015/02/09/understanding-python-metaclasses/#python-2-metaclass
    """
    instance_count = 0

    def validate_datamodel(cls, dict):
        # if list of submodules, make sure all 'constants' are the same
        for x in dict.values():
            if isinstance(x, list) and isinstance(x[0], HW):
                ref = x[0]._pyha_constants
                for listi in x:
                    di = listi._pyha_constants
                    if di != ref:
                        raise Exception(
                            f'List of submodules: {x}\n but constants are not equal!\n\nTry to remove Const() keyword.')

    def handle_constants(cls, dict):
        """ Go over dict and find all the constants. Remove the Const() wrapper
        and insert to _pyha_constants."""

        dict['_pyha_constants'] = {}
        for k, v in dict.items():
            if isinstance(v, Const):
                dict['_pyha_constants'][k] = v.value
                dict[k] = v.value

        # turn '_delay' into constant
        if '_delay' in dict:
            dict['_pyha_constants']['_delay'] = dict['_delay']

        return dict

    # ran when instance is made
    def __call__(cls, *args, **kwargs):
        ret = super(Meta, cls).__call__(*args, **kwargs)
        ret.__dict__ = cls.handle_constants(ret.__dict__)
        cls.validate_datamodel(ret.__dict__)

        ret._pyha_instance_id = cls.instance_count
        cls.instance_count += 1


        # give self.next to the new object
        ret.__dict__['next'] = type('next', (object,), {})()

        for k, v in ret.__dict__.items():
            if isinstance(v, HW) \
                    or k in PYHA_VARIABLES \
                    or (isinstance(v, list) and isinstance(v[0], HW)):
                continue
            if is_convertible(v):
                setattr(ret.next, k, deepcopy(v))

        # registery of submodules that need 'self update'
        ret._pyha_submodules = []
        for k, v in ret.__dict__.items():
            if k in PYHA_VARIABLES:
                continue
            if isinstance(v, HW):
                ret._pyha_submodules.append(v)
            elif isinstance(v, list) and v != [] and isinstance(v[0], HW):
                ret._pyha_submodules.append(v)

        # save the initial self values
        # all registers will be derived from these values!
        ret.__dict__['_pyha_initial_self'] = deepcopy(ret)

        # every call to 'main' will append returned values here
        ret._outputs = []

        # decorate all methods
        for method_str in dir(ret):
            if method_str in SKIP_FUNCTIONS:
                continue
            method = getattr(ret, method_str)
            if method_str[:2] != '__' and method_str[:1] != '_' and callable(
                    method) and method.__class__.__name__ == 'method':
                new = PyhaFunc(method)
                setattr(ret, method_str, new)

        return ret

class HW(with_metaclass(Meta)):
    """ For metaclass inheritance """

    def __deepcopy__(self, memo):
        """ http://stackoverflow.com/questions/1500718/what-is-the-right-way-to-override-the-copy-deepcopy-operations-on-an-object-in-p """
        cls = self.__class__
        result = cls.__new__(cls)
        memo[id(self)] = result
        for k, v in self.__dict__.items():
            # todo: maybe this also works for 'next'
            if k == '_pyha_initial_self':  # dont waste time on endless deepcopy
                setattr(result, k, copy(v))
            else:
                setattr(result, k, deepcopy(v, memo))
        return result

    def _pyha_update_self(self):
        # for k,v in self.next.__dict__.items():
        #     if isinstance(v, ComplexSfix):
        #         setattr(self, k, deepcopy(v))
        #     else:
        #         setattr(self, k, v)
        # self.__dict__ = deepish_copy(self.next.__dict__)
        self.__dict__.update(deepish_copy(self.next.__dict__))

        # update submodules
        for x in self._pyha_submodules:
            if isinstance(x, list):
                for item in x:
                    item._pyha_update_self()
            else:
                x._pyha_update_self()
