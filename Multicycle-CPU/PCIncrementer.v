`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:37:22 05/10/2016 
// Design Name: 
// Module Name:    PCIncrementer 
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
module PCIncrementer(
    input [31:0] PC0,
    output reg [31:0] PC4
    );
	 
    always @(PC0) begin
	     PC4 = PC0 + 4;
	 end

endmodule
