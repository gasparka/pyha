from sim_automation.cocotb import CocotbAuto
from sim_automation.quartus import make_gate_vhdl

rtl_sim_folder = '/rtl_sim/'
gate_sim_folder = '/gate_sim/'


def run_sim(base_path, vhdl_sources, sim_type='RTL', generate_gate_netlist=False):
    if sim_type is 'RTL':
        path = base_path + rtl_sim_folder
    elif sim_type is 'GATE':
        path = base_path + gate_sim_folder
        if generate_gate_netlist:
            make_gate_vhdl(path + 'quartus/', vhdl_sources)
        vhdl_sources = [path + 'quartus/simulation/modelsim/qpro.vho']

    d = CocotbAuto(path)
    d.vhdl_source_files.extend(vhdl_sources)
    d.run()
