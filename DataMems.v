`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:36:04 05/17/2014 
// Design Name: 
// Module Name:    DataMems 
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
module DataMems(
input clk,
input [7:0] Address,
input [31:0] WriteData,
input MemRead,
input MemWrite,
output [31:0] ReadData,
output [55:0] tempdata
);

	wire [5:0] addr0, addr1, addr2, addr3, Addr, NextAddr;
	wire [7:0] din0,din1,din2,din3;
	wire [7:0] dout0,dout1,dout2,dout3;
	assign tempdata = {addr0,addr1,Addr,NextAddr,din0,din1,dout0,dout1};
	assign Addr = Address[7:2];
	assign NextAddr = Address[7:2] + 1;
	assign addr0 = Address[1]?(Address[0]?
						(NextAddr)/*11*/:
						(NextAddr)/*10*/):(Address[0]?
						(NextAddr)/*01*/:
						(Addr)/*00*/);
	assign addr1 = Address[1]?(Address[0]?
						(NextAddr)/*11*/:
						(NextAddr)/*10*/):(Address[0]?
						(Addr)/*01*/:
						(Addr)/*00*/);
	assign addr2 = Address[1]?(Address[0]?
						(NextAddr)/*11*/:
						(Addr)/*10*/):(Address[0]?
						(Addr)/*01*/:
						(Addr)/*00*/);
	assign addr3 = Address[1]?(Address[0]?
						(Addr)/*11*/:
						(Addr)/*10*/):(Address[0]?
						(Addr)/*01*/:
						(Addr)/*00*/);

	assign din0 = Address[1]?(Address[0]?
						(WriteData[23:16])/*11*/:
						(WriteData[15:8])/*10*/):(Address[0]?
						(WriteData[7:0])/*01*/:
						(WriteData[31:24])/*00*/);
	assign din1 = Address[1]?(Address[0]?
						(WriteData[15:8])/*11*/:
						(WriteData[7:0])/*10*/):(Address[0]?
						(WriteData[31:24])/*01*/:
						(WriteData[23:16])/*00*/);
	assign din2 = Address[1]?(Address[0]?
						(WriteData[7:0])/*11*/:
						(WriteData[31:24])/*10*/):(Address[0]?
						(WriteData[23:16])/*01*/:
						(WriteData[15:8])/*00*/);
	assign din3 = Address[1]?(Address[0]?
						(WriteData[31:24])/*11*/:
						(WriteData[23:16])/*10*/):(Address[0]?
						(WriteData[15:8])/*01*/:
						(WriteData[7:0])/*00*/);

						
	assign ReadData =Address[1]?(Address[0]?
						({dout3,dout0,dout1,dout2})/*11*/:
						({dout2,dout3,dout0,dout1})/*10*/):(Address[0]?
						({dout1,dout2,dout3,dout0})/*01*/:
						({dout0,dout1,dout2,dout3})/*00*/);
						
	DataMem dm0(clk, MemWrite, addr0, din0, dout0);
	DataMem dm1(clk, MemWrite, addr1, din1, dout1);
	DataMem dm2(clk, MemWrite, addr2, din2, dout2);
	DataMem dm3(clk, MemWrite, addr3, din3, dout3);
	

endmodule
