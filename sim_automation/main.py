import logging

from sim_automation.cocotb import CocotbAuto
from sim_automation.quartus import make_gate_vhdl
from sim_automation.vhdl_top_generator import TopMaker

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

rtl_sim_folder = 'rtl_sim'
gate_sim_folder = 'gate_sim'
src_dir = '..'


def generate_sim_stuff(base_dir, dut_name, input_ports, output_ports, vhdl_sources):
    if not (base_dir / rtl_sim_folder).exists():
        (base_dir / rtl_sim_folder).mkdir()

    if not (base_dir / gate_sim_folder).exists():
        (base_dir / gate_sim_folder).mkdir()

    vhdl_sources.extend([base_dir / '../top.vhd'])
    logger.info('Generating top.vhdl and top.sv')
    TopMaker(base_dir / src_dir, dut_name, input_ports, output_ports).make()

    logger.info('Creating quartus project and running map, netlist writer....')
    make_gate_vhdl(base_dir / gate_sim_folder / 'quartus', vhdl_sources)

    logger.info('Sim file generation done!')


def run_rtl_sim(base_path, vhdl_sources):
    logger.info('Running RTL simulation')
    path = base_path / rtl_sim_folder

    d = CocotbAuto(path)
    d.vhdl_source_files.extend(vhdl_sources)

    # add vhdl top and verilog top
    # verilog top is just VHDL top wrapper, to use VPI
    d.vhdl_source_files.extend([base_path / '../top.vhd'])
    d.verilog_source_files.extend([base_path / '../top.sv'])
    d.run()


def run_gate_sim(base_path):
    logger.info('Running GATE-level simulation')
    path = base_path / gate_sim_folder
    vhdl_sources = [path / 'quartus/simulation/modelsim/qpro.vho']

    d = CocotbAuto(path)
    d.vhdl_source_files.extend(vhdl_sources)

    # need only verilog top (all vhdl is not in .vho file)
    d.verilog_source_files.extend([base_path / '../top.sv'])
    d.run()
