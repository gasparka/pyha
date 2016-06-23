module top_sv #()
  (
  input clk,rst_n,
  input  [17 :0]        x,
  output [17 :0]       y
  );


// VHDL DUT
  top_vhdl #()
  top_vhdl (
    .clk(clk),
    .rst_n(rst_n),
    .x      (x),
    .y  (y)
    );


endmodule
