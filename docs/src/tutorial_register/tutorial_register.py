from pathlib import Path

from pyha.common.hwsim import HW
from pyha.simulation.simulation_interface import assert_sim_match, SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE

conversion_path = Path(__file__).parent / 'convert'


class Register(HW):
    def __init__(self):
        self.reg = 0  # define integer register with startup value of 7077
        self._delay = 1

    def main(self, inp):
        """ Hardware model, convertable to VHDL """
        self.next.reg = inp  # wat
        return self.reg

    def model_main(self, input_list):
        # this could just return the input_list,  but i want to emphasize lists
        outputs = []
        for inp in input_list:
            outputs.append(inp)

        return outputs


def test_register_pos():
    inputs = [1, 2, 3, 4]
    expect = [1, 2, 3, 4]

    dut = Register()
    assert_sim_match(dut, [int], expect, inputs,
                     simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE],
                     dir_path=conversion_path)

# def test_register_neg():
#     inputs = [-1, -2, -3, -4]
#     expect = [-1, -2, -3, -4]
#
#     dut = Register()
#     assert_sim_match(dut, [int], expect, inputs,
#                      simulations=[SIM_MODEL, SIM_HW_MODEL, SIM_RTL, SIM_GATE])
