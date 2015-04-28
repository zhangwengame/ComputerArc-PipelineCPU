`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:36:09 05/17/2014
// Design Name:   RegFile
// Module Name:   D:/3130000064/SingleClk/regfilerest.v
// Project Name:  SingleClk
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegFile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module regfilerest;

	// Inputs
	reg PCclk;
	reg [4:0] regA;
	reg [4:0] regB;
	reg [4:0] regW;
	reg [31:0] Wdat;
	reg RegWrite;
	reg [4:0] regX;

	// Outputs
	wire [31:0] Adat;
	wire [31:0] Bdat;
	wire [31:0] Xdat;

	// Instantiate the Unit Under Test (UUT)
	RegFile uut (
		.PCclk(PCclk), 
		.regA(regA), 
		.regB(regB), 
		.regW(regW), 
		.Wdat(Wdat), 
		.Adat(Adat), 
		.Bdat(Bdat), 
		.RegWrite(RegWrite), 
		.regX(regX), 
		.Xdat(Xdat)
	);

	initial begin
		// Initialize Inputs
		PCclk = 0;
		regA = 0;
		regB = 0;
		regW = 0;
		Wdat = 0;
		RegWrite = 0;
		regX = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		regA = 5'b10000;
		regB = 5'b10001;
		regW = 5'b10010;
		Wdat = 32'hAAAABBBB;
		RegWrite = 1;
		regX = 5'b10000;
		#10;
		PCclk=1;
		#10;
		PCclk=0;
		

	end
      
endmodule

