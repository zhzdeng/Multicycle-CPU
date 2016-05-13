`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   20:52:48 05/11/2016
// Design Name:   MultiCycle_CPU
// Module Name:   Y:/Desktop/Multicycle-CPU/Multicycle-CPU/textFile.v
// Project Name:  Multicycle-CPU
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: MultiCycle_CPU
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module textFile;

	// Inputs
	reg clk;
	wire [1:0] Extsel;
	wire PCWre;
	wire InsMemRW;
	wire [1:0] RegOut;
	wire RegWre;
	wire ALUSrcB;
	wire ALUM2Reg;
	wire WrRegData;
	wire [1:0] PCSrc;
	wire [2:0]ALUOp;
	wire DataMemRW;
	wire zero;
	wire [31:0] _PcIn;
	wire [31:0]_ALUout;
	wire [31:0] _Pc0;
	wire [31:0] _Pc4;
	wire [31:0] _instruction;
	wire [4:0] _thirdRg;
	wire [31:0] _ALUM2DRout;
	wire [31:0] _WBdata;
	wire [31:0] _RgData1;
	wire [31:0] _RgData2;
	wire [31:0] _extendOut;
	wire [31:0] _pcaddrSelect1;
	wire [31:0] _IRin;
	wire [31:0] _PCextendOut;
	wire [31:0] _ADROut;
	wire [31:0] _BDROut;
	wire [31:0] _ALUResult;
	wire [31:0] _DataOut;
	wire [31:0] _WriteData;

	// Instantiate the Unit Under Test (UUT)
	MultiCycle_CPU uut (
		.clk(clk),
		.Extsel(Extsel),
		.PCWre(PCWre),
		.InsMemRW(InsMemRW),
		.RegOut(RegOut),
		.RegWre(RegWre),
		.ALUSrcB(ALUSrcB),
		.ALUM2Reg(ALUM2Reg),
		.PCSrc(PCSrc),
		.ALUOp(ALUOp),
		.WrRegData(WrRegData),
		.DataMemRW(DataMemRW),
		.zero(zero),
		._ALUout(_ALUout),
		._PcIn(_PcIn),
		._Pc0(_Pc0),
		._Pc4(_Pc4),
		._instruction(_instruction),
		._thirdRg(_thirdRg),
		._ALUM2DRout(_ALUM2DRout),
		._WBdata(_WBdata),
		._RgData1(_RgData1),
		._RgData2(_RgData2),
		._extendOut(_extendOut),
		._pcaddrSelect1(_pcaddrSelect1),
		._IRin(_IRin),
		._PCextendOut(_PCextendOut),
		._ADROut(_ADROut),
		._BDROut(_BDROut),
		._ALUResult(_ALUResult),
		._DataOut(_DataOut),
		._WriteData(_WriteData)
	);

	initial begin
		// Initialize Inputs

		// Extsel = 0;
		// PCWre = 1;
		// InsMemRW = 0;
		// RegOut = 0;
		// RegWre = 0;
		// ALUSrcB = 0;
		// ALUM2Reg = 0;
		// PCSrc = 0;
		// DataMemRW = 0;
		// zero = 0;
		// _PcIn = 0;
		// _Pc0 = 32'hzzzzzzz;
		// _Pc4 = 0;
		// _instruction = 0;
		// _thirdRg = 0;
		// _ALUM2DRout = 0;
		// _WBdata = 0;
		// _RgData1 = 0;
		// _RgData2 = 0;
		// _extendOut = 0;
		// _pcaddrSelect1 = 0;
		// _IRin = 0;
		// _PCextendOut = 0;
		// _ADROut = 0;
		// _BDROut = 0;
		// _ALUResult = 0;
		// _DataOut = 0;
		// _WriteData = 0;
		clk = 1;
		forever #20 clk = !clk;
		// Wait 100 ns for global reset to finish
		#3000 $stop;

		// Add stimulus here

	end

endmodule

