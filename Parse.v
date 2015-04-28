`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:07:25 03/24/2015 
// Design Name: 
// Module Name:    Parse 
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
module Parse32(input clk, input [31:0]data, output [63:0] odata
);
Parse4 p1(clk,data[3:0],odata[7:0]);
Parse4 p2(clk,data[7:4],odata[15:8]);
Parse4 p3(clk,data[11:8],odata[23:16]);
Parse4 p4(clk,data[15:12],odata[31:24]);
Parse4 p5(clk,data[19:16],odata[39:32]);
Parse4 p6(clk,data[23:20],odata[47:40]);
Parse4 p7(clk,data[27:24],odata[55:48]);
Parse4 p8(clk,data[31:28],odata[63:56]);
endmodule

module Parse12(input clk, input [11:0]data, output [23:0] odata
);
Parse4 p1(clk,data[3:0],odata[7:0]);
Parse4 p2(clk,data[7:4],odata[15:8]);
Parse4 p3(clk,data[11:8],odata[23:16]);
endmodule

module Parse4(input clk, input [3:0]data, output reg[7:0] odata
);

always @(posedge clk)
begin
	case(data[3:0]) 
			4'b0000:odata[7:0] <= "0";
			4'b0001:odata[7:0] <= "1";
			4'b0010:odata[7:0] <= "2";
			4'b0011:odata[7:0] <= "3";
			4'b0100:odata[7:0] <= "4";
			4'b0101:odata[7:0] <= "5";
			4'b0110:odata[7:0] <= "6";
			4'b0111:odata[7:0] <= "7";
			4'b1000:odata[7:0] <= "8";
			4'b1001:odata[7:0] <= "9";
			4'b1010:odata[7:0] <= "A";
			4'b1011:odata[7:0] <= "B";
			4'b1100:odata[7:0] <= "C";
			4'b1101:odata[7:0] <= "D";
			4'b1110:odata[7:0] <= "E";
			4'b1111:odata[7:0] <= "F";
			default:odata[7:0] <= "0";
			endcase
end
endmodule
