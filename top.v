`timescale 1ns / 1ps
`define DEBUG 1
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:11:17 05/17/2014 
// Design Name: 
// Module Name:    top 
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
module top(	input CCLK, BTN1,BTN2, BTN3 ,input [3:0] SW, output LCDRS, LCDRW, LCDE, 
					output [3:0] LCDDAT, output [7:0] LED/*,output [31:0] disp_num,output [31:0]PC,output [31:0]AAdat,output [31:0]BBdat,output [31:0]Result,output [2:0]ALUoper,output JUMP_ID_EX,output BEQ_EX_MEM,output BNE_EX_MEM,output ZERO_EX_MEM*/);
	wire clk_1ms,clk_100ms;
	wire BTN1_OUT,BTN2_OUT,BTN3_OUT;
	reg reset=1;
	wire [3:0] lcdd;
   wire rslcd, rwlcd, elcd;
	//reg [255:0]strdata = "P:111 I:12345678N:111 R:12345678";
	reg [255:0]strdata = "----- I:12345678N:111 R:12345678";
	reg [3:0] temp=0;
	reg [19:0] disp_code;
	reg [4:0] sww;
	reg tmp;
	reg [4:0]type;
	wire [31:0] disp_num;
	wire [63:0] regnum;
	wire [63:0] opnum;
	wire [23:0] pcnum;
	wire [23:0] rnonum;
	wire [7:0] IDTYPE,EXTYPE,MEMTYPE,WBTYPE;
	wire [31:0] Type;
	initial tmp=0;
	assign LCDDAT[3]=lcdd[3];
	assign LCDDAT[2]=lcdd[2];
	assign LCDDAT[1]=lcdd[1];
	assign LCDDAT[0]=lcdd[0];

	assign LCDRS=rslcd;
	assign LCDRW=rwlcd;
	assign LCDE=elcd;

	assign LED[0] = SW[0];
	assign LED[1] = SW[1];
	assign LED[2] = SW[2];
	assign LED[3] = SW[3];
	assign LED[4] = tmp;
	assign LED[5] = temp[1];
	assign LED[6] = temp[2];
	assign LED[7] = temp[3];
	
	display M0 (CCLK, BTN3_OUT|clk_100ms, strdata, rslcd, rwlcd, elcd, lcdd);      
	
	clock M2 (CCLK, 25000, clk_1ms);
	clock M3 (CCLK, 2500000, clk_100ms);
	pbdebounce P3 (clk_1ms, BTN1, BTN1_OUT);
   pbdebounce P1 (clk_1ms, BTN2, BTN2_OUT);
	pbdebounce P2 (clk_1ms, BTN3, BTN3_OUT);
	
	always @(posedge CCLK)
	begin
		case (Type)
			16'b0000000000000001:type<=0;
			16'b0000000000000010:type<=1;
			16'b0000000000000100:type<=2;
			16'b0000000000001000:type<=3;
			16'b0000000000010000:type<=4;
			16'b0000000000100000:type<=5;
			16'b0000000001000000:type<=6;
			16'b0000000010000000:type<=7;
			16'b0000000100000000:type<=8;
			16'b0000001000000000:type<=9;
			16'b0000010000000000:type<=10;
			16'b0000100000000000:type<=11;
			16'b0001000000000000:type<=12;
			16'b0010000000000000:type<=13;
			16'b0100000000000000:type<=14;
			32'b00000000000000001000000000000000:type<=15;
			32'b00000000000000010000000000000000:type<=16;
			32'b00000000000000100000000000000000:type<=17;
			32'b00000000000001000000000000000000:type<=18;
			32'b00000000000010000000000000000000:type<=19;
			32'b00000000000100000000000000000000:type<=20;
			32'b00000000001000000000000000000000:type<=21;
			32'b00000000010000000000000000000000:type<=22;
			32'b00000000100000000000000000000000:type<=23;
			32'b00000001000000000000000000000000:type<=24;
			32'b00000010000000000000000000000000:type<=25;
			32'b00000100000000000000000000000000:type<=26;
			32'b00001000000000000000000000000000:type<=27;
			32'b00010000000000000000000000000000:type<=28;
			32'b00100000000000000000000000000000:type<=29;
			32'b01000000000000000000000000000000:type<=30;			
		//	11'b00000000000:type<=11;
			default:type<=31;
			endcase
	end

	wire [31:0] OP;	
	wire [31:0] PC4;
	wire [31:0] NextPC;
	wire [31:0] ReadData;
	wire [31:0] Result;
	wire [2:0] ALUop;
	wire [1:0] Branch;
	wire RegDst, ALUsrcB, ALUsrcBB,ALUsrcA,MemtoReg, RegWrite, MemRead, MemWrite,  Jump,Jr,Jal;
	wire zero, PCclk;
	wire [4:0] regA, regB, regW;
	wire [31:0] Adat, Bdat, BBdat, AAdat, Wdat;
	wire [4:0] ALUoper;
	wire [9:0] PCclk_;
	wire [5:0] Func;
	wire [31:0] BranchTo;
	
	wire [55:0] tempdata;
	
	reg [31:0] PC;
	initial PC = 0;
	
	reg [31:0] INS_IF_ID;
	reg [31:0] PC4_IF_ID;
	reg BUBBLE_IF_ID;
	
	reg [31:0] A_ID_EX,B_ID_EX,IMM_ID_EX,PC_ID_EX,INS_ID_EX,WDATA_ID_EX;
	reg [4:0] RD_ID_EX,RT_ID_EX;
	reg JUMP_ID_EX,REGDST_ID_EX,MEMTOREG_ID_EX,REGWRITE_ID_EX,MEMREAD_ID_EX,MEMWRITE_ID_EX,BEQ_ID_EX,BNE_ID_EX;
	reg [4:0] ALUOPER_ID_EX;
	reg [4:0] TYPE_ID_EX;
	reg BUBBLE_ID_EX,JAL_ID_EX;
	reg DATAFROMALU_ID_EX,DATAFROMMEM_ID_EX;
	wire ZERO_ID;
	wire [31:0]PC_ID,ZERO_ID_A,ZERO_ID_B;
	
	reg [31:0] PC_EX_MEM,RESULT_EX_MEM,WDATA_EX_MEM;
	reg [4:0] REGWB_EX_MEM;
	reg ZERO_EX_MEM,BNE_EX_MEM,BEQ_EX_MEM,MEMREAD_EX_MEM,MEMWRITE_EX_MEM,MEMTOREG_EX_MEM,REGWRITE_EX_MEM,JAL_EX_MEM;
	reg [4:0] TYPE_EX_MEM;
	reg BUBBLE_EX_MEM;
	wire [4:0] REGWB_EX;
	
	reg [31:0] DATA_MEM_WB,RESULT_MEM_WB,PC_MEM_WB;
	reg [4:0] REGWB_MEM_WB;
	reg MEMTOREG_MEM_WB,REGWRITE_MEM_WB;
	reg [4:0] TYPE_MEM_WB;
	reg BUBBLE_MEM_WB,JAL_MEM_WB;
	
	wire AFROMR_ID,BFROMR_ID,AENABLE_ID,BENABLE_ID,EXFORWARD,MEMFORWARD,AFROMEX_ID,AFROMMEM_ID,BFROMEX_ID,BFROMMEM_ID;
	wire AENABLE_EX,BENABLE_EX;
	wire DSTALL,CSTALL;
	wire SBRANCH,SJUMP;
	assign DSTALL=(AFROMR_ID||BFROMR_ID)&&(~BUBBLE_IF_ID);
	assign CSTALL=(Jump||(Branch[0]&&ZERO_ID==1)||(Branch[1]&&ZERO_ID==0)||Jr||Jal)&&(~BUBBLE_IF_ID);
	//assign Type={Addu,Subu,Xor,Nor,Slt,Sltu,Sllv,Srlv,Srav,Addiu,Xori,Lui,Slti,Sltiu,Jr,Jal,	
	//             Lw,Sw,Beq,Bne,Addi,Andi,Ori,J,Sll,Srl,Sra,And,Or,Add,Sub}	
	assign EXFORWARD=(((TYPE_ID_EX>=17)&&(TYPE_ID_EX<=31))||
							TYPE_ID_EX==10||TYPE_ID_EX==9||TYPE_ID_EX==8||TYPE_ID_EX==6||TYPE_ID_EX==5||TYPE_ID_EX==4||TYPE_ID_EX==3||TYPE_ID_EX==2||TYPE_ID_EX==1||TYPE_ID_EX==0);
	assign MEMFORWARD=(((TYPE_ID_EX>=17)&&(TYPE_ID_EX<=31))||
							  TYPE_EX_MEM==13||TYPE_EX_MEM==10||TYPE_EX_MEM==9||TYPE_EX_MEM==8||TYPE_EX_MEM==6||TYPE_EX_MEM==5||TYPE_EX_MEM==4||TYPE_EX_MEM==3||TYPE_EX_MEM==2||TYPE_EX_MEM==1||TYPE_EX_MEM==0);
														    // 00000000000000000	
	assign AENABLE_ID=(~BUBBLE_IF_ID)&&((Type&32'b01111111111101110111111100001111)>0);
	assign BENABLE_ID=(~BUBBLE_IF_ID)&&((Type&32'b01111111110000000001100001111111)>0);
	assign AENABLE_EX=(~BUBBLE_ID_EX)&&((Type&32'b01111111111101110111111100001111)>0);
	assign BENABLE_EX=(~BUBBLE_ID_EX)&&((Type&32'b01111111110000000011100001111111)>0);
	assign AFROMEX_ID=REGWRITE_ID_EX==1&&REGWB_EX==regA&&~BUBBLE_ID_EX;
	assign AFROMMEM_ID=REGWRITE_EX_MEM==1&&REGWB_EX_MEM==regA&&~BUBBLE_EX_MEM;
	assign BFROMEX_ID=REGWRITE_ID_EX==1&&REGWB_EX==regB&&~BUBBLE_ID_EX;
	assign BFROMMEM_ID=REGWRITE_EX_MEM==1&&REGWB_EX_MEM==regB&&~BUBBLE_EX_MEM;
	assign AFROMR_ID=AENABLE_ID&&(AFROMEX_ID&&~EXFORWARD);
	assign BFROMR_ID=BENABLE_ID&&(BFROMEX_ID&&~EXFORWARD);	
	//assign SBRANCH1
	
	initial
	begin
		JUMP_ID_EX=0; REGDST_ID_EX=0; MEMTOREG_ID_EX=0; REGWRITE_ID_EX=0; MEMREAD_ID_EX=0; MEMWRITE_ID_EX=0;
		BEQ_ID_EX=0; BNE_ID_EX=0; BUBBLE_ID_EX=1; JAL_ID_EX=0;
		ZERO_EX_MEM=0; BNE_EX_MEM=0; BEQ_EX_MEM=0; MEMREAD_EX_MEM=0; MEMWRITE_EX_MEM=0; MEMTOREG_EX_MEM=0; REGWRITE_EX_MEM=0;BUBBLE_EX_MEM=1;JAL_EX_MEM=0;
		MEMTOREG_MEM_WB=0; REGWRITE_MEM_WB=0; BUBBLE_MEM_WB=1;  JAL_MEM_WB=0;
		INS_IF_ID=0; BUBBLE_IF_ID=1; 
		
	  
	end 

	
	Parse32 P32_1(CCLK,disp_num[31:0],regnum[63:0]);
	Parse32 P32_2(CCLK,OP[31:0],opnum[63:0]);
	Parse12 P12_1(CCLK,PC[11:0],pcnum[23:0]);
	Parse12 P12_2(CCLK,{{7{1'b0}},BTN1_OUT,SW[3:0]},rnonum[23:0]);
	Parse5 P5_1(CCLK,type[4:0],IDTYPE[7:0]);
	Parse5 P5_2(CCLK,TYPE_ID_EX[4:0],EXTYPE[7:0]);
	Parse5 P5_3(CCLK,TYPE_EX_MEM[4:0],MEMTYPE[7:0]);
	Parse5 P5_4(CCLK,TYPE_MEM_WB[4:0],WBTYPE[7:0]);
	always @(posedge CCLK) strdata[255:248]<=BUBBLE_IF_ID?"X":IDTYPE;
	always @(posedge CCLK) strdata[247:240]<=BUBBLE_ID_EX?"X":EXTYPE;
	always @(posedge CCLK) strdata[239:232]<=BUBBLE_EX_MEM?"X":MEMTYPE;
	always @(posedge CCLK) strdata[231:224]<=BUBBLE_MEM_WB?"X":WBTYPE;
	always @(posedge CCLK) strdata[111:88]<=rnonum[23:0];
	always @(posedge CCLK) strdata[63:0]<=regnum[63:0];
	always @(posedge CCLK) strdata[191:128]<=opnum[63:0];
	
	assign REGWB_EX=JAL_ID_EX?31:(REGDST_ID_EX?RD_ID_EX:RT_ID_EX);
	
	always @(posedge PCclk)
	begin
		PC<=DSTALL?PC:
			 (Branch[0]==1&&~BUBBLE_IF_ID?(ZERO_ID==1?PC_ID:PC4):
			  (Branch[1]==1&&~BUBBLE_IF_ID?(ZERO_ID==0?PC_ID:PC4):
				((Jump||Jal)&&~BUBBLE_IF_ID?{PC4_IF_ID[31:28],INS_IF_ID[25:0],2'b00}:
				 (
					Jr&&~BUBBLE_IF_ID?
					(AFROMEX_ID&&AENABLE_ID?(JAL_ID_EX?PC_ID_EX:Result):(AFROMMEM_ID&&AENABLE_ID?(JAL_EX_MEM?PC_EX_MEM:((TYPE_EX_MEM==14)?ReadData:RESULT_EX_MEM)):AAdat))<<2
					:PC4
				 )					
				)
			  )
			 );
		PC4_IF_ID<=DSTALL?PC:PC4;
		INS_IF_ID<=DSTALL?INS_IF_ID:OP;
		BUBBLE_IF_ID<=CSTALL&(~DSTALL);
		
		A_ID_EX<=AFROMEX_ID&&AENABLE_ID?(JAL_ID_EX?PC_ID_EX:Result):(AFROMMEM_ID&&AENABLE_ID?(JAL_EX_MEM?PC_EX_MEM:((TYPE_EX_MEM==14)?ReadData:RESULT_EX_MEM)):AAdat);
		B_ID_EX<=BFROMEX_ID&&BENABLE_ID?(JAL_ID_EX?PC_ID_EX:Result):(BFROMMEM_ID&&BENABLE_ID?(JAL_EX_MEM?PC_EX_MEM:((TYPE_EX_MEM==14)?ReadData:RESULT_EX_MEM)):BBdat);	
		WDATA_ID_EX<=Bdat;
		IMM_ID_EX<={{16{INS_IF_ID[15]}},INS_IF_ID[15:0]};
		INS_ID_EX<=INS_IF_ID;
		PC_ID_EX<=PC4_IF_ID;
		RD_ID_EX<=INS_IF_ID[15:11];
		RT_ID_EX<=INS_IF_ID[20:16];
		REGDST_ID_EX<=RegDst;
		ALUOPER_ID_EX<=ALUoper;
		MEMTOREG_ID_EX<=MemtoReg;
		REGWRITE_ID_EX<=RegWrite&(((~DSTALL)&(~CSTALL))||Jal)&(~BUBBLE_IF_ID);
		MEMREAD_ID_EX<=MemRead&(((~DSTALL)&(~CSTALL))||Jal)&(~BUBBLE_IF_ID);
		MEMWRITE_ID_EX<=MemWrite&(((~DSTALL)&(~CSTALL))||Jal)&(~BUBBLE_IF_ID);
		JUMP_ID_EX<=Jump;
		BEQ_ID_EX<=Branch[0];
		BNE_ID_EX<=Branch[1];
		TYPE_ID_EX<=type;
		BUBBLE_ID_EX<=DSTALL|BUBBLE_IF_ID;
		DATAFROMALU_ID_EX<=BFROMEX_ID&&(type==13)&&EXFORWARD;
		DATAFROMMEM_ID_EX<=BFROMEX_ID&&(type==13)&&(TYPE_ID_EX==14);
		JAL_ID_EX<=Jal;
		
		WDATA_EX_MEM<=DATAFROMALU_ID_EX?RESULT_EX_MEM:(DATAFROMMEM_ID_EX?ReadData:WDATA_ID_EX);
		RESULT_EX_MEM<=Result;
		ZERO_EX_MEM<=zero;
		PC_EX_MEM<=PC_ID_EX;
	//S	B_EX_MEM<=B_ID_EX;
		REGWB_EX_MEM<=REGWB_EX;
		MEMTOREG_EX_MEM<=MEMTOREG_ID_EX;
		REGWRITE_EX_MEM<=REGWRITE_ID_EX;
		MEMREAD_EX_MEM<=MEMREAD_ID_EX;
		MEMWRITE_EX_MEM<=MEMWRITE_ID_EX;
		BEQ_EX_MEM<=BEQ_ID_EX;
		BNE_EX_MEM<=BNE_ID_EX;
		TYPE_EX_MEM<=TYPE_ID_EX;
		BUBBLE_EX_MEM<=BUBBLE_ID_EX;
		JAL_EX_MEM<=JAL_ID_EX;
		
		PC_MEM_WB<=PC_EX_MEM;
		DATA_MEM_WB<=ReadData;
		RESULT_MEM_WB<=RESULT_EX_MEM;
		REGWB_MEM_WB<=REGWB_EX_MEM;
		MEMTOREG_MEM_WB<=MEMTOREG_EX_MEM;
		REGWRITE_MEM_WB<=REGWRITE_EX_MEM;
		TYPE_MEM_WB<=TYPE_EX_MEM;
		BUBBLE_MEM_WB<=BUBBLE_EX_MEM;
		JAL_MEM_WB<=JAL_EX_MEM;
	end
	
	assign PCclk = BTN2_OUT;//BTN2_OUT;	
	assign PC4 = PC + 4;
	assign regA = INS_IF_ID[25:21];
	assign regB = INS_IF_ID[20:16];
	assign regW = REGWB_MEM_WB;
	assign Wdat = JAL_MEM_WB?PC_MEM_WB:(MEMTOREG_MEM_WB?DATA_MEM_WB:RESULT_MEM_WB);
	assign BBdat = ALUsrcB?(ALUsrcBB?{{16{1'b0}},INS_IF_ID[15:0]}:{{16{INS_IF_ID[15]}},INS_IF_ID[15:0]}):Bdat;
	assign AAdat = ALUsrcA?{{27{1'b0}},INS_IF_ID[10:6]}:Adat;
	
	assign ZERO_ID_A = AFROMEX_ID&&AENABLE_ID?(JAL_ID_EX?PC_ID_EX:Result):(AFROMMEM_ID&&AENABLE_ID?(JAL_EX_MEM?PC_EX_MEM:((TYPE_EX_MEM==14)?ReadData:RESULT_EX_MEM)):AAdat);
	assign ZERO_ID_B = BFROMEX_ID&&BENABLE_ID?(JAL_ID_EX?PC_ID_EX:Result):(BFROMMEM_ID&&BENABLE_ID?(JAL_EX_MEM?PC_EX_MEM:((TYPE_EX_MEM==14)?ReadData:RESULT_EX_MEM)):BBdat);	
	assign ZERO_ID = ZERO_ID_A==ZERO_ID_B;
	
	assign PC_ID = PC4_IF_ID+{{14{INS_IF_ID[15]}},INS_IF_ID[15:0],{2{1'b0}}};
	
	SingleCtrl m5(INS_IF_ID[31:26], INS_IF_ID[5:0],ALUop, RegDst, ALUsrcA, ALUsrcB, ALUsrcBB, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump,Jr,Jal,Type);
	ALUctr m8(ALUop, INS_IF_ID[31:26],INS_IF_ID[5:0], ALUoper);
	
	RegFile m6(PCclk, PCclk_, regA, regB, regW, Wdat, Adat, Bdat, REGWRITE_MEM_WB, {BTN1_OUT,SW[3:0]}, disp_num);	
	ALU m7 (A_ID_EX,B_ID_EX,ALUOPER_ID_EX,Result,zero,,);		
	InstrMem m9(.clka(CCLK),.addra(PC[9:2]),.douta(OP));
	//DataMems m11(PCclk_[4], RESULT_EX_MEM[7:0],WDATA_EX_MEM, MEMREAD_EX_MEM, MEMWRITE_EX_MEM, ReadData,tempdata);
	//Pipedmem m13(PCclk_[4],MEMWRITE_EX_MEM,RESULT_EX_MEM[31:0],WDATA_EX_MEM,ReadData);
	BlockMem m14(CCLK,MEMWRITE_EX_MEM,RESULT_EX_MEM[7:2],WDATA_EX_MEM,ReadData);
	delay m12(PCclk,CCLK,PCclk_,);
	
endmodule

/*	always@(posedge CCLK)begin
	case(SW[3:0])
		0:disp_code={Bdat[9:0],2'b00,Result[7:0]};
		1:disp_code={1'b0,Result[15:12],1'b0,Result[11:8],1'b0,Result[7:4],1'b0,Result[3:0]};
		2:disp_code={1'b0,1'b0,ALUoper[2:0],regW[4:0],1'b0,ReadData[7:4],1'b0,ReadData[3:0]};
		3:disp_code={1'b0,Wdat[15:12],1'b0,Wdat[11:8],1'b0,Wdat[7:4],1'b0,Wdat[3:0]};
		4:disp_code={1'b0,ReadData[15:12],1'b0,ReadData[11:8],1'b0,ReadData[7:4],1'b0,ReadData[3:0]};
		5:disp_code=tempdata[19:0];
		6:disp_code=tempdata[39:20];
		7:disp_code={4'd0,tempdata[55:40]};
		8:disp_code={1'b0,PC[15:12],1'b0,PC[11:8],1'b0,PC[7:4],1'b0,PC[3:0]};
		9:disp_code={1'b0,NextPC[15:12],1'b0,NextPC[11:8],1'b0,NextPC[7:4],1'b0,NextPC[3:0]};
		10:disp_code={4'b0,zero,4'b0,Branch,1'b0,BranchTo[7:4],1'b0,BranchTo[3:0]};
	endcase
	end*/
	/*always @(posedge BTN3_OUT)
	begin
		temp = temp +1;
		case(temp) 
			4'b0000:strdata[7:0] <= "0";
			4'b0001:strdata[7:0] <= "1";
			4'b0010:strdata[7:0] <= "2";
			4'b0011:strdata[7:0] <= "3";
			4'b0100:strdata[7:0] <= "4";
			4'b0101:strdata[7:0] <= "5";
			4'b0110:strdata[7:0] <= "6";
			4'b0111:strdata[7:0] <= "7";
			4'b1000:strdata[7:0] <= "8";
			4'b1001:strdata[7:0] <= "9";
			4'b1010:strdata[7:0] <= "A";
			4'b1011:strdata[7:0] <= "B";
			4'b1100:strdata[7:0] <= "C";
			4'b1101:strdata[7:0] <= "D";
			4'b1110:strdata[7:0] <= "E";
			4'b1111:strdata[7:0] <= "F";
			default:strdata[7:0] <= "0";
			endcase
	end*/
//	counter_26bit m1(clk, reset, clk_1ms, count_out);
//	key_switch m2(clk_1ms, count_out, push, sw, push_out, sw_out); 	
//	display m3(clk, count_out, disp_code, blinking, digit_anode, display);
//	display_x m4(clk,disp_num,anode,segment);
	