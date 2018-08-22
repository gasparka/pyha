from pyha import Hardware, simulate, sims_close
from pyha.common.util import hex_to_bool_list


class CRC16(Hardware):
    """ Calculate 16 bit CRC, galois based """

    def __init__(self, init_galois, xor):
        """
        :param init_galois: initial value for LFSR. **This must be in galois form, many tools report it in fibo mode only**
        :param xor: feedback value
        """
        self.XOR = xor
        # NB! tools generally report fibo init value...need to convert it to galois!
        self.INIT_GALOIS = init_galois
        self.lfsr = init_galois

        self.DELAY = 1

    def main(self, din, reload):
        """
        :param din: bit in
        :param reload: when True, reloads the initial value to LFSR
        :return: current LFSR value (integer), CRC is correct if this is 0. Once it gets to 0 it STAYS 0, reset needed.
        """
        if reload:
            lfsr = self.INIT_GALOIS
        else:
            lfsr = self.lfsr
        out = lfsr & 0x8000
        next = ((lfsr << 1) | din) & 0xFFFF
        if out != 0:
            next = next ^ self.XOR
        self.lfsr = next
        return self.lfsr


def test_simple_one():
    dut = CRC16(init_galois=0x48f9, xor=0x1021)
    inp = hex_to_bool_list('8dfc4ff97dffdb11ff438aee29243910365e908970b9475e')
    reload = [False] * len(inp)

    sims = simulate(dut, inp, reload)
    assert sims['MODEL_PYHA'][-1] == 0 # CRC was correct
    assert sims_close(sims)


def test_reset_two():
    dut = CRC16(init_galois=0x48f9, xor=0x1021)
    inp = hex_to_bool_list('8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb'
                            '8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb')
    reload = [False] * 192 + [True] + [False] * 191

    sims = simulate(dut, inp, reload)
    assert sims['MODEL_PYHA'][191] == 0  # CRC was correct
    assert sims['MODEL_PYHA'][-1] == 0 # CRC was correct
    assert sims_close(sims)