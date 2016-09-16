from pathlib import Path

from LEGACY.sim_automation.main import basic_hdl_test

vhdl_sources = ['../../../avg/hdl/average.vhd',
                '../casc.vhd']

dut_name = 'casc'
input_ports = ['x']
output_ports = ['y']


def test():
    base_path = Path(__file__).parent
    basic_hdl_test(base_path, vhdl_sources, dut_name, input_ports, output_ports)


if __name__ == "__main__":
    test()
