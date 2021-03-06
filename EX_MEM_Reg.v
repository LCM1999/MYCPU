`timescale 1ns / 1ps
module EX_MEM_Reg(
   input CLK,
   input RST,
   input [1:0] MEM_Signal,
   input [1:0] MEM_WB_Signal,
   input [31:0] ALUOut,
   input [4:0] EX_Reg_RD,
   //input [31:0] DataBusB,  // what's this?
   
   output reg EX_MEM_Write_Con,
   output reg EX_MEM_Read_Con,
   output reg [31:0] EX_MEM_ALUOut,
   //output reg [31:0] MEM_DataBusB,
   output reg EX_MEM_MEMtoReg,
   output reg EX_MEM_RegWre,
   output reg [4:0] EX_MEM_Reg_RD
   );
   
   always@(posedge CLK or negedge RST)
   begin
    if(~RST)
      begin
        EX_MEM_Write_Con <= 0;
        EX_MEM_Read_Con <= 0;
        EX_MEM_ALUOut <= 32'b0;
        //MEM_DataBUsB <= 32'b0;
        EX_MEM_MEMtoReg <= 0;
        EX_MEM_RegWre <= 0;
        EX_MEM_Reg_RD <= 5'b0;
      end
    else
      begin
        EX_MEM_Read_Con <= MEM_Signal[1];
        EX_MEM_Write_Con <= MEM_Signal[0];
        EX_MEM_ALUOut <= ALUOut;
        //MEM_DataBusB <= DataBusB;
        EX_MEM_MEMtoReg <= MEM_WB_Signal[1];
        EX_MEM_RegWre <= MEM_WB_Signal[0];
        EX_MEM_Reg_RD <= EX_Reg_RD;
      end
   end
endmodule  
