`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    11:55:18 04/17/2016
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
    input PCWre,
    input [31:0] instructionInput,
    output reg[31:0] instructionOutput
    );

    initial begin
      instructionOutput <= 32'bz;
    end

      always @(instructionInput or PCWre)
	     begin
		      if (PCWre == 1 'b1)
				    instructionOutput = instructionInput + 4;
		  end

endmodule
