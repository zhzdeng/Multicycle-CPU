`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:22:45 05/11/2016
// Design Name:
// Module Name:    MultiCycle_CPU
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
module MultiCycle_CPU(
    input clk,
    // 控制信号
    input [1:0] Extsel,
    input PCWre,
    input InsMemRW,
    input [1:0]RegOut,
    input RegWre,
    input ALUSrcB,
    input ALUM2Reg,
    input [1:0]PCSrc,
    input DataMemRW,
    input zero,
    // 中间数据
    input [31:0]_PcIn,
    input [31:0]_Pc0,
    input [31:0]_Pc4,
    input [31:0]_instruction,
    input [4:0]_thirdRg,
    input [31:0]_ALUM2DRout,
    input [31:0]_WBdata,
    input [31:0]_RgData1,
    input [31:0]_RgData2,
    input [31:0]_extendOut,
    input [31:0]_pcaddrSelect1,
    input [31:0]_IRin,
    input [31:0]_PCextendOut,
    input [31:0]_ADROut,
    input [31:0]_BDROut,
    input [31:0]_ALUResult,
    input [31:0]_DataOut,
    input [31:0]_WriteData
    );

// IF
PC pc(
      .addressIn(_PcIn),                  // 指令输入，经过PC判断后输出
      .PCWre(PCWre),                      // CU控制信号
      .CLK(clk),                          // 时钟信号
      .RST(0),                            // PC归零信号
      .addressOut(_Pc0)                   // 指令输出
    );

PCIncrementer pcincrementer(
      .PC0(_Pc0),
      .PC4(_Pc4)                          // PC加法器指令输出
    );

PCBranchJumper pcbranchjumper(
      .PC0(_Pc4),
      .offset(_extendOut),                // 立即数
      .PC1(_pcaddrSelect1)                // 输出到PCAddressSelector 1端口
    );

InstructionRom instructionrom(
    .address(_Pc0),                    // 地址
    .RW(InsMemRW),                     // 读写控制端 1 写; 0 读 应该保持为0
    .read_data(_IRin)                  // 数据输出端
    );

// ID
IR ir(
    .instructionIn(_IRin),
    .IRWre(IRWre),
    .CLK(clk),
    .instructionOut(_instruction)      // 当前指令
    );


Control_Unit cu(
    clk,
    _instruction[31:26],
    zero,
    0,
    PCWre,                       // PC的enable 1: 工作 halt : 0;
    ALUSrcB,                     // ALU的数据端选择
    ALUM2Reg,                    // 只有lw：1
    RegWre,                      // 写入通用寄存器使能端信号 1： 写入
    WrRegData,                   // 选择输入数据的类型，PC+4的值还是其他
    InsMemRW,                    // 指令存储器读写端，只能读，一直为0
    DataMemRW,                   // 1:写入数据存储器（只有lw），0：读
    IRWre,                       // 是否修改指令寄存器的值
    Extsel,                      //
    ALUOp,                       // ALU的运算类型
    PCSrc,                       // beq PCSrc = zero others: 0
    RegOut                       // 0: rt; 1: rd
    );

ThreeInOneSelector5Bit writeregseletr(
    .Control(RegOut),
    .OneInput(_instruction[20:16]),
    .TwoInput(_instruction[15:11]),
    .DataOutput(_thirdRg)
    );

TwoInOneSelector32Bit writedata(
    .ZeroInput(_Pc0),
    .OneInput(_ALUM2DRout),
    .Control(WrRegData),
    .DataOutput(_WBdata)
    );

GeneralRegisters registers(
    .ReadReg1Address(_instruction[25:21]),
    .ReadReg2Address(_instruction[20:16]),
    .WriteRegAddress(_thirdRg),
    .DataOfWrite(_WBdata),
    .WriteControl(RegWre),
    .Clock(clk),
    .CleanAllControl(1),
    .ReadData1(_RgData1),
    .ReadData2(_RgData2)
    );

ImmediateExtender extend(
    .ExtSel(Extsel),
    .immediateIn(_instruction[15:0]),
    .immediateOut(_extendOut)
    );

PCImmediateJumper PCextend(
    .PC0(_Pc0),
    .immediate(_instruction[25:0]),
    .PC1(_PCextendOut)
    );

PCAddressSelector pcaddrselect(
    .origin(_Pc4),
    .withOffset(_pcaddrSelect1),
    .inRegister(_RgData1),
    .immediate(_PCextendOut),
    .PCSrc(PCSrc),
    .addressOut(_PcIn)
    );

// EXE
InstructionRegisters ADR(
    .dataIn(_RgData1),
    .CLK(clk),
    .dataOut(_ADROut)
    );

InstructionRegisters BDR(
    .dataIn(_RgData2),
    .CLK(clk),
    .dataOut(_BDROut)
    );

ALU alu(
    .InputDataA(_ADROut),               // 寄存器A
    .InputDataB(_BDROut),               // 寄存器B
    .ImmediateDataB(_extendOut),        // 立即数
    .ALUSrcB(ALUSrcB),                  // CU控制信号，决定B为寄存器值或是立即数
    .ALUOp(ALUOp),                      // CU控制信号，决定运算类型
    .zero(zero),                        // 输出信号，通知CU为跳转信号
    .result(_ALUResult)                 // 输出结果
    );

// MEM

InstructionRegisters ALUout(
    .dataIn(_ALUResult),
    .CLK(clk),
    .dataOut(_ALUout)
    );

DataRam dataram(
    .address(_ALUout),       // 数据存储器地址输入端口
    .DataIn(_BDROut),        // 数据存储器数据输入端口
    .RW(DataMemRW),          // 数据存储器读写控制信号
    .clk(clk),
    .DataOut(_DataOut)       // 数据存储器数据输出端口
   );

TwoInOneSelector32Bit DataOutputSelector(
      .ZeroInput(_ALUResult),
      .OneInput(_DataOut),
      .Control(ALUM2Reg),
      .DataOutput(_WriteData)
    );

// WB
InstructionRegisters ALUM2DR(
    .dataIn(_WriteData),
    .CLK(clk),
    .dataOut(_ALUM2DRout)
    );
endmodule
