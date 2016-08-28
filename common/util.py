import collections


def get_iterable(x):
    if isinstance(x, collections.Iterable):
        return x
    else:
        return [x]


def tabber(str):
    TAB = '    '
    """ Add tab infront of every line """
    return '\n'.join(['{}{}'.format(TAB, x) for x in str.splitlines() if x != ''])
