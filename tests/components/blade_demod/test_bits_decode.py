from scipy import signal

from pyha.common.sfix import Sfix
from pyha.common.util import load_gnuradio_file, hex_to_bool_list
import numpy as np

from pyha.components.blade_demod.bits_decode import BitsDecode, CRC16, HeaderCorrelator
from pyha.simulation.simulation_interface import plot_assert_sim_match, SIM_MODEL, assert_sim_match, \
    debug_assert_sim_match, SIM_HW_MODEL, SIM_RTL, SIM_GATE


def test_uks_one():
    expected_data = '8dfc4ff97dffdb11ff438aee29243910365e908970b9475e'
    iq = load_gnuradio_file(
        '/home/gaspar/git/pyha/tests/components/blade_demod/one_uksetaga_f2405350000.00_fs2181818.18_rx6_30_0_band2000000.00.iq')

    iq = iq[600:4000]
    demod = np.angle(iq[1:] * np.conjugate(iq[:-1])) / np.pi
    sps = 16
    taps = [1 / sps] * sps
    iqf = signal.lfilter(taps, [1], demod)


    dut = BitsDecode(0.2)
    r = debug_assert_sim_match(dut, [Sfix(left=0, right=-17)],
                                 None, iqf,
                                 rtol=1e-9,
                                 atol=1e-9,
                                 simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                                 dir_path='/home/gaspar/git/pyha/playground/conv'
                                 )

    # remove invalid outputs
    hm = np.array([bool(x) for x,valid in zip(*r[1]) if bool(valid)]).astype(int)
    assert (hm == r[0]).all()

    hrtl = np.array([bool(x) for x,valid in zip(*r[2]) if bool(valid)]).astype(int)
    assert (hrtl == r[0]).all()

    hgate = np.array([bool(x) for x,valid in zip(*r[3]) if bool(valid)]).astype(int)
    assert (hgate == r[0]).all()
    # packets = BitsDecode(f)
    # assert len(packets) == 1
    # assert expected_data in packets[0]



def test_crc():
    inputs = hex_to_bool_list('8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb')

    dut = CRC16(init_galois=0x48f9, xor=0x1021)
    assert_sim_match(dut, [bool],
                                 None, inputs,
                                 rtol=1e-9,
                                 atol=1e-9,
                                 simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                                 dir_path='/home/gaspar/git/pyha/playground/conv'
                                 )

class TestHeaderCorrelator:
    def setup(self):
        self.dut = HeaderCorrelator(header=0x8dfc, packet_len=12 * 16)

    def test_one_packet(self):
        inputs = hex_to_bool_list('8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb')
        r = debug_assert_sim_match(self.dut, [bool], None, inputs,
                                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                         dir_path='/home/gaspar/git/pyha/playground/conv'
                                     )
        pass