from pyha.common.const import Const
from pyha.common.hwsim import HW
import matplotlib.pyplot as plt
# this is NRZ decoder

class BitsDecode(HW):
    # todo: it uses 32 bit counter for bit_counter..overkill
    def __init__(self, decision_lim):
        self.decision_lim = Const(decision_lim)
        self.bit_counter = 0
        self.state = False
        self.period = Const(16)

        self.out_bit = False
        self.out_valid = False

    def push_bit(self, b):
        self.next.out_bit = b
        self.next.out_valid = True

    def main(self, x):
        self.next.out_valid = False
        self.next.bit_counter = self.bit_counter + 1
        if x > self.decision_lim:
            if not self.state:
                self.push_bit(True)
            self.next.state = True
            self.next.bit_counter = 0
        elif x < -self.decision_lim:
            if self.state:
                self.push_bit(False)
            self.next.state = False
            self.next.bit_counter = 0

        # self.next gives same result..
        if self.bit_counter >= self.period:
            if self.state:
                self.push_bit(False)
            else:
                self.push_bit(True)
            self.next.bit_counter = 0
        return self.out_bit, self.out_valid

    def get_delay(self):
        return 1

    def model_main(self, sig):
        state = 0
        bit_counter = 0
        bits = []
        debugi = []
        debugb = []

        def push_bit(val, i):
            bits.append(val)
            debugi.append(i)
            debugb.append(self.decision_lim if val else -self.decision_lim)

        for i, x in enumerate(sig):
            bit_counter += 1
            if x > self.decision_lim:
                if state != 1:
                    push_bit(1, i)
                state = 1
                bit_counter = 0
            elif x < -self.decision_lim:
                if state != 0:
                    push_bit(0, i)
                state = 0
                bit_counter = 0
            elif bit_counter >= self.period:
                n = 1 if state == 0 else 0
                push_bit(n, i)
                bit_counter = 0

        # plt.plot(sig)
        # plt.stem(debugi, debugb)
        # plt.show()
        return bits


class CRC16(HW):
    def __init__(self, init_galois, xor):
        self.xor = xor

        #NB! tools generally raport fibo init value...need to convert it!
        self.init_galois = init_galois

        self.lfsr = [False] * 16

    def main(self, din):
        out = self.lfsr & 0x8000
        self.next.lfsr = ((self.lfsr << 1) | din) & 0xFFFF
        if out:
            self.next.lfsr = self.next.lfsr ^ self.xor
        return self.lfsr

    def get_delay(self):
        return 1

    def model_main(self, data):
        ret = []
        lfsr = self.init_galois
        for din in data:
            out = lfsr & 0x8000
            lfsr = ((lfsr << 1) | din) & 0xFFFF
            if out:
                lfsr ^= self.xor
            ret.append(lfsr)
        return ret
