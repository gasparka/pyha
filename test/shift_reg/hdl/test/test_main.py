from pathlib import Path

from sim_automation.main import generate_sim_stuff, run_rtl_sim, run_gate_sim

vhdl_sources = ['../shift_reg.vhd']

dut_name = 'ShiftReg'
input_ports = ['x']
output_ports = ['y']

base_path = Path(__file__).parent
vhdl_sources = [base_path / x for x in vhdl_sources]


def test():
    generate_sim_stuff(base_path, dut_name, input_ports, output_ports, vhdl_sources)
    run_rtl_sim(base_path, vhdl_sources)
    run_gate_sim(base_path)


if __name__ == "__main__":
    test()
    # generate_sim_stuff(base_path, dut_name, input_ports, output_ports, vhdl_sources)
    # run_rtl_sim(base_path, vhdl_sources)
    # run_gate_sim(base_path)
