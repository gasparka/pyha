class ShiftReg(object):
    def __init__(self, size):
        self.shift_reg = [0] * size

    def main(self, new_sample):
        out = self.shift_reg[-1]
        self.shift_reg = [new_sample] + self.shift_reg[:-1]
        return out
