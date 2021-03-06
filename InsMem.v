`timescale 1ns / 1ps
module InsMem(
  input [31:0] InsAddr,  //this rom stores ins, get Ins by its address
  //input stall,  //enable to read or write
  output reg[31:0] InsData  //output the ins code
  );
  
  reg[7:0] ROM [127:0];  //There are 8 bits in each row of this ROM
                         //this rom have 128 rows in total
                         //this rom an store 128/(32/8) = 32 Ins
  
  initial begin
    $readmemh("D:\\ModelSim\\examples\\work\\romData.txt", ROM);
  end
  
  always@(InsAddr)
  begin
    //if(~stall)
      //begin
        InsData[7:0] <= ROM[InsAddr+3];
        InsData[15:8] <= ROM[InsAddr+2];
        InsData[23:16] <= ROM[InsAddr+1];
        InsData[31:24] <= ROM[InsAddr];
      //end
  end
endmodule  
