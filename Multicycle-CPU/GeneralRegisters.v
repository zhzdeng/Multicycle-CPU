`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    20:39:40 04/13/2016
// Design Name:
// Module Name:    GeneralRegisters
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
// �����б�
// ����һ���Ĵ�����ַ�����ڶ����Ĵ�����ַ��д��Ĵ�����ַ
// д�����ݣ� д������źţ�ʱ���źţ�ͬ����������ź�
// ��һ��������ݣ��ڶ����������
module GeneralRegisters(
    input [4:0] ReadReg1Address,
    input [4:0] ReadReg2Address,
    input [4:0] WriteRegAddress,
    input [31:0] DataOfWrite,
    input WriteControl,
    input Clock,
    input CleanAllControl,
    output [31:0] ReadData1,
    output [31:0] ReadData2
    );

	 reg[31:0] registers[1:31]; // r1 - r31 0�żĴ������ɼ����̶�Ϊ0
	 assign ReadData1 = ReadReg1Address == 0 ?
			  0 : registers[ReadReg1Address];
	 assign ReadData2 = ReadReg2Address == 0 ?
			  0 : registers[ReadReg2Address];

	 integer i; // ��֭���󣬷ŵ�������﷨����

   initial begin
     for (i = 1; i < 32; i = i + 1) registers[i] <= 0;
   end

	 always @(negedge Clock) begin
		if (CleanAllControl == 1) begin
			//integer i = 1;
			for (i = 1; i < 32; i = i + 1)
				registers[i] <= 0;
		end else begin
			 if (WriteControl == 1)
				registers[WriteRegAddress] = DataOfWrite;
	   end
	 end
endmodule

