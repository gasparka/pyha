from scipy import signal

from pyha.common.sfix import Sfix
from pyha.common.util import load_gnuradio_file
import numpy as np

from pyha.components.blade_demod.bits_decode import BitsDecode
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