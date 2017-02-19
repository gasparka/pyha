from pyha.common.sfix import Sfix
from pyha.components.dc_removal import DCRemoval
from pyha.simulation.simulation_interface import assert_sim_match


def test_basic():
    x = [1] * 16 + [-1] * 16
    expected = [0.984375, 0.953125, 0.90625, 0.84375, 0.765625, 0.671875,
                0.5625, 0.4375, 0.328125, 0.234375, 0.15625, 0.09375,
                0.046875, 0.015625, 0., 0., -1.96875, -1.90625,
                -1.8125, -1.6875, -1.53125, -1.34375, -1.125, -0.875,
                -0.65625, -0.46875, -0.3125, -0.1875, -0.09375, -0.03125,
                0., 0.]

    dut = DCRemoval(8)

    assert_sim_match(dut, [Sfix(left=1, right=-18)], expected, x)

# def test_basic():
#     x = [2] * 8 + [-2] * 8
#     expected = [1.75, 1.5, 1.25, 1., 0.75, 0.5, 0.25, 0., -3.5,
#                 -3., -2.5, -2., -1.5, -1., -0.5, 0.]
#     dut = DCRemoval(8)
#
#     assert_sim_match(dut, [Sfix(left=2, right=-18)], expected, x,
#                      simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL])

# def test_tst():
#     x = [2] * 8 + [-2] * 8
#     expected = [0.03125, 0.09375, 0.1875, 0.3125, 0.46875, 0.65625,
#                 0.875, 1.125, 1.28125, 1.34375, 1.3125, 1.1875,
#                 0.96875, 0.65625, 0.25, -0.25]
#     dut = Tst(8)
#     assert_sim_match(dut, [Sfix(left=2, right=-18)], expected, x,
#                      simulations=[SIM_MODEL, SIM_HW_MODEL])
#
# def test_tst2():
#     len = 2 ** 6
#     x = np.random.uniform(-1, 1, len)
#     x += np.random.uniform(-1, 1, len)
#     x += np.random.uniform(-1, 1, len)
#     x += np.random.uniform(-1, 1, len)
#     # dut = Tst(256)
#     # y = dut.model_main(x)
#     y = x/4
#     # hist = np.histogram(y)
#     # print(hist)
#     print(np.var(y), np.max(y), np.min(y))
#     import matplotlib.pyplot as plt
#     plt.hist(y, bins=50)
#     y2 = y * np.sqrt(12/16)
#     print(np.var(y2))
#     plt.hist(y2, bins=50)
#     plt.show()

# f, Pxx_den = signal.welch(y2)
# plt.semilogy(f, Pxx_den)
# plt.grid()
# plt.show()
