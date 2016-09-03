import decorator

marker = object()


# http://developer.paylogic.com/articles/pytest-xdist-and-session-scoped-fixtures.html
def _memoize(func, *args, **kw):
    """Memoization helper to cache function's return value as an attribute of this function."""
    cache = getattr(func, '_cache', marker)
    if cache is marker:
        func._cache = func(*args, **kw)
        return func._cache
    else:
        return cache


def memoize(f):
    """Decorator which caches the return value of the function."""
    return decorator.decorator(_memoize, f)
