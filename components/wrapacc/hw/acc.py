class WrapAcc():
    def __init__(self, bits):
        self.bits = bits
        self.counter = -1.0

    # @property
    # def max(self):
    #     return 1 - 2 ** -self.bits
    #
    # @property
    # def min(self):
    #     return -1
    #
    # def freq_to_step(self, freq, fs):
    #     return freq * (self.max - self.min) / fs

    def __call__(self, step):
        # fmin = self.min
        # fmax = self.max

        val = resize(self.counter + step, self.counter)

        is_wrap = val > self.max or val < self.min


        # # wrap logic
        # self.counter = (val - fmin) % (fmax - fmin) + fmin

        # return resl
