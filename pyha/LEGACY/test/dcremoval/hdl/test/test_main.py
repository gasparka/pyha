from pathlib import Path

from LEGACY.sim_automation.main import basic_hdl_test

vhdl_sources = ['../../../avg/hdl/average.vhd',
                '../../../avg_cascade_dc/hdl/casc.vhd',
                '../dcremoval.vhd']

dut_name = 'dcremoval'
input_ports = ['x1', 'x2']
output_ports = ['y1', 'y2']


def test():
    base_path = Path(__file__).parent
    basic_hdl_test(base_path, vhdl_sources, dut_name, input_ports, output_ports)


if __name__ == "__main__":
    test()
    # run_rtl_sim(Path(__file__).parent, vhdl_sources)
