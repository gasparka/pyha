import numpy as np
from scipy import signal

from pyha.common.sfix import Sfix
from pyha.common.util import load_gnuradio_file, hex_to_bool_list, hex_to_bit_str
from pyha.components.blade_demod.bits_decode import BitsDecode, CRC16, HeaderCorrelator, PacketSync, DemodToPacket
from pyha.simulation.simulation_interface import SIM_MODEL, assert_sim_match, \
    debug_assert_sim_match, SIM_HW_MODEL, SIM_RTL, SIM_GATE


class TestBitsDecode:
    def setup(self):
        self.expected_data = '8dfc4ff97dffdb11ff438aee29243910365e908970b9475e'
        iq = load_gnuradio_file(
            'one_uksetaga_f2405350000.00_fs2181818.18_rx6_30_0_band2000000.00.iq')

        iq = iq[600:4020]
        demod = np.angle(iq[1:] * np.conjugate(iq[:-1])) / np.pi

        sps = 16
        taps = [1 / sps] * sps
        self.input = signal.lfilter(taps, [1], demod)

        # import matplotlib.pyplot as plt
        # plt.plot(self.input)
        # plt.show()

        self.dut = BitsDecode(0.2)

    def _sim_match(self, sim_outs):
        def type_conv(data):
            # remove invalid outputs and convert to int
            return np.array([bool(x) for x, valid in zip(*data) if bool(valid)]).astype(int)

        ref = sim_outs[0]
        for x in sim_outs[1:]:
            o = type_conv(x)
            assert (o == ref).all()

    def test_model(self):
        model = ''.join(str(x) for x in self.dut.model_main(self.input))
        expect = hex_to_bit_str(self.expected_data)
        assert expect in model

    def test_uks_one(self):
        r = debug_assert_sim_match(self.dut, [Sfix(left=0, right=-17)],
                                   None, self.input,
                                   simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                                   dir_path='/home/gaspar/git/pyha/playground/conv'
                                   )

        self._sim_match(r)


class TestBitsDecodeDiivan:
    def setup(self):
        self.expected_data = '8dfc4ff97dffdb11ff438aee29243910365e908970b9475e'
        iq = load_gnuradio_file(
            'one_diivan_f2405350000.00_fs2181818.18_rx6_30_0_band2000000.00.iq')

        iq = iq[1000:4400]
        demod = np.angle(iq[1:] * np.conjugate(iq[:-1])) / np.pi

        sps = 16
        taps = [1 / sps] * sps
        self.input = signal.lfilter(taps, [1], demod)

        # import matplotlib.pyplot as plt
        # plt.plot(self.input)
        # plt.show()

        self.dut = BitsDecode(0.2)

    def _sim_match(self, sim_outs):
        def type_conv(data):
            # remove invalid outputs and convert to int
            return np.array([bool(x) for x, valid in zip(*data) if bool(valid)]).astype(int)

        ref = sim_outs[0]
        for x in sim_outs[1:]:
            o = type_conv(x)
            assert (o == ref).all()

    def test_model(self):
        model = ''.join(str(x) for x in self.dut.model_main(self.input))
        expect = hex_to_bit_str(self.expected_data)
        assert expect in model

    def test_uks_one(self):
        r = debug_assert_sim_match(self.dut, [Sfix(left=0, right=-17)],
                                   None, self.input,
                                   simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL],
                                   dir_path='/home/gaspar/git/pyha/playground/conv'
                                   )

        self._sim_match(r)


class TestBitsDecodeUksHWSim:
    """ this finds bit_counter off by one error """
    def setup(self):
        self.expected_data = '8dfc4ff97dffdb11ff438aee29243910365e908970b9475e'
        iq = load_gnuradio_file(
            'hwsim_one_uksetaga_f2405350000.00_fs2181818.18_rx6_30_0_band2000000.00.iq')

        self.input = iq
        self.dut = BitsDecode(0.2)

    def _sim_match(self, sim_outs):
        def type_conv(data):
            # remove invalid outputs and convert to int
            return np.array([bool(x) for x, valid in zip(*data) if bool(valid)]).astype(int)

        expect = hex_to_bit_str(self.expected_data)
        for x in sim_outs[1:]:
            o = ''.join(str(x) for x in type_conv(x))
            assert expect in o

    def test_model(self):
        model = ''.join(str(x) for x in self.dut.model_main(self.input))
        expect = hex_to_bit_str(self.expected_data)
        assert expect in model

    def test_uks_one(self):
        r = debug_assert_sim_match(self.dut, [Sfix(left=0, right=-17)],
                                   None, self.input,
                                   simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                                   dir_path='/home/gaspar/git/pyha/playground/conv'
                                   )

        # import matplotlib.pyplot as plt
        # plt.plot(self.dut.debugx)
        # plt.stem(self.dut.debugi, self.dut.debugb)
        # plt.show()

        self._sim_match(r)

