module mips_tb();
  `timescale 1ns/1ps
  reg clk;
  reg PcReSet;
  wire [31:0]pc;
  wire [31:0]Instruction;
  integer i;
  initial
  begin
    clk=0;
    PcReSet = 0;
    PcReSet = 1;
    #50
    PcReSet = 0;
  end
  always@(*)
  begin
    #50 clk<=~clk;
    if (!clk)
    begin
      $display("\nPC: %h",pc);
      $display("Instruction: %b",Instruction);
    end
  end
  mips my_mips(clk,PcReSet,pc,Instruction);
endmodule