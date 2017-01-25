from pyha.common.const import Const
from pyha.common.hwsim import HW
import matplotlib.pyplot as plt
# this is NRZ decoder

class BitsDecode(HW):
    def __init__(self):
        self.decision_lim = Const(0.4)
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
        self.next.bit_counter = self.next.bit_counter + 1
        if x > self.decision_lim:
            print(self.out_bit)
            if not self.state:
                self.push_bit(True)
            self.next.state = True
            self.next.bit_counter = 0
        elif x < -self.decision_lim:
            if self.state:
                self.push_bit(False)
            self.next.state = False
            self.next.bit_counter = 0
        elif self.next.bit_counter >= self.period:
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
            debugb.append(1 if val else -1)

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