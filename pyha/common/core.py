import logging
import sys
import time
import weakref
from collections import UserList
from copy import deepcopy, copy

import numpy as np
from six import with_metaclass

from pyha import Complex
from pyha.common.context_managers import RegisterBehaviour, AutoResize, SimulationRunning, SimPath, \
    PYHA_DISABLE_PROFILE_HACKS
from pyha.common.fixed_point import Sfix, resize, default_sfix
# functions that will not be decorated/converted/parsed
from pyha.common.util import np_to_py, get_iterable, is_constant

SKIP_FUNCTIONS = ('__init__', 'model')
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('core')


class PyhaFunc:
    """ All functions of a Pyha class will be wrapped in this object, calls to original function are done with 'profiler hack' in
    order to save the local variables. """

    # if true, just call the function.. 10 x faster (but VHDL generation not supported)
    bypass = False

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

        self.local_types = {}
        self.arg_types = None
        self.kwarg_types = None
        self.output_types = None
        self.outputs_is_tuple = False

        self.is_main = self.function_name == 'main'

    def call_with_locals_discovery(self, *args, **kwargs):
        """ Call decorated function with tracing to read back local values """
        if PYHA_DISABLE_PROFILE_HACKS:
            res = self.func(*args, **kwargs)
            return res
        else:
            self.TraceManager.set_profile()
            res = self.func(*args, **kwargs)
            sys.setprofile(None)  # without this things get fucked up
            self.TraceManager.remove_profile()

            self.TraceManager.last_call_locals.pop('self')
            self.update_local_types(self.TraceManager.last_call_locals)

            # in case nested call, restore the tracer function
            self.TraceManager.restore_profile()

            return res

    def get_local_types(self):
        return self.local_types

    def add_local_type(self, name, value):
        self.local_types[name] = value

    def get_arg_types(self):
        return self.arg_types

    def get_kwarg_types(self):
        return self.kwarg_types

    def get_output_types(self):
        if self.outputs_is_tuple:
            return tuple(self.output_types)
        else:
            if len(self.output_types) == 1:
                return self.output_types[0]  # single return (this was temporarily converted to list)
            else:
                return self.output_types

    def update_local_types(self, new_stack):
        for k, v in new_stack.items():
            if k in self.local_types and not isinstance(v, Sfix) and isinstance(self.local_types[k], Sfix):
                continue  # dont allow overwriting Sfix values
            self.local_types[k] = v

    def update_input_types(self, args, kwargs):
        if self.arg_types is None:
            self.arg_types = list(args)
        else:
            for i, v in enumerate(args):
                if not isinstance(v, Sfix) and isinstance(self.arg_types[i], Sfix):
                    continue  # dont allow overwriting Sfix values
                self.arg_types[i] = v

        if self.kwarg_types is None:
            self.kwarg_types = kwargs
        else:
            for k, v in kwargs.items():
                if k in self.kwarg_types and not isinstance(v, Sfix) and isinstance(self.kwarg_types[k], Sfix):
                    continue  # dont allow overwriting Sfix values
                self.kwarg_types[k] = v

    def update_output_types(self, ret):
        ret = get_iterable(ret)
        if self.output_types is None:
            if isinstance(ret, tuple):
                self.outputs_is_tuple = True
            self.output_types = list(ret)
        else:
            for i, v in enumerate(ret):
                if not isinstance(v, Sfix) and isinstance(self.output_types[i], Sfix):
                    continue  # dont allow overwriting Sfix values
                self.output_types[i] = v

    def __call__(self, *args, **kwargs):
        if PyhaFunc.bypass:
            return self.func(*args, **kwargs)

        self.update_input_types(args, kwargs)
        self.calls += 1

        with SimPath(f'{self.class_name}.{self.function_name}()'):
            with RegisterBehaviour.enable():
                with AutoResize.enable():
                    ret = self.call_with_locals_discovery(*args, **kwargs)

        self.update_output_types(ret)
        return ret


