`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    18:57:09 05/10/2016
// Design Name:
// Module Name:    PCAddressSelector
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
module PCAddressSelector(
    input [31:0] origin,
    input [31:0] withOffset,
    input [31:0] inRegister,
    input [31:0] immediate,
    input [1:0] PCSrc,
    output reg [31:0] addressOut
    );

   initial
    addressOut = 32'h00000000;

	 always @(origin or withOffset or immediate or inRegister or PCSrc) begin
	     case (PCSrc)
		    2 'b00: begin
				    addressOut = origin;
					 end
				2 'b01: begin
				    addressOut = withOffset;
					 end
				2 'b10: begin
				    addressOut = inRegister;
					 end
				2 'b11: begin
				    addressOut = immediate;
					 end
		 endcase
    end

endmodule
