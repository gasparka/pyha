import os

from sim_automation.main import run_sim

vhdl_sources = ['../average.vhd',
                '../top.vhd']

base_path = os.path.dirname(os.path.realpath(__file__))

if __name__ == "__main__":
    run_sim(base_path, vhdl_sources)
    # run_sim(base_path, vhdl_sources, 'GATE', generate_gate_netlist=True)
    # run_sim(base_path, vhdl_sources, 'GATE')
