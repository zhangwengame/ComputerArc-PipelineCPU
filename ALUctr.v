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
module ALUctr(ALUop, OP, Func, ALUoper);
input [2:0] ALUop;
input [5:0] OP;
input [5:0] Func;
output [4:0] ALUoper;
wire Addiu,Xori,Lui,Slti,Sltiu;

assign Addiu=(OP==6'b001001);
assign Xori=(OP==6'b001110);
assign Lui=(OP==6'b001111);
assign Slti=(OP==6'b001010);
assign Sltiu=(OP==6'b001011);

assign ALUoper[4]=Addiu|Xori|Lui|Slti|Sltiu;

assign ALUoper[3]=(~ALUop[2]&ALUop[1]&&(Func==6'b100001))//addu
|(~ALUop[2]&ALUop[1]&&(Func==6'b100011))//subu
|(~ALUop[2]&ALUop[1]&&(Func==6'b100110)) //xor
|(~ALUop[2]&ALUop[1]&&(Func==6'b101011)) //sltu
|(~ALUop[2]&ALUop[1]&&(Func==6'b000100)) //sllv
|(~ALUop[2]&ALUop[1]&&(Func==6'b000110)) //srlv
|(~ALUop[2]&ALUop[1]&&(Func==6'b100111))//nor
|(~ALUop[2]&ALUop[1]&&(Func==6'b000111));//srav

assign ALUoper[2]=(~ALUop[2]&~ALUop[1]&ALUop[0])
|(~ALUop[2]&ALUop[1]&Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&~Func[0])
|(~ALUop[2]&ALUop[1]&Func[5]&~Func[4]&Func[3]&~Func[2]&Func[1]&~Func[0])
|(~ALUop[2]&ALUop[1]&~Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&~Func[0]) //srl
|(~ALUop[2]&ALUop[1]&~Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&Func[0]) //sra
|(~ALUop[2]&ALUop[1]&&(Func==6'b100011))//subu
|(~ALUop[2]&ALUop[1]&&(Func==6'b101010)) //slt
|(~ALUop[2]&ALUop[1]&&(Func==6'b000100)) //sllv
|(~ALUop[2]&ALUop[1]&&(Func==6'b000110)) //srlv
|(~ALUop[2]&ALUop[1]&&(Func==6'b000111))//srav
|Sltiu;
assign ALUoper[1]=(~ALUop[2]&~ALUop[1]&~ALUop[0])|(~ALUop[2]&~ALUop[1]&ALUop[0])
|(~ALUop[2]&ALUop[1]&Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&~Func[0])
|(~ALUop[2]&ALUop[1]&Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&~Func[0])
|(~ALUop[2]&ALUop[1]&Func[5]&~Func[4]&Func[3]&~Func[2]&Func[1]&~Func[0])
|(~ALUop[2]&ALUop[1]&~Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&~Func[0]) //sll
|(~ALUop[2]&ALUop[1]&&(Func==6'b100001))//addu
|(~ALUop[2]&ALUop[1]&&(Func==6'b100011))//subu
|(~ALUop[2]&ALUop[1]&&(Func==6'b101010)) //slt
|(~ALUop[2]&ALUop[1]&&(Func==6'b101011)) //sltu
|(~ALUop[2]&ALUop[1]&&(Func==6'b000111)) //srav
|Lui|Slti;
assign ALUoper[0]=(~ALUop[2]&ALUop[1]&Func[5]&~Func[4]&~Func[3]&Func[2]&~Func[1]&Func[0])
|(~ALUop[2]&ALUop[1]&Func[5]&~Func[4]&Func[3]&~Func[2]&Func[1]&~Func[0])
|(ALUop[2]&~ALUop[1]&ALUop[0])
|(~ALUop[2]&ALUop[1]&~Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&~Func[0]) //sll
|(~ALUop[2]&ALUop[1]&~Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&Func[0])  //sra
|(~ALUop[2]&ALUop[1]&&(Func==6'b100110)) //xor
|(~ALUop[2]&ALUop[1]&&(Func==6'b101010)) //slt
|(~ALUop[2]&ALUop[1]&&(Func==6'b101011)) //sltu
|(~ALUop[2]&ALUop[1]&&(Func==6'b000110)) //srlv
|(~ALUop[2]&ALUop[1]&&(Func==6'b000111))//srav
|Xori|Slti;
endmodule
/*
ALUop 	Function field 	ALU
op2 op1 op0 F5 	F4 	F3 	F2 	F1 	F0 	Operation 	Function
0  0  0  x 	x  x  x  x 	x  00010  Add
0  0  1  x 	x  x  x  x 	x  00110  Sub
1  0  0  x 	x  x  x  x 	x  00000  And
1  0  1  x 	x  x  x  x 	x  00001  Or
0  1  x  1 	0  0  0  0 	0  00010  Add
0  1  x  1 	0  0  0  1 	0  00110  Sub
0  1  x  1 	0  0  1  0 	0  00000  And
0  1  x  1 	0  0  1  0 	1  00001  Or
0  1  x  x 	x  1  0  1 	0  00111  SLT
0  1  x  0  0  0  0  0  0  00011  Sll
0  1  x  0  0  0  0  1  0  00100  Srl
0  1  x  0  0  0  0  1  1  00101  Sra  
0  1  x  1 	0  0  0  0 	1  01010  Add
0  1  x  1 	0  0  0  1 	1  01110  Sub
0  1  x  1 	0  0  1  1 	0  01001  Xor
0  1  x  1 	0  0  1  1 	1  01000  Nor
0  1  x  1 	0  1  0  1 	0  00111  Slt
0  1  x  1 	0  1  0  1 	1  01011  Sltu
0  1  x  0 	0  0  1  0 	0  01100  Sllv
0  1  x  0 	0  0  1  1 	0  01101  Srlu
0  1  x  0 	0  0  1  1 	1  01111  Srav
 

00000 And
00001 Or
00010 Add
00011 Sll
00100 Srl
00101 Sra
00110 Sub
00111 SLT
01000 Nor
01001 Xor
01010 Addu
01011 Sltu
01100 Sllv
01101 Srlv
01110 Subu
01111 Srav
10000 Addiu
10001 Xori
10010 Lui
10011 Slti
10100 Sltiu

*/
