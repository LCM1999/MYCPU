`timescale 1ns / 1ps
module Hazard_Detection(
  input [4:0] ID_Reg_RS,
  input [4:0] ID_Reg_RT,
  input [4:0] ID_EX_Addr,
  //input [4:0] EX_MEM_Addr,
  //input [4:0] MEM_WB_Addr,
  
  output stall);
  
  assign stall = (((ID_Reg_RS == ID_EX_Addr) || (ID_Reg_RT == ID_EX_Addr))
                  && (ID_EX_Addr != 5'b0)) ? 1'b1 : 1'b0;
  
  endmodule
  
