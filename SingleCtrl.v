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
output MemtoReg, 
output RegWrite,
output MemRead, 
output MemWrite, 
output [1:0]Branch, 
output Jump,
output [15:0]Type
	);
wire R,Lw,Sw,Beq,Bne,Addi,Andi,Ori,J,Sll,Srl,Sra,And,Or,Add,Sub;
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
assign Add=R&(Func==6'b100000);
assign Sub=R&(Func==6'b100010);
assign And=R&(Func==6'b100100);
assign Or=R&(Func==6'b100101);
assign RegDst=R; 
assign ALUsrcB=Lw|Sw|Addi|Andi|Ori;
assign ALUsrcA=Sll|Srl|Sra;
assign MemtoReg=Lw;
assign RegWrite=R|Lw|Addi|Andi|Ori|Sll|Srl|Sra;
assign MemRead=Lw;
assign MemWrite=Sw;
assign Branch[0]=Beq;
assign Branch[1]=Bne;
assign ALUop[2]=Andi|Ori;
assign ALUop[1]=R;
assign ALUop[0]=Beq|Ori|Bne;
assign Jump=J;
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
assign Type={Lw,Sw,Beq,Bne,Addi,Andi,Ori,J,Sll,Srl,Sra,And,Or,Add,Sub};
endmodule
