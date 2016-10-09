from copy import deepcopy
from functools import wraps

from common.sfix import Sfix
from conversion.extract_datamodel import locals_hack
from conversion.top_generator import inout_saver
from six import iteritems, with_metaclass

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

        now.update(deepish_copy(next))

        ret = func(*args, **kwargs)
        return ret

    clock_tick_wrap.__wrapped__ = clock_tick
    return clock_tick_wrap


def forbid_assign_to_self(func, class_name):
    """ In Hapy user should only assign to self.next.X, any assign to
        'self.X' is a bug and this decorator tests for that """

    @wraps(func)
    def forbid_assign_to_self_wrap(*args, **kwargs):
        old = deepish_copy(args[0].__dict__)
        res = func(*args, **kwargs)

        for key, value in args[0].__dict__.items():
            import numpy as np
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
    """ After each __call__, check that 'self' has consistent types(only single type over time)
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
        # add profiler hack to access local variables of functions
        for attr in attrs:
            if callable(attrs[attr]):
                attrs[attr] = locals_hack(attrs[attr], name)

        if '__call__' in attrs:
            attrs['__call__'] = forbid_assign_to_self(attrs['__call__'], name)
            attrs['__call__'] = inout_saver(attrs['__call__'])  # TODO: this should be only enabled on conversion
            attrs['__call__'] = self_type_consistent_checker(attrs['__call__'], name)
            # decorate the __call__ function with clock_tick
            attrs['__call__'] = clock_tick(attrs['__call__'])
        else:
            pass
        ret = super(Meta, mcs).__new__(mcs, name, bases, attrs)
        return ret

    # ran when instance is made
    def __call__(cls, *args, **kwargs):
        # print('  Meta.__call__(cls=%s, args=%s, kwargs=%s)' % (cls, args, kwargs))
        ret = super(Meta, cls).__call__(*args, **kwargs)

        # save the initial self values
        ret.__dict__['__initial_self__'] = deepcopy(ret)

        # give self.next to the new object
        ret.__dict__['next'] = deepcopy(ret)
        return ret


class HW(with_metaclass(Meta)):
    """ For metaclass inheritance """
    pass
