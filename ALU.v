`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:12:14 05/17/2014 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
input [31:0] Adat,
input [31:0] Bdat,
input [4:0] ALUoper,
output [31:0] Result,
output zero,
output carryout,
output overflow
);
wire slt, sltu,caryt, overf;
wire[31:0] andt, orxt, addsub,sll,srl,sra,add,sub,sllv,srlv,srav,xorr,norr,lui; 
wire signed[31:0] signedBdat;
wire signed[31:0] signedAdat;
assign signedBdat=Bdat;
assign signedAdat=Adat;
assign andt = Adat&Bdat;//And
assign orxt = Adat|Bdat;//Or
assign sll  = Bdat<<Adat;
assign sllv  = Bdat<<Adat;
assign srl  = Bdat>>Adat;
assign srlv  = Bdat>>Adat;
assign sra  = signedBdat>>>Adat;
assign srav  = signedBdat>>>Adat;
assign add  = Adat+Bdat;
assign sub  = Adat-Bdat;
assign slt  = signedAdat<signedBdat;
assign sltu = Adat<Bdat;
assign xorr = (Adat^Bdat);
assign norr = ~(Adat|Bdat);
assign lui= Bdat<<16;
Adder32 a32a(Adat, Bdat, ALUoper[2], ALUoper[2], addsub, caryt, overf); //Add/Sub
xor(cyt, caryt, ALUoper[2]); //SUB
//xor(slt, overf, addsub[31]); //SLT
MUX32x1 mx32(Result, {ALUoper[4],ALUoper[3],ALUoper[2],ALUoper[1],ALUoper[0]}, 
				 andt, orxt, addsub, sll, srl, sra, addsub, {31'h0,slt},
				 norr/*9*/,xorr/*10*/,add/*11*/,{31'h0,sltu}/*12*/,sllv/*13*/,srlv/*14*/,sub/*15*/,srav/*16*/,add/*17*/,xorr/*18*/,
				 lui/*19*/,{31'h0,slt}/*20*/,{31'h0,sltu}/*21*/,/*22*/,/*23*/,/*24*/,/*26*/,/*27*/,/*28*/,/*29*/,
				 /*30*/,/*31*/,/*32*/);

and(carryout,~ALUoper[3],~ALUoper[2],~ALUoper[1], ~ALUoper[0], cyt); //carryout
assign overflow=overf&((ALUoper==5'b00000)||(ALUoper==5'b00110));
nor(zero, Result[0], Result[ 1], Result[ 2], Result[ 3],
Result[ 4], Result[ 5], Result[ 6], Result[ 7],
Result[ 8], Result[ 9], Result[10], Result[11],
Result[12], Result[13], Result[14], Result[15],
Result[16], Result[17], Result[18], Result[19],
Result[20], Result[21], Result[22], Result[23],
Result[24], Result[25], Result[26], Result[27],
Result[28], Result[29], Result[30], Result[31]);
endmodule
/*
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