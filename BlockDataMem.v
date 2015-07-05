`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:20 05/12/2015 
// Design Name: 
// Module Name:    BlockDataMem 
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
module Pipedmem(clka, wea, addra, dina, douta);
   input               clka;
   input               wea;
   input     [31: 0] dina;
	input	    [31: 0]	addra;
	output reg  [31: 0]	douta;
	
	localparam RAM_DEPTH = 6;
	localparam RAM_WIDTH = 32;
	localparam RAM_SIZE  = 2 ** RAM_DEPTH;
	(* bram_map = "yes" *)
	reg		[RAM_WIDTH - 1: 0]	ram[ 0: RAM_SIZE - 1]; 
	wire	[RAM_DEPTH - 1: 0]	index_in_ram = addra[RAM_DEPTH + 1: 2];
	
	initial begin
		$readmemh("ram.dat", ram);
	end

    always @(posedge clka) begin
        if (wea) begin 
            ram[index_in_ram] <= dina;           
        end
        else begin
            douta <= ram[index_in_ram];
        end
    end
				
endmodule
