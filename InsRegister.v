`timescale 1ns / 1ps
module IR(
  input CLK,
  input [31:0] ins,
  //input Flash, //enable IRIns to change
  output reg[31:0] IRIns
  );
  
  always@(posedge CLK)
  begin
    //if(~Flash)
    //  begin
        IRIns <= ins;
    //  end
    /*
    else
      begin
        IRIns <= 31'b0;
      end
      */
  end
endmodule  
