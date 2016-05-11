`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:22:49 04/13/2016
// Design Name:
// Module Name:    InstructionRom
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

//  myRomData.txt��16������д
module InstructionRom(
	input [31:0]address,					// ��ַ
	input RW,											// ��д���ƶ� 1 д; 0 �� Ӧ�ñ���Ϊ0
	output reg[31:0]read_data			// ���������
	);

	 reg [7:0] member [0:255];

	 initial
		$readmemh("myRomData.list", member);

	 always @(address or RW)
		begin
			if (RW == 1) begin
				member[address]     <= read_data[31:24];
				member[address + 1] <= read_data[23:16];
				member[address + 2] <= read_data[15:8];
				member[address + 3] <= read_data[7:0];
			end else begin
					read_data = {member[address], member[address + 1], member[address + 2]
							, member[address + 3]};
			end
		end
endmodule
