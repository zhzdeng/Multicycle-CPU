`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:52:45 05/11/2016 
// Design Name: 
// Module Name:    ADR 
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
module ADR(
    input [31:0] dataIn,
    input CLK,
    output reg [31:0] dataOut
    );

    always @(posedge CLK) begin
	     dataOut = dataIn;
	 end

endmodule
