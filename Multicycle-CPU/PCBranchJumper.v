`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:50:45 05/10/2016 
// Design Name: 
// Module Name:    PCBranchJumper 
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
module PCBranchJumper(
    input [31:0] PC0,
    input [31:0] offset,
    output reg [31:0] PC1
    );

    always @(PC0 or offset) begin
	     PC1 = PC0 + (offset << 2);
	 end

endmodule
