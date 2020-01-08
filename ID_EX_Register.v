`timescale 1ns / 1ps
module ID_EX_Reg(
  input CLK,
  input RST,
  input [3:0]MEM_WB_Con,  // MEMread, MEMwrite, MEMtoReg, RegWre
  input [2:0] ALUOp,
  input [4:0] ID_Reg_RS,
  input [4:0] ID_Reg_RT,
  input [4:0] ID_Reg_RD,
  input [31:0] ID_immediate,
  input [31:0] DataBusA,
  //input ALUSrcB,
  input [31:0] DataBusB,
  output reg [1:0] MEM_Con,
  output reg [1:0] WB_Con,
  //output reg SrcB,
  output reg [2:0] ALUCon,
  output reg [4:0] ID_EX_Reg_RS,   // I think these message are provided by IF_ID directly
  output reg [4:0] ID_EX_Reg_RT,   // could be a better choice.
  output reg [4:0] ID_EX_Reg_RD,
  output reg [31:0] ID_EX_Reg_immediate,
  output reg [31:0] ID_EX_DataBusA,
  output reg [31:0] ID_EX_DataBusB
  );
  
  always@(posedge CLK or negedge RST)
  begin
    if(~RST)
      begin
        MEM_Con <= 2'b0;
        WB_Con <= 3'b0;
        ALUCon <= 3'b0;
        ID_EX_Reg_RS <= 5'b0;
        ID_EX_Reg_RT <= 5'b0;
        ID_EX_Reg_RD <= 5'b0;
        ID_EX_Reg_immediate <= 32'b0;
        ID_EX_DataBusA <= 32'b0;
        //SrcB <= 0;
        ID_EX_DataBusB <= 32'b0;
      end
    else
      begin
        MEM_Con <= MEM_WB_Con[3:2];
        WB_Con <= MEM_WB_Con[1:0];
        ALUCon <= ALUOp;
        //SrcB <= ALUSrcB;
        ID_EX_Reg_RS <= ID_Reg_RS;
        ID_EX_Reg_RT <= ID_Reg_RT;
        ID_EX_Reg_RD <= ID_Reg_RD;
        ID_EX_Reg_immediate <= ID_immediate;
        ID_EX_DataBusA <= DataBusA;
        ID_EX_DataBusB <= DataBusB;
      end
  end
endmodule   
        
        
