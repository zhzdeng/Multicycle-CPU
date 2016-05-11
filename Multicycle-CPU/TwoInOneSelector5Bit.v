`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    19:47:31 04/18/2016
// Design Name:
// Module Name:    TwoInOneSelector5Bit
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
module TwoInOneSelector5Bit(
    input [4:0] ZeroInput,
    input [4:0] OneInput,
    input Control,
    output reg[4:0] DataOutput
    );

    always @(Control or ZeroInput or OneInput) begin
    	 DataOutput = (Control == 1) ? OneInput : ZeroInput;
    end
endmodule
