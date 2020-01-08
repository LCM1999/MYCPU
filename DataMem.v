`timescale 1ns / 1ps
module DataMem(  //this module need to be conferm
  input CLK,
  input RST,
  input read,  // 1->enable to read
  input write, // same as 'read'
  input [4:0] addr,
  input [31:0] wData,
  output [31:0] rData
  );
  
  parameter RAM_SIZE = 32;
  reg [31:0] ram [RAM_SIZE-1:0];  
  
  assign rData = (read && (addr < RAM_SIZE))?ram[addr] : 32'b0;
  
  integer i;
  always@(posedge CLK or negedge RST)
  begin
    if(~RST)
      begin
        for(i = 0; i < RAM_SIZE; i = i + 1)
          ram[i] <= 32'h00000000;
      end
    else begin
      if(write && (addr < RAM_SIZE))
        begin
          ram[addr] <= wData;
        end
    end
  end
endmodule
