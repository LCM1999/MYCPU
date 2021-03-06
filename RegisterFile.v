`timescale 1ns / 1ps
module RegFile(
  input CLK,
  input RST,
  input [4:0] rs,
  input [4:0] rt,
  input [4:0] write,  //addr
  input [31:0] writeData,  // WB_DataBus
  input RegWre,  //enable to write, WB_RegWre
  input [4:0] rd,
  input RegDst,
  output [31:0] readData1, 
  output [31:0] readData2,
  output reg [4:0] addr
  );
  
  reg [31:0] register[31:1];  //31 32bit register!!!!!!!!
  integer i;
  initial begin
    for(i = 0; i < 32; i = i + 1) register[i] <= 0;
  end

  //!!!!!!!!!!!!!!NB!!!!!!!!!!!!!!
  assign readData1 = (rs==5'b0)? 32'b0 : register[rs];
  assign readData2 = (rt==5'b0)? 32'b0 : register[rt];
  
  always@(negedge CLK or negedge RST)
  begin
    if(~RST)
      begin
        for(i = 0; i < 32; i = i + 1) register[i] <= 32'b0;
      end
    else begin
      if(RegWre && write < 32)
        begin 
          register[write] = writeData;
        end
    end
  end
  
  always@(*)
  begin
    case(RegDst)
      1'b0: addr <= rd;
      1'b1: addr <= rt;
    endcase
  end
endmodule  