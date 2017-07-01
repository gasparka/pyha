import sys
from collections import UserList
from contextlib import suppress
from copy import deepcopy, copy
from enum import Enum

import numpy as np

from pyha.common.const import Const
from pyha.common.context_managers import RegisterBehaviour, AutoResize
from pyha.common.sfix import Sfix, ComplexSfix, resize
from six import iteritems, with_metaclass

# functions that will not be decorated/converted/parsed
from pyha.common.util import escape_for_vhdl

SKIP_FUNCTIONS = ('__init__', 'model_main')

# Pyha related variables in the object __dict__
PYHA_VARIABLES = (
    '_pyha_constants', '_pyha_initial_self', '_pyha_submodules', '_pyha_instance_id', '_delay', '_pyha_updateable')

default_sfix = Sfix(0, 0, -17)
default_complex_sfix = ComplexSfix(0 + 0j, 0, -17)


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
    elif isinstance(obj, (PyhaList, list)):
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
            if event != 'return':
                return

            cls.last_call_locals = frame.f_locals

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
        with RegisterBehaviour.enable():
            with AutoResize.enable():
                ret = self.call_with_locals_discovery(*args, **kwargs)
                # ret = self.func(*args, **kwargs)
        # fixme: ComplexSfix related hack, can remove later
        ret = deepcopy(ret)
        self.last_return = ret

        real_self._outputs.append(ret)
        return ret


class Meta(type):
    """
    https://blog.ionelmc.ro/2015/02/09/understanding-python-metaclasses/#python-2-metaclass
    """
    instance_count = 0

    def validate_datamodel(cls, dict):
        # TODO: not required actually?
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

        for k, v in ret.__dict__.items():
            if isinstance(v, list):
                ret.__dict__[k] = PyhaList(v, type=deepcopy(v[0]), name=k)

        # make ._next variable that holds 'next' state for elements that dont know how to update themself
        ret._next = {}
        for k, v in ret.__dict__.items():
            if k in ['__dict__', '_next', '_pyha_constants', '_pyha_instance_id']:
                continue
            if hasattr(v, '_pyha_update_self'):
                continue
            ret._next[k] = deepcopy(v)

        ret._pyha_updateable = []
        for k, v in ret.__dict__.items():
            if hasattr(v, '_pyha_update_self'):
                ret._pyha_updateable.append(v)

        # save the initial self values - all registers and initial values will be derived from these values!
        ret.__dict__['_pyha_initial_self'] = deepcopy(ret)

        # every call to 'main' will append returned values here
        ret._outputs = []

        # decorate all methods -> for locals discovery
        for method_str in dir(ret):
            if method_str in SKIP_FUNCTIONS:
                continue
            method = getattr(ret, method_str)
            if method_str[:2] != '__' and method_str[:1] != '_' and callable(
                    method) and method.__class__.__name__ == 'method':
                new = PyhaFunc(method)
                setattr(ret, method_str, new)

        return ret


def auto_resize(target, value):
    if not AutoResize.is_enabled() or not isinstance(target, Sfix) or Sfix._float_mode.enabled:
        return value

    left = target.left if target.left is not None else value.left
    right = target.right if target.right is not None else value.right

    return resize(value, left, right, round_style=target.round_style,
                  overflow_style=target.overflow_style)


class SfixList(list):
    """ On assign to element resize the value """

    def __init__(self, seq, type):
        super().__init__(seq)
        self.type = type

    def __setitem__(self, i, y):
        y = auto_resize(self.type, y)

        if self.type.left is None:
            self.type.left = y.left

        if self.type.right is None:
            self.type.right = y.right

        super().__setitem__(i, y)

    def __getitem__(self, y):
        r = super().__getitem__(y)
        if isinstance(r, list):
            return SfixList(r, self.type)
        return r

    def copy(self):
        return SfixList(super().copy(), self.type)

        # these may be needed to support shift reg resizes
        # def __add__(self, other):
        #    assert 0
        #
        # def __radd__(self, other):
        #     pass


