`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:36:02 11/11/2020
// Design Name:   data_memory
// Module Name:   C:/Users/SOLO/Desktop/san diego/The Fourht Year/The Fall Semester/COMPE - 475/cpu/cpu/tb_data_mem.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: data_memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_data_mem;

	// Inputs
	reg clk_in;
	reg write_en_in;
	reg [7:0] addr_in;
	reg [31:0] data_in;

	// Outputs
	wire [31:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	data_memory uut (
		.clk_in(clk_in), 
		.write_en_in(write_en_in), 
		.addr_in(addr_in), 
		.data_in(data_in), 
		.data_out(data_out)
	);
	
	always #5 clk_in=~clk_in;
	initial begin
		// Initialize Inputs
		clk_in = 0;
		write_en_in = 0;
		addr_in = 0;
		data_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		addr_in=3;
		#100;
		addr_in=4;
		#100;
		data_in=10;#1;
		write_en_in=1;
		#10;write_en_in=0;
		#100;
        
		// Add stimulus here

	end
      
endmodule

