`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:30:25 04/14/2015
// Design Name:   genpulse
// Module Name:   G:/Prom/ISE/Pipeline_CPU/testforpulse.v
// Project Name:  SingleCycl_LCD
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: genpulse
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testforpulse;

	// Inputs
	reg clk;
	reg [4:0] observ;

	// Outputs
	wire pulse;

	// Instantiate the Unit Under Test (UUT)
	genpulse uut (
		.clk(clk), 
		.observ(observ), 
		.pulse(pulse)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		observ = 0;

		// Wait 100 ns for global reset to finish
		#10;
      observ=1;
		#50;
		observ=7;
		#50;
		observ=11;
		// Add stimulus here

	end
   always 
	begin
	clk=0;
	#1;
	clk=1;
	#1;
	end
endmodule

