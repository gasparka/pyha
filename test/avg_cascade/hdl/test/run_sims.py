import os

from sim_automation.main import generate_sim_stuff, run_rtl_sim, run_gate_sim

vhdl_sources = ['../../../avg/hdl/average.vhd',
                '../casc.vhd',
                '../top.vhd']

dut_name = 'casc'
input_ports = ['x']
output_ports = ['y']

base_path = os.path.dirname(os.path.realpath(__file__))

if __name__ == "__main__":
    generate_sim_stuff(base_path, dut_name, input_ports, output_ports, vhdl_sources)
    run_rtl_sim(base_path, vhdl_sources)
    run_gate_sim(base_path)
