
module DMem(DataOut,DataAddr,DataIn,DMemW,clk);
	input [11:0] DataAddr;
	input [31:0] DataIn;
	input 		 DMemW;
	input 		 clk;
	reg[4:0] i;
	
	output[31:0] DataOut;
	
	reg [31:0]  DMem[1023:0];
	
	always@(posedge clk)
	//begin
		if(DMemW)
			DMem[DataAddr[11:2]] <= DataIn;
		//$display("DMem:");
		//for (i = 5'b0; i <= 5'h4; i = i + 1)
		  //$display("%d: %h", i, DMem[i]);
	//end
	assign DataOut = DMem[DataAddr[11:2]];
endmodule