from scipy import signal


class FIR(object):
    def __init__(self, order):
        self.order = order
        self.taps = signal.remez(order, [0, 0.1, 0.2, 0.5], [1, 0])
        self.mul = [0] * order
        self.sm = [0] * order

    def filter(self, x):
        for i in reversed(range(len(self.taps))):
            self.mul[i] = x * self.taps[i]
            if i == 0:
                self.sm[0] = self.mul[i]
            else:
                self.sm[i] = self.sm[i - 1] + self.mul[i]

        return self.sm[-1]
