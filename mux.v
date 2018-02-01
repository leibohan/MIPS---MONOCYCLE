module mux(s, d0, d1, d2, d3, y);
  parameter num_of_ways = 4, length = 32, siglen = 1;
  input [1:0]s;
  input [length:1]d0;
  input [length:1]d1;
  input [length:1]d2;
  input [length:1]d3;
  output reg [length:1]y;
  always@(s or d0 or d2 or d3 or d1)
  begin
    case (s)
      0:
        y <= d0;
      1:
        y <= d1;
      2:
        y <= d2;
      3:
        y <= d3;
    endcase
  end
endmodule