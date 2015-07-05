`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:54:38 05/21/2014 
// Design Name: 
// Module Name:    delay 
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
module delay(PCclk,clk,PCclk_,single_count);
	 
input PCclk;
input clk;
output [9:0] PCclk_;
output [5:0] single_count;

	reg [9:0] PCclk_;	 
	reg [5:0] single_count;

	initial PCclk_ = 0;
	initial single_count = 0;

	always@(posedge clk)begin
		if(PCclk)
			single_count <= 0;
		else if(single_count == 6'b111111)
			single_count <= 6'b111111;
		else
			single_count <= single_count + 1;
	end
	
	always@(posedge clk)begin
		case(single_count)
		//	5: PCclk_[0] <= 1;
		//	10: PCclk_[1] <= 1;
			8: PCclk_[3] <= 1;//Ð´¼Ä´æÆ÷
			5: PCclk_[4] <= 1;//Êý¾Ý´æ´¢Æ÷²Ù×÷
			10: PCclk_[2] <= 1;//¶Á¼Ä´æÆ÷
			default:PCclk_ <= 10'd0;
		endcase
	end
endmodule
