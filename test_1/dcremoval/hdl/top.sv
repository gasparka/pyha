module top_sv #()
  (
  input clk,rst_n,
  input  [17 :0]        x1, x2,
  output [17 :0]       y1, y2
  );


// VHDL DUT
  top #()
  top (
    .clk(clk),
    .rst_n(rst_n),
    .x1      (x1),
    .x2 (x2),
    .y1  (y1),
    .y2 (y2)
    );


endmodule
