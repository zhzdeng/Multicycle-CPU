`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:33:56 05/11/2016 
// Design Name: 
// Module Name:    InstructionRegisters 
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
module InstructionRegisters(
    input [31:0] dataIn,
    input CLK,
    output reg [31:0] dataOut
    );

    always @(posedge CLK) begin
	     dataOut = dataIn;
	 end

endmodule
