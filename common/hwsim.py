from copy import deepcopy
from functools import wraps

from conversion.extract_datamodel import locals_hack
from six import iteritems, with_metaclass

"""
Purpose: Make python class simulatable as hardware, mainly provide 'register' behaviour
"""

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


# class clock_tick(object):
#
#     def __init__(self, func):
#         self.func = func
#
#     def __call__(self, *args, **kwargs):
#         now = self.__dict__
#         next = self.__dict__['next'].__dict__
#
#         now.update(deepish_copy(next))
#
#         ret = self.func(self, *args, **kwargs)
#         return ret


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
        ret.__dict__['next'] = deepcopy(ret)
        return ret


class HW(with_metaclass(Meta)):
    """ For metaclass inheritance """
    pass
