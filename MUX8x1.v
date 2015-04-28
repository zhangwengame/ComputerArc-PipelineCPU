`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:56:41 03/23/2015 
// Design Name: 
// Module Name:    MUX8x1 
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
module MUX8x1(
output [31:0] Result,
input [2:0] oper,
input [31:0] x0,
input [31:0] x1,
input [31:0] x2,
input [31:0] x3,
input [31:0] x4,
input [31:0] x5,
input [31:0] x6,
input [31:0] x7
);

assign Result = oper[2]?(oper[1]?(oper[0]?x7:x6):(oper[0]?x5:x4)):(oper[1]?(oper[0]?x3:x2):(oper[0]?x1:x0));

endmodule