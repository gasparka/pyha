import sys
from typing import List

from common.sfix import Sfix


class FunctionNotSimulated(Exception):
    pass


class VariableMultipleTypes(Exception):
    pass


class VariableNotConvertable(Exception):
    pass


def locals_hack(func):
    """ Update register values from "next" """
    func.tmp_locals = {}
    func._locals = {}

    def locals_hack_wrap(*args, **kwargs):
        def tracer(frame, event, arg):
            # Note: this runs for ALL returns, only the LAST frame is valid info
            # TODO: filter to only run for wanted methods return? (tried -> failed)
            if event == 'return':
                func.tmp_locals = frame.f_locals.copy()


        sys.setprofile(tracer)
        # trace the function call
        res = func(*args, **kwargs)
        sys.setprofile(None)

        func.tmp_locals.pop('self')

        func._locals.update(func.tmp_locals)

        return res

    return locals_hack_wrap


# class locals_hack(object):
#     """http://code.activestate.com/recipes/577283-decorator-to-expose-local-variables-of-a-function-/
#         persistent_locals2 has been co-authored with Andrea Maffezzoli"""
#
#     def __init__(self, func, class_name):
#         self.tmp_locals = {}
#         self._locals = {}
#         self.class_name = class_name
#         self.func = func
#         self._call_count = 0
#         self.multitype_vars = None
#
#     def __get__(self, obj, objtype):
#         """Support instance methods.
#         http://stackoverflow.com/questions/2365701/decorating-python-class-methods-how-do-i-pass-the-instance-to-the-decorator"""
#         import functools
#         return functools.partial(self.__call__, obj)
#
#     def __call__(self, *args, **kwargs):
#         def tracer(frame, event, arg):
#             # Note: this runs for ALL returns, only the LAST frame is valid info
#             # TODO: filter to only run for wanted methods return? (tried -> failed)
#             if event == 'return':
#                 self.tmp_locals = frame.f_locals.copy()
#
#         # tracer is activated on next call, return or exception
#         sys.setprofile(tracer)
#         # trace the function call
#         res = self.func(*args, **kwargs)
#         sys.setprofile(None)
#
#         self._call_count += 1
#         self.tmp_locals.pop('self')
#         # check multitype
#         self.multitype_check()
#
#
#         # self.multitype_vars = key
#
#         self._locals.update(self.tmp_locals)
#
#         return res
#
#     def multitype_check(self):
#         def bad(var_name, old, new):
#             raise VariableMultipleTypes('Variable with multiple types!\nClass: {}\nFunction: {}\nVariable: {}\n Old: {}\n New: {}'
#                                         .format(self.class_name,
#                                                 self.func.__name__, var_name,
#                                                 old,
#                                                 new))
#
#         for key, value in self.tmp_locals.items():
#             if key in self._locals:
#                 if isinstance(value, Sfix):
#                     old = self._locals[key]
#                     if value.left != old.left or value.right != old.right:
#                         bad()
#                 elif type(value) != type(self._locals[key]):
#                     bad()
#
#     def clear_locals(self):
#         self._locals = {}
#
#     @property
#     def locals(self):
#         return self._locals


def is_convertable(obj):
    allowed_types = [Sfix, int, bool]
    if type(obj) in allowed_types:
        return True
    elif isinstance(obj, List):
        # To check whether all elements are of the same type
        if len(set(map(type, obj))) == 1:
            if all(type(x) in allowed_types for x in obj):
                return True

    return False


# TODO: for initial values i just reject unconvertable types, this makes sense??
def initial_values(obj):
    ret = {}
    for key, val in obj.__dict__.items():
        if is_convertable(val):
            ret.update({key: val})
    return ret



def extract_locals(obj):
    ret = {}
    for method in dir(obj):
        call = getattr(obj, method)
        if type(call) == locals_hack:
            if call._call_count == 0:
                raise FunctionNotSimulated('\nClass: {}\nFunction: {}\n has not been simulated before conversion.'
                                           .format(type(obj).__name__, call.func.__name__))

            if call.multitype_vars is not None:
                raise VariableMultipleTypes('\nClass: {}\nFunction: {}\nVariable: {}\n is used with multiple types'
                                            .format(type(obj).__name__, call.func.__name__, call.multitype_vars))

            for key, val in call.locals.items():
                if not is_convertable(val):
                    raise VariableNotConvertable(
                        '\nClass: {}\nFunction: {}\nVariable: {}\nType: {},\n {} is not convertable.'
                        .format(type(obj).__name__, call.func.__name__, key, type(val).__name__, val))

            ret[call.func.__name__] = call.locals

    return ret
