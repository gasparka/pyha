from pyha.common.util import load_gnuradio_file, save_gnuradio_file

lp = load_gnuradio_file('/home/gaspar/git/pyha/tests/components/blade_demod/latestiq_f2405.35_fs6_rx6_30_0_band2_one.iq')
hp = load_gnuradio_file('/home/gaspar/git/pyha/tests/components/blade_demod/latestiq_f2405.35_fs6_rx6_5_0_band2_one.iq')
n = load_gnuradio_file('/home/gaspar/git/pyha/tests/components/blade_demod/f2404_fs16.896_one_hop.iq')

# lp = lp[1030000: 1050000]
# save_gnuradio_file('/home/gaspar/git/pyha/tests/components/blade_demod/latestiq_f2405.35_fs6_rx6_30_0_band2_one.iq', lp)
import matplotlib.pyplot as plt
plt.plot(abs(lp), label='lp')
plt.plot(abs(hp), label='hp')
plt.plot(abs(n), label='norm')
plt.legend()
plt.show()