class PyhaList(UserList):
    # TODO: Conversion should select only one element. Help select this, may some elements are not fully simulated.
    # TODO: DONT LIKE THAT SIM AND CONV FUNCT IN SAME CLASS
    def __init__(self, data, type, name):
        super().__init__(data)
        self.type = type
        self._next = deepcopy(data)

        self.name = name
        self.current = self.data
        self.initial = deepcopy(data)
        self.elem_type = None  # this is filled in later

    def __setitem__(self, i, y):
        if hasattr(self.type, '_pyha_update_self'):
            # object already knows how to handle registers
            self[i] = y
        else:
            if isinstance(self.type, Sfix):
                y = auto_resize(self.type, y)

                if self.type.left is None:
                    self.type.left = y.left

                if self.type.right is None:
                    self.type.right = y.right

            if RegisterBehaviour.is_enabled():
                self._next[i] = y
            else:
                self.data[i] = y

    def _pyha_update_self(self):
        if RegisterBehaviour.is_force_disabled():
            return
        if hasattr(self.type, '_pyha_update_self'):
            # object already knows how to handle registers
            for x in self.data:
                x._pyha_update_self()
        else:
            self.data = self._next[:]

    def _pyha_name(self):
        return escape_for_vhdl(self.name)

    def _pyha_type(self):
        elem_type = self.elem_type._pyha_type()
        # some type may contain illegal chars for name..replace them
        elem_type = elem_type.replace('(', '_').replace(')', '_').replace(' ', '_').replace('-', '_').replace('.', '_')
        return f'{elem_type}_list_t(0 to {len(self.data) - 1})'


class PyhaInt:
    def __init__(self, var_name, current, initial):
        self.name = var_name
        self.initial = initial
        self.current = current

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False

    def _pyha_name(self):
        return escape_for_vhdl(self.name)

    def _pyha_type(self):
        return 'integer'


class PyhaBool:
    def __init__(self, var_name, current, initial):
        self.name = var_name
        self.initial = initial
        self.current = current

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False

    def _pyha_name(self):
        return escape_for_vhdl(self.name)

    def _pyha_type(self):
        return 'boolean'


class PyhaSfix:
    def __init__(self, var_name, current, initial):
        self.name = var_name
        self.initial = initial
        self.current = current

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False

    def _pyha_name(self):
        return escape_for_vhdl(self.name)

    def _pyha_type(self):
        return f'sfixed({self.current.left} downto {self.current.right})'


class PyhaModule:
    def __init__(self, var_name, current, initial):
        self.name = var_name
        self.initial = initial
        self.current = current

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False

    def _pyha_name(self):
        return escape_for_vhdl(self.name)

    def _pyha_type(self):
        return escape_for_vhdl(f'{type(self.current).__name__}_{self.current._pyha_instance_id}.self_t')

class PyhaEnum:
    def __init__(self, var_name, current, initial):
        self.name = var_name
        self.initial = initial
        self.current = current

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False

    def _pyha_name(self):
        return escape_for_vhdl(self.name)

    def _pyha_type(self):
        return type(self.current).__name__


class HW(with_metaclass(Meta)):
    def _pyha_get_conversion_vars(self):
        def filter_junk(x):
            return {k: v for k, v in x.items()
                    if not k.startswith('_') and not isinstance(v, PyhaFunc)}

        current_vars = filter_junk(vars(self))
        initial_vars = filter_junk(vars(self._pyha_initial_self))

        def pyha_type(name, current_val, initial_val=None):
            if type(current_val) == int:
                return PyhaInt(name, current_val, initial_val)
            elif type(current_val) == bool:
                return PyhaBool(name, current_val, initial_val)
            elif type(current_val) == Sfix:
                return PyhaSfix(name, current_val, initial_val)
            elif type(current_val) == PyhaList:
                # lists are already converted to PyhaList in the meta class due to the need of __setattr__ overload in python simulation
                # fill in the elem_type so that PyhaList knows what it is dealing with
                current_val.elem_type = pyha_type('list_element_name_dont_use', current_val.current[0],
                                                  current_val.initial[0])
                return current_val
            elif isinstance(current_val, HW):
                return PyhaModule(name, current_val, initial_val)
            elif isinstance(current_val, Enum):
                return PyhaEnum(name, current_val, initial_val)
            assert 0

        # convert to conversion classes
        ret = [pyha_type(name, current_val, initial_val) for name, current_val, initial_val in
               zip(current_vars.keys(), current_vars.values(), initial_vars.values())]

        return ret

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
        if RegisterBehaviour.is_force_disabled():
            return
        # update atoms
        self.__dict__.update(self._next)

        # update all childs
        for x in self._pyha_updateable:
            x._pyha_update_self()

    def __setattr__(self, name, value):
        # todo: alos implements imlicit next
        """ Implements auto-resize feature, ie resizes all assigns to Sfix registers.
        this is only enabled for 'main' function, that simulates hardware.
        """

        if AutoResize.is_enabled():
            target = getattr(self._pyha_initial_self, name)
            value = auto_resize(target, value)

        if not RegisterBehaviour.is_enabled():
            self.__dict__[name] = value
            return

        if isinstance(value, list):
            # example: self.i = [i] + self.i[:-1]
            assert isinstance(self.__dict__[name], PyhaList)
            self.__dict__[name]._next = value
            return

        self._next[name] = value
