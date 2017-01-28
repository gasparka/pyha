from pyha.common.const import Const
from pyha.common.hwsim import HW
# this is NRZ decoder
from pyha.common.util import hex_to_bool_list


class BitsDecode(HW):
    # debugi = []
    # debugb = []
    # debugx = []
    # di = 0
    def __init__(self, decision_lim=0.2):
        # todo: this algorithm is the biggest bullshit i have made, it was nice once but it turned out it was lazy on valid output
        self.decision_lim = Const(decision_lim)
        self.bit_counter = 0
        self.state = False
        self.cstate = False
        self.period = Const(16)

        self.out_bit = False
        self.out_valid = False

    def push_bit(self, b):
        self.next.out_bit = b
        self.next.out_valid = True
        self.next.bit_counter = 0
        # self.debugi.append(self.di)
        # self.debugb.append(self.decision_lim if b else -self.decision_lim)

    def main(self, x):
        self.next.out_valid = False
        self.next.bit_counter = self.bit_counter + 1
        if x > self.decision_lim:
            self.next.cstate = False
            if not self.state:
                self.push_bit(True)
            self.next.state = True

            # when output saturates for long time...just output crap to keep clock running
            if self.next.bit_counter >= self.period:
                self.push_bit(False)

        elif x < -self.decision_lim:
            self.next.cstate = False
            if self.state:
                self.push_bit(False)
            self.next.state = False

            # when output saturates for long time...just output crap to keep clock running
            if self.next.bit_counter >= self.period:
                self.push_bit(False)
        else:
            if not self.cstate:
                self.next.bit_counter = 0
            self.next.cstate = True

        if self.next.bit_counter >= self.period:
            if self.state:
                self.push_bit(False)
            else:
                self.push_bit(True)

        # self.di += 1
        # self.debugx.append(x)
        return self.out_bit, self.out_valid


    def get_delay(self):
        return 1

    def model_main(self, sig):
        # model will not match in case of noise signals
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


class PacketSync(HW):
    def __init__(self, header, packet_len):
        self.packet_len_lim = Const(packet_len - 1)
        self.headercorr = HeaderCorrelator(header, packet_len)
        self.crc = CRC16(0x48f9, 0x1021)
        self._delay = self.headercorr.get_delay() + self.crc.get_delay()

        self.delay = [False] * self.headercorr.get_delay()
        self.packet_counter = 0

        # read this when valid=1
        self.bits = [False] * packet_len

    def main(self, data):
        reload = self.next.headercorr.main(data)
        self.next.packet_counter = self.packet_counter - 1
        if reload or self.packet_counter == 0:
            self.next.packet_counter = self.packet_len_lim

        self.next.delay = self.delay[1:] + [data]
        crc = self.next.crc.main(self.delay[0], reload)
        # TODO: here is bug, crc is first 0 when counter is 1
        if crc == 0 and self.packet_counter == 0:
            return True
        else:
            return False

    def get_delay(self):
        return self._delay

    def model_main(self, data):
        head = self.headercorr.model_main(data)
        crc = self.crc.model_main(data, head)

        ret = [False] * len(crc)
        for i in range(self.packet_len_lim, len(crc)):
            if head[i - self.packet_len_lim] and crc[i] == 0:
                ret[i] = True
        return ret


class DemodToPacket(HW):
    def __init__(self):
        self.bits = BitsDecode(0.2)
        self.packsync = PacketSync(header=0x8dfc, packet_len=12 * 16)

        self._delay = self.bits.get_delay() + self.packsync.get_delay()

    def main(self, inp):
        ret = False
        bit, valid = self.next.bits.main(inp)
        if valid:
            ret = self.next.packsync.main(bit)
        return ret, valid

    def get_delay(self):
        # model and hw will not delay match anyways... because of noise
        return self._delay

    def model_main(self, inp):
        bits = self.bits.model_main(inp)
        pack = self.packsync.model_main(bits)
        return pack
