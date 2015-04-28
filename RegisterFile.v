`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:49 05/17/2014 
// Design Name: 
// Module Name:    RegisterFile 
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
module RegisterFile(
input [4:0] R1,
input [4:0] R2,
input [4:0] WR,
input [31:0] Wdata,
input RegWrite,
output [31:0] Rdata1,
output [31:0] Rdata2,

output [1023:0] regs

);

reg [1023:0] regs;

reg [31:0] Rdata1;
reg [31:0] Rdata2;
always@(posedge clk)begin
	Rdata1 <= regs[{R1,5'b11111}:{R1,5'b00000}]; 
	Rdata2 <= regs[{R2,5'b11111}:{R2,5'b00000}];
end

always@(posedge clk)begin
	if(RegWrite)
		regs[{WR,5'b11111}:{WR,5'b00000}] = Wdata;
end

endmodule



