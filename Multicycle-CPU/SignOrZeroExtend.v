`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    11:39:39 04/15/2016
// Design Name:
// Module Name:    SignOrZeroExtend
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
// ExtSel = 1 ÓÐ·ûºÅÀ©Õ¹
module SignOrZeroExtend(
    input ExtSel,
    input [15:0] immediate,
    output reg [31:0] DataOut
    );

    initial begin
      DataOut <= 32'bz;
    end
	 always @(immediate or ExtSel) begin
		if (ExtSel == 0)
			DataOut = {16'b0000000000000000, immediate};
		else
			DataOut = {{16{immediate[15]}}, immediate};
	 end

endmodule
