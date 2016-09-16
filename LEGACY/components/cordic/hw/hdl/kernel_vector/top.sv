
module top_sv #()
  (
  input clk,rst_n,
  input  [19 :0]    x1,x2,x3,
  output [19 :0]    y1,y2,y3
  );

  top #()
  top (.*);
endmodule
