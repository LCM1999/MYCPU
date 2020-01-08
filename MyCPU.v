`timescale 1ns / 1ps
module MyCPU(
  input CLK,
  input RST,
  //PCadder
  output [31:0] nextPC,
  //PC
  output [31:0] currPC,
  //InsMEM
  output [31:0] InsData,
  //InsReg
  output [31:0] IRIns,
  //InsDecode
  output [5:0] op,
  output [4:0] rs,
  output [4:0] rt,
  output [4:0] rd,
  output [15:0] ID_immediate,
  //CU
  output RegWre,
  output RegDst,
  output [1:0] J,
  output MEM_Read,
  output MEM_Write,
  output MEMtoReg,
  output ExtSign,
  output [2:0] ALUOp,
  //RegisterFile
  output [31:0] Reg_DataBusA,
  output [31:0] Reg_DataBusB,
  output [4:0] addr,
  //Extend
  output [31:0] extended,
  //ID_EX_Register
  output [1:0] MEM_Con,
  output [1:0] WB_Con,
  output [2:0] ALUCon,
  output [4:0] ID_EX_Reg_RS,
  output [4:0] ID_EX_Reg_RT,
  output [4:0] ID_EX_Reg_RD,
  output [31:0] ID_EX_Reg_immediate,
  output [31:0] ID_EX_DataBusA,
  output [31:0] ID_EX_DataBusB,
  //ALU
  output [31:0] result,
  //EX_MEM_Reg
  output EX_MEM_Write_Con,
  output EX_MEM_Read_Con,
  output [31:0] EX_MEM_ALUOut,
  output EX_MEM_MEMtoReg,
  output EX_MEM_RegWre,
  output [4:0] EX_MEM_Reg_RD,
  //DataMem
  output [31:0] rData,
  //MEM_WB_Reg
  output WB_RegWre,
  output [31:0] WB_DataBus,
  output [4:0] WB_Reg_RD,
  //Harzard_Detection
  output stall,
  //ByPass_Control
  output [1:0] ForwardA,
  output [1:0] ForwardB,
  //Branch_Control
  output Flash,
  output [1:0] PCSrc
  );
  
  
  /***********************IF_Part***********************/
  /***************Begin************/
  
  pcAdder PCadder(
    .RST(RST),
    .PCSrc(PCSrc),
    .offset(ID_EX_Reg_immediate),
    //.aim(ID_EX_Reg_immediate),
    .currPC(currPC),
    .nextPC(nextPC)
    );
    
  PC PC(
    .CLK(CLK),
    .RST(RST),
    .stall(stall),
    .nextPC(nextPC),
    .currPC(currPC)
    );
    
  InsMem InsMem(
    .InsAddr(currPC),
    //.stall(stall),
    .InsData(InsData)
    );
    
  /***************End*****************/
  /*******************IF_ID******************/
  /***************Begin***************/
    
  IR InsRegister(
    .CLK(CLK),
    .ins(InsData),
    //.Flash(Flash),
    .IRIns(IRIns)
    );
    
  ID InsDecode(
    .CLK(CLK),
    .RST(RST),
    .Flash(Flash),
    .InsCode(IRIns),
    .op(op),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .ID_immediate(ID_immediate)
    );
    
  /**************End****************/
  /*****************ID_Part****************/
  /**************Begin**************/
  
  wire [31:0] ReadData2;
  wire [3:0] MEM_WB_ConSignal;
  
  CU Control(
    .OpCode(op),
    .RegWre(RegWre),
    .RegDst(RegDst),
    //.PCSrc(PCSrc),
    .J(J),
    .MEM_Read(MEM_Read),
    .MEM_Write(MEM_Write),
    .MEMtoReg(MEMtoReg),
    .ExtSign(ExtSign),
    .ALUOp(ALUOp)
    );
    
  RegFile RegFile(
    .CLK(CLK),
    .RST(RST),
    .rs(rs),
    .rt(rt),
    .write(WB_Reg_RD),
    .writeData(WB_DataBus),
    .RegWre(WB_RegWre),
    .rd(rd),
    .RegDst(RegDst),
    .readData1(Reg_DataBusA),
    .readData2(ReadData2),
    .addr(addr)
    );
    
  Extend_Unit EU(
    .EU_immediate(ID_immediate),
    .ExtSign(ExtSign),
    .extended(extended)
    );
    
  assign Reg_DataBusB = ExtSign ? extended : ReadData2;
  assign MEM_WB_ConSignal = {MEM_Read, MEM_Write, MEMtoReg, RegWre};  // MEMread, MEMwrite, MEMtoReg, RegWre
  
  /**************End************/
  
  // TODO: In this part, we should think about another case, 
  // In this case, IF_RT => RD , so if IF_RT have a hazard with
  // RT signal in other parts, we should not identify this case is a hazard.
  // We can solve this promble In this File, so that we dont have to fix HD once more.
  
  /*****************ID_EX********************/
  /************Begin************/
  
  wire [4:0] ID_RT;
  
  assign ID_RT = RegDst ? 5'b00000 : rt;
  
  ID_EX_Reg ID_EX_Reg(
    .CLK(CLK),
    .RST(RST),
    .MEM_WB_Con(MEM_WB_ConSignal),
    .ALUOp(ALUOp),
    .ID_Reg_RS(rs),
    .ID_Reg_RT(ID_RT),
    .ID_Reg_RD(addr),
    .ID_immediate(extended),
    .DataBusA(Reg_DataBusA),
    .DataBusB(Reg_DataBusB),
    .MEM_Con(MEM_Con),
    .WB_Con(WB_Con),
    .ALUCon(ALUCon),
    .ID_EX_Reg_RS(ID_EX_Reg_RS),
    .ID_EX_Reg_RT(ID_EX_Reg_RT),
    .ID_EX_Reg_RD(ID_EX_Reg_RD),
    .ID_EX_Reg_immediate(ID_EX_Reg_immediate),
    .ID_EX_DataBusA(ID_EX_DataBusA),
    .ID_EX_DataBusB(ID_EX_DataBusB)
    );
    
  /**************End************/
  /*******************EX_Part********************/
  /**************Begin**************/
  
  reg [31:0] ALU_SrcA;
  reg [31:0] ALU_SrcB;
  wire [31:0] MEM_ALU_DataBus;
  
  always@(*)
  begin
    case(ForwardA)
      2'b00: ALU_SrcA = ID_EX_DataBusA;
      //2'b01: ALU_SrcA = EX_MEM_ALUOut;
      2'b01: ALU_SrcA = MEM_ALU_DataBus;
      2'b10: ALU_SrcA = WB_DataBus;
    endcase
  end
  
  always@(*)
  begin
    case(ForwardB)
      2'b00: ALU_SrcB = ID_EX_DataBusB;
      //2'b01: ALU_SrcB = EX_MEM_ALUOut;
      2'b01: ALU_SrcB = MEM_ALU_DataBus;
      2'b10: ALU_SrcB = WB_DataBus;
    endcase
  end
  
  ALU ALU(
    .ALUOp(ALUCon),
    .SrcDataA(ALU_SrcA),
    .SrcDataB(ALU_SrcB),
    .result(result)
    );
  
  /**************End*************/
  /********************EX_MEM********************/
  /**************Begin***********/
  
  //wire [31:0] EX_MEM_ALUOut; //declared in ALU part
  
  EX_MEM_Reg EX_MEM_Reg(
    .CLK(CLK),
    .RST(RST),
    .MEM_Signal(MEM_Con),
    .MEM_WB_Signal(WB_Con),
    .ALUOut(result),
    .EX_Reg_RD(ID_EX_Reg_RD),
    .EX_MEM_Write_Con(EX_MEM_Write_Con),
    .EX_MEM_Read_Con(EX_MEM_Read_Con),
    .EX_MEM_ALUOut(EX_MEM_ALUOut),
    .EX_MEM_MEMtoReg(EX_MEM_MEMtoReg),
    .EX_MEM_RegWre(EX_MEM_RegWre),
    .EX_MEM_Reg_RD(EX_MEM_Reg_RD)
    );
  
  /****************End****************/
  /**********************MEM_Part******************/
  /****************Begin***************/

  wire [4:0] MEM_Addr;
  
  assign MEM_Addr = EX_MEM_Write_Con ? EX_MEM_Reg_RD : EX_MEM_ALUOut[4:0];
  
  DataMem DataMem(
    .CLK(CLK),
    .RST(RST),
    .read(EX_MEM_Read_Con),
    .write(EX_MEM_Write_Con),
    .addr(MEM_Addr),
    .wData(EX_MEM_ALUOut),
    .rData(rData)
    );
    
  assign MEM_ALU_DataBus = EX_MEM_MEMtoReg ? rData : EX_MEM_ALUOut;
    /*
    if(~MEM_WB_MEMtoReg)
      begin
        WB_DataBus <= ALU_DataBus;
      end
    else
      begin
        WB_DataBus <= MEM_DataBus;
      end*/
    
  /***************End***************/
  /********************MEM_WB*********************/
  /***************Begin**************/
  
  MEM_WB_Reg MEM_WB_Reg(
    .CLK(CLK),
    .RST(RST),
    .MEM_WB_RegWre(EX_MEM_RegWre),
    //.MEM_WB_MEMtoReg(EX_MEM_MEMtoReg),
    .MEM_Reg_RD(EX_MEM_Reg_RD),
    //.ALU_DataBus(EX_MEM_ALUOut),
    //.MEM_DataBus(rData),
    .MEM_ALU_DataBus(MEM_ALU_DataBus),
    .WB_RegWre(WB_RegWre),  // Declare in RegisterFile Part.
    .WB_DataBus(WB_DataBus),
    .WB_Reg_RD(WB_Reg_RD)
    );
  
  /***************End****************/
  /********************Hazard_Detection*******************/
  /***************Begin**************/
  
  Hazard_Detection HD(
    .ID_Reg_RS(rs),
    .ID_Reg_RT(ID_RT),
    .ID_EX_Addr(ID_EX_Reg_RD),
    //.EX_MEM_Addr(MEM_Reg_Addr),
    //.MEM_WB_Addr(WB_addr),
    .stall(stall) //declared in PC part
    );
    
  /**************End******************/
  /********************ByPass_Contral**********************/
  /**************Begin****************/
  
  BypassContral ByPassControl(
    .ID_EX_Reg_RS(ID_EX_Reg_RS),
    .ID_EX_Reg_RT(ID_EX_Reg_RT),
    .EX_MEM_Reg_RD(EX_MEM_Reg_RD),
    .EX_MEM_RegWre(EX_MEM_RegWre),
    .MEM_WB_Reg_RD(WB_Reg_RD),
    .MEM_WB_RegWre(WB_RegWre),
    .ForwardA(ForwardA),
    .ForwardB(ForwardB)
    );
  
  /****************End****************/
  /**********************Branch_Control**********************/
  /****************Begin**************/
  
  Branch_Control BranchControl(
    .J(J),
    .ALUOut(result[0]),
    .Flash(Flash),
    .PCSrc(PCSrc)
    );
  /****************End****************/
endmodule
  
  
  
  
  
  
  
