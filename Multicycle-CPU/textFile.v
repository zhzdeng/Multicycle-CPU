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
	reg [1:0] Extsel;
	reg PCWre;
	reg InsMemRW;
	reg [1:0] RegOut;
	reg RegWre;
	reg ALUSrcB;
	reg ALUM2Reg;
	reg [1:0] PCSrc;
	reg DataMemRW;
	reg zero;
	reg [31:0] _PcIn;
	reg [31:0] _Pc0;
	reg [31:0] _Pc4;
	reg [31:0] _instruction;
	reg [4:0] _thirdRg;
	reg [31:0] _ALUM2DRout;
	reg [31:0] _WBdata;
	reg [31:0] _RgData1;
	reg [31:0] _RgData2;
	reg [31:0] _extendOut;
	reg [31:0] _pcaddrSelect1;
	reg [31:0] _IRin;
	reg [31:0] _PCextendOut;
	reg [31:0] _ADROut;
	reg [31:0] _BDROut;
	reg [31:0] _ALUResult;
	reg [31:0] _DataOut;
	reg [31:0] _WriteData;

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
		.DataMemRW(DataMemRW),
		.zero(zero),
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

		Extsel = 0;
		PCWre = 0;
		InsMemRW = 0;
		RegOut = 0;
		RegWre = 0;
		ALUSrcB = 0;
		ALUM2Reg = 0;
		PCSrc = 0;
		DataMemRW = 0;
		zero = 0;
		_PcIn = 0;
		_Pc0 = 0;
		_Pc4 = 0;
		_instruction = 0;
		_thirdRg = 0;
		_ALUM2DRout = 0;
		_WBdata = 0;
		_RgData1 = 0;
		_RgData2 = 0;
		_extendOut = 0;
		_pcaddrSelect1 = 0;
		_IRin = 0;
		_PCextendOut = 0;
		_ADROut = 0;
		_BDROut = 0;
		_ALUResult = 0;
		_DataOut = 0;
		_WriteData = 0;
		clk = 1;
		forever #10 clk = !clk;
		// Wait 100 ns for global reset to finish
		#100 $stop;

		// Add stimulus here

	end

endmodule

