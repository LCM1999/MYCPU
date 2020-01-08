`timescale 1ns / 1ps
module ID(
  input CLK,
  input RST,
  input Flash,
  input [31:0] InsCode,
  output reg[5:0] op,
  output reg[4:0] rs,
  output reg[4:0] rt,
  output reg[4:0] rd,
  output reg[15:0] ID_immediate
  );
  
  initial begin
    op <= 6'b0;
    rs <= 5'b1;
    rt <= 5'b1;
    rd <= 5'b0;
    ID_immediate <= 16'b0;
  end
  
  always@(posedge CLK or negedge RST)
  begin
    if(~RST)
      begin
        op <= 6'b0;
        rs <= 5'b0;
        rt <= 5'b0;
        rd <= 5'b0;
        ID_immediate <= 16'b0;
      end
    else
      begin
        if(~Flash)
          begin
            op <= InsCode[31:26];
            rs <= InsCode[25:21];
            rt <= InsCode[20:16];
            rd <= InsCode[15:11];
            ID_immediate <= InsCode[15:0];
          end
        else
          begin
            op <= 6'b0;
            rs <= 5'b0;
            rt <= 5'b0;
            rd <= 5'b0;
            ID_immediate <= 16'b0;
          end
      end
  end
endmodule
    
