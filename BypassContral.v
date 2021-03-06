module BypassContral(
  input [4:0] ID_EX_Reg_RS,
  input [4:0] ID_EX_Reg_RT,
  input [4:0] EX_MEM_Reg_RD,
  input EX_MEM_RegWre,
  input [4:0] MEM_WB_Reg_RD,
  input  MEM_WB_RegWre,
  
  output [1:0] ForwardA,
  output [1:0] ForwardB
  );
  
  assign ForwardA = ((EX_MEM_Reg_RD == ID_EX_Reg_RS) && (EX_MEM_Reg_RD != 5'b0)
                      && EX_MEM_RegWre) ? 2'b01 : //this case means SrcA <= ALU output
                    ((MEM_WB_Reg_RD == ID_EX_Reg_RS) && (MEM_WB_Reg_RD != 5'b0)
                      && MEM_WB_RegWre) ? 2'b10 : //this case means SrcA <= MEM output
                    2'b00; //SrcA don't need forward
  assign ForwardB = ((EX_MEM_Reg_RD == ID_EX_Reg_RT) && (EX_MEM_Reg_RD != 5'b0)
                      && EX_MEM_RegWre) ? 2'b01 :
                    ((MEM_WB_Reg_RD == ID_EX_Reg_RT) && (MEM_WB_Reg_RD != 5'b0)
                      && MEM_WB_RegWre) ? 2'b10 :
                    2'b00;
  
endmodule
  
  