class TestCRC16:
    def setup(self):
        self.dut = CRC16(init_galois=0x48f9, xor=0x1021)

    def test_uks_one(self):
        data = hex_to_bool_list('8dfc4ff97dffdb11ff438aee29243910365e908970b9475e')
        reload = [False] * len(data)
        model = self.dut.model_main(data, reload)
        assert model[-1] == 0
        assert_sim_match(self.dut, [bool, bool],
                         None, data, reload,
                         simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         dir_path='/home/gaspar/git/pyha/playground/conv'
                         )

    def test_one(self):
        data = hex_to_bool_list('8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb')
        data = hex_to_bool_list('8dfc4ff97dffdb11ff438aee29243910365e908970b9475e')
        reload = [False] * len(data)

        model = self.dut.model_main(data, reload)
        assert model[-1] == 0

        assert_sim_match(self.dut, [bool, bool],
                         None, data, reload,
                         simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         dir_path='/home/gaspar/git/pyha/playground/conv'
                         )

    def test_reset(self):
        data = hex_to_bool_list('A8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb')
        reload = [False, False, False, False, True] + [False] * 191

        model = self.dut.model_main(data, reload)
        assert model[-1] == 0

        assert_sim_match(self.dut, [bool, bool],
                         None, data, reload,
                         simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         dir_path='/home/gaspar/git/pyha/playground/conv'
                         )

    def test_two(self):
        data = hex_to_bool_list('8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb'
                                '8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb')
        reload = [False] * 192 + [True] + [False] * 191

        model = self.dut.model_main(data, reload)
        assert model[191] == 0
        assert model[-1] == 0

        assert_sim_match(self.dut, [bool, bool],
                         None, data, reload,
                         simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         dir_path='/home/gaspar/git/pyha/playground/conv'
                         )


class TestHeaderCorrelator:
    def setup(self):
        self.dut = HeaderCorrelator(header=0x8dfc, packet_len=12 * 16)

    def test_one_packet(self):
        inputs = hex_to_bool_list('8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb')
        expect = [True] + [False] * 191
        assert_sim_match(self.dut, [bool], expect, inputs,
                         simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         dir_path='/home/gaspar/git/pyha/playground/conv'
                         )

    def test_two_packet(self):
        inputs = hex_to_bool_list('8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb'
                                  '8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb')
        expect = [True] + [False] * 191 + [True] + [False] * 191
        assert_sim_match(self.dut, [bool], expect, inputs,
                         simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         dir_path='/home/gaspar/git/pyha/playground/conv'
                         )


class TestPacketSync:
    def setup(self):
        self.dut = PacketSync(header=0x8dfc, packet_len=12 * 16)

    def test_one_packet(self):
        inputs = hex_to_bool_list('8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb')
        expect = [False] * 191 + [True]
        assert_sim_match(self.dut, [bool], expect, inputs,
                         simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         dir_path='/home/gaspar/git/pyha/playground/conv'
                         )

    def test_two_packet(self):
        inputs = hex_to_bool_list('8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb'
                                  '8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb')
        expect = [False] * len(inputs)
        expect[191] = True
        expect[-1] = True
        assert_sim_match(self.dut, [bool], expect, inputs,
                         simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         dir_path='/home/gaspar/git/pyha/playground/conv'
                         )

    def test_full(self):
        inputs = hex_to_bool_list('8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb'
                                  '43534587894321874237888738022073'
                                  '8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb'
                                  '213487897857348758'
                                  '8dfc4ff97dffdb11ff438aee2524391039a4908970b91cdb')

        assert_sim_match(self.dut, [bool], None, inputs,
                         simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                         dir_path='/home/gaspar/git/pyha/playground/conv'
                         )


class TestDemodToPacket:
    def setup(self):
        self.expected_data = '8dfc4ff97dffdb11ff438aee29243910365e908970b9475e'
        iq = load_gnuradio_file(
            'one_uksetaga_f2405350000.00_fs2181818.18_rx6_30_0_band2000000.00.iq')

        demod = np.angle(iq[1:] * np.conjugate(iq[:-1])) / np.pi

        sps = 16
        taps = [1 / sps] * sps
        self.input = signal.lfilter(taps, [1], demod)
        self.dut = DemodToPacket()

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
        r = debug_assert_sim_match(self.dut, [Sfix(left=0, right=-17)],
                                   None, self.input,
                                   simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                                   dir_path='/home/gaspar/git/pyha/playground/conv'
                                   )

        self._sim_match(r)


class TestDemodToPacketHWSim:
    def setup(self):
        self.expected_data = '8dfc4ff97dffdb11ff438aee29243910365e908970b9475e'
        iq = load_gnuradio_file(
            'hwsim_one_uksetaga_f2405350000.00_fs2181818.18_rx6_30_0_band2000000.00.iq')
        self.input = iq
        self.dut = DemodToPacket()

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
        r = debug_assert_sim_match(self.dut, [Sfix(left=0, right=-17)],
                                   None, self.input,
                                   simulations=[SIM_MODEL, SIM_HW_MODEL],
                                   dir_path='/home/gaspar/git/pyha/playground/conv'
                                   )

        model = ''.join(str(int(x)) for x in self.dut.packsync.dbg)
        expect = hex_to_bit_str(self.expected_data)
        print(model)
        print(expect)
        assert expect in model
        self._sim_match(r)
