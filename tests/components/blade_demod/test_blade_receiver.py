from pathlib import Path

import pytest
from pyha import simulation

from pyha.common.sfix import ComplexSfix, Sfix
from pyha.common.util import load_gnuradio_file, bools_to_hex
from pyha.components.blade_demod.blade_receiver import Phantom2Receiver, Phantom2ReceiverBlade
from pyha.simulation.simulation_interface import debug_assert_sim_match, SIM_MODEL
import numpy as np


@pytest.mark.slowtest
class TestPhantom2Receiver:
    def setup(self):
        self.dut = Phantom2Receiver()

    def _assert_sims(self, ref, hw_sims):
        for x in hw_sims:
            hwr = [x for x, valid in zip(*x) if valid]
            assert (hwr == ref).all()

    def test_uks_one(self):
        path = Path(__file__).parent / 'data/one_uksetaga_f2405350000.00_fs2181818.18_rx6_30_0_band2000000.00.iq'
        data = load_gnuradio_file(str(path))

        r = debug_assert_sim_match(self.dut, [ComplexSfix(left=0, right=-17)], None, data)

        ref = r[0]
        assert len(ref) == 6
        assert '0x8dfc4ff9' == bools_to_hex(ref[0])
        assert '0x7dffdb11' == bools_to_hex(ref[1])
        assert '0xff438aee' == bools_to_hex(ref[2])
        assert '0x29243910' == bools_to_hex(ref[3])
        assert '0x365e9089' == bools_to_hex(ref[4])
        assert '0x70b9475e' == bools_to_hex(ref[5])

        self._assert_sims(ref, r[1:])

    def test_diivan_one(self):
        path = Path(__file__).parent / 'data/one_diivan_f2405350000.00_fs2181818.18_rx6_30_0_band2000000.00.iq'
        data = load_gnuradio_file(str(path))

        r = debug_assert_sim_match(self.dut, [ComplexSfix(left=0, right=-17)], None, data)

        ref = r[0]
        assert len(ref) == 6
        assert '0x8dfc4ff9' == bools_to_hex(ref[0])
        assert '0x7dffdb11' == bools_to_hex(ref[1])
        assert '0xff438aee' == bools_to_hex(ref[2])
        assert '0x29243910' == bools_to_hex(ref[3])
        assert '0x365e9089' == bools_to_hex(ref[4])
        assert '0x70b9475e' == bools_to_hex(ref[5])

        self._assert_sims(ref, r[1:])


class TestPhantom2ReceiverBlade:
    def setup(self):
        self.dut = Phantom2ReceiverBlade()

    def _assert_sims(self, ref, hw_sims):
        for x in hw_sims:
            hwr = [x for x, valid in zip(*x) if valid]
            assert (hwr == ref).all()

    def test_uks_one(self):
        path = Path(__file__).parent / 'data/blade_signaltap.npy'
        data = np.load(str(path))
        r = debug_assert_sim_match(self.dut, [Sfix(left=0, right=-15)] * 2, None, data.real, data.imag
                                   ,simulations=[SIM_MODEL])

        pass
        # self._assert_sims(ref, r[1:])
