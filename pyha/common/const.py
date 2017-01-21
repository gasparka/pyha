from copy import copy


class Const:
    def __init__(self, value):
        self._value = value

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False

    def __getitem__(self, item):
        return self._value[item]

    @property
    def value(self):
        return self._value

    def copy(self):
        # this is needed to make deepish_copy work
        return copy(self)
