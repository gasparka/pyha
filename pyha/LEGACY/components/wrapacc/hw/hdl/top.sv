
module top_sv #()
  (
  input clk,rst_n,
  input  [31 :0]    x1,
  output [31 :0]    y1,
  output logic      y2
  );

  top #()
  top (.*);
endmodule
