# def plot_assert_sim_match(model, expected, *x, types=None, simulations=None, rtol=1e-05, atol=1e-9, dir_path=None,
#                           skip_first=0):
#     """
#     Same arguments as :code:`assert_sim_match`. Instead of asserting it plots all the simulations.
#
#     """
#     import matplotlib.pyplot as plt
#     simulations = sim_rules(simulations, model)
#     for sim_type in simulations:
#         dut = Simulation(sim_type, model=model, dir_path=dir_path)
#         hw_y = dut.main(*x)
#         plt.plot(hw_y[skip_first:], label=str(sim_type))
#
#     plt.legend()
#     plt.show()


