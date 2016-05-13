`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    21:01:39 04/14/2016
// Design Name:
// Module Name:    Control_Unit
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

module Control_Unit(
		input clk,
    input [5:0] opcode,
    input zero,
    input RST,
    output reg PCWre, 						// PC的enable 1: 工作 halt : 0;
    output reg ALUSrcB, 					// ALU的数据端选择
    output reg ALUM2Reg, 					// 只有lw：1
    output reg RegWre, 						// 写入通用寄存器使能端信号 1： 写入
		output reg WrRegData,					// 选择输入数据的类型，PC+4的值还是其他
		output reg InsMemRW, 					// 指令存储器读写端，只能读，一直为0
    output reg DataMemRW,			 		// 1:写入数据存储器（只有lw），0：读
    output reg IRWre,							// 是否修改指令寄存器的值
    output reg [1:0]Extsel, 			//
    output reg [2:0] ALUOp, 			// ALU的运算类型
    output reg [1:0] PCSrc, 			// beq PCSrc = zero others: 0
    output reg [1:0] RegOut 			// 0: rt; 1: rd
    );

		reg [2:0] curState;
		reg [2:0] _ALUOp;
		initial begin
			curState <= 3'b000;
			PCWre    <= 1;
			InsMemRW <= 0;
			IRWre    <= 1;
		end

		always @(posedge clk) begin
			if (RST == 1) curState = 3'b000;
			else begin
				case(curState)
					3'b000: begin // IF 这里没有考虑halt
						PCWre     <= 1;
						ALUSrcB   <= 1'bz;
						ALUM2Reg  <= 1'bz;
						RegWre    <= 0;
						WrRegData <= 1'bz;
						DataMemRW <= 1'bz;
						IRWre     <= 1;
						Extsel    <= 2'b11;
						ALUOp     <= 3'bzzz;
						PCSrc     <= 2'bzz;
						RegOut    <= 2'bzz;
						curState  <= 3'b001;
					end

					3'b001: begin // ID
						RegWre    <= 0;
						DataMemRW <= 1'bz;
						PCWre     <= 0;
						IRWre     <= 0;

						// 这里操作码有问题
						case(opcode)
							6'b000000: begin // add
								ALUSrcB   <= 0;
								ALUM2Reg  <= 0;
								WrRegData <= 1;
								PCSrc     <= 2'b00;
								RegOut    <= 2'b10;
								_ALUOp    <= 3'b000;
								curState  <= 3'b110;
							end
							6'b000001: begin // sub
								ALUSrcB   <= 0;
								ALUM2Reg  <= 0;
								WrRegData <= 1;
								PCSrc     <= 2'b00;
								RegOut    <= 2'b10;
								_ALUOp    <= 3'b001;
								curState  <= 3'b110;
							end
							6'b000010: begin // addi
								ALUSrcB   <= 1;
								ALUM2Reg  <= 0;
								WrRegData <= 1;
								Extsel    <= 2'b10;
								PCSrc     <= 2'b00;
								RegOut    <= 2'b01;
								_ALUOp    <= 3'b000;
								curState  <= 3'b110;
							end
							6'b010000: begin // or
								ALUSrcB   <= 0;
								ALUM2Reg  <= 0;
								WrRegData <= 1;
								PCSrc     <= 2'b00;
								RegOut    <= 2'b10;
								_ALUOp    <= 3'b101;
								curState  <= 3'b110;
							end
							6'b010001: begin // and
								ALUSrcB   <= 0;
								ALUM2Reg  <= 0;
								WrRegData <= 1;
								PCSrc     <= 2'b00;
								RegOut    <= 2'b10;
								_ALUOp    <= 3'b110;
								curState  <= 3'b110;
							end
							6'b010010: begin // ori
								ALUSrcB   <= 1;
								ALUM2Reg  <= 0;
								WrRegData <= 1;
								Extsel    <= 2'b01;
								PCSrc     <= 2'b00;
								RegOut    <= 2'b01;
								_ALUOp    <= 3'b101;
								curState  <= 3'b110;
							end
							6'b011000: begin // sll
								ALUSrcB   <= 1;
								ALUM2Reg  <= 0;
								WrRegData <= 1;
								Extsel    <= 2'b00;
								PCSrc     <= 2'b00;
								RegOut    <= 2'b10;
								_ALUOp    <= 3'b100;
								curState  <= 3'b110;
							end
							6'b100000: begin // move
								ALUSrcB   <= 0;
								ALUM2Reg  <= 0;
								WrRegData <= 1;
								PCSrc     <= 2'b00;
								RegOut    <= 2'b10;
								_ALUOp    <= 3'b000;
								curState  <= 3'b110;
							end
							6'b100111: begin // slt
								ALUSrcB   <= 0;
								ALUM2Reg  <= 0;
								WrRegData <= 1;
								PCSrc     <= 2'b00;
								RegOut    <= 2'b10;
								_ALUOp    <= 3'b010;
								curState  <= 3'b110;
							end
							6'b110000: begin // sw
								ALUSrcB  <= 1;
								PCSrc    <= 2'b00;
								Extsel   <= 2'b10;
								_ALUOp   <= 3'b000;
								curState <= 3'b010;
							end
							6'b110001: begin // lw
								ALUSrcB   <= 1;
								ALUM2Reg  <= 1;
								WrRegData <= 1;
								Extsel    <= 2'b10;
								PCSrc     <= 2'b00;
								RegOut    <= 2'b01;
								_ALUOp    <= 3'b000;
								curState  <= 3'b010;
							end
							6'b110100: begin // beq  此处不设置PCSrc 在curStart=101处设置
								ALUSrcB  <= 0;
								Extsel   <= 2'b10;
								_ALUOp   <= 3'b111;
								curState <= 3'b101;
							end
							6'b111000: begin // j
								PCSrc    <= 2'b11;
								curState <= 3'b000;
							end
							6'b111001: begin // jr
								PCSrc    <= 2'b10;
								curState <= 3'b000;
							end
							6'b111010: begin // jal
								WrRegData <= 0;
								RegOut    <= 2'b00;
								RegWre    <= 1;
								PCSrc     <= 2'b11;
								curState  <= 3'b000;
							end
							6'b111111: begin // halt
								curState <= 3'b000;
							end
						endcase
					end

					3'b110: begin // EXE add,sub,addi,or,and,ori,move,slt,sll
						ALUOp    <= _ALUOp;
						curState <= 3'b111;
					end

					3'b101: begin // EXE beq
						PCSrc    <= 2'b00;
						ALUOp    <= _ALUOp;
						curState <= 3'b000;
					end

					3'b010: begin // EXE sw,lw
						ALUOp    <= _ALUOp;
						curState <= 3'b011;
					end

					3'b111: begin // WB
						RegWre   <= 1;
						curState <= 3'b000;
					end

					3'b011: begin // MEM
						if (opcode == 6'b110000) begin // sw
								 DataMemRW <= 1;
								 curState  <= 3'b000;
							end
						else begin
									DataMemRW <= 0;
									curState  <= 3'b100; // lw
							end
					end

					3'b100: begin // WB
						RegWre   <= 1;
						curState <= 3'b000;
					end
				endcase
			end
		end

		always @(zero) begin
			if (opcode == 6'b110100) begin
				if (zero == 0) PCSrc = 2'b00;
				else if (zero == 1) PCSrc = 2'b01;
				else PCSrc = 2'bzz;
			end
		end
endmodule
