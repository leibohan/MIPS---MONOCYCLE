
module GPR(DataOut1,DataOut2,clk,WData,WE,WeSel,ReSel1,ReSel2);
	input clk;
	input WE;
	input [4:0] WeSel,ReSel1,ReSel2;
	input [31:0] WData;
	
	output [31:0] DataOut1,DataOut2;
	
	
	reg [31:0] Gpr[31:0];
	
	always@(posedge clk)
	begin
		if(WE == 1)
			Gpr[WeSel] <= WData;
			//$display("2:%h 3:%h 4:%h 5:%h 6:%h 29:%h 31:%h", Gpr[2], Gpr[3], Gpr[4], Gpr[5], Gpr[6], Gpr[29], Gpr[31]);
	end
	assign DataOut1 = (ReSel1==0)?0:Gpr[ReSel1];
	assign DataOut2 = (ReSel2==0)?0:Gpr[ReSel2];
		
endmodule