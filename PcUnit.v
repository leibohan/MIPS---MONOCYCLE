module PcUnit(PC,PcReSet,PcSel,Clk,Address);

	input   PcReSet;
	input   PcSel;
	input   Clk;
	input   [31:0] Address;
	
	output reg[31:0] PC;
	
	integer i;
	reg [31:0] temp;
	always@(posedge Clk or posedge PcReSet)
	begin
		if(PcReSet == 1)
			PC <= 32'h00003000;
			
		PC = PC + 4;
	  if(PcSel == 1)
      PC = Address;
	end
endmodule