class Meta(type):
    """
    https://blog.ionelmc.ro/2015/02/09/understanding-python-metaclasses/#python-2-metaclass
    """
    # ran when instance is made
    def __call__(cls, *args, **kwargs):
        cls._pyha_is_initialization = True  # flag to avoid problems in __setattr__
        ret = super(Meta, cls).__call__(*args, **kwargs)

        if not SimulationRunning.is_enabled():  # local objects are simplified, they need no reset or register behaviour
            ret._pyha_next = {}
            ret._pyha_updateable = []
            for k, v in ret.__dict__.items():
                if k.startswith('_pyha') or k == '__dict__':
                    continue

                if isinstance(v, np.ndarray):
                    v = np_to_py(v)

                from pyha.common.ram import RAM
                if isinstance(v, list) and not isinstance(ret, RAM):
                    v = PyhaList(v, ret.__class__.__name__, k)
                    ret.__dict__[k] = v

                if is_constant(k):
                    continue

                if hasattr(v, '_pyha_update_registers'):
                    ret._pyha_updateable.append(v)
                    continue

                ret._pyha_next[k] = deepcopy(v)
            ret.__dict__['_pyha_initial_self'] = deepcopy(ret) # TODO: this exists only for initial values, deepcopy very slow on large objects!

        del cls._pyha_is_initialization
        return ret


def auto_resize(target, value):
    if not AutoResize.is_enabled() or not isinstance(target, (Sfix, Complex)) or Sfix._float_mode.enabled:
        return value
    if target.bits is not None:
        right = value.right
        try:
            left = right + target.bits
            if target.signed:
                left -= 1  # -1 is to count for the sign bit!
        except TypeError:  # right was None?
            left = None
    elif target.upper_bits is not None:
        left = value.left
        try:
            right = left - target.upper_bits
            if target.signed:
                right += 1  # +1 is to count for the sign bit!
        except TypeError:  # left was None?
            right = None
    else:
        left = target.left if target.left is not None else value.left
        right = target.right if target.right is not None else value.right
    return target(value, left, right)
    # return resize(value, left, right, round_style=target.round_style,
    #               overflow_style=target.overflow_style, wrap_is_ok=target.wrap_is_ok, signed=target.signed)


