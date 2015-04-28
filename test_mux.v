`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:33:25 05/17/2014
// Design Name:   MUX4x1
// Module Name:   D:/Xilinx/SingleClk/test_mux.v
// Project Name:  SingleClk
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MUX4x1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_mux;

	// Inputs
	reg [1:0] oper;
	reg [31:0] x0;
	reg [31:0] x1;
	reg [31:0] x2;
	reg [31:0] x3;

	// Outputs
	wire [31:0] Result;

	// Instantiate the Unit Under Test (UUT)
	MUX4x1 uut (
		.Result(Result), 
		.oper(oper), 
		.x0(x0), 
		.x1(x1), 
		.x2(x2), 
		.x3(x3)
	);

	initial begin
		// Initialize Inputs
		oper = 0;
		x0 = 4;
		x1 = 5;
		x2 = 6;
		x3 = 7;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		oper = 1;
		#10;
		oper = 3;
		#10;
		oper = 2;

	end
      
endmodule

