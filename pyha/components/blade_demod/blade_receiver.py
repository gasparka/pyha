from pyha.common.hwsim import HW
from pyha.components.blade_demod.bits_decode import DemodToPacket


class BladeReceiver(HW):
    def __init__(self):
        # self.demod = BladeDemodQuadMavg(0.5, 16)
        self.packet = DemodToPacket()

        # self._delay = self.demod.get_delay() + self.packet.get_delay()
        self._delay = self.packet.get_delay()

    def main(self, c):
        # demod = self.next.demod.main(c)
        packet_found, valid = self.next.packet.main(c)
        return packet_found, valid

    def get_delay(self):
        return self._delay

    def model_main(self, c):
        # demod = self.demod.model_main(c)
        # packet = self.packet.model_main(demod)
        packet = self.packet.model_main(c)
        return packet
