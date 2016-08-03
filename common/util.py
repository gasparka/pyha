import collections


def get_iterable(x):
    if isinstance(x, collections.Iterable):
        return x
    else:
        return [x]


def tabber(str):
    """ Add tab infront of every line """
    return ''.join(['\t{}'.format(x) for x in str.splitlines()])
