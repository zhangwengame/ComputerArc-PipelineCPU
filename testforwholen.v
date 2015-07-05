`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:14:54 06/16/2015
// Design Name:   top
// Module Name:   G:/Prom/ISE/Pipeline_CPU/testforwholen.v
// Project Name:  SingleCycl_LCD
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

module testforwholen;

	// Inputs
	reg CCLK;
	reg BTN1;
	reg BTN2;
	reg BTN3;
	reg [3:0] SW;

	// Outputs
	wire LCDRS;
	wire LCDRW;
	wire LCDE;
	wire [3:0] LCDDAT;
	wire [7:0] LED;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.CCLK(CCLK), 
		.BTN1(BTN1), 
		.BTN2(BTN2), 
		.BTN3(BTN3), 
		.SW(SW), 
		.LCDRS(LCDRS), 
		.LCDRW(LCDRW), 
		.LCDE(LCDE), 
		.LCDDAT(LCDDAT), 
		.LED(LED)
	);

	initial begin
		// Initialize Inputs
		CCLK = 0;
		BTN2 = 0;
		BTN1 = 0;
		SW = 4'b1011;
		
		
		// Wait 100 ns for global reset to finish
		#100;
		SW = 4'b0001; //addi  $s0, $zero, 5
		BTN1=0;
      BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1; 
		#10;
		BTN2=0;
		#100; 
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;		
		SW = 4'b0010; 
		BTN1=0;
		BTN2=1; //ori   $s1, $s1, 3
		#10;
		BTN2=0;
		#100; 
		SW = 4'b0011; 
		BTN1=0;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		SW = 4'b0100; 
		BTN1=0;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		SW = 4'b0101; 
		BTN1=0;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		SW = 4'b0110; 
		BTN1=0;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		SW = 4'b0011;
		BTN1=1;
		BTN2=1;//sub   $s3, $s0, $s1
		#10;
		BTN2=0;
		#100;
		SW = 4'b0100;
		BTN1=1;
		BTN2=1;//and   $s4, $s0, $s1 
		#10;
		BTN2=0;
		#100;
		SW = 4'b0101;
		BTN1=1;
		BTN2=1;//or    $s5, $s0, $s1 
		#10;
		BTN2=0;
		#100;
		SW = 4'b0000;
		BTN1=1;
		BTN2=1;//srl   $s0, $s0, 2 
		#10;
		BTN2=0;
		#100;
		SW = 4'b0000;
		BTN1=1;
		BTN2=1;//sll   $s0, $s0, 31 
		#10;
		BTN2=0;
		#100;
		SW = 4'b0000;
		BTN1=1;
		BTN2=1;//sra   $s0, $s0, 31 
		#10;
		BTN2=0;
		#100;
		SW = 4'b0010;
		BTN1=1;
		BTN2=1;//sw    $s2, 0($zero)
		#10;
		BTN2=0;
		#100;
		SW = 4'b0011;
		BTN1=1;
		BTN2=1;//lw    $s3, 0($zero)
		#10;
		BTN2=0;
		#100;
		SW = 4'b0010;
		BTN1=1;
		BTN2=1;//subi  $s2, $s2, 1  
		#10;
		BTN2=0;
		#100;
		SW = 4'b0010;
		BTN1=1;
		BTN2=1;//jump:beq   $s2, $s3, 2 
		#10;
		BTN2=0;
		#100;
		SW = 4'b0010;
		BTN1=1;
		BTN2=1;//addi  $s2, $s2, 1
		#10;
		BTN2=0;
		#100;
		SW = 4'b0010;
		BTN1=1;
		BTN2=1;//j     jump
		#10;
		BTN2=0;
		#100;
		SW = 4'b0010;
		BTN1=1;
		BTN2=1;//bne   $s2, $s3, 2 
		#10;
		BTN2=0;
		#100;
		SW = 4'b0010;
		BTN1=1;
		BTN2=1;//subi  $s2, $s3, 1 
		#10;
		BTN2=0;
		#100;
		SW = 4'b0010;
		BTN1=1;
		BTN2=1;//addi  $s2, $s2, 1 
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
	
	end
         always 
	begin
	#1;
	CCLK=0;
	#1;
	CCLK=1;
	end
      
endmodule

