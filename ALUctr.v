`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:45:06 05/17/2014 
// Design Name: 
// Module Name:    ALUctr 
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
module ALUctr(ALUop, Func, ALUoper);
input [2:0] ALUop;
input [5:0] Func;
output [2:0] ALUoper;

assign ALUoper[2]=(~ALUop[2]&~ALUop[1]&ALUop[0])
|(~ALUop[2]&ALUop[1]&Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&~Func[0])
|(~ALUop[2]&ALUop[1]&Func[5]&~Func[4]&Func[3]&~Func[2]&Func[1]&~Func[0])
|(~ALUop[2]&ALUop[1]&~Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&~Func[0]) //srl
|(~ALUop[2]&ALUop[1]&~Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&Func[0]); //sra

assign ALUoper[1]=(~ALUop[2]&~ALUop[1]&~ALUop[0])|(~ALUop[2]&~ALUop[1]&ALUop[0])
|(~ALUop[2]&ALUop[1]&Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&~Func[0])
|(~ALUop[2]&ALUop[1]&Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&~Func[0])
|(~ALUop[2]&ALUop[1]&Func[5]&~Func[4]&Func[3]&~Func[2]&Func[1]&~Func[0])
|(~ALUop[2]&ALUop[1]&~Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&~Func[0]); //sll

assign ALUoper[0]=(~ALUop[2]&ALUop[1]&Func[5]&~Func[4]&~Func[3]&Func[2]&~Func[1]&Func[0])
|(~ALUop[2]&ALUop[1]&Func[5]&~Func[4]&Func[3]&~Func[2]&Func[1]&~Func[0])
|(ALUop[2]&~ALUop[1]&ALUop[0])
|(~ALUop[2]&ALUop[1]&~Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&~Func[0]) //sll
|(~ALUop[2]&ALUop[1]&~Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&Func[0]);  //sra
endmodule
/*
ALUop 	Function field 	ALU
op2 op1 op0 F5 	F4 	F3 	F2 	F1 	F0 	Operation 	Function
0  0  0  x 	x  x  x  x 	x  010  Add
0  0  1  x 	x  x  x  x 	x  110  Sub
1  0  0  x 	x  x  x  x 	x  000  And
1  0  1  x 	x  x  x  x 	x  001  Or
0  1  x  1 	0  0  0  0 	0  010  Add
0  1  x  1 	0  0  0  1 	0  110  Sub
0  1  x  1 	0  0  1  0 	0  000  And
0  1  x  1 	0  0  1  0 	1  001  Or
0  1  x  x 	x  1  0  1 	0  111  SLT
0  1  x  0  0  0  0  0  0  011  Sll
0  1  x  0  0  0  0  1  0  100  Srl
0  1  x  0  0  0  0  1  1  101  Sra  
000 And
001 Or
010 Add
011 Sll
100 Srl
101 Sra
110 Sub
111 SLT
*/
