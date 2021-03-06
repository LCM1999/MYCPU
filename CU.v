`timescale 1ns / 1ps
module CU(
  input [5:0] OpCode,
  
  output RegWre,  // enable regfile to write
  output RegDst,  //00->EX_addr = RT, 01->EX_addr = RD, 10->EX_addr = RS, 11->exception
  // as you can see, this signal have new meaning
  output [1:0] J,
  //output [1:0] PCSrc,
  output MEM_Read,  // 1->enable ram to read
  output MEM_Write,  // 1->enable ram to write
  output MEMtoReg,  // 0->ALUData>>Reg, 1->MEMData>>Reg
  //output ALUSrcA,  // is this useful?
  //output ALUSrcB,  // 0->SrcB exists, 1->SrcB=0
  //is this useful?
  output ExtSign,  // this imme should be extended
  output [2:0] ALUOp
  );
  
  wire exception;
  assign exception = 
    (OpCode == 6'b000000 ||  //add
     OpCode == 6'b000001 ||  //addi
     OpCode == 6'b000010 ||  //sub
     OpCode == 6'b000011 ||  //subi
     OpCode == 6'b000100 ||  //cmp
     OpCode == 6'b000101 ||  //cmps
     OpCode == 6'b000110 ||  //sl
     OpCode == 6'b000111 ||  //sr
     OpCode == 6'b001000 ||  //or
     OpCode == 6'b001001 ||  //and
     OpCode == 6'b010000 ||  //mw
     OpCode == 6'b010001 ||  //mr
     OpCode == 6'b100000 ||  //mov
     OpCode == 6'b100001 ||  //movi [0,rt,immediate]
     OpCode == 6'b100010 ||  //jmp
     OpCode == 6'b100011)    //jb
     ? 1'b0 : 1'b1;

  assign RegWre =
         (exception ||
          OpCode == 6'b010000 ||
          OpCode == 6'b100010 ||
          OpCode == 6'b100011) ? 1'b0 : 1'b1;
          
  assign RegDst = 
          exception ? 1'b0 :
          (OpCode == 6'b000001 ||
           OpCode == 6'b000011 ||
           OpCode == 6'b100001 ||
           OpCode == 6'b100010 ||
           OpCode == 6'b100011) ? 1'b1 : 1'b0;
           
  assign J =
          exception ? 2'b00 :
          (OpCode == 6'b100010) ? 2'b10 :
          (OpCode == 6'b100011) ? 2'b11 : 2'b00;
  /*
  assign PCSrc =
          exception ? 2'b11 :
          OpCode == 6'b100010 ? 2'b10 :
          OpCode == 6'b100011 ? 2'b01 : 2'b00;
  */
  assign MEM_Read = 
          exception ? 1'b0 :
          (OpCode == 6'b010001) ? 1'b1 : 1'b0;
  
  assign MEM_Write = 
          exception ? 1'b0 :
          (OpCode == 6'b010000) ? 1'b1 : 1'b0;
  
  assign MEMtoReg = 
          exception ? 1'b0 :
          (OpCode == 6'b010000 ||
           OpCode == 6'b010001) ? 1'b1 : 1'b0;
  
  /**
  assign ALUSrcA =
  
  
  assign ALUSrcB = 
          exception ? 1'b1 :
          (OpCode == 6'b010000 ||
           OpCode == 6'b010001 ||
           OpCode == 6'b100000 ||
           OpCode == 6'b100001) ? 1'b1 : 1'b0;
  */
  
  assign ExtSign = 
          exception ? 1'b0 :
          (OpCode == 6'b000001 ||
           OpCode == 6'b000011 ||
           OpCode == 6'b100001) ? 1'b1 : 1'b0;
  
  assign ALUOp[2:0] = 
          exception ? 3'b000 :
          (OpCode == 6'b000000 ||
           OpCode == 6'b000001 ||
           OpCode == 6'b010000 ||
           OpCode == 6'b010001 ||
           OpCode == 6'b100000 ||
           OpCode == 6'b100001 ||
           OpCode == 6'b100010) ? 3'b000 :
          (OpCode == 6'b000010 ||
           OpCode == 6'b000011) ? 3'b001 :
          (OpCode == 6'b000100 ||
           OpCode == 6'b100011) ? 3'b010 :
          (OpCode == 6'b000101) ? 3'b011 :
          (OpCode == 6'b000110) ? 3'b100 :
          (OpCode == 6'b000111) ? 3'b101 :
          (OpCode == 6'b001000) ? 3'b110 :
          (OpCode == 6'b001001) ? 3'b111 : 3'b000;
            
endmodule
