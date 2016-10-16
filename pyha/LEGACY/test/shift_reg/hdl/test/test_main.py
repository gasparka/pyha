from pathlib import Path

from LEGACY.sim_automation.main import basic_hdl_test

vhdl_sources = ['../shift_reg.vhd']

dut_name = 'ShiftReg'
input_ports = ['x']
output_ports = ['y']


def test():
    base_path = Path(__file__).parent
    # run_rtl_sim(base_path, vhdl_sources)
    basic_hdl_test(base_path, vhdl_sources, dut_name, input_ports, output_ports)


if __name__ == "__main__":
    test()
