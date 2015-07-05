`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:14:14 05/17/2014 
// Design Name: 
// Module Name:    SingleCtrl 
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
module SingleCtrl(
input [5:0] OP,
input [5:0] Func,
output [2:0] ALUop,
output RegDst, 
output ALUsrcA,
output ALUsrcB, 
output ALUsrcBB, 
output MemtoReg, 
output RegWrite,
output MemRead, 
output MemWrite, 
output [1:0]Branch, 
output Jump,
output oJr,
output oJal,
output [31:0]Type
	);
wire R,Lw,Sw,Beq,Bne,Addi,Andi,Ori,J,Sll,Srl,Sra,And,Or,Add,Sub,Addu,Subu,Xor,Nor,Slt,Sltu,Sllv,Srlv,Srav,Addiu,Xori,Lui,Slti,Sltiu,Jr,Jal;
assign R=~OP[5]&~OP[4]&~OP[3]&~OP[2]&~OP[1]&~OP[0];
assign Lw=OP[5]&~OP[4]&~OP[3]&~OP[2]&OP[1]&OP[0];
assign Sw=OP[5]&~OP[4]&OP[3]&~OP[2]&OP[1]&OP[0];
assign Beq=~OP[5]&~OP[4]&~OP[3]&OP[2]&~OP[1]&~OP[0];
assign Bne=~OP[5]&~OP[4]&~OP[3]&OP[2]&~OP[1]&OP[0];
assign Addi=~OP[5]&~OP[4]&OP[3]&~OP[2]&~OP[1]&~OP[0];
assign Andi=~OP[5]&~OP[4]&OP[3]&OP[2]&~OP[1]&~OP[0];
assign Ori=~OP[5]&~OP[4]&OP[3]&OP[2]&~OP[1]&OP[0];
assign J=~OP[5]&~OP[4]&~OP[3]&~OP[2]&OP[1]&~OP[0];
assign Sll=R&~Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&~Func[0]; //000000
assign Srl=R&~Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&~Func[0]; //000010
assign Sra=R&~Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&Func[0]; //000011
//-----------------
assign Addu=R&(Func==6'b100001);
assign Subu=R&(Func==6'b100011);
assign Xor=R&(Func==6'b100110);
assign Nor=R&(Func==6'b100111);
assign Slt=R&(Func==6'b101010);
assign Sltu=R&(Func==6'b101011);
assign Sllv=R&(Func==6'b000100);
assign Srlv=R&(Func==6'b000110);
assign Srav=R&(Func==6'b000111);
assign Addiu=(OP==6'b001001);
assign Xori=(OP==6'b001110);
assign Lui=(OP==6'b001111);
assign Slti=(OP==6'b001010);
assign Sltiu=(OP==6'b001011);
assign Jr=R&(Func==6'b001000);
assign Jal=(OP==6'b000011);
//-------------------
assign Add=R&(Func==6'b100000);
assign Sub=R&(Func==6'b100010);
assign And=R&(Func==6'b100100);
assign Or=R&(Func==6'b100101);
assign RegDst=R; 
assign ALUsrcB=Lw|Sw|Addi|Andi|Ori|Addiu|Xori|Lui|Slti|Sltiu;
assign ALUsrcBB=Andi|Ori|Xori|Sltiu;
assign ALUsrcA=Sll|Srl|Sra;
assign MemtoReg=Lw;
assign RegWrite=R|Lw|Addi|Andi|Ori|Addiu|Xori|Lui|Slti|Sltiu|Jal;
assign MemRead=Lw;
assign MemWrite=Sw;
assign Branch[0]=Beq;
assign Branch[1]=Bne;
assign ALUop[2]=Andi|Ori|Addiu|Xori|Lui|Slti|Sltiu;
assign ALUop[1]=R|Addiu|Xori|Lui|Slti|Sltiu;
assign ALUop[0]=Beq|Ori|Bne|Addiu|Xori|Lui|Slti|Sltiu;
assign Jump=J;
assign oJr=Jr;
assign oJal=Jal;
/*and (RegDst, ~OP[5],~OP[4],~OP[3],~OP[2],~OP[1],~OP[0]);
and (ALUsrc, OP[5],~OP[4], ~OP[2], OP[1], OP[0]);
and (MemtoReg, OP[5],~OP[4],~OP[3],~OP[2], OP[1], OP[0]);
and (RegWrite, ~OP[4],~OP[3],~OP[2] );
and (MemRead, OP[5],~OP[4],~OP[3],~OP[2], OP[1], OP[0]);
and (MemWrite, OP[5],~OP[4], OP[3],~OP[2], OP[1], OP[0]);
and (Branch, ~OP[5],~OP[4],~OP[3], OP[2],~OP[1],~OP[0]);
and (ALUop[1], ~OP[5],~OP[4],~OP[3],~OP[2],~OP[1],~OP[0]);
and (ALUop[0], ~OP[5],~OP[4],~OP[3], OP[2],~OP[1],~OP[0]);
and (Jump, ~OP[5], ~OP[4], ~OP[3], ~OP[2], OP[1], ~OP[0]);*/
assign Type={Addu,Subu,Xor,Nor,Slt,Sltu,Sllv,Srlv,Srav,Addiu,Xori,Lui,Slti,Sltiu,Jr,Jal,Lw,Sw,Beq,Bne,Addi,Andi,Ori,J,Sll,Srl,Sra,And,Or,Add,Sub};
endmodule
