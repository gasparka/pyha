from pyha import Hardware, simulate, sims_close
from pyha.common.util import hex_to_bool_list


class HeaderCorrelator(Hardware):
    """ Correlate against 16 bit header
    Once header is found, 'packet_len' bits are skipped before next header can be correlated!
    In general you would use this block to reset the CRC calculation.
    """

    def __init__(self, header, packet_len):
        """
        :param header: 16 bit header
        :param packet_len: this is used as a cooldown, to not discover packets inside packets
        """

        self.COOLDOWN_RESET = packet_len - 1
        self.HEADER = hex_to_bool_list(header)
        self.DELAY = 1

        self.cooldown = 0
        self.shr = [False] * 16

    def main(self, din):
        """
        :param din: bit in
        :return: True if 100% correlation
        """
        self.shr = self.shr[1:] + [din]

        if self.cooldown > 0:
            self.cooldown = self.cooldown - 1
            return False

        if self.shr != self.HEADER:
            return False

        self.cooldown = self.COOLDOWN_RESET
        return True


def test_one_packet():
    dut = HeaderCorrelator(header=0x8dfc, packet_len=12 * 16)
    inp = hex_to_bool_list('8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb')
    expect = [False] * len(inp)
    expect[15] = True

    sims = simulate(dut, inp)
    assert sims_close(sims, expect)


def test_cooldown():
    """ Shall find only one correlation because second one happens inside the first packet. """
    dut = HeaderCorrelator(header=0x8dfc, packet_len=12 * 16)
    inp = hex_to_bool_list('8dfc4ff97dffdb11ff438aee25243'
                           '123'
                           '8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb')
    expect = [False] * len(inp)
    expect[15] = True

    sims = simulate(dut, inp)
    assert sims_close(sims, expect)


def test_two_packet():
    dut = HeaderCorrelator(header=0x8dfc, packet_len=12 * 16)
    inp = hex_to_bool_list('8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb'
                           '8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb')
    expect = [False] * len(inp)
    expect[15] = True
    expect[207] = True

    sims = simulate(dut, inp)
    assert sims_close(sims, expect)
