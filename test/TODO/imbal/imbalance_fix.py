
class ImbalanceFix:
    # idea: put initial values as self. values aswell, easy to get them and convert.
    # idea: use self as reg.next. Must make some mech for reg.current access
    def __init__(self, mu_pow):
        self.phase_h = 0.0
        self.mag_h = 0.0
        self.mu_pow = mu_pow

    def mag_fix(self, i, q):
        """ Remove magnitude imbalance """
        y = i * self.mag_h
        e = abs(q) - abs(y)

        # SHOUDL BE SHIFT
        step = e * self.mu_pow
        self.mag_h += step

        return y, q

    def phase_fix(self, i, q):
        """ Remove phase imbalance """
        clean_q = q - (i * self.phase_h)
        orth = clean_q * i

        # SHOUDL BE SHIFT
        step = orth * self.mu_pow
        self.phase_h += step

        return i, clean_q

    def main(self, i, q):
        ir, qr = self.mag_fix(i, q)
        ir, qr = self.phase_fix(ir, qr)
        return ir, qr
