from scipy import signal

from pyha.common.sfix import Sfix
from pyha.common.util import load_gnuradio_file, hex_to_bool_list
import numpy as np

from pyha.components.blade_demod.bits_decode import BitsDecode, CRC16
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
    r = debug_assert_sim_match(dut, [bool],
                                 None, inputs,
                                 rtol=1e-9,
                                 atol=1e-9,
                                 simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                                 dir_path='/home/gaspar/git/pyha/playground/conv'
                                 )

    ints = []
    for bools in np.array(r[1]).T:
        hws = ''.join([str(int(x)) for x in bools])
        ints.append(int(hws, 2))

    for x, y in zip(ints, r[0]):
        print(x, y)
    assert (ints == r[0]).all()
    pass


def test_2crc2():
    init = 0x48f9 # THIS IS SOME MAGIC VALUE
    lfsr = init


    data = [int(x) for x in bin(int('8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb', 16))[2:]]
    # data = [int(x) for x in bin(int('8dfc4ff97dffdb11ff438aee2524391039a4908970b90000', 16))[2:]]
    # data = [int(x) for x in bin(int('8dfc4ff97dffdb11ff438aee2524391039a4908970b90000', 16))[2:]]
    # assert len(data) == 192

    for din in data:
        out = lfsr & 0x8000
        lfsr = ((lfsr << 1) | din) & 0xFFFF
        if out:
            lfsr ^= 0x1021
        print(hex(lfsr))
    pass
#     /**
# * \file pycrc_stdout
# * Functions and types for CRC checks.
# *
# * Generated on Thu Jan 26 12:37:02 2017,
# * by pycrc v0.9, https://pycrc.org
# * using the configuration:
# *    Width         = 16
# *    Poly          = 0x1021
# *    Xor_In        = 0xfa53
# *    ReflectIn     = False
# *    Xor_Out       = 0x0000
# *    ReflectOut    = False
# *    Algorithm     = bit-by-bit
# *****************************************************************************/
# #include "pycrc_stdout.h"     /* include the header file generated with pycrc */
# #include <stdlib.h>
# #include <stdint.h>
# #include <stdbool.h>
#
# /**
# * Update the crc value with new data.
# *
# * \param crc      The current crc value.
# * \param data     Pointer to a buffer of \a data_len bytes.
# * \param data_len Number of bytes in the \a data buffer.
# * \return         The updated crc value.
# *****************************************************************************/
# crc_t crc_update(crc_t crc, const void *data, size_t data_len)
# {
#    const unsigned char *d = (const unsigned char *)data;
#    unsigned int i;
#    bool bit;
#    unsigned char c;
#
#    while (data_len--) {
#        c = *d++;
#        for (i = 0; i < 8; i++) {
#            bit = crc & 0x8000;
#            crc = (crc << 1) | ((c >> (7 - i)) & 0x01);
#            if (bit) {
#                crc ^= 0x1021;
#            }
#        }
#        crc &= 0xffff;
#    }
#    return crc & 0xffff;
# }
#
#
# /**
# * Calculate the final crc value.
# *
# * \param crc  The current crc value.
# * \return     The final crc value.
# *****************************************************************************/
# crc_t crc_finalize(crc_t crc)
# {
#    unsigned int i;
#    bool bit;
#
#    for (i = 0; i < 16; i++) {
#        bit = crc & 0x8000;
#        crc = (crc << 1) | 0x00;
#        if (bit) {
#            crc ^= 0x1021;
#        }
#    }
#    return (crc ^ 0x0000) & 0xffff;
# }