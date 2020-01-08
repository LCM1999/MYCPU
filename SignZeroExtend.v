`timescale 1ns / 1ps
module Extend_Unit(
  input [15:0] EU_immediate, 
  input ExtSign,  // enable to be entended
  output reg [31:0] extended  //resulted
  );
  
  always@(*)
  begin
    if(ExtSign)
      begin
        extended[15:0] = EU_immediate;
        extended[31:16] = EU_immediate[15] ? 16'hffff : 16'h0000;
      end
  end
endmodule
