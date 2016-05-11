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
// 参数列表
// 读第一个寄存器地址，读第二个寄存器地址，写入寄存器地址
// 写入数据， 写入控制信号，时钟信号，同步清零控制信号
// 第一个输出数据，第二个输出数据
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

	 reg[31:0] registers[1:31]; // r1 - r31 0号寄存器不可见，固定为0
	 assign ReadData1 = ReadReg1Address == 0 ?
			  0 : registers[ReadReg1Address];
	 assign ReadData2 = ReadReg2Address == 0 ?
			  0 : registers[ReadReg2Address];

	 integer i; // 蜜汁错误，放到里面就语法错误

   initial begin
     for (i = 1; i < 32; i = i + 1) registers[i] <= 0;
   end

	 always @(negedge Clock) begin
		if (CleanAllControl == 0) begin
			//integer i = 1;
			for (i = 1; i < 32; i = i + 1)
				registers[i] <= 0;
		end else begin
			 if (WriteControl == 1)
				registers[WriteRegAddress] = DataOfWrite;
	   end
	 end
endmodule

