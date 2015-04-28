`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:55:00 03/23/2015
// Design Name:   ALU
// Module Name:   G:/Prom/ISE/SingleCycl_LCD/testforalu.v
// Project Name:  SingleCycl_LCD
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testforalu;

	// Inputs
	reg [31:0] Adat;
	reg [31:0] Bdat;
	reg [2:0] ALUoper;

	// Outputs
	wire [31:0] Result;
	wire zero;
	wire carryout;
	wire overflow;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.Adat(Adat), 
		.Bdat(Bdat), 
		.ALUoper(ALUoper), 
		.Result(Result), 
		.zero(zero), 
		.carryout(carryout), 
		.overflow(overflow)
	);

	initial begin
		// Initialize Inputs
		Adat = 32'b11111111111111111111111111011011;
		Bdat = 32'b11111111111111111111111111011011;
		ALUoper = 3'b110;

		// Wait 100 ns for global reset to finish
		#100;

		// Add stimulus here

	end
      
endmodule

