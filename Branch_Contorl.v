`timescale 1ns / 1ps
module Branch_Control(
  input [1:0]J,
  input ALUOut,
  output reg Flash,
  output reg [1:0] PCSrc
  );
  
  always@(*) begin
    case(J)
      2'b00: Flash = 1'b0;
      2'b10: Flash = 1'b1;
      2'b11: Flash = ALUOut ? 1'b1 : 1'b0;
      default: Flash = 1'b0;
    endcase
  end
  
  always@(*) begin
    case(J)
      2'b00: PCSrc = 2'b00;
      2'b10: PCSrc = 2'b10;
      2'b11: PCSrc = ALUOut ? 2'b01 : 2'b00;
      default: PCSrc = 2'b00;
    endcase
  end
endmodule