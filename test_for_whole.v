`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:26:57 03/17/2015
// Design Name:   top
// Module Name:   G:/Prom/ISE/SingleClk/test_for_whole.v
// Project Name:  SingleClk
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_whole;

	// Inputs
	reg clk;
	reg [7:0] sw;
	reg [7:0] sww;
	reg [3:0] push;

	// Outputs
	wire [7:0] led;
	wire [3:0] digit_anode;
	wire [7:0] display;
	wire [7:0] anode;
	wire [7:0] segment;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.sw(sw), 
		.sww(sww), 
		.push(push), 
		.led(led), 
		.digit_anode(digit_anode), 
		.display(display), 
		.anode(anode), 
		.segment(segment)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		sw = 0;
		sww = 0;
		push = 0;

		// Wait 100 ns for global reset to finish
		#10;
		push=4'b0100;
		#200;
		push=4'b0000;
		#200;
		push=4'b0100;
		#200;		
        
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

