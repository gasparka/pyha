from pyha.common.hwsim import HW
from pyha.components.blade_demod.bits_decode import DemodToPacket
from pyha.components.blade_demod.blade_adaptor import BladeToComplex
from pyha.components.blade_demod.blade_demod import DemodQuadMavg


class Phantom2ReceiverBlade(HW):
    """ Adds BladeToComplex before Phantom2Receiver """
    def __init__(self):
        self.blade_to_complex = BladeToComplex()
        self.recv = Phantom2Receiver()

        self._delay = self.recv._delay + self.blade_to_complex._delay

    def main(self, i, q):
        c = self.next.blade_to_complex.main(i, q)
        packet_part, valid = self.next.recv.main(c)
        return packet_part, valid

    def model_main(self, i, q):
        c = self.blade_to_complex.model_main(i, q)
        a = self.recv.model_main(c)
        return a


class Phantom2Receiver(HW):
    def __init__(self):
        self.demod = DemodQuadMavg(0.5, 16)
        self.packet = DemodToPacket()

        self._delay = self.demod._delay + self.packet._delay

    def main(self, c):
        demod = self.next.demod.main(c)
        packet_part, valid = self.next.packet.main(demod)
        return packet_part, valid

    def model_main(self, c):
        demod = self.demod.model_main(c)
        packet = self.packet.model_main(demod)
        return packet
