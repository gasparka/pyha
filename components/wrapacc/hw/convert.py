from pathlib import Path

from sim_automation.vhdl_top_generator import TopMaker

vhdl_sources = ['/home/gaspar/git/hwpy/components/wrapacc/hw/hdl/wrapacc.vhd']

dut_name = 'WrapAcc'
input_ports = ['x']
output_ports = ['y1', 'y0']

if __name__ == "__main__":
    base_dir = Path(__file__).parent
    TopMaker(base_dir / 'hdl', dut_name, input_ports, output_ports).make()