class PyhaList(UserList):
    """ All the lists in the design will be wrapped in this in order to
     override __setitem__ for array element assigns, like a[1] = 1 """

    # TODO: Conversion should select only one element. Help select this, may some elements are not fully simulated.
    def __init__(self, data, class_name='None', var_name='None'):
        super().__init__(data)
        self.var_name = var_name
        self.class_name = class_name
        if not hasattr(self.data[0], '_pyha_update_registers'):
            self._pyha_next = deepcopy(data)

    def __setitem__(self, i, y):
        """ Implements auto-resize feature, ie resizes all assigns to Sfix registers.
        Also implements the register behaviour i.e saves assigned value to shadow variable, that is later used by the '_pyha_update_registers' function.
        """
        if hasattr(self.data[0], '_pyha_update_registers'):
            # object already knows how to handle registers
            # copy relevant stuff only
            for k, v in y.__dict__.items():
                if k.startswith('_pyha'):
                    continue
                setattr(self.data[i], k, v)
                # self.data[i].__dict__['_pyha_next'][k] = v

        else:
            if isinstance(self.data[i], (Sfix, Complex)):
                with SimPath(f'{self.var_name}[{i}]='):
                    y = auto_resize(self.data[i], y)

                # lazy bounds feature, if bounds is None, take the bound from assigned value
                if self.data[i].left is None:
                    for x, xn in zip(self.data, self._pyha_next):
                        x.left = y.left
                        xn.left = y.left

                if self.data[i].right is None:
                    for x, xn in zip(self.data, self._pyha_next):
                        x.right = y.right
                        xn.right = y.right

            if RegisterBehaviour.is_enabled():
                self._pyha_next[i] = y
            else:
                self.data[i] = y

    def _pyha_update_registers(self):
        """ Update registers (eveyrthing in self), called after the return of toplevel 'main' """
        if RegisterBehaviour.is_force_disabled():
            return
        if hasattr(self.data[0], '_pyha_update_registers'):  # is submodule
            for x in self.data:
                x._pyha_update_registers()
        else:
            self.data = self._pyha_next[:]

    def _pyha_enable_function_profiling_for_types(self):
        if hasattr(self.data[0], '_pyha_update_registers'):  # is submodule
            for i, x in enumerate(self.data):
                x._pyha_enable_function_profiling_for_types()

    def _pyha_insert_tracer(self, label=''):
        if hasattr(self.data[0], '_pyha_update_registers'):  # is submodule
            for i, x in enumerate(self.data):
                x._pyha_insert_tracer(label=f'{label}[{i}]')

    def _pyha_floats_to_fixed(self, silence=False):
        """ Go over the datamodel and convert floats to sfix, this is done before RTL/GATE simulation """
        from pyha.common.complex import default_complex
        if hasattr(self.data[0], '_pyha_update_registers'):  # is submodule
            for x in self.data:
                x._pyha_floats_to_fixed(silence)
        else:
            if not isinstance(self.data[0], (float, complex)):
                return

            new = []
            for x in self.data:
                if isinstance(x, float):
                    item = default_sfix(x)
                    item.round_style = 'truncate'
                    item.overflow_style = 'wrap'
                elif isinstance(x, complex):
                    item = default_complex(x)
                    item.round_style = 'truncate'
                    item.overflow_style = 'wrap'

                new.append(item)

            # if not silence:
            #     import pandas as pd
            #     pd.options.display.max_rows = 32
            #     l = pd.DataFrame({'original': self.data, 'converted': new})
            #     logger.debug(
            #         f'Converted {self.class_name}.{self.var_name}:\n {l}')
            self.data = new
            self._pyha_next = new

    def _pyha_to_python_value(self):
        return [x._pyha_to_python_value() for x in self.data]


