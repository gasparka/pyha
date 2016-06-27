class ListTst(object):
    def __init__(self, window_pow):
        self.ch = [Average(10)] * 8

    # average chain
    def main(self, new_sample):
        l = new_sample
        for x in self.ch:
            l = x.main(l)
        return l

    def abstract(self, x):
        import numpy as np
        return np.convolve(x, np.ones((self.window,)) / self.window, mode='full')



