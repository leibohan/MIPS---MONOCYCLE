module EXT(Imm16, EXTOp, Imm32);
  input [15:0]Imm16;
  input [1:0]EXTOp;
  output reg [31:0]Imm32;
  
  always@(*)
  begin
    case (EXTOp)
      00:
        Imm32 <= {16'b0, Imm16[15:0]};
      01:
        Imm32 <= Imm16[15]?{16'hFFFF, Imm16}:{16'b0, Imm16};
      10:
        Imm32 <= {Imm16, 16'b0};
      default:
        ;
    endcase
  end
endmodule
