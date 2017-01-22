import sys
from copy import deepcopy, copy

import numpy as np
from six import iteritems, with_metaclass

from pyha.common.const import Const
from pyha.common.sfix import Sfix, ComplexSfix

"""
Purpose: Make python class simulatable as hardware, mainly provide 'register' behaviour
"""

# functions that will not be decorated/converted/parsed
SKIP_FUNCTIONS = ('__init__', 'model_main')


class AssignToSelf(Exception):
    def __init__(self, class_name, variable_name):
        message = 'Assigment to self.{}, did you mean self.next.{}?\nClass: {}'.format(
            variable_name, variable_name, class_name)
        super().__init__(message)


class TypeNotConsistent(Exception):
    def __init__(self, class_name, function_name, variable_name, old, new):
        # these clutter printing
        from contextlib import suppress
        with suppress(KeyError):  # only available for 'self'
            new.pop('__initial_self__')
            old.pop('__initial_self__')
        message = 'Self/local not consistent type!\nClass: {}\nFunction: {}\nVariable: {}\nOld: {}:{}\nNew: {}:{}'.format(
            class_name, function_name, variable_name, type(old), repr(old), type(new), new)
        super().__init__(message)


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
                if isinstance(v, ComplexSfix):
                    out[k] = copy(v)
                else:
                    out[k] = v  # ints

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
        self.dict_types_consistent_check(self.TraceManager.last_call_locals, self.locals)

        self.locals.update(self.TraceManager.last_call_locals)

        # in case nested call, restore the tracer function
        self.TraceManager.restore_profile()
        return res

    def __call__(self, *args, **kwargs):

        self.last_args = args
        self.last_kwargs = kwargs
        real_self = self.func.__self__
        self.calls += 1
        # function is not main, dont have to simulate clock
        if not self.is_main:
            return self.call_with_locals_discovery(*args, **kwargs)

        # update registers from next
        now = real_self.__dict__
        next = real_self.__dict__['next'].__dict__
        old_next = deepish_copy(next)

        now.update(old_next)
        # protect assign to self
        old_self = deepish_copy(now)

        # CALL IS HERE!
        ret = self.call_with_locals_discovery(*args, **kwargs)

        self.last_return = ret

        self.forbid_assign_to_self(real_self.__dict__, old_self)

        """ After each main, check that 'self' has consistent types(only single type over time)
         This only checks the 'next' dict, since assign to 'normal' dict **should** be impossible
        """
        self.dict_types_consistent_check(real_self.__dict__['next'].__dict__, old_next)

        return ret


class Meta(type):
    """
    https://blog.ionelmc.ro/2015/02/09/understanding-python-metaclasses/#python-2-metaclass
    """
    instance_count = 0

    def validate_datamodel(cls, dict):
        # todo: rework
        # if list of submodules, make sure all 'constants' are the same
        for x in dict.values():
            if isinstance(x, list) and isinstance(x[0], HW):
                ref = [v for v in x[0].__dict__.values() if isinstance(v, Const)]
                for listi in x:
                    di = [v for v in listi.__dict__.values() if isinstance(v, Const)]
                    if di != ref:
                        raise Exception(
                            'List of submodules: {}\n but constants are not equal!\n\nTry to remove Const() keyword.'.format(
                                x))

    def handle_constants(cls, dict):
        """ Go over dict and find all the constants. Remove the Const() wrapper
        and insert to __constants__."""

        dict['__constants__'] = {}
        for k, v in dict.items():
            if isinstance(v, Const):
                dict['__constants__'][k] = v.value
                dict[k] = v.value
        return dict

    # ran when instance is made
    def __call__(cls, *args, **kwargs):
        ret = super(Meta, cls).__call__(*args, **kwargs)
        ret.__dict__ = cls.handle_constants(ret.__dict__)
        cls.validate_datamodel(ret.__dict__)

        ret.pyha_instance_id = cls.instance_count
        cls.instance_count += 1

        # save the initial self values
        # all registers will be derived from these values!
        ret.__dict__['__initial_self__'] = deepcopy(ret)

        # give self.next to the new object
        ret.__dict__['next'] = deepcopy(ret)

        # decorate all methods
        for method_str in dir(ret):
            if method_str in SKIP_FUNCTIONS:
                continue
            method = getattr(ret, method_str)
            if method_str[:2] != '__' and callable(method) and method.__class__.__name__ == 'method':
                new = PyhaFunc(method)
                setattr(ret, method_str, new)

        return ret


class HW(with_metaclass(Meta)):
    """ For metaclass inheritance """
    pass
