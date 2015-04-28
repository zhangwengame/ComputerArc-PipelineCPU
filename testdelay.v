`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:08:06 05/21/2014
// Design Name:   delay
// Module Name:   D:/3130000064/SingleClk/testdelay.v
// Project Name:  SingleClk
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: delay
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testdelay;

	// Inputs
	reg PCclk;
	reg clk;

	// Outputs
	wire [9:0] PCclk_;
	wire [5:0] single_count;

	// Instantiate the Unit Under Test (UUT)
	delay uut (
		.PCclk(PCclk), 
		.clk(clk), 
		.PCclk_(PCclk_), 
		.single_count(single_count)
	);

	initial begin
		// Initialize Inputs
		PCclk = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		#10;
		
		PCclk=1;
		#10;
		PCclk=0;
		#400;
		
		PCclk=1;
		#10;
		PCclk=0;
		#400;

	end
	
	always begin
		clk=~clk;
		#1;
	end
      
endmodule

