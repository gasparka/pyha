from copy import copy


class Const:
    def __init__(self, value):
        self._value = value

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        else:
            return self._value == other

    def __lt__(self, other):
        return self._value < other

    def __gt__(self, other):
        return self._value > other

    def __le__(self, other):
        return self._value <= other

    def __ge__(self, other):
        return self._value >= other

    def __getitem__(self, item):
        return self._value[item]

    def __add__(self, other):
        return self._value + other

    @property
    def value(self):
        return self._value

    def copy(self):
        # this is needed to make deepish_copy work
        return copy(self)
