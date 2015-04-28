`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:10:21 03/17/2015
// Design Name:   InstrMem1
// Module Name:   G:/Prom/ISE/SingleClk/testforins.v
// Project Name:  SingleClk
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: InstrMem1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testforins;

	// Inputs
	reg clka;
	reg [0:0] wea;
	reg [7:0] addra;
	reg [31:0] dina;

	// Outputs
	wire [31:0] douta;

	// Instantiate the Unit Under Test (UUT)
	InstrMem1 uut (
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
		addra = 0;
		dina = 0;

		// Wait 100 ns for global reset to finish
			#100;
      addra=8'b0000;
				#100;
      addra=8'b0001;
				#100;
      addra=8'b0010;
		
		
		// Add stimulus here

	end
    always 
begin
clka=0;
#1;
clka=1;
#1;
end         
endmodule

