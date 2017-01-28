import numpy as np

from pyha.common.sfix import ComplexSfix
from pyha.common.util import load_gnuradio_file
from pyha.components.blade_demod.blade_receiver import BladeReceiver
from pyha.simulation.simulation_interface import debug_assert_sim_match, SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE


class TestDemodToPacket:
    def setup(self):
        self.expected_data = '8dfc4ff97dffdb11ff438aee29243910365e908970b9475e'
        iq = load_gnuradio_file(
            'one_uksetaga_f2405350000.00_fs2181818.18_rx6_30_0_band2000000.00.iq')

        self.input = iq
        self.dut = BladeReceiver()

    def _sim_match(self, sim_outs):
        def type_conv(data):
            # remove invalid outputs and convert to int
            return np.array([bool(x) for x, valid in zip(*data) if bool(valid)]).astype(int)

        # TODO: only checks the valid output, add test for package data
        ref = [x for x in sim_outs[0] if x]
        for x in sim_outs[1:]:
            o = [c for c in type_conv(x) if c]
            assert o == ref

    def test_model(self):
        model = [x for x in self.dut.model_main(self.input) if x]
        assert len(model) == 1

    def test_uks_one(self):
        r = debug_assert_sim_match(self.dut, [ComplexSfix(left=0, right=-17)],
                                   None, self.input,
                                   simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                                   dir_path='/home/gaspar/git/pyha/playground/conv'
                                   )

        self._sim_match(r)