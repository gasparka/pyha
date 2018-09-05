from collections import deque
from copy import deepcopy
from pyha import Hardware


class ShiftRegister(Hardware):
    def __init__(self, items):
        # deepcopy is needed for safety/sanity. Else some other code can change the contents of shift register, because it just stores the pointers (this did happen)
        self.data = deque(deepcopy(items), maxlen=len(items))
        self.to_push = deepcopy(items[0])

    def peek(self):
        return self.data[0]

    def push_next(self, item):
        """ Actual push happens on the next clock cycle! """
        # CONVERSION PREPROCESSOR replace next line with:
        # self.data = self.data[1:] + [item]
        self.to_push = item

    def __setattr__(self, key, value):
        self.__dict__[key] = value

    def _pyha_update_registers(self):
        self.data.append(self.to_push)

