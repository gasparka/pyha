from LEGACY.test.TODO import FIR


class LMS:
    def __init__(self, mu_pow, order):
        self.fir = FIR(order)
        self.mag_h = 0.0
        self.mu_pow = mu_pow

    def mag_fix(self, x, desired):
        y = self.fir.filter(x)
        # bug here, must delay other input
        e = abs(desired) - abs(y)

        # need e history
        for i in range(self.order):
            self.fir.taps[i] += self.mu_pow * e

        return y, q
