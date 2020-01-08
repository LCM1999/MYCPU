`timescale 1ns / 1ps
module pcAdder (
  input RST,
  input [1:0] PCSrc,  //it should control the way of PCadder work
  input [31:0] offset,  
//  input [31:0] rs,  
  input [31:0] currPC,
  
  output reg [31:0] nextPC
  );

  always@(*)
  begin
    if(~RST)
      begin
        nextPC <= 0;
      end
    else
      begin
    //    nextPC <= currPC + 4;
        case(PCSrc)
          2'b00: nextPC = currPC + 4;
          2'b01: nextPC = currPC + 4 + offset;
          2'b10: nextPC = {14'b0, offset[15:0], 2'b00};
          //2'b11: nextPC = {pc[31:28], addr, 2'b00};
        endcase
      end
  end
endmodule
  