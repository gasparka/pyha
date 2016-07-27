class WrapAcc():
    def __init__(self, bits):
        self.bits = bits
        self.counter = -1.0

    @property
    def max(self):
        return 1 - 2 ** -self.bits

    @property
    def min(self):
        return -1

    def freq_to_step(self, freq, fs):
        return freq * (self.max - self.min) / fs

    def __call__(self, step_list):
        fmin = self.min
        fmax = self.max

        resl = []
        for step in step_list:
            val = self.counter + step

            is_wrap = val > self.max or val < self.min
            resl.append([self.counter, is_wrap])

            # wrap logic
            self.counter = (val - fmin) % (fmax - fmin) + fmin

        return resl
