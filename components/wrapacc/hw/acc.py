from common.register import clock_tick
from common.sfix import resize, Sfix


class WrapAcc:
    def __init__(self, bits):
        self.input_sfix = [Sfix(0, 0, -bits)]
        self.bits = bits
        self.counter = Sfix(-1.0, 0, -bits)
        self.is_wrap = False

    @property
    def delay(self):
        # 0 matches NUMPY (last element not included)
        # delay is actually 1, but the default value is relavant in this case
        return 0

    @clock_tick
    def __call__(self, step):
        val = self.counter + step

        self.next.is_wrap = val > self.counter.max_representable() or \
                            val < self.counter.min_representable()

        self.next.counter = resize(val, self.counter, overflow_style='WRAP')

        return self.counter, self.is_wrap
