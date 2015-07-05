`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:23:59 05/12/2015
// Design Name:   Pipedmem
// Module Name:   G:/Prom/ISE/Pipeline_CPU/testforpipemem.v
// Project Name:  SingleCycl_LCD
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Pipedmem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testforpipemem;

	// Inputs
	reg clka;
	reg wea;
	reg [31:0] addra;
	reg [31:0] dina;

	// Outputs
	wire [31:0] douta;

	// Instantiate the Unit Under Test (UUT)
	Pipedmem uut (
		.clka(clka), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta)
	);

	initial begin
		// Initialize Inputs
		clka = 0;
		wea = 0;
		addra = 20;
		dina = 0;

		// Wait 100 ns for global reset to finish
		
        
		// Add stimulus here

	end
        always 
	begin
	#1;
	clka=0;
	#1;
	clka=1;
	end    
endmodule

