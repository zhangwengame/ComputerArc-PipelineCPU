`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:21:29 04/14/2015 
// Design Name: 
// Module Name:    genpulse 
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
module genpulse(input clk, input [4:0]observ, output reg pulse
    );
reg [5:0]count;
reg change;
initial count=0;
initial pulse=0;
initial change=0;
always@(observ) change<=1;

	always@(posedge clk)
	begin
		if(change)
		begin
			count <= 0;
			change<=0;
		end
		else if(count == 6'b111111)
			count <= 6'b111111;
		else
			count <= count + 1;
	end
	always@(posedge clk)begin
		case(count)
			1:pulse<=1;
			2:pulse<=1;
			default:pulse<=0;
		endcase
	end
endmodule
