from pathlib import Path

from sim_automation.main import run_rtl_sim

vhdl_sources = ['../cordickernel.vhd']

dut_name = 'cordickernel'
input_ports = ['x1', 'x2', 'x3']
output_ports = ['y1', 'y2', 'y3']


def test():
    base_path = Path(__file__).parent
    print(base_path)
    run_rtl_sim(base_path, vhdl_sources)
    # basic_hdl_test(base_path, vhdl_sources, dut_name, input_ports, output_ports)


if __name__ == "__main__":
    test()
    # run_rtl_sim(Path(__file__).parent, vhdl_sources)
