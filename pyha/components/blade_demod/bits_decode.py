from enum import Enum
from math import ceil

from pyha.common.const import Const
from pyha.common.hwsim import HW
from pyha.common.util import hex_to_bool_list


class DecodeState(Enum):
    HIGH_IN, HIGH_OUT, LOW_IN, LOW_OUT = range(4)


class BitsDecode(HW):
    # debugi = []
    # debugb = []
    # debugx = []
    # debugs = []
    # di = 0
    def __init__(self, decision_lim=0.2):
        self.decision_lim = Const(decision_lim)
        self.bit_counter = 0
        self.state = False
        self.cstate = False
        self.period = Const(16)

        self.out_bit = False
        self.out_valid = False

        self.state = DecodeState.HIGH_IN
        self.sample_clock = 1

    def main(self, x):
        self.next.out_valid = False
        self.next.sample_clock = self.sample_clock - 1

        # state machine -> ghetto clock recovery
        if self.state == DecodeState.HIGH_IN:
            if x < self.decision_lim:
                self.next.state = DecodeState.HIGH_OUT
                self.next.sample_clock = self.period
        elif self.state == DecodeState.HIGH_OUT:
            if x < -self.decision_lim:
                self.next.state = DecodeState.LOW_IN
                self.next.sample_clock = 0
        elif self.state == DecodeState.LOW_OUT:
            if x > self.decision_lim:
                self.next.state = DecodeState.HIGH_IN
                self.next.sample_clock = 0
        elif self.state == DecodeState.LOW_IN:
            if x > -self.decision_lim:
                self.next.state = DecodeState.LOW_OUT
                self.next.sample_clock = self.period

        # bit sampler
        if self.next.sample_clock == 0:
            if self.state == DecodeState.HIGH_IN:
                self.next.out_bit = True
            elif self.state == DecodeState.HIGH_OUT:
                self.next.out_bit = False
            elif self.state == DecodeState.LOW_IN:
                self.next.out_bit = False
            elif self.state == DecodeState.LOW_OUT:
                self.next.out_bit = True
            self.next.out_valid = True
            self.next.sample_clock = self.period

        # self.di += 1
        # self.debugx.append(x)
        # self.debugs.append(self.state.value/3)
        # if self.next.out_valid:
        #     self.debugi.append(self.di)
        #     self.debugb.append(self.decision_lim if self.next.out_bit else -self.decision_lim)
        return self.out_bit, self.out_valid

    def get_delay(self):
        return 1

    def model_main(self, sig):
        # model will not match in case of noise signals
        # NB! likely that the hw algorithm actually works better than this model
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
                    bit_counter = 0
                state = 1
            elif x < -self.decision_lim:
                if state != 0:
                    push_bit(0, i)
                bit_counter = 0
                state = 0
            elif bit_counter >= self.period:
                n = 1 if state == 0 else 0
                push_bit(n, i)
                bit_counter = 0
        # #
        # import matplotlib.pyplot as plt
        # plt.plot(sig)
        # plt.stem(debugi, debugb)
        # plt.show()
        return bits


class CRC16(HW):
    def __init__(self, init_galois, xor):
        self.xor = Const(xor)
        # NB! tools generally raport fibo init value...need to convert it!
        self.init_galois = Const(init_galois)
        self.lfsr = init_galois

    def main(self, din, reload):
        if reload:
            lfsr = self.init_galois
        else:
            lfsr = self.lfsr
        out = lfsr & 0x8000
        self.next.lfsr = ((lfsr << 1) | din) & 0xFFFF
        if out != 0:
            self.next.lfsr = self.next.lfsr ^ self.xor
        return self.lfsr

    def get_delay(self):
        return 1

    def model_main(self, data, reload):
        ret = []
        lfsr = self.init_galois
        for din, rl in zip(data, reload):
            if rl:
                lfsr = self.init_galois

            out = lfsr & 0x8000
            lfsr = ((lfsr << 1) | din) & 0xFFFF
            if out:
                lfsr ^= self.xor
            ret.append(lfsr)
        return ret


