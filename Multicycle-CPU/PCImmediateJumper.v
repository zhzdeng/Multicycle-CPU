`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:46:08 05/10/2016 
// Design Name: 
// Module Name:    PCImmediateJumper 
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
module PCImmediateJumper(
    input [31:0] PC0,
    input [25:0] immediate,
    output reg [31:0] PC1
    );
    
	 reg [25:0] temp;
    always @(immediate) begin
	     temp = immediate << 2;
	     PC1 = {PC0[31:28], temp, 2 'b00};
	 end
endmodule
