class WrapAcc():
    def __init__(self, bits, scale=None):
        if scale is None:
            self.scale = 1.0
        else:
            self.scale = scale
        self.bits = bits
        self.counter = -1.0

    @property
    def max(self):
        return 1.0 - 2 ** -self.bits

    @property
    def min(self):
        return -1.0

    def freq_to_step(self, freq, fs):
        # NOTE: just mult by 1/np
        # or 2*np.pi*freq/fs/(np.pi)
        return freq * (self.max - self.min) / fs

    def __call__(self, step_list):
        fmin = self.min
        fmax = self.max

        resl = []
        is_wrap = False
        for step in step_list:
            val = self.counter + step

            resl.append([self.counter * self.scale, is_wrap])

            # wrap logic
            self.counter = (val - fmin) % (fmax - fmin) + fmin

            # this can fail due to float magic
            # is_wrap = val > self.max or val < self.min
            is_wrap = (val - fmin) >= (fmax - fmin)



        return resl
