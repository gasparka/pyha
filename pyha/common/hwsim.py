from copy import deepcopy
from functools import wraps

import numpy as np
from six import iteritems, with_metaclass

from pyha.common.sfix import Sfix
from pyha.conversion.extract_datamodel import LocalsExtractor

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


def clock_tick(func):
    """ Update register values from "next" """

    @wraps(func)
    def clock_tick_wrap(*args, **kwargs):
        now = args[0].__dict__
        next = args[0].__dict__['next'].__dict__

        # now = func.func.__self__.__dict__
        # next = func.func.__self__.__dict__['next'].__dict__

        now.update(deepish_copy(next))

        ret = func(*args, **kwargs)
        return ret

    clock_tick_wrap.__wrapped__ = clock_tick
    return clock_tick_wrap


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

    def __new__(mcs, name, bases, attrs, **kwargs):
        # print('  Meta.__new__(mcs=%s, name=%r, bases=%s, attrs=[%s], **%s)' % (mcs, name, bases, ', '.join(attrs), kwargs))

        # TODO: some hook to enable this for conversion only
        # for attr in attrs:
        #     if callable(attrs[attr]):
        #         attrs[attr] = locals_hack(attrs[attr], name)

        # if 'main' in attrs:
        #     attrs['main'] = forbid_assign_to_self(attrs['main'], name)
        #     # attrs['main'] = inout_saver(attrs['main'])  # TODO: this should be only enabled on conversion
        #     attrs['main'] = self_type_consistent_checker(attrs['main'], name)
        #     attrs['main'] = clock_tick(attrs['main'])
        # else:
        #     pass
        ret = super(Meta, mcs).__new__(mcs, name, bases, attrs)
        return ret

    # ran when instance is made
    def __call__(cls, *args, **kwargs):
        ret = super(Meta, cls).__call__(*args, **kwargs)

        # save the initial self values
        ret.__dict__['__initial_self__'] = deepcopy(ret)

        # give self.next to the new object
        ret.__dict__['next'] = deepcopy(ret)

        for method_str in dir(ret):
            method = getattr(ret, method_str)
            if method_str[:2] != '__' and callable(method) and method.__class__.__name__ == 'method':
                new = LocalsExtractor(method, cls.__name__)

                if 'main' == method_str:
                    # new = forbid_assign_to_self(new, cls.__name__)
                    # attrs['main'] = inout_saver(attrs['main'])  # TODO: this should be only enabled on conversion
                    # new = self_type_consistent_checker(new, cls.__name__)
                    new = clock_tick(new)

                setattr(ret, method_str, new)

        return ret


class HW(with_metaclass(Meta)):
    """ For metaclass inheritance """
    pass
