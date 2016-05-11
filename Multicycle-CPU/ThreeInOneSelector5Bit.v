`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    14:40:44 05/11/2016
// Design Name:
// Module Name:    ThreeInOneSelector5Bit
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
module ThreeInOneSelector5Bit(
		input [1:0]  Control,
		input [4:0] OneInput,
    input [4:0] TwoInput,
    output reg[4:0] DataOutput
    );

    always @(Control or TwoInput or OneInput) begin
      if (Control == 2'b00) DataOutput = 5'b11111;
      else if (Control == 2'b01) DataOutput = OneInput;
      else if (Control == 2'b10) DataOutput = TwoInput;
      else DataOutput = 5'bzzzzz;
    end

endmodule
