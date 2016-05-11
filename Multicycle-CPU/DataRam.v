`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    16:07:34 04/13/2016
// Design Name:
// Module Name:    DataRam
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
// DataIn 数据输入 address 地址总线 RW : 1 write; :0 read
module DataRam(
   input [31:0] address,       // 数据存储器地址输入端口
   input [31:0] DataIn,        // 数据存储器数据输入端口
   input RW,                   // 数据存储器读写控制信号
   input clk,
	 output reg[31:0] DataOut        // 数据存储器数据输出端口
   );

	reg [7:0] memory [0:255];
  integer i;
  initial begin
    for (i = 0; i < 256; i = i + 1) memory[i] <= 32'b0;
  end

  always @(address or DataIn or RW) begin
    if (RW == 0)
        DataOut = {memory[address], memory[address + 1],
                 memory[address + 2], memory[address + 3]};
    end
	always @(negedge clk) begin
			if (RW == 1) begin
        memory[address] <= DataIn[31:24];
  			memory[address + 1] <= DataIn[23:16];
  			memory[address + 2] <= DataIn[15:8];
  			memory[address + 3] <= DataIn[7:0];
			end
	end
endmodule
