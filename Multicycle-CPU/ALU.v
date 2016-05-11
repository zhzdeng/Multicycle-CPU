`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    11:09:27 05/11/2016
// Design Name:
// Module Name:    ALU
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
module ALU(
    input [31:0] InputDataA,        // �Ĵ���A
    input [31:0] InputDataB,        // �Ĵ���B
    input [31:0] ImmediateDataB,    // ������
    input ALUSrcB,                  // CU�����źţ�����BΪ�Ĵ���ֵ����������
    input [2:0] ALUOp,              // CU�����źţ�������������
    output reg zero,                    // ����źţ�֪ͨCUΪ��ת�ź�
    output reg[31:0] result            // ������
    );
	 reg[31:0] tempB;
	 reg[31:0] tempResult;

   initial begin
      zero <= 1'bz;
      result <= 32'bz;
   end

    always @(InputDataA or InputDataB or ImmediateDataB or ALUSrcB or ALUOp)
	     begin
		      zero <= 0;
		      if (ALUSrcB == 1)
				    tempB = ImmediateDataB;
				else
				    tempB = InputDataB;
				case(ALUOp)
				  3'b000: begin
					    tempResult = InputDataA + tempB;
						 end
					3'b001: begin
					    tempResult = InputDataA - tempB;
					    end
				  3'b010: begin
					    tempResult = InputDataA < tempB;
					    end
          3'b011: begin
					    tempResult = InputDataA >> tempB;
					    end
          3'b100: begin
					    tempResult = InputDataA << tempB;
					    end
					3'b101: begin
					    tempResult = InputDataA | tempB;
					    end
          3'b110: begin
					    tempResult = InputDataA & tempB;
					    end
          3'b111: begin
					    tempResult = InputDataA ^ tempB;
						 if (tempResult == 0)
						     zero <= 1 'b1;
					    end
				endcase
				result <= tempResult;
			end

endmodule
