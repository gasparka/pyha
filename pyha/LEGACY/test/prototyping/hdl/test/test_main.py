from pathlib import Path

from LEGACY.sim_automation.main import basic_hdl_test, run_rtl_sim

vhdl_sources = ['../shift_reg.vhd']

dut_name = 'ShiftReg'
input_ports = ['x']
output_ports = ['y']


def test():
    base_path = Path(__file__).parent
    basic_hdl_test(base_path, vhdl_sources, dut_name, input_ports, output_ports)


if __name__ == "__main__":
    # test()
    run_rtl_sim(Path(__file__).parent, vhdl_sources)
