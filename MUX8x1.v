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
module MUX32x1(
output [31:0] Result,
input [4:0] oper,
input [31:0] x0,
input [31:0] x1,
input [31:0] x2,
input [31:0] x3,
input [31:0] x4,
input [31:0] x5,
input [31:0] x6,
input [31:0] x7,
input [31:0] x8,
input [31:0] x9,
input [31:0] x10,
input [31:0] x11,
input [31:0] x12,
input [31:0] x13,
input [31:0] x14,
input [31:0] x15,
input [31:0] x16,
input [31:0] x17,
input [31:0] x18,
input [31:0] x19,
input [31:0] x20,
input [31:0] x21,
input [31:0] x22,
input [31:0] x23,
input [31:0] x24,
input [31:0] x25,
input [31:0] x26,
input [31:0] x27,
input [31:0] x28,
input [31:0] x29,
input [31:0] x30,
input [31:0] x31
);
wire [31:0]Re1,Re2,Re3,Re4;
MUX8x1 mx81(Re1,oper[2:0],x0,x1,x2,x3,x4,x5,x6,x7);
MUX8x1 mx82(Re2,oper[2:0],x8,x9,x10,x11,x12,x13,x14,x15);
MUX8x1 mx83(Re3,oper[2:0],x16,x17,x18,x19,x20,x21,x22,x23);
MUX8x1 mx84(Re4,oper[2:0],x24,x25,x26,x27,x28,x29,x31,x31);
assign Result = oper[4]?(oper[3]?Re4:Re3):(oper[3]?Re2:Re1);

endmodule
