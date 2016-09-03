from LEGACY.common.register import clock_tick
from common.sfix import resize, Sfix


class WrapAcc:
    def __init__(self, bits, scale=None, scalebits=27):
        assert bits < 32
        self.scalebits = scalebits
        self.scale = Sfix.auto_size(scale, scalebits)
        self.scaled = Sfix()

        self.input_sfix = [Sfix(0, 0, -bits)]
        self.output_sfix = [Sfix(0, 1, -25)]
        self.bits = bits
        self.counter = Sfix(-1.0, 0, -bits)
        self.is_wrap = False
        self.is_wrap_delay = False

    @property
    def delay(self):
        # 0 matches NUMPY (last element not included)
        # delay is actually 1, but the default value is relevant in this case
        # return 0

        # delay 1 due to scaling
        # FIXME: this is bullshit, should be 2
        return 1

    @clock_tick
    def __call__(self, step):
        val = self.counter + step

        self.next.is_wrap = val > self.counter.max_representable() or \
                            val < self.counter.min_representable()

        self.next.counter = resize(val, self.counter, overflow_style='WRAP')

        # scale stuff
        self.next.is_wrap_delay = self.is_wrap
        counter_small = resize(self.counter, Sfix(0, 0, -self.scalebits + 1))
        if self.scale is not None:
            self.next.scaled = resize(counter_small * self.scale, self.scale)
        else:
            self.next.scaled = counter_small

        # self.next.scaled = resize(self.next.scaled, Sfix(0, 1, -17))
        # return self.counter, self.is_wrap
        return self.scaled, self.is_wrap_delay
