`timescale 1ns / 1ps
module ALU(
  input [2:0] ALUOp,
  input [31:0] SrcDataA,
  //input SrcB,  //need fix, this signal now decide should A be plused
  input [31:0] SrcDataB,
  output reg[31:0] result
  );
  
  reg [31:0] A;
  reg [31:0] B;
  
  
  initial begin
    result <= 32'b0;
  end
  
  always@(*)
  begin
    A = SrcDataA;
    B = SrcDataB; //(SrcB == 0) ? SrcDataB : 32'b0;
    case(ALUOp)
      3'b000: result <= A + B;
      3'b001: result <= A - B;
      3'b010: result <= (A <B) ? 1:0;
      3'b011: result <= (((A < B) && (A[31] == B[31])) || ((A[31] == 1 && B[31] == 0))) ? 1 : 0;
      3'b100: result <= A<<B;
      3'b101: result <= A>>B;
      3'b110: result <= A|B;
      3'b111: result <= A&B;
    endcase
  end
endmodule
      