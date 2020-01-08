`timescale 1ns / 1ps
module PC(
  input CLK,
  input RST,
  input stall,  // Enable Pc to add
  input [31:0] nextPC,  // next address conculated by PCadder
  
  output reg[31:0] currPC
  );

  always@(posedge CLK or negedge RST)
  begin
    if(~RST) begin
      currPC <= 0;
    end
  else
    begin
      if(~stall)
        begin
          currPC <= nextPC;
        end
      else
        begin
          currPC <= currPC;
        end
    end
  end
endmodule
