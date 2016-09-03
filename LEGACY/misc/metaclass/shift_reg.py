from LEGACY.common.register import clock_tick


class ShiftReg(object):
    def __init__(self, size):
        self.shr = [0] * size

    @clock_tick
    def main(self, new_sample):
        out = self.shr[-1]
        # self.next.shr = [new_sample] + self.shr[:-1]
        self.next.shr = [new_sample] + self.shr[:-1]
        return out


def test():
    size = 8
    dut = ShiftReg(size)
    out = []
    test_len = 100
    stimul = []
    for x in range(test_len):
        stimul.append(x)
        out.append(dut.main(x))

    assert out[:size] == [0] * size
    assert out[size:] == stimul[:-size]
    # assert dut.next.shift_reg == list(reversed(stimul[-size:]))


test()
