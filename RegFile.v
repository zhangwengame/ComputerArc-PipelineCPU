	`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:59:00 05/17/2014 
// Design Name: 
// Module Name:    RegFile 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RegFile(PCclk, PCclk_, regA, regB, regW, Wdat, Adat, Bdat, RegWrite, regX, Xdat);
input PCclk;
input [9:0] PCclk_;
input [4:0] regA, regB, regW, regX;
input [31:0] Wdat;
input RegWrite;
output [31:0] Adat, Bdat, Xdat;

reg [31:0] iRegf[31:0];

reg [31:0] Adat;
reg [31:0] Bdat;

assign Xdat = iRegf[regX];

integer i;
initial begin
	for(i=0; i<32; i=i+1)begin
		iRegf[i] <= 0;
	end
end

always @(posedge PCclk_[3]) begin
	if(RegWrite) begin
		iRegf[regW] <= (regW == 5'b00000) ? 32'h0 : Wdat;
	end
end

always @(posedge PCclk_[2]) begin
	Adat <= iRegf[regA];
	Bdat <= iRegf[regB];
end

endmodule
