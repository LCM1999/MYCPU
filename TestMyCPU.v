`timescale 1ns / 1ps

module TestMyCPU();

  reg CLK;
  reg RST;
  
  wire [31:0] nextPC;
  wire [31:0] currPC;
  wire [31:0] InsData;
  wire [31:0] IRIns;
  wire [5:0] op;
  wire [4:0] rs;
  wire [4:0] rt;
  wire [4:0] rd;
  wire [15:0] ID_immediate;
  wire RegWre;
  wire RegDst;
  wire [1:0] J;
  //wire Flash;
  wire MEM_Read;
  wire MEM_Write;
  wire MEMtoReg;
  wire ExtSign;
  wire [2:0] ALUOp;
  wire [31:0] Reg_DataBusA;
  wire [31:0] Reg_DataBusB;
  wire [4:0] addr;
  wire [31:0] extended;
  wire [1:0] MEM_Con;
  wire [1:0] WB_Con;
  wire [2:0] ALUCon;
  wire [4:0] ID_EX_Reg_RS;
  wire [4:0] ID_EX_Reg_RT;
  wire [4:0] ID_EX_Reg_RD;
  wire [31:0] ID_EX_Reg_immediate;
  wire [31:0] ID_EX_DataBusA;
  wire [31:0] ID_EX_DataBusB;
  wire [31:0] result;
  wire EX_MEM_Write_Con;
  wire EX_MEM_Read_Con;
  wire [31:0] EX_MEM_ALUOut;
  wire EX_MEM_MEMtoReg;
  wire EX_MEM_RegWre;
  wire [4:0] EX_MEM_Reg_RD;
  wire [31:0] rData;
  wire WB_RegWre;
  wire [31:0] WB_DataBus;
  wire [4:0] WB_Reg_RD;
  wire stall;
  wire [1:0] ForwardA;
  wire [1:0] ForwardB;
  wire Flash;
  wire [1:0] PCSrc;
  
  MyCPU test(
    .CLK(CLK),
    .RST(RST),
    .nextPC(nextPC),
    .currPC(currPC),
    .InsData(InsData),
    .IRIns(IRIns),
    .op(op),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .ID_immediate(ID_immediate),
    .RegWre(RegWre),
    .RegDst(RegDst),
    .J(J),
    //.Flash(Flash),
    .MEM_Read(MEM_Read),
    .MEM_Write(MEM_Write),
    .MEMtoReg(MEMtoReg),
    .ExtSign(ExtSign),
    .ALUOp(ALUOp),
    .Reg_DataBusA(Reg_DataBusA),
    .Reg_DataBusB(Reg_DataBusB),
    .addr(addr),
    .extended(extended),
    .MEM_Con(MEM_Con),
    .WB_Con(WB_Con),
    .ALUCon(ALUCon),
    .ID_EX_Reg_RS(ID_EX_Reg_RS),
    .ID_EX_Reg_RT(ID_EX_Reg_RT),
    .ID_EX_Reg_RD(ID_EX_Reg_RD),
    .ID_EX_Reg_immediate(ID_EX_Reg_immediate),
    .ID_EX_DataBusA(ID_EX_DataBusA),
    .ID_EX_DataBusB(ID_EX_DataBusB),
    .result(result),
    .EX_MEM_Write_Con(EX_MEM_Write_Con),
    .EX_MEM_Read_Con(EX_MEM_Read_Con),
    .EX_MEM_ALUOut(EX_MEM_ALUOut),
    .EX_MEM_MEMtoReg(EX_MEM_MEMtoReg),
    .EX_MEM_RegWre(EX_MEM_RegWre),
    .EX_MEM_Reg_RD(EX_MEM_Reg_RD),
    .rData(rData),
    .WB_RegWre(WB_RegWre),
    .WB_DataBus(WB_DataBus),
    .WB_Reg_RD(WB_Reg_RD),
    .stall,
    .ForwardA(ForwardA),
    .ForwardB(ForwardB),
    .Flash(Flash),
    .PCSrc(PCSrc)
    );
    
    initial begin
      CLK <= 0;
      RST <= 0;
      #50 RST <= 1;
      forever #50 CLK <= ~CLK;
    end
  endmodule
  
