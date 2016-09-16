class HDLStuff(object):
    def __init__(self, base_path, vhdl_src, verilog_src, input_sfix, output_sfix):
        self.output_sfix = output_sfix
        self.input_sfix = input_sfix
        self.base_path = base_path
        self.vhdl_src = vhdl_src
        self.verilog_src = verilog_src