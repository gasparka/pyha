import numpy as np
from pyha import Hardware
from pyha.common.fixed_point import sign_bit, Sfix
from pyha.common.util import is_power2


class DownCounter(Hardware):
    def __init__(self, start_value):
        if start_value == 0:
            bits = 1
        else:
            bits = int(np.log2(start_value)) + 1
        self.START_VALUE = Sfix(start_value, bits, 0)
        self.counter = self.START_VALUE

    def restart(self):
        self.counter = self.START_VALUE

    def is_over(self):
        # test if counter is negative -> must be over
        return sign_bit(self.counter - 1)

    def tick(self):
        if not self.is_over():
            self.counter -= 1


class WrappingCounter(Hardware):
    def __init__(self, start_value, max_value):
        assert is_power2(max_value)
        bits = int(np.log2(max_value))
        self.START_VALUE = Sfix(start_value, bits, 0, signed=False, wrap_is_ok=True)
        self.counter = self.START_VALUE

    def get(self):
        return self.counter

    def tick(self):
        self.counter += 1