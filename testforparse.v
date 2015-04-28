`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:17:10 03/24/2015
// Design Name:   Parse32
// Module Name:   G:/Prom/ISE/SingleCycl_LCD/testforparse.v
// Project Name:  SingleCycl_LCD
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Parse32
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testforparse;

	// Inputs
	reg clk;
	reg [31:0] data;

	// Outputs
	wire [63:0] odata;

	// Instantiate the Unit Under Test (UUT)
	Parse32 uut (
		.clk(clk), 
		.data(data), 
		.odata(odata)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		data = 0;
		data=32'b00010010001101000101011001111000;	
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
   always 
	begin
	#1;
	clk=0;
	#1;
	clk=1;
	end   
endmodule