class HeaderCorrelator(HW):
    def __init__(self, header, packet_len):
        # once header is found, 'packet_len' bits are skipped before next header can be correlated!
        # NB/TODO: there is possibility that random noise triggers the cooldown, so correct package may be lost!
        self.cooldown_reset = Const(packet_len - 1)
        self.header = Const(hex_to_bool_list(header))

        self.cooldown = 0
        self.shr = [False] * 16

    def main(self, din):
        self.next.shr = self.shr[1:] + [din]
        ret = False
        if self.cooldown == 0:
            if self.shr == self.header:
                self.next.cooldown = self.cooldown_reset
                ret = True
        else:
            self.next.cooldown = self.next.cooldown - 1
        return ret

    def get_delay(self):
        return 16

    def model_main(self, data):
        rets = [False] * len(data)
        i = 0
        while i < len(data):
            word = data[i:i + 16]
            if word == self.header:
                rets[i] = True
                i += self.cooldown_reset
            i += 1
        return rets


def bits_to_int(bits):
    assert len(bits) <= 32
    s = ''.join(str(int(x)) for x in bits)
    return int(s, 2)


class PacketSync(HW):
    def __init__(self, header, packet_len):
        self.packet_len_lim = Const(packet_len - 1)
        self.n32out = ceil(self.packet_len_lim.value / 32)  # number of 32 bit output packets per correct packet

        self.headercorr = HeaderCorrelator(header, packet_len)
        self.crc = CRC16(0x48f9, 0x1021)
        self._delay = self.headercorr.get_delay() + self.crc.get_delay() + 1 + self.n32out # n32out: delay is needed if outputs are to be presented!

        self.delay = [False] * self.headercorr.get_delay()
        self.packet_counter = 0

        # read this when valid=1
        self.bits = [False] * (packet_len + self.headercorr.get_delay() + self.crc.get_delay())

        self.part_out_counter = self.n32out

        # output
        self.out = [False] * 32
        self.valid = False

        # constants
        self.n32out = Const(self.n32out)

    def main(self, data):
        self.next.valid = False
        self.next.bits = self.bits[1:] + [data]

        reload = self.next.headercorr.main(data)
        self.next.packet_counter = self.packet_counter - 1
        if reload or self.packet_counter == 0:
            self.next.packet_counter = self.packet_len_lim

        self.next.delay = self.delay[1:] + [data]
        crc = self.next.crc.main(self.delay[0], reload)

        if crc == 0 and self.packet_counter == 0:
            self.next.part_out_counter = 0

        if self.part_out_counter < self.n32out:
            self.next.part_out_counter = self.next.part_out_counter + 1

        for i in range(self.n32out):
            if self.part_out_counter == i:
                self.next.out = self.bits[(i * 32) - i: 32 + (i * 32) - i]
                self.next.valid = True

        return self.out, self.valid

    def get_delay(self):
        return self._delay

    def model_main(self, data):
        head = self.headercorr.model_main(data)
        crc = self.crc.model_main(data, head)

        ret = []
        for i in range(self.packet_len_lim, len(crc)):
            b = i - self.packet_len_lim
            if head[b] and crc[i] == 0:
                for i in range(0, self.n32out):
                    ofs = i * 32
                    r = data[b + ofs: b + ofs + 32]
                    ret.append(r)
        return ret


class DemodToPacket(HW):
    def __init__(self):
        self.bits = BitsDecode(0.2)
        self.packsync = PacketSync(header=0x8dfc, packet_len=12 * 16)

        self._delay = self.bits.get_delay() + self.packsync.get_delay()

        self.default_ret = [False] * 32

    def main(self, inp):
        pack_part = self.default_ret
        part_valid = False
        bit, bit_valid = self.next.bits.main(inp)
        if bit_valid:
            pack_part, part_valid = self.next.packsync.main(bit)
        return pack_part, part_valid

    def get_delay(self):
        # model and hw will not delay match anyways... because of noise
        return self._delay

    def model_main(self, inp):
        bits = self.bits.model_main(inp)
        pack = self.packsync.model_main(bits)
        return pack
