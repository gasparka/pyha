from pyha.common.hwsim import HW
from pyha.components.blade_demod.bits_decode import DemodToPacket
from pyha.components.blade_demod.blade_adaptor import BladeToComplex
from pyha.components.blade_demod.blade_demod import BladeDemodQuadMavg


class Phantom2ReceiverBlade(HW):
    """ Adds BladeToComplex before Phantom2Receiver """
    def __init__(self):
        self.blade_to_complex = BladeToComplex()
        self.recv = Phantom2Receiver()

        self._delay = self.recv.get_delay() + self.blade_to_complex.get_delay()

    def main(self, i, q):
        c = self.next.blade_to_complex.main(i, q)
        packet_part, valid = self.next.recv.main(c)
        return packet_part, valid

    def get_delay(self):
        return self._delay

    def model_main(self, i, q):
        c = self.blade_to_complex.model_main(i, q)
        a = self.recv.model_main(c)
        return a


class Phantom2Receiver(HW):
    def __init__(self):
        self.demod = BladeDemodQuadMavg(0.5, 16)
        self.packet = DemodToPacket()

        self._delay = self.demod.get_delay() + self.packet.get_delay()

    def main(self, c):
        demod = self.next.demod.main(c)
        packet_part, valid = self.next.packet.main(demod)
        return packet_part, valid

    def get_delay(self):
        return self._delay

    def model_main(self, c):
        demod = self.demod.model_main(c)
        packet = self.packet.model_main(demod)
        return packet
