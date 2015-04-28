`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:12:59 05/17/2014 
// Design Name: 
// Module Name:    Adder32 
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
module Adder32(A, B, Cin, m, S, CF, OF);
input[31:0] A, B;
input Cin, m;
output [31:0] S;
output CF, OF;

wire t1, t2, t3, t4, t5, t6, t7;
Adder4 ad1(A[ 3: 0], B[ 3: 0], Cin, m, S[ 3: 0], t1, w1);
Adder4 ad2(A[ 7: 4], B[ 7: 4], t1, m, S[ 7: 4], t2, w2);
Adder4 ad3(A[11: 8], B[11: 8], t2, m, S[11: 8], t3, w3);
Adder4 ad4(A[15:12], B[15:12], t3, m, S[15:12], t4, w4);
Adder4 ad5(A[19:16], B[19:16], t4, m, S[19:16], t5, w5);
Adder4 ad6(A[23:20], B[23:20], t5, m, S[23:20], t6, w6);
Adder4 ad7(A[27:24], B[27:24], t6, m, S[27:24], t7, w7);
Adder4 ad8(A[31:28], B[31:28], t7, m, S[31:28], CF, OF);
endmodule
