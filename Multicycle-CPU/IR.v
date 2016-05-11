`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    10:40:54 05/11/2016
// Design Name:
// Module Name:    IR
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module IR(
    input [31:0] instructionIn,
    input IRWre,
  	 input CLK,
    output reg [31:0] instructionOut
    );

    always @(posedge CLK) begin
	     if (IRWre == 1) instructionOut = instructionIn;
	 end

endmodule
