from LEGACY.test.TODO import FIR
from LEGACY.test.TODO import ImbalanceFix
from test.dc_removal.main import DCRemoval


class PreRecv(object):
    def __init__(self):
        self.i_fir = FIR(8)
        self.q_fir = FIR(8)
        self.dc_rem = DCRemoval(4)
        self.imbal = ImbalanceFix(4)

    def main(self, i, q):
        dec_i = self.i_fir.filter(i)
        dec_q = self.i_fir.filter(q)
        dc_rem_i, dc_rem_q = self.dc_rem.main(dec_i, dec_q)
        imbal_i, imbal_q = self.imbal.main(dc_rem_i, dc_rem_q)

        return imbal_i, imbal_q
