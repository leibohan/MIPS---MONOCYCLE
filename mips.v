module mips(clk,PcReSet,PC,Instruction);
    wire [4:0]Read_Addr_1; 
    wire [4:0]Read_Addr_2; 
    wire [4:0]Write_Addr;
    wire [31:0]Write_Data;
    wire RFWr;
    input clk;
    wire [31:0]Read_Data_1;
    wire [31:0]Read_Data_2;
    GPR RegisteFile(Read_Data_1, Read_Data_2, clk, Write_Data, RFWr, Write_Addr, Read_Addr_1, Read_Addr_2);
    
    wire [31:0]ALU_A;
    wire [31:0]ALU_B;
    wire Zero;
    wire [1:0]ALUOp;
    wire [31:0]ALU_C;
    Alu ALU(ALU_C, Zero, ALU_A, ALU_B, ALUOp);
    
    output wire [31:0]Instruction;
    wire [31:0] Read_Address;
    IM InstructionMemory(Instruction, Read_Address[31:2]);

    output wire [31:0]PC;
    input PcReSet;
    wire [31:0]Address;
    wire [1:0] NPCOp;
    PcUnit pc(PC, PcReSet,NPCOp, clk, Address);

    wire [15:0]Imm16;
    wire [1:0]EXTOp; 
    wire [31:0]Imm32;
    EXT ext(Imm16, EXTOp, Imm32);

    wire [31:0]DataOut;
    wire [31:0]Addr;
    wire [31:0]dataIn;
    wire DMWr;
    DMem DataMemory(DataOut,Addr,dataIn,DMWr,clk);

    wire [31:0]adder;
    NPC addpc(PC,Imm32,adder);

    wire Bsel;
    mux ALUsec({1'b0, Bsel},Read_Data_2,Imm32,ALU_B,ALU_B,ALU_B);

    wire [1:0]WDSel;
    mux #(4, 32, 2) RFWsec(WDSel,ALU_C,DataOut,PC,Write_Data,Write_Data);
    
    wire [1:0]GPRSel;
    mux #(4, 5, 2) RFWAsec(GPRSel,Instruction[15:11],Instruction[20:16],5'b11111,Write_Addr,Write_Addr);

    mux #(4, 32, 2) PCsel(NPCOp,32'b0,adder,{4'b0,Instruction[25:0], 2'b0},Address,Address);

    wire rst,IRWr,PCWr;
    ctrl Control(clk, rst, Instruction[31:26], Instruction[5:0], Zero, Bsel, WDSel, RFWr, DMWr, NPCOp, EXTOp, ALUOp,PCWr, IRWr, GPRSel);



    assign Read_Addr_1 = Instruction[25:21];
    assign Read_Addr_2 = Instruction[20:16];
    assign ALU_A = Read_Data_1;
    assign dataIn = Read_Data_2;
    assign Addr = ALU_C;
    assign Read_Address = PC;
    assign Imm16 = Instruction[15:0];
endmodule