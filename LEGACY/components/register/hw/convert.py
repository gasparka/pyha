from pathlib import Path

from LEGACY.sim_automation.vhdl_top_generator import TopMaker

vhdl_sources = ['/home/gaspar/git/hwpy/components/register/hw/hdl/register.vhd']

dut_name = 'registerr'
input_ports = ['x1']
output_ports = ['y1']

if __name__ == "__main__":
    base_dir = Path(__file__).parent
    TopMaker(base_dir / 'hdl', dut_name, input_ports, output_ports).make()