class Hardware(with_metaclass(Meta)):

    def _pyha_is_local(self):
        return not hasattr(self, '_pyha_initial_self')

    def __deepcopy__(self, memo):
        cls = self.__class__
        result = cls.__new__(cls)
        memo[id(self)] = result

        with RegisterBehaviour.force_disable():
            with AutoResize.force_disable():
                if SimulationRunning.is_enabled():
                    for k, v in self.__dict__.items():
                        # try:
                        #     local = self._pyha_is_local
                        # except:
                        #     local = False

                        if k.startswith('_pyha'):
                            continue
                        # elif local and isinstance(v, PyhaFunc): # PyhaFunc MUST be copied for initial objects...everything breaks otherwise
                        #     continue
                        else:
                            setattr(result, k, deepcopy(v, memo))
                else:
                    for k, v in self.__dict__.items():
                        if k == '_pyha_initial_self' or k == '_pyha_next' or isinstance(v,
                                                                                        Hardware):  # dont waste time on endless deepcopy
                            setattr(result, k, copy(v))
                            # print(k, v)
                        else:
                            setattr(result, k, deepcopy(v, memo))
        return result

    def _pyha_update_registers(self):
        """ Update registers (everything in self), called after the return of toplevel 'main' """
        if RegisterBehaviour.is_force_disabled() or self._pyha_is_local():
            return
        # update atoms
        self.__dict__.update(self._pyha_next)

        # update all childs
        for x in self._pyha_updateable:
            x._pyha_update_registers()

    def _pyha_enable_function_profiling_for_types(self):
        for k, v in self.__dict__.items():
            if k == '_pyha_initial_self':
                continue
            if hasattr(v, '_pyha_update_registers'):
                v._pyha_enable_function_profiling_for_types()

        for method_str in dir(self):
            if method_str in SKIP_FUNCTIONS:
                continue
            method = getattr(self, method_str)
            if method_str[:2] != '__' and method_str[:1] != '_' and callable(
                    method) and method.__class__.__name__ == 'method':
                new = PyhaFunc(method)
                self.__dict__[method_str] = new

    def _pyha_insert_tracer(self, label=''):
        from pyha.simulation.tracer import Tracer
        for k, v in self.__dict__.items():
            if k == '_pyha_initial_self':
                continue
            if hasattr(v, '_pyha_update_registers'):
                v._pyha_insert_tracer(label=f'{label}.{k}')

        for method_str in dir(self):
            if method_str == 'model' or method_str == 'main':
                self.__dict__[method_str] = Tracer(getattr(self, method_str), method_str, owner=self, label=label)

    def _pyha_floats_to_fixed(self, silence=False):
        """ Go over the datamodel and convert floats to sfix, this is done before RTL/GATE simulation """
        from pyha.common.complex import default_complex
        # update atoms
        for k, v in self.__dict__.items():
            if hasattr(v, '_pyha_update_registers'):
                v._pyha_floats_to_fixed(silence)

            if not isinstance(v, (float, complex)):
                continue

            if isinstance(v, float):
                new = default_sfix(v)
                new.round_style = 'truncate'
                new.overflow_style = 'wrap'

            elif isinstance(v, complex):
                new = default_complex(v)
                new.round_style = 'truncate'
                new.overflow_style = 'wrap'

            if not silence:
                logger.debug(
                    f'Converted {self.__class__.__name__}.{k} = {v} -> {new}')
            self.__dict__[k] = new
            try:
                self._pyha_next[k] = deepcopy(new)
            except AttributeError:  # problem in code? -> fuck it
                pass

        # update all childs
        # for x in self._pyha_updateable:
        # x._pyha_floats_to_fixed(silence)

        # update initial self
        try:
            self._pyha_initial_self._pyha_floats_to_fixed(silence=True)
        except:
            pass

    def __setattr__(self, name, value):
        """ Implements auto-resize feature, ie resizes all assigns to Sfix registers.
        Also implements the register behaviour i.e saves assigned value to shadow variable, that is later used by the '_pyha_update_registers' function.
        """
        if hasattr(self, '_pyha_is_initialization') or self._pyha_is_local() or not RegisterBehaviour.is_enabled():
            self.__dict__[name] = value
            return

        if AutoResize.is_enabled():
            target = getattr(self._pyha_initial_self, name)
            with SimPath(f'{name}='):
                value = auto_resize(target, value)

        if isinstance(value, list):
            # list assign
            # example: self.i = [i] + self.i[:-1]
            assert isinstance(self.__dict__[name], PyhaList)
            if hasattr(self.__dict__[name][0], '_pyha_update_registers'):
                # list of submodules -> need to copy each value to submodule next
                for elem, new in zip(self.__dict__[name], value):
                    # for deeper submodules, deepcopy was not necessary..
                    # copy relevant stuff only
                    for k, v in new.__dict__.items():
                        if k.startswith('_pyha'):
                            continue
                        elem.__dict__['_pyha_next'][k] = v
            else:
                self.__dict__[name]._pyha_next = value
            return

        if isinstance(value, Hardware):
            for k, v in value.__dict__.items():
                if k.startswith('_pyha'):
                    continue
                n = self.__dict__[name]
                setattr(n, k, v)
            return

        self.__dict__['_pyha_next'][name] = value

    def _pyha_to_python_value(self):
        ret = copy(self)
        for k, v in self.__dict__.items():
            try:
                ret.__dict__[k] = v._pyha_to_python_value()
            except:
                ret.__dict__[k] = v

        return ret

    def __str__(self):
        filt = {}
        for k, v in vars(self).items():
            if k[0] != '_':
                filt[k] = v

        return f'{self.__class__.__name__}{filt}'

    def __repr__(self):
        return str(self)
