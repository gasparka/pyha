from copy import deepcopy


class Reg(object):
    def __init__(self, val):
        self._val_next = val
        self._val = val

    def __get__(self, obj, type=None):
        print('WTF')
        return self._val

    def __set__(self, obj, value):
        raise AttributeError()


class Cont(object):
    def __init__(self, val):
        self.reg = Reg(val)

    #         self.reg = RevealAccess(10)

    def __getattribute__(self, name):
        attr = super(Cont, self).__getattribute__(name)
        if hasattr(attr, '__get__'):
            return attr.__get__(self, Cont)
        return attr

    def __setattr__(self, key, value):
        attr = super(Cont, self).__getattribute__(key)
        if hasattr(attr, '__set__'):
            return attr.__set__(self, Cont, 0)
        return attr


# def setaatt

def wrapper(f):
    print('Wrapper')

    def wrap(*args, **kwargs):
        print('before func')
        f(*args, **kwargs)
        print('after func')

    return wrap


class Meta(type):
    """https://blog.ionelmc.ro/2015/02/09/understanding-python-metaclasses/#python-2-metaclass"""

    def __init__(cls, name, bases, attrs, **kwargs):
        if '__call__' in attrs:
            # decorate the __call__ function wtih clock_tick
            attrs['__call__'] = wrapper(attrs['__call__'])
        else:
            pass
            # raise Exception('Class is missing __call__ function!')

        print('  Meta.__init__(cls=%s, name=%r, bases=%s, attrs=[%s], **%s)' % (
            cls, name, bases, ', '.join(attrs), kwargs
        ))
        return super().__init__(name, bases, attrs)

    # ran when instance is made
    def __call__(cls, *args, **kwargs):
        # args[0].__dict__['next'] = deepcopy(args[0])
        print('  Meta.__call__(cls=%s, args=%s, kwargs=%s)' % (cls, args, kwargs))
        ret = super().__call__(*args, **kwargs)
        ret.__dict__['next'] = deepcopy(ret)
        return ret


class Base(metaclass=Meta):
    pass


class Test(Base):
    def __init__(self):
        self.a = 1
        print('MAIN Init')

    def __call__(self, *args, **kwargs):
        print('CALL')

    def random_function(self):
        self.next.a = 25


dut = Test()
dut.next.a = 2
print('Lol')
