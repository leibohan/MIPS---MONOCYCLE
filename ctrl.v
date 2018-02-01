`include "./instruction_def.v"

module ctrl(clk, rst, OP, Funct, Zero, BSel, WDSel, RFWr, DMWr, NPCOp, EXTOp, ALUOp,PCWr, IRWr, GPRSel);
  input clk;
  input rst;
  input [5:0]OP;
  input [5:0]Funct;
  input Zero;
  
  output wire BSel;
  output wire[1:0]WDSel;
  output wire RFWr;
  output wire DMWr;
  output wire[1:0]NPCOp;
  output wire[1:0]EXTOp;
  output wire[1:0]ALUOp;
  output wire PCWr;
  output wire IRWr;
  output wire[1:0]GPRSel;
  
  assign BSel = (OP == `ORI_OP) || (OP == `SW_OP) ||(OP == `LW_OP);
  assign WDSel[1] = (OP == `JAL_OP) || (OP == `SW_OP);
  assign WDSel[0] = (OP == `LW_OP);
  assign RFWr = (OP == `ADDU_OP) || (OP == `ORI_OP) ||(OP == `LW_OP) || (OP == `JAL_OP);
  assign DMWr = (OP == `SW_OP);
  assign NPCOp[0] = (OP == `BEQ_OP) && (Zero == 1);
  assign NPCOp[1] = (OP == `JAL_OP);
  assign EXTOp[0] = (OP == `SW_OP) || (OP == `LW_OP) || (OP == `BEQ_OP);
  assign EXTOp[1] = 0;
  assign ALUOp[0] = (OP == `BEQ_OP) || ((OP == `SUBU_OP)&&(Funct == `SUBU_FUNCT));
  assign ALUOp[1] = (OP == `ORI_OP);
  assign PCWr = (OP == `JAL_OP) || ((OP == `BEQ_OP)&&(Zero == 0));
  assign IRWr = 0;
  assign GPRSel[0] = (OP == `ORI_OP) || (OP == `LW_OP);
  assign GPRSel[1] = (OP == `JAL_OP);

endmodule
