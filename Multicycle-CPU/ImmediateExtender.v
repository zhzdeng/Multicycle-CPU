`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:16:54 05/11/2016 
// Design Name: 
// Module Name:    ImmediateExtender 
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
module ImmediateExtender(
    input [1:0] ExtSel,
    input [15:0] immediateIn,
    output reg [31:0] immediateOut
    );

    always @(ExtSel) begin
	     case (ExtSel)
		      2 'b00: begin
				    immediateOut = {27 'b0, immediateIn[10:6]};
			       end
				2 'b01: begin
				    immediateOut = {16 'b0, immediateIn};
					 end
				2 'b10: begin
				    immediateOut = {{16{immediateIn[15]}}, immediateIn};
					 end
		  endcase
	 end
endmodule
