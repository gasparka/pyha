import logging
from cmath import isclose

import numpy as np

from pyha.simulation.simulation_interface import enforce_simulation_rules, Simulation


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


def debug_assert_sim_match(model, expected, *x, types=None, simulations=None, rtol=1e-05, atol=1e-9, dir_path=None,
                           fuck_it=False, **kwards):
    """ Instead of asserting anything return outputs of each simulation """
    simulations = enforce_simulation_rules(simulations)
    outs = []
    for sim_type in simulations:
        dut = Simulation(sim_type, model=model, input_types=types, dir_path=dir_path)
        hw_y = dut.main(*x)
        outs.append(hw_y)
    return outs


def assert_sim_match(model, expected, *x, types=None, simulations=None, rtol=1e-04, atol=(2 ** -17) * 4, dir_path=None,
                     skip_first=0):
    """
    Run bunch of simulations and assert that they match outputs.

    :param model: Instance of your class
    :param types: If :code:`main` is defined, provide input types for each argument, all arguments will be
     automatically casted to these types.
    :param expected: Expected output of the simulation. If None, assert all simulations match eachother.
    :param x: Inputs, if you have multiple inputs, use *x for unpacking.
    :param simulations: Simulations to run and assert:
    - SIM_MODEL: runs model ('model_main')
    - SIM_HW_MODEL: runs HW model ('main')
    - SIM_RTL: converts to VHDL and runs RTL simulation via GHDL and Cocotb
    - SIM_GATE: runs sources trough Quartus and simulates the generated netlist
    .. note:: If None(default), runs all simulations. SIM_HW_MODEL must be run if SIM_RTL or SIM_GATE are going to run.
    :param rtol: Relative tolerance for assertion. Look np.testing.assert_allclose.
    :param atol: Absolute tolerance for assertion. Look np.testing.assert_allclose.
    :param dir_path: Where are conversion outputs written, if empty uses temporary directory.
    :param skip_first: Skip first 'n' samples for assertion.

    """
    l = logging.getLogger(__name__)
    simulations = enforce_simulation_rules(simulations)

    for sim_type in simulations:
        dut = Simulation(sim_type, model=model, input_types=types, dir_path=dir_path)
        hw_y = dut.main(*x)
        if expected is None and sim_type is simulations[0]:
            l.warning(f'"expected=None", all sims must output: \n{hw_y}')
            expected = hw_y

        try:
            assert len(expected) > 0
            # if type(expected[0]) != type(hw_y[0]):
            #     hw_y = hw_y.astype(type(expected[0]))
            np.testing.assert_allclose(expected[skip_first:], hw_y[skip_first:len(expected)], rtol, atol=atol)
            l.info('########### Pass! ###########')
        except AssertionError as e:
            l.error('##############################################################')
            l.error('##############################################################')
            l.error(f'\t\t"{sim_type}" failed')
            l.error('##############################################################')
            l.error('##############################################################')

            print('Failures (* shows what failed):')
            print(f'Expected \t Actual \t ATOL \t\t\t RTOL')
            print(f'---------------------------------------------------')
            # abs(a-b) <= max(rel_tol * max(abs(a), abs(b)), abs_tol)
            for i, (expect, actual) in enumerate(
                    zip(np.array(expected)[skip_first:].flat, np.array(hw_y)[skip_first:len(expected)].flat)):
                if not isclose(expect, actual, rel_tol=rtol, abs_tol=atol):
                    a = abs(expect - actual)
                    r = rtol * max(abs(expect), abs(actual))
                    if r > atol:
                        print(f'{expect:.5f} \t {actual:.5f} \t {a:.5f} \t *{r:.5f}')
                    else:
                        print(f'{expect:.5f} \t {actual:.5f} \t *{a:.5f} \t {r:.5f}')

            raise