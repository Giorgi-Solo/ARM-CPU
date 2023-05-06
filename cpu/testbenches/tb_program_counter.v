`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:36:40 12/17/2020
// Design Name:   program_counter
// Module Name:   C:/Users/SOLO/Desktop/san diego/The Fourht Year/The Fall Semester/COMPE - 475/cpu/cpu/tb_program_counter.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: program_counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_program_counter;

	// Inputs
	reg mux_sel;
	reg clk_in;
	reg [7:0] addr_to_jmp_in;

	// Outputs
	wire [7:0] PC_out;
	wire [7:0] R15_out;

	// Instantiate the Unit Under Test (UUT)
	program_counter uut (
		.mux_sel(mux_sel), 
		.clk_in(clk_in), 
		.addr_to_jmp_in(addr_to_jmp_in), 
		.PC_out(PC_out), 
		.R15_out(R15_out)
	);

	initial begin
		// Initialize Inputs
		mux_sel = 0;
		clk_in = 0;
		addr_to_jmp_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

