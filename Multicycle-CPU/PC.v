`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    18:24:08 05/10/2016
// Design Name:
// Module Name:    PC
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
module PC(
    input [31:0] addressIn,
    input PCWre,
    input CLK,
    input RST,
    output reg [31:0] addressOut
    );

	 initial
	     addressOut = 32 'h00000000;

	 always @(posedge CLK) begin
      if (PCWre == 1 'b1) addressOut = addressIn;
      if (RST   == 1'b1)  addressOut = 32'h00000000;
	 end

endmodule
