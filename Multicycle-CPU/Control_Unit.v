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
    output reg PCWre, 						// PC��enable 1: ���� halt : 0;
    output reg ALUSrcB, 					// ALU�����ݶ�ѡ��
    output reg ALUM2Reg, 					// ֻ��lw��1
    output reg RegWre, 						// д��ͨ�üĴ���ʹ�ܶ��ź� 1�� д��
		output reg WrRegData,					// ѡ���������ݵ����ͣ�PC+4��ֵ��������
		output reg InsMemRW, 					// ָ��洢����д�ˣ�ֻ�ܶ���һֱΪ0
    output reg DataMemRW,			 		// 1:д�����ݴ洢����ֻ��lw����0����
    output reg IRWre,							// �Ƿ��޸�ָ��Ĵ�����ֵ
    output reg [1:0]Extsel, 			//
    output reg [2:0] ALUOp, 			// ALU����������
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
			if (RST == 0) curState = 3'b000;
			else begin
				case(curState)
					3'b000: begin // IF ����û�п���halt
						PCWre     <= 1;
						ALUSrcB   <= 1'bz;
						ALUM2Reg  <= 1'bz;
						RegWre    <= 1;
						WrRegData <= 1'bz;
						DataMemRW <= 1'bz;
						IRWre     <= 1;
						Extsel    <= 2'bzz;
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

						// ���������������
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
							6'b110100: begin // beq  �˴�������PCSrc ��curStart=101������
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
						if (opcode == 2'b110000) begin // sw
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

		always @(opcode or zero) begin
			if (opcode == 6'b110100)
				PCSrc = zero == 1 ? 2'b00 : 2'b01;
		end
endmodule
