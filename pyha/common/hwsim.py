from copy import deepcopy
from functools import wraps

import numpy as np
from six import iteritems, with_metaclass

from pyha.common.sfix import Sfix

"""
Purpose: Make python class simulatable as hardware, mainly provide 'register' behaviour
"""


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
    # for k,v in org.iteritems():

    # for k,v in org.items():
    for k, v in iteritems(org):
        try:
            out[k] = v.copy()  # dicts, sets
        except AttributeError:
            try:
                out[k] = v[:]  # lists, tuples, strings, unicode
            except TypeError:
                out[k] = v  # ints

    return out


class PyhaFunc:
    def __init__(self, func):
        self.class_name = func.__self__.__class__.__name__
        self.func = func
        self.calls = 0
        self.locals = {}

    def __call__(self, *args, **kwargs):
        real_self = self.func.__self__

        # uptade registers from next
        now = real_self.__dict__
        next = real_self.__dict__['next'].__dict__
        old_next = deepish_copy(next)
        now.update(old_next)

        # protect assign to self
        old = deepish_copy(now)

        # CALL IS HERE!
        ret = self.func(*args, **kwargs)

        # check if self was assigned
        for key, value in now.items():
            if key == 'next' or isinstance(value, (np.ndarray, np.generic)):
                continue

            if value != old[key]:
                raise AssignToSelf(self.class_name, key)

        #
        dict_types_consistent_check(self.class_name, self.func.__name__, real_self.__dict__['next'].__dict__, old_next)


        return ret
        # TraceManager.set_profile()
        # res = self.func(*args, **kwargs)
        # TraceManager.remove_profile()
        #
        # self.calls += 1
        # # TraceManager.last_call_locals.pop('self')
        # from pyha.common.hwsim import dict_types_consistent_check
        # dict_types_consistent_check(self.class_name, self.func.__name__, TraceManager.last_call_locals, self.locals)
        #
        # self.locals.update(TraceManager.last_call_locals)
        #
        # # in case nested call, restore the tracer function
        # TraceManager.restore_profile()
        # return res

        # def __get__(self, obj, objtype):
        #     """Support instance methods."""
        #     return functools.partial(self.__call__, obj)


# def clock_tick(func):
#     """ Update register values from "next" """
#
#     @wraps(func)
#     def clock_tick_wrap(*args, **kwargs):
#         now = args[0].__dict__
#         next = args[0].__dict__['next'].__dict__
#
#         # now = func.func.__self__.__dict__
#         # next = func.func.__self__.__dict__['next'].__dict__
#
#         now.update(deepish_copy(next))
#
#         ret = func(*args, **kwargs)
#         return ret
#
#     clock_tick_wrap.__wrapped__ = clock_tick
#     return clock_tick_wrap


def forbid_assign_to_self(func, class_name):
    """ User should only assign to self.next.X, any assign to
        'self.X' is a bug and this decorator tests for that """

    @wraps(func)
    def forbid_assign_to_self_wrap(*args, **kwargs):
        old = deepish_copy(args[0].__dict__)
        res = func(*args, **kwargs)

        for key, value in args[0].__dict__.items():
            if key == 'next' or isinstance(value, (np.ndarray, np.generic)):
                continue

            if value != old[key]:
                raise AssignToSelf(class_name, key)

        return res

    return forbid_assign_to_self_wrap


def dict_types_consistent_check(class_name, function_name, new, old):
    """ Check 'old' dict against 'new' dict for types, if not consistent raise """
    for key, value in new.items():
        if key in old:
            old_value = old[key]
            if isinstance(value, Sfix):
                if value.left != old_value.left or value.right != old_value.right:
                    if old_value.left == 0 and old_value.right == 0:
                        # sfix lazy init
                        continue
                    raise TypeNotConsistent(class_name, function_name, key, old, new)
            elif type(value) != type(old_value):
                raise TypeNotConsistent(class_name, function_name, key, old, new)
            elif isinstance(value, list):
                if len(old_value) != len(value):
                    raise TypeNotConsistent(class_name, function_name, key, old, new)


def self_type_consistent_checker(func, class_name):
    """ After each main, check that 'self' has consistent types(only single type over time)
     This only checks the 'next' dict, since assign to 'normal' dict **should** be impossible
    """
    @wraps(func)
    def self_type_consistent_checker_wrap(*args, **kwargs):
        nxt = args[0].__dict__['next'].__dict__
        old = deepish_copy(nxt)
        res = func(*args, **kwargs)
        new = nxt

        dict_types_consistent_check(class_name, func.__name__, new, old)

        return res

    return self_type_consistent_checker_wrap


class Meta(type):
    """
    https://blog.ionelmc.ro/2015/02/09/understanding-python-metaclasses/#python-2-metaclass
    """

    # ran when instance is made
    def __call__(cls, *args, **kwargs):
        ret = super(Meta, cls).__call__(*args, **kwargs)

        # save the initial self values
        ret.__dict__['__initial_self__'] = deepcopy(ret)

        # give self.next to the new object
        ret.__dict__['next'] = deepcopy(ret)

        # decorate all methods
        for method_str in dir(ret):
            method = getattr(ret, method_str)
            if method_str[:2] != '__' and callable(method) and method.__class__.__name__ == 'method':
                new = PyhaFunc(method)
                setattr(ret, method_str, new)

        return ret


class HW(with_metaclass(Meta)):
    """ For metaclass inheritance """
    pass
